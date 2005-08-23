indexing
	description: "Objects that hold constants for GB_ABOUT_DIALOG"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_ABOUT_DIALOG_CONSTANTS

feature -- Access

	t_version_info: STRING is
		once
			Result := "EiffelBuild (5.7.011)"
		end

	t_Copyright_info: STRING is
		once
			Result := 
				"Copyright (C) 1985-2004 Eiffel Software Inc.%N%
				%All rights reserved"
		end

	t_info: STRING is
		once
			create Result.make (500)
			Result.append (
				"Eiffel Software Inc.%N%
				%ISE Building%N%
				%356 Storke Road, Goleta, CA 93117 USA%N%
				%Telephone: 805-685-1006, Fax 805-685-6869%N%
				%Electronic mail: <info@eiffel.com>%N%
				% %N%
				%Web Customer Support: http://support.eiffel.com%N%
				%Visit Eiffel on the Web: http://www.eiffel.com%N"
			)
		end

invariant
	invariant_clause: True -- Your invariant here

end -- class GB_ABOUT_DIALOG_CONSTANTS
