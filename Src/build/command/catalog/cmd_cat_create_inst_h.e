
class CMD_CAT_CREATE_INST_H 

inherit

	HOLE
		redefine
			process_stone
		end;
	EB_BUTTON_COM

creation

	make

feature {NONE}

	focus_string: STRING is
		do
			Result := Focus_labels.create_instance_label
		end;

	focus_label: FOCUS_LABEL is
		do
			Result := command_catalog.focus_label
		end;

	target: WIDGET is
		do
			Result := Current
		end;

	make (a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
			initialize_focus;
			register
		end; -- Create
 
	symbol: PIXMAP is
		do
			Result := Pixmaps.create_command_instance_pixmap
		end;

feature {NONE}

	process_stone is
		require else
			valid_stone: stone /= void;
		local
			inst_editor: CMD_INST_EDITOR;
			inst: CMD_INSTANCE;
			com_type: CMD;
			com_inst: CMD_INSTANCE
		do
			com_type ?= stone.original_stone;
			com_inst ?= stone.original_stone;
			if (com_type /= Void) then
				!!inst.session_init (com_type);
				inst.create_editor
			elseif (com_inst /= Void) then
				!!inst.session_init (com_inst.associated_command);
				inst.create_editor
			end					
		end;

	execute (argument: ANY) is
		local
			inst_editor: CMD_INST_EDITOR
		do
			inst_editor := window_mgr.cmd_inst_editor;
			window_mgr.display (inst_editor)	
		end;


end 
