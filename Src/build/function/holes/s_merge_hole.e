indexing
	description: "State merge hole."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class S_MERGE_HOLE

inherit
	EB_BUTTON

creation
	make_with_editor
		
feature {NONE} -- Initialization

	make_with_editor (par: EV_TOOL_BAR; ed: STATE_EDITOR) is
		local
			rout_cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [STATE_EDITOR]
		do
			make (par)
			create rout_cmd.make (~process_state)
			create arg.make (ed)
			add_pnd_command (Pnd_types.state_type, rout_cmd, arg)
		end

	process_state (arg: EV_ARGUMENT1 [STATE_EDITOR]; ev_data: EV_PND_EVENT_DATA) is
		local
			st: BUILD_STATE
		do
			st ?= ev_data.data
			if arg.first.edited_function /= st then
				arg.first.edited_function.merge (st)
			end
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.merge_pixmap
		end

end -- class S_MERGE_HOLE

