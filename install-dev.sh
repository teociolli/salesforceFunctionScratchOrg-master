#!/bin/bash

# Set parameters
ORG_ALIAS="s3"

echo ""
echo "Installing Functions + S3 demo org:"
echo "- Org alias:      $ORG_ALIAS"
echo ""


echo "Creating scratch org..." && \
sfdx force:org:create -s -f config/project-scratch-def.json -a $ORG_ALIAS -d 30 --targetdevhubusername lmohan@functions-demo-pre.w22 && \
echo "" && \

echo "Pushing source..." && \
sfdx force:source:push -f -u $ORG_ALIAS && \
echo "" && \

echo "Assigning permissions..." && \
sfdx force:user:permset:assign -n Functions -u $ORG_ALIAS && \
echo ""

EXIT_CODE="$?"

# Check exit code
echo ""
if [ "$EXIT_CODE" -eq 0 ]; then
  echo "Installation completed."
  echo ""
  sfdx force:org:open -u $ORG_ALIAS
else
    echo "Installation failed."
fi

exit $EXIT_CODE