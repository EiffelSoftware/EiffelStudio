indexing
	description: "Context editor hole."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CON_ED_HOLE

inherit
	EDIT_BUTTON
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_TOOL_BAR) is
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{EDIT_BUTTON} Precursor (par)
			create cmd.make (~process_context)
			add_pnd_command (Pnd_types.context_type, cmd, Void)
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.context_pixmap
		end

--	create_focus_label is 
--		do
--			set_focus_string(Focus_labels.context_label)
--		end

	create_empty_editor is
		local
			editor: CONTEXT_EDITOR_TOP_SHELL
		do
			editor := window_mgr.context_editor
			window_mgr.display (editor)
		end

feature {CON_ED_HOLE} -- Pick and Drop

	process_context (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			ctxt: CONTEXT
		do
			ctxt ?= ev_data.data
			ctxt.create_editor
		end

end -- class CON_ED_HOLE

