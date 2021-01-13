note
	description: "Objects that hold constants for GB_ABOUT_DIALOG"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_ABOUT_DIALOG_CONSTANTS

inherit
	EIFFEL_CONSTANTS

feature -- Access

	t_version_info: STRING
		once
			Result := "EiffelBuild "
			Result.append_string (two_digit_minimum_major_version)
			Result.append_character ('.')
			Result.append_string (two_digit_minimum_minor_version)
			Result.append_character ('.')
				-- We put (9999 + 1) because if we were to put 10000 the 4 zeros
				-- will get replaced by the delivery scripts (see comments for `snv_revision').
			Result.append ((svn_revision // (9999 + 1).as_natural_32).as_natural_16.out)
			Result.append_character ('.')
			Result.append ((svn_revision \\ (9999 + 1).as_natural_32).as_natural_16.out)
		end

	t_Copyright_info: STRING
		once
			Result :=
				"Copyright (C) 1985-2021 Eiffel Software Inc.%N%
				%All rights reserved"
		end

	t_info: STRING
		once
			create Result.make (500)
			Result.append (
				"Eiffel Software%N%
				%5949 Hollister Ave., Goleta, CA 93117 USA%N%
				%Telephone: 805-685-1006%N%
				%Fax 805-685-6869%N%
				%%N%
				%Web Customer Support: http://support.eiffel.com%N%
				%Visit Eiffel on the Web: http://www.eiffel.com%N"
			)
		end

feature {NONE} -- Implementation

	svn_revision: NATURAL_32
			-- SVN revision that build EiffelBuild.
			-- We use `0000' because it is replaced by the actual svn revision number
			-- when doing a delivery.
		do
			Result := 0000
		end

invariant
	invariant_clause: True -- Your invariant here

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_ABOUT_DIALOG_CONSTANTS
