# import the django 
from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect,JsonResponse
from django.template import loader
from cryptography.fernet import Fernet
# Import model
from . import models
# Import encode script
from .scripts import encodedname as EN
# Import Ai model class
from .AImodel.tedi import TextExtractor
# Get the enviroment variables
from django.conf import settings
# Import Forms
from .forms import UploadImageForm
# Create your views here.
def patientform(request):
    template=loader.get_template('patientform.html')
    query = request.GET.get('pname')
    if query:
        subjects = models.PatientInformations.objects.filter(initial_name__icontains=query)
        subjects_list = list(subjects.values())
        return JsonResponse(subjects_list)
    return HttpResponse(template.render())
# Upload view
## Upload file into the server
def upload_file(request):
    if request.method == 'POST':
        form = UploadImageForm(request.POST, request.FILES)
        if form.is_valid():
            azure_key = settings.AI_MODEL["MODEL_KEY"]
            endpoint = settings.AI_MODEL["MODEL_ENDPOINT"]
            extractor = TextExtractor(azure_key, endpoint)
            result = TextExtractor.extract_text_from_image(request.FILES['image'])

        return HttpResponseRedirect('/file_list/')  # redirect after post
    else:
        form = UploadImageForm()
    return render(request, 'upload.html', {'form': form})
    # List the file namem from database
# Get Name Information
def file_list(request):
    query = request.GET.get('q')
    if query:
        subjects = models.PatientInformations.objects.filter(initial_name__icontains=query)
    else:
        subjects =models.PatientInformations.objects.all()
    # ## Decrypt the names
    # for subject in subjects:
    #     subject.encoded_name = subject.decode_name()
    return render(request, 'file_list.html', {'subjects': subjects})
def delete_subject(request, id):
    if request.method == 'POST':
        patient = models.PatientInformations.objects.get(id=id)
        patient.delete()
        return HttpResponseRedirect('/file_list/')
