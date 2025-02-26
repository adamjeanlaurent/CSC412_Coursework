#!/bin/bash

# get params
PATH_TO_DATA_FILES="$1"
OUTPUT_FILE_PATH="$2"

# temp directory to hold files created during execution
TEMP_DIR="./temp/"

# create temp directory
mkdir "${TEMP_DIR}"

# get last char of param directories
LAST_CHAR_OF_PATH_TO_DATA_FILES="${PATH_TO_DATA_FILES: -1}"

# if last character of path is not a / , append / to the path
if [ "$LAST_CHAR_OF_PATH_TO_DATA_FILES" != "/" ] ; then
    PATH_TO_DATA_FILES="${PATH_TO_DATA_FILES}/"
fi

# ensure that output file extension ends in .c
if [ ${OUTPUT_FILE_PATH: -2} != ".c" ] ; then
    OUTPUT_FILE_PATH="${OUTPUT_FILE_PATH}.c"
fi

GREATEST_INDEX=0

# loop through .txt files in path to data files
for FILE in "$PATH_TO_DATA_FILES"*.txt ; do
    # get index of file
    FILE_INDEX=$(grep -o '^[0-9]*' $FILE)
    # if index of file is greatest than greatest index so far, overwrite it with index of file
    if [ $FILE_INDEX -gt $GREATEST_INDEX ] ;
    then
        GREATEST_INDEX=$FILE_INDEX
    fi
done

# build all execs
sh ./build.sh

# create output file
touch $OUTPUT_FILE_PATH

# run version 1
../Source/Version1/v1 $GREATEST_INDEX $PATH_TO_DATA_FILES $OUTPUT_FILE_PATH

# delete temp dir
rm -r $TEMP_DIR

# test ./script01.sh /Users/ajean-laurent/Desktop/CSC_412_Work/Prog04/Data-Sets/Data-Set-1/ /Users/ajean-laurent/Desktop/CSC_412_Work/Prog04/Source/Version1/outputfile.c
