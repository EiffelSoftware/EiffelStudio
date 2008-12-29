note
	description: "An INI syntax error where a string was unexpected in the INI file text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	INI_UNEXPECTED_SYNTAX_ERROR

inherit
	INI_SYNTAX_ERROR
		redefine
			message
		end

create
	make

feature -- Access

	message: STRING
			-- Full error message
		do
			create Result.make (sytax_error_prefix.count + unexpected_error_prefix.count + text.count + unexpected_error_suffix.count)
			Result.append (sytax_error_prefix)
			Result.append (unexpected_error_prefix)
			Result.append (text)
			Result.append (unexpected_error_suffix)
		end

feature -- Implementation

	unexpected_error_prefix: STRING = "Unxpected '"
			-- Expected error prefix

	unexpected_error_suffix: STRING = "'.";
			-- Expected error prefix

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

end -- class {INI_UNEXPECTED_SYNTAX_ERROR}
