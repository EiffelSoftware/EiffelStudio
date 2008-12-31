note
	description: "Error to indicate that a specified ini contains an override for a reserved property name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_MISSING_INI_RESERVED_PROPERTY

inherit
	ERROR_ERROR_INFO
		redefine
			code
		end

create
	make_with_context

feature -- Access

	code: STRING
			-- Error code
		once
			Result := "EINI3"
		end

feature {NONE} -- Implementation

	dollar_description: STRING
			-- Dollar encoded description. $x are replaced by array
			-- indicies.
		do
			Result := "The specified INI pixmap matrix files contains a definition for the reserved property '{1}'."
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {ERROR_MISSING_INI_RESERVED_PROPERTY}
