indexing
	description: "Temporary class to call GetWindowsDirectory"
	external_name: "WindowsDirectoryExtractor"

external class
	WINDOWS_DIRECTORY_EXTRACTOR

create
	make
	
feature {NONE} -- Initialization

	frozen make is
	      	  	-- Initialize structure.
		external
			"IL creator use WindowsDirectoryExtractor"
		end
	
feature -- Access

	frozen windows_directory_name: STRING is
	        	-- Windows path on this machine.
		external
		   	"IL signature (): System.String use WindowsDirectoryExtractor"
		alias
			"WindowsDirectoryName"
		end

end -- class WINDOWS_DIRECTORY_EXTRACTOR
