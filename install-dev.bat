@echo OFF

set ORG_ALIAS=s3

@echo:
echo Installing Functions + S3 demo org (%ORG_ALIAS%)
@echo:


echo Creating scratch org...
cmd.exe /c sfdx force:org:create -s -f config/project-scratch-def.json -a %ORG_ALIAS% --targetdevhubusername lmohan@functions-demo-pre.w22  -d 30
call :checkForError
@echo:

echo Pushing source...
cmd.exe /c sfdx force:source:push -f -u %ORG_ALIAS%
call :checkForError
@echo:

echo Assigning permissions...
cmd.exe /c sfdx force:user:permset:assign -n Functions -u %ORG_ALIAS%
call :checkForError
@echo:

rem Check exit code
@echo:
if ["%errorlevel%"]==["0"] (
  echo Installation completed.
  @echo:
  cmd.exe /c sfdx force:org:open -u %ORG_ALIAS%
)

:: ======== FN ======
GOTO :EOF

rem if the app has failed
:checkForError
if NOT ["%errorlevel%"]==["0"] (
    echo Installation failed.
    exit /b %errorlevel%
)