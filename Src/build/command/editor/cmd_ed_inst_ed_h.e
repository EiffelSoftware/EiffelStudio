
class CMD_ED_INST_ED_H 
 
inherit
 
	CMD_EDITOR_HOLE
		rename
			make as old_make
		redefine
			compatible, process_command,
			process_instance
		end
	WINDOWS;
	COMMAND

creation

	make

feature {NONE}

	make (ed: CMD_EDITOR; a_parent: COMPOSITE) is
		do
			old_make (ed, a_parent);
			-- added by samik
			set_focus_string (Focus_labels.command_instance_label)
			-- end of samik
			add_activate_action (Current, Void)
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

	stone_type: INTEGER is
		do
		end;

	compatible (st: STONE): BOOLEAN is
		do
			Result := 
				st.stone_type = Stone_types.command_type or else
				st.stone_type = Stone_types.instance_type
		end;
 
	process_command (cmd_stone: CMD_STONE) is
		do
			create_instance_editor (cmd_stone.data);
		end;

	process_instance (inst_stone: CMD_INST_STONE) is
		do
			create_instance_editor (inst_stone.associated_command)
		end; 

	execute (argument: ANY) is
		do
			create_instance_editor (command_editor.current_command)	
		end;
 
end
