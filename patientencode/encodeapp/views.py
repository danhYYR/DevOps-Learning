# import the django 
from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader
from cryptography.fernet import Fernet
# Import model
from . import models
# Import encode script
from .scripts import encodedname as EN
# Create your views here.
def patientform(request):
    template=loader.get_template('patientform.html')
    return HttpResponse(template.render())
# Upload view
# Upload file into the server
def upload_file(request):
    if request.method == 'POST':
        # Get the ID file
        id = models.EncodedFileName.objects.count()
         # Get the uploaded file
        file_list = request.FILES
        # In case Single file upload
        if "File" in file_list:
            initial_name = file_list['File'].name
            # TODO: Encode the file name here
            ### Store into the Model
            key = Fernet.generate_key().decode()
            ## Create a new EncodedFileName object and save it to the database
            encoded_file_name = models.EncodedFileName(
                initial_name=initial_name,
                key=key
            )
            ## Store into the database
            encoded_file_name.save()  
        return HttpResponseRedirect('/file_list/')  # redirect after post
    else:
        return render(request, 'upload.html')
    # List the file namem from database
# Get Name Information
def file_list(request):
    query = request.GET.get('q')
    if query:
        subjects = models.EncodedFileName.objects.filter(initial_name__icontains=query)
    else:
        subjects =models.EncodedFileName.objects.all()
    # ## Decrypt the names
    # for subject in subjects:
    #     subject.encoded_name = subject.decode_name()
    return render(request, 'file_list.html', {'subjects': subjects})
def delete_subject(request, id):
    if request.method == 'POST':
        patient = models.EncodedFileName.objects.get(id=id)
        patient.delete()
        return HttpResponseRedirect('/file_list/')