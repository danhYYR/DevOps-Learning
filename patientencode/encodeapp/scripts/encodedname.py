# Import the necessary module
import os
import re
# Rename Method
def change_file_folder(folder):
    new_name_list=[]
    for file in folder:
        new_name=change_file_name(file)
        new_name_list.append(new_name)
def change_file_name(file_name):
    # Use a regular expression to match the subject name and ID
    match = re.match(r'(\D+)(\d+)', file_name)
    if match:
        # If a match was found, return the subject name and ID
        subject_name = match.group(1)
        id = match.group(2)
        return subject_name
    else:
        # If no match was found, return None
        return None
# Get the file list in a folder
def ListFiles(directory):
    # Get all files in directory
    files = os.listdir(directory)
    # Prepare the pattern to scan
    pattern = r'(\D+)(\d+)' 
    files_list=[]
    for file in files:
        files_list.append( re.search(pattern,file).group(0))
    unique_files = list(set(files_list))
    return unique_files