
class CMD_ED_INST_ED_H 
 
inherit
 
	CMD_EDITOR_HOLE
		rename
			make as old_make
		end
	WINDOWS;
	COMMAND

creation

	make

feature {NONE}

	make (ed: CMD_EDITOR; a_parent: COMPOSITE) is
		do
			old_make (ed, a_parent);
			add_activate_action (Current, Void)
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.command_instance_label
		end;

	source: WIDGET is
		do
			Result := Current
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.create_command_instance_b_pixmap;
		end;
			
feature {NONE}

	create_instance_editor (c: CMD) is
		local
			inst_editor: CMD_INST_EDITOR;
			inst: CMD_INSTANCE;
		do
			if not (c = Void) then
				!!inst.session_init (c);
				inst_editor := window_mgr.cmd_inst_editor;
				inst_editor.set_instance (inst);
				window_mgr.display (inst_editor)	
			end
		end;
 
	process_stone is
		local
			cmd_type: CMD_STONE;
			cmd_inst: CMD_INST_STONE
		do
			cmd_type ?= stone;
			cmd_inst ?= stone;
			if not (cmd_type = Void) then
				create_instance_editor (cmd_type.original_stone);
			elseif not (cmd_inst = Void) then
				create_instance_editor (cmd_inst.associated_command)
			end
		end; -- process_stone

	execute (argument: ANY) is
		do
			create_instance_editor (command_editor.current_command)	
		end;
 
end
