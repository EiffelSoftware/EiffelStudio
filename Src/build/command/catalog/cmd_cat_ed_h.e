
class CMD_CAT_ED_H 

inherit

	CMD_CAT_BUTTON
		rename
			button as source,
			make_visible as make_button_visible,
			make as cmd_cat_make,		
			identifier as cmd_cat_identifier
		redefine
			process_stone
		end;

	CMD_CAT_BUTTON
		rename
			button as source,
			make as cmd_cat_make,
			identifier as cmd_cat_identifier
		redefine
			make_visible, process_stone
		select
			make_visible
		end;
	STONE
		redefine
			original_stone
		end;	
	CURSORS
		rename
			Command_cursor as stone_cursor
		end;
	COMMAND;
	PIXMAPS

creation

	make

feature {NONE}

	original_stone: like Current;
	
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

feature 

	make (f: STRING) is
		do
			focus_string := f;
			register
		end;

	make_visible (a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_button_visible (a_parent);
			set_symbol (Command_pixmap);
			initialize_transport;
			add_activate_action (Current, Nothing)
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
