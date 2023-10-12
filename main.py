import os
import ChangeName as CN
try:
    folder_name = input("Type your folder you want to change \n")
    file_list = CN.ListFiles(folder_name)
    Folder_1 = CN.FileList(folder_name,file_list)
    new_name=[]
    i=0
    while (len(new_name)<len(Folder_1.file_list)):
        print("OldName: "+Folder_1.file_list[i])
        new_name.append(input("Type the new name : "))
        print(Folder_1.file_list[i]+" will change to "+new_name[i])
        i=i+1
    if (Folder_1.check_namelist(new_name)):
        Folder_1.change_filename(new_name)
except:
    print("Something went wrong please try again")