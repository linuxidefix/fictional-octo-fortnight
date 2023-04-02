#!/bin/bash

# Récupère la version courante du projet Maven
CURRENT_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

# Calcule la prochaine version de correctif
PATCH_VERSION=$(echo $CURRENT_VERSION | awk -F. '{printf("%d.%d.%d", $1, $2, $3+1)}')

# Calcule la prochaine version mineure
MINOR_VERSION=$(echo $CURRENT_VERSION | awk -F. '{printf("%d.%d.%d", $1, $2+1, 0)}')

# Calcule la prochaine version majeure
MAJOR_VERSION=$(echo $CURRENT_VERSION | awk -F. '{printf("%d.%d.%d", $1+1, 0, 0)}')

# Détermine la version suivante en fonction du paramètre d'entrée next_version_type
case "${{ inputs.next_version_type }}" in
  "PATCH")
    NEXT_VERSION="${PATCH_VERSION}"
    ;;
  "MINOR")
    NEXT_VERSION="${MINOR_VERSION}"
    ;;
  "MAJOR")
    NEXT_VERSION="${MAJOR_VERSION}"
    ;;
  *)
    NEXT_VERSION="${PATCH_VERSION}"
    ;;
esac

# Sortie des variables de version
echo ::set-output name=current_version::$CURRENT_VERSION
echo ::set-output name=next_patch_version::$PATCH_VERSION
echo ::set-output name=next_minor_version::$MINOR_VERSION
echo ::set-output name=next_major_version::$MAJOR_VERSION
echo ::set-output name=next_version::$NEXT_VERSION
