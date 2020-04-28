# WrapcUI

## Note
> This code depends on URI launcher, a library you will need to download at https://svn.eiffel.com/eiffelstudio/trunk/Src.
> To use this tool, ensure you have set the environment variable %EIFFEL_SRC% to the directory where you have checked out the code.

## Compiling

The WrapC UI project consists of two targets: `wrapcui` and `test`. The `wrapcui` is the production target, where you will finalize an executable. The `test` target is dedicated to writing and executing tests against the production target code. Presently, there is but one test, which was used to prove the code that parses the wrapcui configuration "Save" file, which is just XML.

To create a finalized executable, open the `wrapcui` target and compile (or clean compile if needed). With a successful compile, Ctrl-Shift-F7 or select `Finalize` from the `Project` menu option. The executable will be produced in the `F_code` folder under your EIFGENs folder in the project folder. Move the executable to a folder of your choice and ensure you have set a proper PATH to it for later.

### Execution in Workbench

If you run WrapCUI in EiffelStudio's Workbench mode, you may find that you encounter an error where the code is not creating the target output directory structure. This is a known limitation (bug perhaps). The code works in the finalized executable.

## Using

The UI code literally wraps the EWG code, which is the basis of the WrapC CLI project and executable. Therefore, the UI controls mimick the CLI options. When WrapCUI first opens, each of the text fields are blank (empty). From here, you have two choices.

* Manually set each option as needed by your project.
* Open options previously set and saved as an XML-based WrapCUI configuration file (named whatever you like, with whatever extension you like).

### Manual Option Setting

Before setting options for full-header and output-dir, you will need to:

* Download your target C project, which will have your target header (*.h) file.
* Create your target output directory.

#### Full Header Option

Manaully type the full or relative path (relative to your current directory) to your target header file.

Alternatively, use the `...` button to set the full path using the file-open dialog that appears.

#### Output Directory Option

Manually type the full or relative path to your target output directory.

Alternatively, use the `...` button to set the full path using the directory dialog that appears.

#### C-compiler Options

Manually enter any C compiler options as needed.

#### Pre-process Script

Manually enter the full or relative path to a pre-process script, as needed.

#### Post-process Script

Manually enter the full or relative path to a post-process script, as needed.

#### Config XML File

Manually type the full or relative path to a config.xml (or other name) file, as needed.

Alternatively, use the `...` button to set the full path to a config.xml file using the file-open dialog that appears.

## Next Steps

Once all of the options are set, you have several steps available to you.

* `Save` the configuration in an XML file. Do this if you desire to quickly and easily reload the configuration you've just created.
* `Clean` the output directory (delete all files and folders in it)
* `Run` WrapC with the configuration you have set up or loaded (`File->Open`)

#### Note on Cleaning

There is a bug in EWG we have not found yet where once you click `Run`, the code does not release its file handles. Attempting to run `Clean` after a `Run` will generate an error and the files and folders will not be deleted. In order to successfully `Clean`, you will need to ensure the configuration is `Save`d, close WrapCUI, re-open WrapCUI, `Open` the saved configuration, and then `Clean` it.
