indexing

	description:
			"Set all specified values back to default.";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_DEFAULTS

inherit
	EWB_CMD
		rename
			name as defaults_cmd_name,
			help_message as defaults_help,
			abbreviation as defaults_abb
		redefine
			loop_action
		end;
	SHARED_QUERY_VALUES

creation
	make_loop

feature -- Creation

	make_loop (parent: BASIC_EWB_LOOP) is
			-- Create menu-option with link
			-- to `parent'
		do
			main_menu := parent;
		end;

feature {NONE} -- Execute

	loop_action is
			-- Execute the command.
		do
			execute;
		end;

	execute is
			-- Reset all menu options to default.
		local
			ewb_cmd: EWB_CMD;
		do
			clear_values;
			!EWB_NUMBER_OF_CALLS! ewb_cmd.make_loop;
			main_menu.switches_menu.force (ewb_cmd, 1);
			!EWB_FEATURENAME! ewb_cmd.make_loop;
			main_menu.switches_menu.force (ewb_cmd, 2);
			!EWB_TOTAL_SEC! ewb_cmd;
			main_menu.switches_menu.force (ewb_cmd, 3);
			!EWB_SELF_SEC! ewb_cmd;
			main_menu.switches_menu.force (ewb_cmd, 4);
			!EWB_DESCENDENTS_SEC! ewb_cmd;
			main_menu.switches_menu.force (ewb_cmd, 5);
			!EWB_PERCENTAGE! ewb_cmd;
			main_menu.switches_menu.force (ewb_cmd, 6);
			!EWB_INPUT! ewb_cmd.make_loop;
			main_menu.profile_menu.force (ewb_cmd, 7);
			!EWB_LANGUAGE! ewb_cmd.make_loop;
			main_menu.profile_menu.force (ewb_cmd, 8);
			!EWB_RUN_PROF! ewb_cmd;
			main_menu.profile_menu.force (ewb_cmd, 9);
		end;

feature {NONE} -- Attributes

	main_menu: BASIC_EWB_LOOP
		-- The manin menu with all sub menus.
		-- Needed for reinitialization of the options in this menu.

end -- class EWB_DEFAULTS
