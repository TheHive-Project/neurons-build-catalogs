#!/usr/bin/env bash

build_catalog() {
    DIR=$1
    echo '[' > ${DIR}/${DIR}.json
    echo '[' > ${DIR}/${DIR}-devel.json
    echo '[' > ${DIR}/${DIR}-stable.json

    first=1
    for JSON in ${DIR}/*/*.json
    do
        if test -z "${first}"
        then
    	echo ',' >> ${DIR}/catalog.json
    	echo ',' >> ${DIR}/${DIR}-devel.json
    	echo ',' >> ${DIR}/${DIR}-stable.json
        else
    	first=
        fi

        jq 'del(.command) + { dockerImage: ("cortexneurons/" + (.name | ascii_downcase) + ":devel") }' ${JSON} >> ${DIR}/${DIR}-devel.json
        jq 'del(.command) + { dockerImage: ("cortexneurons/" + (.name | ascii_downcase) + ":" + .version) }' ${JSON} >> ${DIR}/${DIR}-stable.json
        jq 'del(.command) + { dockerImage: ("cortexneurons/" + (.name | ascii_downcase) + ":" + (.version | split("."))[0]) }' ${JSON} >> ${DIR}/${DIR}.json
    done

    echo ']' >> ${DIR}/${DIR}.json
    echo ']' >> ${DIR}/${DIR}-devel.json
    echo ']' >> ${DIR}/${DIR}-stable.json
}

build_catalog analyzers
build_catalog responders