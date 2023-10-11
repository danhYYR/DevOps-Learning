# Import the necessary module
import os
import re
# Class FileList for app controlling
class FileList:
    def __init__(self,path_name,file_list) -> None:
        self.path_name=path_name
        self.file_list=file_list
    # Rename Method
    def change_filename(self,new_name):
        # Compile the pattern
        files = os.listdir(self.path_name)
        for file in files:
            # Prepare pattern to scan text
            pattern=r'(\w+(?=[_\s]))'
            # Get the fole path to interact to file
            full_path=os.path.join(self.path_name,file)
            for i,oldname in enumerate(self.file_list):
                if file.startswith(oldname):
                    path_new=re.sub(pattern,new_name[i],full_path)
                    os.rename(full_path,path_new)
    # Used for fixing bug the length difference between old and new name list
    def check_namelist(self,new_name_list):
        if (len(new_name_list)==len(self.file_list)):
            return True
        else:
            return False
# Function help to get the file list 
# Get the file list in a folder
def ListFiles(directory):
    # Get all files in directory
    files = os.listdir(directory)
    # Prepare the pattern to scan
    pattern = r'(\w+(?=[_\s]))'
    files_list=[]
    for file in files:
        files_list.append( re.search(pattern,file).group(0))
    unique_files = list(set(files_list))
    return unique_files
# Auto create the psedo file
def PsedoFiles(path_name=os.getcwd(),file_name=None,number=None):
    if (path_name==os.getcwd()):
        os.makedirs("TestFile",exist_ok=True)
        path_name = os.path.join(path_name,"TestFile")
    full_path = os.path.join(path_name,file_name)
    number=int(number)
    for i in range(number):
        f = open(full_path+"_"+str(i+1),"w")
        f.write(os.path.join(full_path,"No"+str(i)))
        f.close