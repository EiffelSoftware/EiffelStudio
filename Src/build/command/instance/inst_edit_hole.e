
class INST_EDIT_HOLE 

inherit

	EB_BUTTON_COM;
	HOLE
		redefine
			process_instance
		select
			init_toolkit
		end;
	DRAG_SOURCE;
	CMD_INST_STONE;
	COMMAND;

creation

	make

feature {NONE}

	instance_editor: CMD_INST_EDITOR;
			-- Associated instance editor

feature 

	data: CMD_INSTANCE is
		do
			if instance_editor.command_instance /= Void then
				Result := instance_editor.command_instance.data
			end
		end;

	target, source: WIDGET is
		do
			Result := Current
		end;

-- samik	focus_label: FOCUS_LABEL is
-- samik		do
-- samik			Result := instance_editor.focus_label
-- samik		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.command_instance_label)
		end;

	associated_command: CMD is
		do
			Result := data.associated_command;
		end;

	make (ed: CMD_INST_EDITOR; a_parent: COMPOSITE) is
			-- Create the cmd_edit_hole with `ed' 
			-- as instance_editor.
		require
			not_void_ed: not (ed = Void)
		do
			instance_editor := ed;
			make_visible (a_parent);
			register;
			initialize_transport
		end; 

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_pixmap
		end;

	full_symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_dot_pixmap
		end;

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_symbol (symbol)
			end
		end

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_symbol (full_symbol)
			end
		end

feature {NONE}

	process_instance (dropped: CMD_INST_STONE) is
		local
			inst: CMD_INSTANCE
		do
			inst := dropped.data;
			if inst.edited then
				inst.inst_editor.raise
			else
				instance_editor.set_instance (inst)
			end
		end; 

	execute (argument: ANY) is
		local
			inst: CMD_INSTANCE
		do
			if (data /= Void) then
				!!inst.session_init (data.associated_command);
				instance_editor.set_instance (inst)
			end 
		end;


end
