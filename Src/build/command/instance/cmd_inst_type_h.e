
class CMD_INST_TYPE_H 

inherit

	COMMAND;
	EB_BUTTON_COM;
	HOLE
		redefine
			process_command, process_instance,
			compatible
		select
			init_toolkit
		end

creation

	make

	
feature {NONE}

	instance_editor: CMD_INST_EDITOR;
			-- Associated instance editor

	
feature 

	make (ed: CMD_INST_EDITOR; a_parent: COMPOSITE) is
			-- Create Current with `ed' 
			-- as instance_editor.
		require
			not_void_ed: not (ed = Void)
		do
			instance_editor := ed;
			make_visible (a_parent);
			register;
		end; -- Create

	symbol: PIXMAP is
		do
			Result := Pixmaps.create_command_instance_pixmap
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.command_type_label)
		end;

	source, target: WIDGET is
		do	
			Result := Current
		end
	
feature {NONE}

	stone_type: INTEGER is do end;

	compatible (st: STONE): BOOLEAN is
		do
			Result := st.stone_type = Stone_types.command_type or else
				st.stone_type = Stone_types.type_stone_type
		end;

	process_command (cmd_stone: CMD_STONE) is
		local
			inst: CMD_INSTANCE
		do
			!!inst.session_init (cmd_stone.data);
			instance_editor.set_instance (inst)
		end;

	process_instance (inst_stone: CMD_INST_STONE) is
		local
			inst: CMD_INSTANCE
		do
			!!inst.session_init (inst_stone.associated_command);
			instance_editor.set_instance (inst)
		end; 

	execute (argument: ANY) is
		local
			cmd: CMD;
			inst: CMD_INSTANCE
		do
			if instance_editor.command_instance /= Void then
				cmd := instance_editor.command_instance.associated_command;
				!!inst.session_init (cmd);
				instance_editor.set_instance (inst)
			end
		end;

end 
