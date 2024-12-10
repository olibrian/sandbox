#!/bin/bash

# Verzeichnis festlegen (aktuelles Verzeichnis oder spezifisches)
SRC_DIR="./src/de/"
DES_DIR="./docs/de/"

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
  echo "Konvertiere $file -> $output"
  # Pandoc-Befehl ausführen
  pandoc -f docx -t markdown "$file" -o "$output" -t gfm --extract-media $DES_DIR/assets/"$filename_short_lc"/
done
