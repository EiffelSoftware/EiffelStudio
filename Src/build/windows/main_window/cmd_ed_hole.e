class CMD_ED_HOLE

inherit

	EDIT_BUTTON
		redefine
			process_stone
		end;

creation
	make

feature

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
			set_symbol (Command_pixmap);
			initialize_focus;
		end;

	process_stone is
		local
			cmd_type: CMD;
			cmd_inst: CMD_INSTANCE
		do
			cmd_type ?= stone.original_stone;
			cmd_inst ?= stone.original_stone;
			if not (cmd_type = Void) then
				cmd_type.create_editor
			elseif not (cmd_inst = Void) then
				cmd_inst.associated_command.create_editor
			end;
		end;

feature {NONE}

	focus_label: LABEL is
		do
			Result := main_panel.focus_label;
		end;

	focus_string: STRING is "Command type hole";	


end
