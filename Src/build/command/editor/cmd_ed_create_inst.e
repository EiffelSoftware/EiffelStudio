
class CMD_ED_CREATE_INST 
 
inherit
	WINDOWS
		select
			init_toolkit
		end
	EB_BUTTON
	COMMAND

creation
	make

feature {NONE}

	command_editor: CMD_EDITOR;

	make (ed: CMD_EDITOR; a_parent: COMPOSITE) is
		do
			command_editor := ed;
			make_visible (a_parent);
			add_activate_action (Current, Void)
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.create_instance_label)
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.create_command_instance_pixmap;
		end;
			
feature {NONE}

	execute (arg: ANY) is
		local
			command_tool: COMMAND_TOOL;
			inst: CMD_INSTANCE;
		do
			if command_editor.current_command /= Void then
				!!inst.session_init (command_editor.current_command);
				command_tool := window_mgr.cmd_command_tool;
				command_tool.set_instance (inst);
				window_mgr.display (command_tool)
			end
		end;

end
