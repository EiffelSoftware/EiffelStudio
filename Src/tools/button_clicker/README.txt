Description

Running Eweasel, people may have to disable those intempestive dialogs that shows up when test crashes asking if one wants to debug it. One may follow Dr Watson (http://dev.eiffel.com/Dr_Watson) to disable them, But sometimes it doesn't work for some reasons. This tool is made as another choice to close those annoying windows.

The tool is functionally simple, and easy to use. Simply start it before or after launching eweasel tests with few settings:

    * Top Window Title - The window where the button to click is.
    * Button Text - The text on the button to be clicked. Note that one need to add a "&" before the shortcut character. 
    * Scan interval - Interval between each scanning for the button, in seconds.

One can use this tool to automatically click buttons raised by applications that may break smooth processes. For example, a tool unconfigurably needs confirmation on certain behaviors (Deleting, Ignoring and so on).

Dependencies

    * EiffelBase
    * EiffelVision2
    * EiffelStudio

Supported Platforms

    * Windows

