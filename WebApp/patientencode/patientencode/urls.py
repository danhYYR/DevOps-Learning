"""
URL configuration for patientencode project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from encodeapp import views
urlpatterns = [
    path('admin/', admin.site.urls),
]
## Add the path route
# Home 
urlpatterns+= [
    path('',views.patientform)
]
# Upload
urlpatterns+=[
    path('upload',views.upload_file)
]
# Get the list file
urlpatterns+=[
    path('file_list/', views.file_list, name='file_list')
]
# Delete Subject id
urlpatterns+=[
    path('subjects/<int:id>/delete/', views.delete_subject, name='delete_subject')
]
