indexing

	description: 
		"Shared file servers.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_FILE_SERVER

feature -- Access

	Class_content_server: CLASS_CONTENT_SERVER is
			-- File server for requesting class 
			-- content (eg. features and invariants) information
		once
			!! Result.make 
		end

	Temporary_system_file_server: S_CASE_FILE_SERVER is
			-- Server file that temporary stores
			-- class and system information. All files
			-- in this server have temporary extension.
		once
			!! Result;
		end;

end -- class SHARED_FILE_SERVER
