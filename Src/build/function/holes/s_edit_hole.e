indexing
	description: "State editor hole."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class S_EDIT_HOLE

inherit
	FUNC_EDIT_HOLE
		redefine
			function_editor
		end

	EV_COMMAND

creation
	make_with_editor

feature {NONE} -- Implementation

	function_editor: STATE_EDITOR

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.state_pixmap
		end

	full_symbol: EV_PIXMAP is
		do
			Result := Pixmaps.state_dot_pixmap
		end

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.state_label)
--		end

	set_callbacks is
			-- Initialize the pick and drop.
		local
			rout_cmd: EV_ROUTINE_COMMAND
		do
			activate_pick_and_drop (Current, Void)
			create rout_cmd.make (~process_state)
			add_pnd_command (Pnd_types.state_type, rout_cmd, Void)
		end

feature {S_EDIT_HOLE} -- Pick and drop

	execute (arg: EV_ARGUMENT; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Prepare the transport.
		do
			set_transported_data (function_editor.edited_function)
			set_data_type (Pnd_types.state_type)
		end

	process_state (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			circle: STATE_CIRCLE
		do
			circle ?= ev_data.data
			if circle.data.edited then
				circle.data.raise_editor
			else
				function_editor.set_edited_function (circle.data)
			end
		end

end -- class S_EDIT_HOLE

