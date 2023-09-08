#!/usr/bin/bash

set -euo pipefail
set -x

mkdir -p ${OUTPUT_DIR}/cada-prio-model-${RELEASE_NAME}+${CADA_PRIO_VERSION}

df -h

tar -C $DOWNLOAD_DIR -xf $DOWNLOAD_DIR/clinvar-data-phenotype-links.tar.gz

find $DOWNLOAD_DIR | sort

cada-prio train-model \
  ${OUTPUT_DIR}/cada-prio-model-${RELEASE_NAME}+${CADA_PRIO_VERSION} \
  --path-hgnc-json $DOWNLOAD_DIR/hgnc_complete_set.json \
  --path-gene-hpo-links $DOWNLOAD_DIR/clinvar-data-phenotype-links*/*.jsonl.gz \
  --path-hpo-genes-to-phenotype $DOWNLOAD_DIR/genes_to_phenotype.txt \
  --path-hpo-obo $DOWNLOAD_DIR/hp.obo \


cat >${OUTPUT_DIR}/cada-prio-model-${RELEASE_NAME}+${CADA_PRIO_VERSION}/spec.yaml <<EOF
dc.identifier: cada-prio/cada-prio-model-$RELEASE_NAME+$CADA_PRIO_VERSION
dc.title: cada-prio trained model files
dc.creator: VarFish Development Team
dc.format: application/binary
dc.date: $(date +%Y%m%d)
x-version: ${RELEASE_NAME}+$CADA_PRIO_VERSION}
dc.description: |
  Model created for ClinVar weekly release $RELEASE_NAME built with
  cada-prio $CADA_PRIO_VERSION.
dc.source:
  - PMID:29165669
  - PMID:34514393
  - https://github.com/bihealth/cada-prio
  - https://github.com/bihealth/cada-prio-data
x-created-from:
  - name: ClinVar weekly release
    version: $RELEASE_NAME
EOF


df -h
