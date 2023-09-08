#!/usr/bin/bash

set -euo pipefail
set -x

mkdir -p $DOWNLOAD_DIR

export TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT ERR

df -h

# Download phenotype links file
URL=$(gh release view -R bihealth/clinvar-data-jsonl --json assets -q '.assets[] | select( .name | contains("phenotype-links") )' | grep -v sha256 | jq -r .url)
wget -O $DOWNLOAD_DIR/clinvar-data-phenotype-links.tar.gz $URL

# Download HGNC information file
wget -O $DOWNLOAD_DIR/hgnc_complete_set.json \
    https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/json/hgnc_complete_set.json

# Download HPO files
URL=$(gh release view -R obophenotype/human-phenotype-ontology --json assets -q '.assets[] | select( .name | contains("hp.obo") )' | jq -r .url)
wget -O $DOWNLOAD_DIR/hp.obo $URL
URL=$(gh release view -R obophenotype/human-phenotype-ontology --json assets -q '.assets[] | select( .name | contains("genes_to_phenotype.txt") )' | jq -r .url)
wget -O $DOWNLOAD_DIR/genes_to_phenotype.txt $URL

df -h
