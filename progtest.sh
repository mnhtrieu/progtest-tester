#!/bin/bash
# ProgTest tester

if  [ -z "$1" ]; then
	echo "[INFO] Pouziti: ./progtest.sh <file> <test_samples>";
	exit 1
fi

if [ -z "$2" ]; then
	echo "[INFO] Pouziti: ./progtest.sh <file> <test_samples>";
	exit 1
fi


FILE="$1"
PROG="./compiled.sh"

if ! [ -d "$2" ]; then
	echo "[ERROR] Pozadovana slozka s testovacimi vzory nebyla nalezena!";
	exit 2
fi

if ! [  -f "$FILE" ]; then
	echo "[ERROR] Pozadovany soubor nebyl nalezen!";
	exit 2
fi

if !(g++ $FILE -Wall -Werror -pedantic -o $PROG); then
	echo "[ERROR] Objevila se chyba pri kompilaci. ";
	exit 3
fi

COUNTER=0
FAILED=0

for IN_FILE in "$2"/*in*; do

   	COUNTER=$((COUNTER+1))
	IN_FILE=`echo -n $IN_FILE | sed -e 's/\/\//\//g'`
    REF_FILE=`echo -n $IN_FILE | sed -e 's/\(.*\)in\(.*\)$/\1out\2/'`
    if ! $PROG < $IN_FILE | diff - $REF_FILE; then
    #if ! diff $REF_FILE my_out.txt; then
    	echo "$IN_FILE... CHYBA";
		FAILED=$((FAILED+1))
    else
    	echo "$IN_FILE... OK";
    fi
done

rm $PROG

if [ "$FAILED" -gt 0 ]; then
	echo "======================================================";
	echo "Nepovedlo se ti splnit $FAILED z $COUNTER testu!";
	echo "======================================================";
	exit 0
else
	echo "======================================================";
	echo "Vyborne! Povedlo se ti splnit vsech $COUNTER testu!";
	echo "======================================================";
	exit 0
fi
