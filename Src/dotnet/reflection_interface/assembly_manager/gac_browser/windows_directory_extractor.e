indexing
	description: "Temporary class to call GetWindowsDirectory"
	external_name: "ISE.AssemblyManager.WindowsDirectoryExtractor"

external class
	WINDOWS_DIRECTORY_EXTRACTOR

create
	make
	
feature {NONE} -- Initialization

	frozen make is
	      	  	-- Initialize structure.
		external
			"IL creator use ISE.AssemblyManager.WindowsDirectoryExtractor"
		end
	
feature -- Access

	frozen windows_directory_name: STRING is
	        	-- Windows path on this machine.
		external
		   	"IL signature (): System.String use ISE.AssemblyManager.WindowsDirectoryExtractor"
		alias
			"WindowsDirectoryName"
		end

end -- class WINDOWS_DIRECTORY_EXTRACTOR
