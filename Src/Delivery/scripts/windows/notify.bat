@echo off
setlocal
set mesg=%~1

echo NOTIFICATION=%mesg%
rem curl -X POST -H "Content-type: application/json" --data "{\"text\":\"%mesg%\"}" https://hooks.slack.com/services/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

endlocal
