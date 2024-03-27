# models.py

from django.db import models
from cryptography.fernet import Fernet
from django.conf import settings

# Initialize Fernet with a secret key
fernet = Fernet(settings.ENCRYPT_KEY.encode())

class EncryptedTextField(models.TextField):
    def from_db_value(self, value, expression, connection):
        if value is None:
            return value
        return fernet.decrypt(value.encode()).decode()

    def to_python(self, value):
        if isinstance(value, str):
            return value
        if value is None:
            return value
        return fernet.decrypt(value).decode()

    def get_prep_value(self, value):
        if value is None:
            return value
        return fernet.encrypt(value.encode()).decode()

class Patient(models.Model):
    name = EncryptedTextField()
    address = models.CharField(max_length=255)

class Prescription(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    date = models.DateField()
    medications = models.TextField()  # For simplicity, we'll store medications as text
    count = models.IntegerField()
# Medication class
class PrescriptionImage(models.Model):
    prescription = models.ForeignKey(Prescription, on_delete=models.CASCADE)
    image_file = models.ImageField(upload_to='images/')