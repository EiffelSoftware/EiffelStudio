indexing
	description: "Behavior editor hole."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class B_EDIT_HOLE

inherit
	FUNC_EDIT_HOLE
		redefine
			function_editor
		end

	EV_COMMAND

creation
	make_with_editor

feature {NONE} -- Implementation

	function_editor: BEHAVIOR_EDITOR

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.behavior_pixmap
		end

	full_symbol: EV_PIXMAP is
		do
			Result := Pixmaps.behavior_dot_pixmap
		end

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.behaviour_label)
--		end

	set_callbacks is
			-- Initialize the pick and drop.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			activate_pick_and_drop (Current, Void)
			create cmd.make (~process_behavior)
			add_pnd_command (Pnd_types.behavior_type, cmd, Void)
		end

feature {B_EDIT_HOLE} -- Drag and drop

	execute (arg: EV_ARGUMENT; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Prepare the transport.
		do
			set_transported_data (function_editor.edited_function)
			set_data_type (Pnd_types.behavior_type)
		end

	process_behavior (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			bh: BEHAVIOR
		do
			bh ?= ev_data.data
			function_editor.edited_function.merge (bh)
		end

end -- class B_EDIT_HOLE

