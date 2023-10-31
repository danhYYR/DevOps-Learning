from django.db import models
from cryptography.fernet import Fernet
class EncodedFileName(models.Model):
    initial_name = models.CharField(max_length=255)
    key = models.CharField(max_length=255)
    encoded_name = models.CharField(max_length=255)
    def __str__(self):
        return self.initial_name
    # Save data into model
    def save(self, *args, **kwargs):
        cipher_suite = Fernet(self.key.encode())
        self.encoded_name = cipher_suite.encrypt(self.initial_name.encode()).decode()
        super().save(*args, **kwargs)
    def decode_name(self):
        cipher_suite = Fernet(self.key.encode())
        return cipher_suite.decrypt(self.encoded_name).decode()