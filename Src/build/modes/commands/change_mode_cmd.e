indexing

	description:
		"EiffelBuild command to change the editing/executing mode.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	CHANGE_MODE_CMD

inherit

	COMMAND
	MODE_CONSTANTS
	SHARED_MODE
		rename
			current_mode as editing_or_executing_mode
		end
	WINDOWS
	SHARED_CONTROL
	STATES

feature -- Execution

	execute (arg: ANY) is
			-- Change editing/executing mode to `new_mode'.
		local
			new_mode_ref: INTEGER_REF
			new_mode: INTEGER
			application: APPLICATION
		do
			new_mode_ref ?= arg
			new_mode := new_mode_ref.item
			set_mode (new_mode)
			if new_mode = executing_mode then
					-- Hide EiffelBuild Tools
				main_panel.disable
					-- Initialize state of the application
				!! application.make
			else
				main_panel.enable
			end
 		end
		
end -- Class CHANGE_MODE_CMD
