indexing
	description: "Inherit hole within the command editor."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMD_INH_HOLE

inherit
	EB_BUTTON

	EV_COMMAND

	REMOVABLE

creation
	make_with_editor

feature {NONE} -- Initialization

	make_with_editor (par: EV_TOOL_BAR; ed: COMMAND_EDITOR) is
		do
			command_editor := ed
			make (par)
			add_pnd_command (Pnd_types.command_type, Current, Void)
		end

feature {NONE} -- Implementation

--	create_focus_label is
--		do
--			if ancestor_command = Void then
--				set_focus_string (Focus_labels.parent_label)
--			else
--				set_focus_string (data.label)
--			end
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.parent_pixmap
		end

	full_symbol: EV_PIXMAP is
		do
			Result := Pixmaps.parent_dot_pixmap
		end

	command_editor: COMMAND_EDITOR

	ancestor_command: CMD is
		local
			user_cmd: USER_CMD
		do
			user_cmd := command_editor.edited_command
			if user_cmd /= Void then
				Result := user_cmd.ancestor_type
			end
		end

feature {NONE} -- Pick and Drop

	execute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- A command is dropped on current.
		local
			cmd: CMD
		do
			cmd ?= ev_data.data
			command_editor.set_ancestor (cmd)
		end

	remove_yourself is
		do
			command_editor.remove_ancestor
		end

feature {COMMAND_EDITOR} -- Status setting

	update_symbol is
		do
			if ancestor_command = Void then
				set_empty_symbol
			else
				set_full_symbol
			end
		end

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_pixmap (symbol)
			end
		end

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_pixmap (full_symbol)
			end
		end

end -- class CMD_INH_HOLE

