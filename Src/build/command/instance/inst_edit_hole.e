
class INST_EDIT_HOLE 

inherit

	EB_BUTTON_COM;
	HOLE
		redefine
			stone, compatible
		end;
	CMD_INST_STONE
		redefine
			transportable
		end;
	COMMAND;

creation

	make

feature {NONE}

	instance_editor: CMD_INST_EDITOR;
			-- Associated instance editor

	transportable: BOOLEAN is
		do
			Result := original_stone /= Void
		end;

feature 

	original_stone: CMD_INSTANCE is
		do
			Result := instance_editor.command_instance.original_stone
		end;

	arguments: LINKED_LIST [ARG_INSTANCE] is
		do
			Result := original_stone.arguments;
		end;

	target, source: WIDGET is
		do
			Result := Current
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := instance_editor.focus_label
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.command_instance_label
		end;

	associated_command: CMD is
		do
			Result := original_stone.associated_command;
		end;

	stone: CMD_INST_STONE;

	compatible (s: CMD_INST_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
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
		end; 

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_pixmap
		end;

	label: STRING is
		do
			Result := stone.label
		end
	
feature {NONE}

	process_stone is
		local
			inst: CMD_INSTANCE
		do
			inst := stone.original_stone;
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
			if (original_stone /= Void) then
				!!inst.session_init (original_stone.associated_command);
				instance_editor.set_instance (inst)
			end 
		end;


end
