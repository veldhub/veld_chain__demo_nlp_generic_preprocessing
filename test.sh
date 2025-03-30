#!/bin/bash

num_failed=0

function compare {
  echo "comparing: ${1} to correct hash: ${2}"
  md5_in_real=$(md5sum "$1" | awk '{print $1}')
  echo "real hash: ${md5_in_real}"
  if [[ "$md5_in_real" = "$2" ]]; then
    echo "result: correct" | tee -a test.log
  else
    echo "result: incorrect" | tee -a test.log
    ((num_failed++))
  fi
}


echo "--- test veld_demo_02__clean.yaml ---" | tee test.log

#data/demo_02/in/grimms_fairy_tales.txt :
md5_in_correct=3b460a560a61b4e70e5ccc6f63c48063
#data/demo_02/out/grimms_fairy_tales__clean.txt :
md5_out_clean_correct=c55240515498f45c912bbcfbc313f339
#data/demo_02/out/grimms_fairy_tales__dirty.txt :
md5_out_dirty_correct=074bdd74e5bc95b6023dd7040bb61320
#data/demo_02/out/veld_rumpelstiltkin.yaml :
md5_out_metadata_correct=2c5f697390be9df5903262308e011692

docker-compose -f veld_demo_02__clean.yaml up &>> test.log

compare ./data/demo_02/in/grimms_fairy_tales.txt "$md5_in_correct"
compare ./data/demo_02/out/grimms_fairy_tales__clean.txt "$md5_out_clean_correct"
compare ./data/demo_02/out/grimms_fairy_tales__dirty.txt "$md5_out_dirty_correct"
compare ./data/demo_02/out/veld_rumpelstiltkin.yaml "$md5_out_metadata_correct"


echo "number of failed tests: ${num_failed}"

