indexing

	description:
		" Description of submenu Switches for %
		% command line option for ec -loop.  %
		% This one prints also the values of  %
		% the switches in the submenu.	      ";
	date: "$Date$";
	revision: "$Revision $"

class EWB_SWITCHES_CMD

inherit
	EWB_STRING
		redefine
			help_message
		end;

creation
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
			Result := clone(switches_help);
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

end -- class EWB_SWITCHES_CMD
