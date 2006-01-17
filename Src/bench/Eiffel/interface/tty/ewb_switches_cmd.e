indexing

	description:
		" Description of submenu Switches for %
		% command line option for ec -loop.  %
		% This one prints also the values of  %
		% the switches in the submenu.	      "
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_SWITCHES_CMD

inherit
	EWB_STRING
		redefine
			help_message
		end;

create
	make_without_help

feature -- Initialization

	make_without_help (n: STRING; c: CHARACTER; s: EWB_MENU) is
		do
			name := n;
			abbreviation := c;
			sub_menu := s;
		end;

feature -- Properties

	help_message: STRING is
		local
			ewb_profile_switch: EWB_PROFILE_SWITCH
			i: INTEGER
		do
			Result := switches_help.twin
			Result.append ("%N%T%T%T%T");
			from
				i := 1
			until
				i > sub_menu.count
			loop
				ewb_profile_switch ?= sub_menu.item (i);
				Result.append (ewb_profile_switch.abbrev_cmd_name);
				Result.extend ('-');
				if ewb_profile_switch.show_enabled then
					Result.extend ('E');
				else
					Result.extend ('D');
				end;

				-- Tabs and Newlines are for output like
				-- 1_tab_2_tab_3
				-- 4_tab_5_tab_6
				-- Where the numbers represent the columns.
				if i = 3 then
					Result.append ("%N%T%T%T%T");
				elseif i /= 6 then
					Result.extend ('%T');
				end;
				i := i + 1;
			end;
		end;

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

end -- class EWB_SWITCHES_CMD
