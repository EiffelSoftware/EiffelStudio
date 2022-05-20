#Example of EV code signing workflow

- Launch the delivery building: generates .7z and .msi (see how to avoid building msi in this first step)
- Sign the content of .7z archives: done remotely, on the machine having the SSl.COM USB token
	`remote_codesigning.bat 22.05 106275 win64 \es-deliv\22.05\win64.VC110_VC140\Eiffel_22.05\setups`
 -> It will overwrite previous build release content

- Go back the deliv folder, and launch the `make_installation` tasks, to redo the .msi
- Sign the new .msi files: done remotely, on the machine having the SSl.COM USB token

	`remote_codesigning_msi.bat 22.05 106275 win64 \es-deliv\22.05\win64.VC110_VC140\Eiffel_22.05\setups`

- 
