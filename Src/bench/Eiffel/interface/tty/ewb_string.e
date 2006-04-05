indexing

	description: 
		"Description of a menu entry string for%
		%command line option for ec -loop."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_STRING 

inherit

	EWB_CMD

create

	make

feature -- Initialization

	make (n, h: STRING; c: CHARACTER; s: EWB_MENU) is
		do
			name := n;
			int_help_message := h;
			abbreviation := c;
			sub_menu := s
		end;

feature -- Properties

	name: STRING;

	help_message: STRING is
		do
			Result := int_help_message;
		end;

	abbreviation: CHARACTER;

	sub_menu: EWB_MENU;

feature {NONE} -- Execution

	execute is
		do
		end;

feature {NONE} -- Attributes

	int_help_message: STRING;

indexing
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

end -- class EWB_STRING
