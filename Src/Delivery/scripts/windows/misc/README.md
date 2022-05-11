The current process to sign the Windows releases:
- Build the delivery as usual (it will upload to S3 storage)
- Sign the release content:
  `bash ./ev_code_sign_release_final.sh 22.05 123456 win64 target_archive.7z`
- upload the ` target_archive.7z ` to the Windows build machine, and rebuild the .msi
- Sign the release .msi files
  `bash ./ev_code_sign_release_final.sh 22.05 123456`
- Upload the result directly to s3 storage, using upload_final.sh .
