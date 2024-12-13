#!/bin/bash

# Verzeichnis festlegen (aktuelles Verzeichnis oder spezifisches). Script direkt im Ordner /docs/de oder /docs/en mit dem Befehl "../../convert.sh en" auführen

i18n=$1 #wird als Argument geliefert
SRC_DIR="../../src/$i18n/"
DES_DIR="./"

declare -A replacements
replacements=(
  ['Em002 Strategischer Leitfaden_V2-0']='[Em002 Strategischer Leitfaden_V2-0](em002.md)'
  ['Em002-1 Praxis Leitfaden_V2-0']='[Em002-1 Praxis Leitfaden_V2-0](em002-1.md)'
  ['Em002-2 Anleitung zur Veröffentlichung von OSS']='[Em002-2 Anleitung zur Veröffentlichung von OSS](em002-2.md)'
  ['Em002-2.1 Checkliste Vorabklärung']='[Em002-2.1 Checkliste Vorabklärung](em002-2.1.md)'
  ['Em002-2.2 Checkliste Analyse und Aufbereitung']='[Em002-2.2 Checkliste Analyse und Aufbereitung](em002-2.2.md)'
  ['Em002-2.3 Checkliste Freigabe und Publikation']='[Em002-2.3 Checkliste Freigabe und Publikation](em002-2.3.md)'
  ['Em002-3 Leitfaden OSS-Lizenzen']='[Em002-3 Leitfaden OSS-Lizenzen](em002-3.md)'
  ['Em002-4 Leitfaden OSS-Community']='[Em002-4 Leitfaden OSS-Community](em002-4.md)'
  ['Em002-4.1 Checkliste OSS-Community']='[Em002-4.1 Checkliste OSS-Community](em002-4.1.md)'
  ['Em002-5 Faktenblatt EMBAG und OSS']='[Em002-5 Faktenblatt EMBAG und OSS](em002-5.md)'
  ['Em002-6 OSS-FAQ']='[Em002-6 OSS-FAQ](em002-6.md)'
)

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

  # Ersetzten von Wörter aus dem Array
  for word in "${!replacements[@]}"; do
    count=$(grep -o "$word" "$output" | wc -l)
    echo "Replace word \"$word\" -> $count"
    sed -i "s/$word/${replacements[$word]}/g" "$output"
  done

  echo "********************************************************************"
done
