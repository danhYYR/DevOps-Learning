#!/bin/bash

# Set the directory
dir=${1}

# Loop over all files in the directory
for file in "$dir"/*
do
  # Check if it's a file (not a directory)
  if [ -f "$file" ]; then
	  
	# Run the get_encodedname script on the file
	 ./get_encodedname.sh $(basename "$file") "$dir"
   #echo "$dir"/"$file"
  fi
done

