indexing
	description: "Toggle used in the menu `View' on the %
				% main panel."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	MAIN_PANEL_TOGGLE

inherit

	TOGGLE_B
		rename
			make as toggle_b_make,
			state as armed,
			init_toolkit as toggle_b_init_toolkit
		end

	LICENCE_COMMAND
--		rename
--			init_toolkit as license_command_init_toolkit
		select
			init_toolkit
		end

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create the toggle button.
		do
			toggle_b_make (a_name, a_parent)
			set_values
			set_callbacks
		end
		
	set_values is
			-- Initialize values.
		do
			set_toggle_off
			set_left_alignment
		end

	set_callbacks is
			-- Add callbacks on the toggle button.
		do
			add_activate_action (Current, Void)
		end

feature -- Execution

	work (arg: ANY) is
			-- Perform actions with `Current' when pressed.
		do
			if main_panel.project_initialized then
				toggle_pressed
			elseif armed then
				set_toggle_off
			else
				set_toggle_on
			end
		end

	toggle_pressed is
			-- Show or hide the associated windows according to
			-- its own value.
		deferred
		end			

end -- class MAIN_PANEL_TOGGLE
