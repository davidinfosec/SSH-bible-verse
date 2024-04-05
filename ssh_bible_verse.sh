#!/bin/bash

# Define base paths for OT and NT directories
OT_PATH="/opt/bible/OT"
NT_PATH="/opt/bible/NT"

# Lists of OT and NT books
OT_BOOKS=(GEN EXO LEV NUM DEU JOS JDG RUT 1SA 2SA 1KI 2KI 1CH 2CH EZR NEH EST JOB PSA PRO ECC SNG ISA JER LAM EZK DAN HOS JOE AMO OBA JON MIC NAH HAB ZEP HAG ZEC MAL)
NT_BOOKS=(MAT MRK LUK JHN ACT ROM 1CO 2CO GAL EPH PHP COL 1TH 2TH 1TI 2TI TIT PHM HEB JAS 1PE 2PE 1JN 2JN 3JN JUD REV)

# Randomly decide if we're picking from OT or NT
if [ $((RANDOM % 2)) -eq 0 ]; then
    TESTAMENT="OT"
    BOOKS=("${OT_BOOKS[@]}")
    BOOK_PATH="$OT_PATH"
else
    TESTAMENT="NT"
    BOOKS=("${NT_BOOKS[@]}")
    BOOK_PATH="$NT_PATH"
fi

# Randomly select a book
BOOK=${BOOKS[$RANDOM % ${#BOOKS[@]}]}

# Construct the path to the book's JSON file
JSON_PATH="$BOOK_PATH/$BOOK/ESV.json"

# Check if the JSON file exists
if [ ! -f "$JSON_PATH" ]; then
    echo "JSON file not found for $BOOK in $TESTAMENT"
    exit 1
fi

# Use jq to parse the JSON file and shuf to select a random verse along with its chapter ID
RANDOM_VERSE_DATA=$(jq -r '[.text[].text[]] | .[] | "\(.ID) \(.text)"' "$JSON_PATH" | shuf -n 1)
CHAPTER_ID=$(echo "$RANDOM_VERSE_DATA" | cut -d' ' -f1)
VERSE_TEXT=$(echo "$RANDOM_VERSE_DATA" | cut -d' ' -f2-)

# Output the formatted verse with book name, chapter ID, and verse text
echo "$BOOK - $CHAPTER_ID: $VERSE_TEXT"
