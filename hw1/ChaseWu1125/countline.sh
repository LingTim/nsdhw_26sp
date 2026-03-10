#!/bin/bash

if [ -z "$1" ]; then
    echo "missing file name"
    exit 1
fi

LINES=$(wc -l < $1)
echo "$LINES lines in $1"
