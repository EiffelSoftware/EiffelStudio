indexing
	description: "Shared object to know what is the computer%
				%where ebench is running.";
	date: "$Date$";
	revision: "$Revision$"

class
	SHARED_PLATFORM_CONSTANTS

feature -- Access

	Platform_constants: PLATFORM_CONSTANTS is
			-- To get on what kind of computer we are running
		once
			create Result
		end

end -- class SHARED_PLATFORM_CONSTANTS
