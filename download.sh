#!/bin/bash

## #{ download_data()
download_data() {
  URL=$1
  DESTINATION_FOLDER=$2
  if wget --no-check-certificate --content-disposition "${URL}" -c -P "${DESTINATION_FOLDER}"; then
    echo "wget of data was successfull"
  else
    echo "wget of data was unsuccessfull"
    echo " url: $URL"
    echo " destination: $DESTINATION_FOLDER"
  fi
}
## #}

######################################################
# Add datasets here:
echo Downloading data for dataset: coop_uav_dataset
URL_BAGS=https://nasmrs.felk.cvut.cz/index.php/s/NPYxhU0hch89Jg0/download
# URL_VIDEO=

# URLs for files and their respective subdirectories
# URL=( "$URL_BAG" "$URL_VIDEO" )
URL=( "$URL_BAGS" )
DATA_FOLDERS=( "." "." )
######################################################

# Do not change below!
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
for (( j=0; j<${#URL[@]}; j++ ));
do
  download_data "${URL[$j]}" "$SCRIPT_PATH/${DATA_FOLDERS[$j]}"

  echo "Unzipping files"
  tar -xvzf rosbags.tar.gz

  echo "Cleaning up"
  rm rosbags.tar.gz

  echo "Done" 
done
