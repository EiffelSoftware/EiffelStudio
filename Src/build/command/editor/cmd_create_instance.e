class CMD_CREATE_INSTANCE

inherit

	CMD_COMMAND
		redefine
			redo,
			command_work
		end

creation

	make

feature {NONE}

	make (an_instance: CMD_INSTANCE; an_associated_command: ANY) is
		do
			cmd_instance := an_instance
			execute (an_associated_command)
		end;


	cmd_instance: CMD_INSTANCE;

	c_name: STRING is
		do
			Result := Command_names.cmd_create_instance_cmd_name
		end;

	command_work is
		do
		end;

	redo is
		local
			inst_editor: CMD_INST_EDITOR
		do
			if not cmd_instance.edited then
				inst_editor := window_mgr.cmd_inst_editor;
				inst_editor.set_instance (cmd_instance);
				window_mgr.display (inst_editor)
			end
		end;

	undo is
		do
			if cmd_instance.edited then
				cmd_instance.inst_editor.clear
			end;
		end;

	worked_on: STRING is
		do
			Result := cmd_instance.label
		end;

end
