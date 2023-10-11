import os
import ChangeName as CN

folder_name = input("Type your folder you want to change \n")
file_list = CN.ListFiles(folder_name)
Folder_1 = CN.FileList(folder_name,file_list)
new_name=[]
while (len(new_name)<len(Folder_1.file_list)):
    new_name.append(input("Type the new name :\n"))
if (Folder_1.check_namelist(new_name)):
    Folder_1.change_filename(new_name)
