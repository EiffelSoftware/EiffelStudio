
class CMD_CAT_ED_H 

inherit

	HOLE
		redefine
			process_stone
		end;
	EB_BUTTON_COM;
	STONE
		redefine
			original_stone
		end;	

creation

	make

feature {NONE}

	original_stone: like Current;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.command_cursor
		end;
	
	process_stone is
		require else
			valid_stone: stone /= Void;
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
			end
		end;

feature {NONE}

	label, focus_string: STRING is
		do
			Result := Focus_labels.create_edit_label
		end;

	target, source: WIDGET is
		do
			Result := Current
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := command_catalog.focus_label
		end;

	make (a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
			initialize_transport;
			initialize_focus;
			register
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_pixmap
		end;
	
feature {NONE}

	execute (argument: ANY) is
		local
			doc: EB_DOCUMENT;
			cmd: USER_CMD
		do
			!!cmd.make;
			cmd.set_internal_name ("");
			cmd.set_eiffel_text (cmd.template);
			!!doc;
			doc.set_directory_name (Environment.commands_directory);
			doc.set_document_name (cmd.eiffel_type);
			doc.update (clone (cmd.template));
			doc := Void;
			command_catalog.add (cmd)
		end;

end
