indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "ISE.AssemblyManager.WindowsDirectoryExtractor"
	assembly: "ISE.AssemblyManager.WindowsDirectoryExtractor", "5.0.0.1", "neutral", "9a928af6e2626f"

external class
	WINDOWS_DIRECTORY_EXTRACTOR

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use ISE.AssemblyManager.WindowsDirectoryExtractor"
		end

feature -- Basic Operations

	frozen windows_directory_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use ISE.AssemblyManager.WindowsDirectoryExtractor"
		alias
			"WindowsDirectoryName"
		end

	frozen get_windows_directory_w (res: SYSTEM_STRING; size: INTEGER): INTEGER is
		external
			"IL static signature (System.String, System.Int32): System.Int32 use ISE.AssemblyManager.WindowsDirectoryExtractor"
		alias
			"GetWindowsDirectoryW"
		end

end -- class WINDOWS_DIRECTORY_EXTRACTOR
