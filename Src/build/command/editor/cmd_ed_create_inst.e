
class CMD_ED_CREATE_INST 
 
inherit
	WINDOWS
	EB_BUTTON;
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

	focus_label: FOCUS_LABEL is
		do
			Result := command_editor.focus_label
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.create_instance_label
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.create_command_instance_b_pixmap;
		end;
			
feature {NONE}

	execute (arg: ANY) is
		local
			inst_editor: CMD_INST_EDITOR;
			inst: CMD_INSTANCE;
		do
			if command_editor.current_command /= Void then
				!!inst.session_init (command_editor.current_command);
				inst_editor := window_mgr.cmd_inst_editor;
				inst_editor.set_instance (inst);
				window_mgr.display (inst_editor)
			end
		end;

end
