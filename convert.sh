#!/bin/bash

# Verzeichnis festlegen (aktuelles Verzeichnis oder spezifisches). Script direkt im Ordner /docs/de oder /docs/en mit dem Befehl "../../convert.sh en" auführen

i18n=$1 #wird als Argument geliefert
SRC_DIR="../../src/$i18n/"
DES_DIR="./"

# Schleife durch alle Dateien im Verzeichnis
for file in "$SRC_DIR"*.docx; do
  
  # Basisname ohne Verzeichnis
  filename="${file##*/}"
  # Entfernt nur die letzte Extension
  filename_short=$(echo "$filename" | cut -d ' ' -f 1)
  # In Kleinbuchstaben umwandel
  filename_short_lc=$(echo "$filename_short" | tr '[:upper:]' '[:lower:]')

  # Ausgabedateiname erstellen
  output=$DES_DIR$filename_short_lc".md"
  echo "Convert $file -> $output"
  # Pandoc-Befehl ausführen
  pandoc -f docx -t markdown "$file" -o "$output" -t gfm --extract-media $DES_DIR"assets/""$filename_short_lc"/ --template=../../header_$i18n.md

done
