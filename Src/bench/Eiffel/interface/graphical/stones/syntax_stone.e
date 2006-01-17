indexing

	description: 
		"Stone representing a syntax error."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"


class SYNTAX_STONE

inherit

	ERROR_STONE
		rename
			make as make_simple_error
		redefine
			code, file_name, help_text
		end

create

	make

feature {NONE} -- Initialization

	make (a_syntax_errori: SYNTAX_ERROR) is
 		do
			syntax_error_i := a_syntax_errori
		end;

feature -- Properties
 
	syntax_error_i: SYNTAX_ERROR;

feature -- Access

	file_name: STRING is
			-- The one from SYNTAX_ERROR: where it happened
		do
			Result := syntax_error_i.file_name
		end;

	help_text: LINKED_LIST [STRING] is
		do
			create Result.make;
			Result.put_front (Interface_names.h_No_help_available)
		end;

	start_position: INTEGER is do Result := syntax_error_i.start_position end;
			-- Stating position of the token involved in the syntax error

	end_position: INTEGER is do Result := syntax_error_i.end_position end;
			-- Ending position of the of the token involved in the syntax
			-- error

	code: STRING is "Syntax error";;
			-- Error code

indexing
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

end -- class SYNTAX_STONE
