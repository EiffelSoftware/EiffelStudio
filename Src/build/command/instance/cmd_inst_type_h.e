
class CMD_INST_TYPE_H 

inherit

	COMMAND;
	EB_BUTTON_COM;
	HOLE

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

	focus_string: STRING is
		do
			Result := Focus_labels.command_type_label
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := instance_editor.focus_label
		end;

	source, target: WIDGET is
		do	
			Result := Current
		end
	
feature {NONE}

	process_stone is
		local
			inst: CMD_INSTANCE;
			cmd_type: CMD_STONE;
			cmd_instance: CMD_INST_STONE
		do
			cmd_type ?= stone;
			cmd_instance ?= stone;
			if not (cmd_type = Void) then
				!!inst.session_init (cmd_type.original_stone);
				instance_editor.set_instance (inst)
			elseif not (cmd_instance = Void) then
				!!inst.session_init (cmd_instance.associated_command);
				instance_editor.set_instance (inst)
			end
		end; -- process_stone

	execute (argument: ANY) is
		local
			cmd: CMD;
			inst: CMD_INSTANCE
		do
			if not (instance_editor.command_instance = Void) then
				cmd := instance_editor.command_instance.associated_command;
				!!inst.session_init (cmd);
				instance_editor.set_instance (inst)
			end
		end;

end 
