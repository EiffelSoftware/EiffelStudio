
class CMD_CAT_CREATE_INST_H 

inherit

	HOLE
		redefine
			compatible, process_command,
			process_instance
		select
			init_toolkit
		end;
	EB_BUTTON_COM
	
creation

	make

feature {NONE}

	create_focus_label is
		do
			set_focus_string (Focus_labels.create_instance_label)
		end;

	target: WIDGET is
		do
			Result := Current
		end;

	make (a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
--			initialize_focus;
			register
		end; -- Create
 
	symbol: PIXMAP is
		do
			Result := Pixmaps.create_command_instance_pixmap
		end;

feature {NONE}

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
		local
			inst: CMD_INSTANCE
		do
			!!inst.session_init (cmd_stone.data);
			inst.create_editor
		end;

	process_instance (cmd_inst_stone: CMD_INST_STONE) is
		local
			inst: CMD_INSTANCE
		do
			!!inst.session_init (cmd_inst_stone.associated_command);
			inst.create_editor
		end;

	execute (argument: ANY) is
		local
			inst_editor: CMD_INST_EDITOR
		do
			inst_editor := window_mgr.cmd_inst_editor;
			window_mgr.display (inst_editor)	
		end;


end 
