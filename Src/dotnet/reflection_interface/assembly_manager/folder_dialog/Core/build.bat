midl folder_browser.idl

if exist folder_browser.key goto key_exists
sn -k folder_browser.key
:key_exists

tlbimp /keyfile:folder_browser.key folder_browser.tlb

call make_folder_dialog.bat