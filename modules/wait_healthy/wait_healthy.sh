#!/bin/bash
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

ENDPOINT=""
ACCESS_TOKEN=""

while getopts 'e:t:' c
do
  case $c in
    e) ENDPOINT=${OPTARG} ;;
    t) ACCESS_TOKEN=${OPTARG} ;;
    *)
      echo "Invalid flag ${OPTARG}"
      exit 1
      ;;
  esac
done

if [[ -z ${ENDPOINT} ]]; then
    echo "-e must be set"
    exit 1
fi

if [[ -z ${ACCESS_TOKEN} ]]; then
    echo "-t must be set"
    exit 1
fi


for ((i=1;i<=50;i++)); do
    sleep 10
    resp=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer ${ACCESS_TOKEN}" "${ENDPOINT}/api/v3/namespaces/default/artifacts")

    code=$(tail -n 1 <<< "${resp}")
    body=$(head -n 1 <<< "${resp}")

   if [[ "${code}" == 200 ]]; then
        name=$(jq -r '.[] | select(.name=="google-cloud") | .name' <<< "${body}")
        if [[ "${name}" == "google-cloud" ]]; then
            echo "Artifact google-cloud loaded, instance healthy"
            exit 0
        fi

        echo "Artifact google-cloud not loaded (${name}), instance unhealthy, checking again in 10 seconds"

    elif [[ "${code}" =~ ^(400|502|504)$ ]]; then
        echo "Instance unhealthy: ${code}, checking again in 10 seconds"

    else
        echo "Unexpected code: ${code}"
        echo "${body}"
        exit 1
    fi
done

echo "Failed to wait for instance to become healthy in allocated time"
exit 1
