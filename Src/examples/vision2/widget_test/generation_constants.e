indexing
	description: "Objects that represents constants for code generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GENERATION_CONSTANTS
