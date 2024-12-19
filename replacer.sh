#!/bin/bash

# Script direkt im Ordner /docs/de oder /docs/en mit dem Befehl "../../convert.sh en" auführen
# ACHTUNG: Script nur eimal ausführen da sonst die Wörter doppelt ersetzt werden!!

i18n=$1 #wird als Argument geliefert
SRC_DIR="./en/"
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
  ['Em002 Strategic Guidelines for Open Source Software in the Federal Administration']='[Em002 Strategic Guidelines for Open Source Software in the Federal Administration](em002.md)'
  ['Em002-1 Practical Guidelines for Open Source Software in the Federal Administration']='[Em002-1 Practical Guidelines for Open Source Software in the Federal Administration](em002-1.md)'
  ['Em002-2 Instructions for Publishing OSS']='[Em002-2 Instructions for Publishing OSS](em002-2.md)'
  ['Em002-2.1 Preliminary Assessment Checklist']='[Em002-2.1 Preliminary Assessment Checklist](em002-2.1.md)'
  ['Em002-2.2 Analysis and Preparation Checklist']='[Em002-2.2 Analysis and Preparation Checklist](em002-2.2.md)'
  ['Em002-2.3 Release and Publication Checklist']='[Em002-2.3 Release and Publication Checklist](em002-2.3.md)'
  ['Em002-3 OSS Licensing Guidelines']='[Em002-3 OSS Licensing Guidelines](em002-3.md)'
  ['Em002-4 OSS Community Guidelines']='[Em002-4 OSS Community Guidelines](em002-4.md)'
  ['Em002-4.1 OSS Community Checklist']='[Em002-4.1 OSS Community Checklist](em002-4.1.md)'
  ['Em002-5 EMOTA and OSS Factsheet']='[Em002-5 EMOTA and OSS Factsheet](em002-5.md)'
  ['Em002-6 FAQ on OSS and Art. 9 EMOTA']='[Em002-6 FAQ on OSS and Art. 9 EMOTA](em002-6.md)'
  
)

# Schleife durch alle Dateien im Verzeichnis
for file in "$SRC_DIR"*.md; do
  echo $file
  # Ersetzten von Wörter aus dem Array
  for word in "${!replacements[@]}"; do
    count=$(grep -o "$word" "$file" | wc -l)
    echo "Replace word \"$word\" -> $count"
    sed -i "s/$word/${replacements[$word]}/g" "$file"
  done

  echo "********************************************************************"
done
