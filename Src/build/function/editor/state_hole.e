indexing
	description: "Hole on the main panel representing the %
				% current state."
	date: "$Date$"
	revision: "$Revision$"

class
	STATE_HOLE

inherit

	EDIT_BUTTON
		redefine
			make, execute, process_state
		end

	SHARED_APPLICATION

	COMMAND_ARGS


creation

	make

feature -- Initialization

	make (a_parent: COMPOSITE) is
			-- Creation routine
		do
			Precursor (a_parent)
			add_button_press_action (3, Current, First)
		end

feature 

	symbol: PIXMAP is
			-- Pixmap appearing on the button.
		do
			Result := Pixmaps.state_pixmap
		end

	create_focus_label is
			-- Create focus label.
		do
			set_focus_string (Focus_labels.current_state_label)
		end
 
	set_state (s: STRING) is
			-- Set current state to `s'.
		local
			state: BUILD_STATE
		do
			state := Shared_app_graph.state (s)
			if state /= Void then
				update_main_panel (state)
			end
		end

feature {NONE}

	create_empty_editor is
		local
			editor: STATE_EDITOR
		do
			editor := Window_mgr.state_editor
			window_mgr.display (editor)
		end

	states_wnd: MAIN_PANEL_STATES_WND is
			-- List of available states that is displayed
			-- when right-click on the button.
		do
			!! Result.make (main_panel.base, Current)
		end

	stone_type: INTEGER is
			-- Stone type.
		do
			Result := Stone_types.state_type
		end

	process_state (dropped: STATE_STONE) is
			-- Process a states.
		do
			update_main_panel (dropped.data)
		end

	execute (argument: ANY) is
			-- Display the list of available states.
		do
			if argument = First then
				states_wnd.popup (Shared_app_graph.state_names)
			else
				Precursor (argument)
			end
		end

	update_main_panel (s: BUILD_STATE) is
			-- Update the main panel.
		do
			main_panel.set_current_state (s)
		end

end -- class STATE_HOLE
