
class CMD_CAT_CREATE_INST_H 

inherit

	CMD_CAT_BUTTON
		rename
			make as old_create,
			make_visible as make_button_visible
		redefine
			process_stone
		end;

	CMD_CAT_BUTTON
		rename
			make as old_create
		redefine
			process_stone, make_visible
		select
			make_visible
		end;


	PIXMAPS
		export
			{NONE} all
		end;

	COMMAND
		export
			{NONE} all
		end;


creation

	make

	
feature 

	make (s: STRING) is
		do
			focus_string := s;
            set_symbol (Create_command_instance_pixmap);
			register
		end; -- Create

	
    make_visible (a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_button_visible (a_parent);
			add_activate_action (Current, Nothing)
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
