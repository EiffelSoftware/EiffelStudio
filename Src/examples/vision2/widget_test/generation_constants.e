indexing
	description: "Objects that represents constants for code generation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATION_CONSTANTS

feature -- Access

	application_file_name: STRING is "test_application.e"
	
	common_test_file_name: STRING is "common_test.e"
	
	ace_file_name: STRING is
		once
			if (create {PLATFORM}).is_windows then
				Result := "ace.Windows.ace"
			else
				Result := "ace.Unix.ace"
			end
		end
	
end -- class GENERATION_CONSTANTS
