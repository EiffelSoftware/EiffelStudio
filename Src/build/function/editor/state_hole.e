indexing
	description: "Hole on the main panel representing the %
				% current state."
	date: "$Date$"
	revision: "$Revision$"

class
	STATE_HOLE

inherit
 	EB_BUTTON
		redefine
			make
		end

	EV_COMMAND

	SHARED_APPLICATION

creation
	make

feature {NONE} -- Initialization

	make (par: EV_TOOL_BAR) is
			-- Creation routine.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			Precursor (par)
			add_button_press_command (1, Current, Void)

			create cmd.make (~process_state)
			add_pnd_command (Pnd_types.state_type, cmd, Void)
		end

feature -- Access

	set_update_procedure (pr: PROCEDURE [ANY, TUPLE [BUILD_STATE]]) is
		do
			update_procedure := pr
		end

--	set_state (s: STRING) is
--			-- Set current state to `s'.
--		local
--			state: BUILD_STATE
--		do
--			state := Shared_app_graph.state (s)
--			if state /= Void then
--				update_main_panel (state)
--			end
--		end

--	create_empty_editor is
--		local
--			editor: STATE_EDITOR
--		do
--			editor := Window_mgr.state_editor
--			window_mgr.display (editor)
--		end

feature {NONE} -- Implementation

	update_procedure: PROCEDURE [ANY, TUPLE [BUILD_STATE]]
			-- Procedure called when the state is changed

	symbol: EV_PIXMAP is
			-- Pixmap appearing on the button.
		do
			Result := Pixmaps.state_pixmap
		end

--	create_focus_label is
--			-- Create focus label.
--		do
--			set_focus_string (Focus_labels.current_state_label)
--		end

	process_state (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Process a states.
		local
			st: BUILD_STATE
		do
			st ?= ev_data.data
			update_procedure.call ([st])
		end

	execute (arg: EV_ARGUMENT; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Update the list of available states.
		local
			menu: EV_POPUP_MENU
			elmt: EV_MENU_ITEM
			update_cmd: EV_ROUTINE_COMMAND
			arg1: EV_ARGUMENT1 [EV_MENU_ITEM]
			states: LINKED_LIST [BUILD_STATE]
		do
			states := Shared_app_graph.states
			if not states.empty then
				create menu.make (parent.parent)
				from
					states.start
				until
					states.after
				loop
					create elmt.make (menu)
					elmt.set_text (states.item.label)
					elmt.set_data (states.item)
					create update_cmd.make (~update_state)
					create arg1.make (elmt)
					elmt.add_select_command (update_cmd, arg1)
					states.forth
				end
				menu.show_at_position (ev_data.x, ev_data.y)
			end
		end

	update_state (arg: EV_ARGUMENT1 [EV_MENU_ITEM]; ev_data: EV_EVENT_DATA) is
			-- Update the state in the `main_window'.
		local
			st: BUILD_STATE
		do
			st ?= arg.first.data
			update_procedure.call ([st])
		end

end -- class STATE_HOLE

