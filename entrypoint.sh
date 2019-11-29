#!/bin/sh -l

# args
# $1 :: ${{ inputs.auth }}
# $2 :: ${{ inputs.title }}
# $3 :: ${{ inputs.content }}
# $4 :: ${{ inputs.description }}
# $5 :: ${{ inputs.public }}
# $6 :: ${{ inputs.response_field }}
# formated
        #{
        #   "files":{
        #       "hello.title":{
        #         "content":"simple.content"
        #      },
        #       "description":"simple.description",
        #       "public":false
        #   }
        #}

title=$(echo $2 | sed 's/\"/\\"/g')
content=$(echo $3 | sed 's/\"/\\"/g')
description=$(echo $4 | sed 's/\"/\\"/g')
public=$5

temp_file=$(mktemp)
echo '{"files":{"'$title'":{"content": "'$content'"}},"description": "'$description'","public": '$public'}' > $temp_file
r_api=$(curl -X POST -H "Content-Type: application/json" -u $1 -s https://api.github.com/gists -d@$temp_file)
rm ${temp_file}

if [ $6 = "url" ]
then
        response=$(echo $r_api | jq '.files | flatten | .[0].raw_url')
else
        response=$(echo $r_api | jq '.files')
fi

echo ::set-output name=response::$response
exit 0
