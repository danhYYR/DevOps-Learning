# extract_text.py

import os

from azure.ai.formrecognizer import FormRecognizerClient
from azure.core.credentials import AzureKeyCredential
from ..models import Prescription, PrescriptionImage

from django.conf import settings

# Initialize Fernet with a secret key
model_id = settings.AI_MODEL["MODEL_ID"]
    
class TextExtractor:
    def __init__(self, api_key, endpoint):
        self.api_key = api_key
        self.endpoint = endpoint
    def extract_text_from_pdf(self, pdf_file):
        # Check if the file is a PDF
        if pdf_file.name.endswith('.pdf'):
            # Convert PDF to images
            images = self.convert_pdf_to_images(pdf_file)
            # Process each image
            for idx, image in enumerate(images):
                text = self.extract_text_from_image(image)
                # Store text in the database
                prescription = Prescription.objects.create(medications=text)
                PrescriptionImage.objects.create(prescription=prescription, image_file=image)

    def convert_pdf_to_images(self, pdf_file):
        # Convert PDF to images
        with tempfile.TemporaryDirectory() as temp_dir:
            images = convert_from_path(pdf_file.path, output_folder=temp_dir)
            return images

    def extract_text_from_image(self, image):
        # Request to Azure Form Recognition
        model_client = DocumentAnalysisClient(self.endpoint, AzureKeyCredential(self.azure_key))
        # Assuming 'image_url' is the URL of the image stored in Azure Blob Storage
        result = model_client.begin_analyze_document(
            model_id=model_id,document=image)
        # Process result and extract text
        text = self.process_form_recognition_result(result)
        return text

    def process_form_recognition_result(self, result):
        # Extract text from the Form Recognition result
        # Result is the output value have extract from the model
        # That is the promise have return the result
        patient_list = []
        medications = []
        prescription_list = []
        for idx, document in enumerate(result.documents):
            print(f"--------Analyzing document #{idx + 1}--------")
            patient_name = document.fields.get("VendorName")
            if patient_name:
                print(
                    f"Patient Name: {patient_name.value} has confidence: {patient_name.confidence}"
                )
                patient_list.append({
                    'name': patient_name.value,
                    'name_confidence': patient_name.confidence
                })
            patient_address = document.fields.get("VendorAddress")
            if patient_address:
                print(
                    f"Patient Address: {patient_address.value} has confidence: {patient_address.confidence}"
                )
            patient_list.append({
                'address': patient_address.value,
                'address_confidence': patient_address.confidence
            })

            print("Medications :")
            for idx, item in enumerate(document.fields.get("Items").value):
                print(f"...Drug #{idx + 1}")
                item_description = item.value.get("Description")
                if item_description:
                    print(
                        f"......Description: {item_description.value} has confidence: {item_description.confidence}"
                    )
                    medications.append({
                        'description': item_description.value,
                        'description_confidence': item_description.confidence
                    })
                item_quantity = item.value.get("Quantity")
                if item_quantity:
                    print(
                        f"......Quantity: {item_quantity.value} has confidence: {item_quantity.confidence}"
                    )
                    medications.append({
                        'quantity': item_quantity.value,
                        'quantity_confidence': item_quantity.confidence
                    })
            prescription_date = document.fields.get("InvoiceDate")
            if prescription_date:
                print(
                    f"Invoice Date: {prescription_date.value} has confidence: {prescription_date.confidence}"
                )
                prescription_list.append({
                    'date':prescription_date.value,
                    'date_confidence': prescription_date.confidence
                })
            prescription_list.append({
                'patient': patient_name.value,
                'medications': medications
            })
        return prescription_list

