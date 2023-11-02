#!/bin/bash

# Set the URL and query
url="http://localhost:8000/file_list/"
query="${1}"
# Send the GET request
response=$(curl -G $url --data-urlencode "q=$query")

# Extract the encoded name from the response
encoded_name=$(echo $response | grep -oP '(?<=<p> Encoded Name: ).*?(?=</p>)')
# Rename the file
dir="${2}"
#echo "$query"
mv "$dir"/"$query" "$dir"/"$encoded_name"
# Save the encoded name to a text file
echo -e  "Old Name: " "$query" " - " "$encoded_name\r" >> encoded_name.txt
