indexing

	description:
		"Test class to test the resources.";
	date: "$Date$";
	revision: "$Revision$"

class TEST_PREFERENCE_TOOL

inherit
	MOTIF_APP
		rename
			make as app_make
		redefine
			build
		end;
	COMMAND;
	RESOURCE_USER
		redefine
			update_boolean_resource
		end;
	EB_CONSTANTS

creation
	make

feature -- Intereface

	build is
		do
			!! form.make ("Basic Form", base);
			!! edit_button.make ("Edit", form);
			!! exit_button.make ("Exit", form);

			edit_button.add_activate_action (Current, edit_it);
			exit_button.add_activate_action (Current, exit_it);

			form.attach_top (edit_button, 10);
			form.attach_left (edit_button, 10);
			form.attach_right (edit_button, 10);
			form.attach_left (exit_button, 10);
			form.attach_right (exit_button, 10);
			form.attach_bottom (exit_button, 10);
			form.attach_top_widget (edit_button, exit_button, 20);

			base.set_size (100,200);

		end

feature {NONE} -- Interface Properties

	form: FORM;
	edit_button, exit_button: PUSH_B

feature {NONE} -- Execution

	execute (argument: ANY) is
			-- Execute Current.
		do
			if argument = edit_it then
				tool := Void
				!! tool.make ("Preference Tool", base.screen)
				!! spc.make (tool);
				!! cpc.make (tool);
				tool.add_preference_category (spc);
				tool.add_preference_category (cpc);
				tool.display;
				tool.raise
			elseif argument = exit_it then
				toolkit.exit
			end
		end

feature {NONE} -- Properties

	tool: PREFERENCE_TOOL;
			-- The preference tool

	spc: SYSTEM_PREF_CAT;
			-- A sample category

	cpc: CLASS_PREF_CAT
			-- A sample category

feature {NONE} -- Execution Properties

	edit_it: ANY is
			-- Argument for `execute'
		once
			!! Result
		end;

	exit_it: ANY is
			-- Argument for `execute'
		once
			!! Result
		end

feature {NONE} -- Initialization

	make is
			-- Initialize Current.
		local
			resources: EB_RESOURCES
		do
			!! resources.initialize;
			System_resources.add_user (Current);
			Class_resources.add_user (Current);
			--modify_resources;
			app_make
		end

feature -- Update

	update_boolean_resource (a_resource: MODIFIED_RESOURCE) is
			-- Update Current to reflect changes in `a_resource'.
		do
			print(a_resource)
			print("%N")
		end

end -- class TEST_PREFERENCE_TOOL
