
indexing
	
	description: "Access to Unix-specific operating system services";
	author: "David Hollenberg";
	date: "October 7, 1997"

class PROCESS_UNIX_OS_ACCESS

feature

	unix_os: PROCESS_UNIX_OS is
			-- Access to Unix-specific operating system services
		once
			create Result;
		end;

end -- class PROCESS_UNIX_OS_ACCESS
