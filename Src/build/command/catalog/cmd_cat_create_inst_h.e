
class CMD_CAT_CREATE_INST_H 

inherit

	CMD_CAT_BUTTON
        rename
            make as old_create
        redefine
            process_stone
		end;
	PIXMAPS
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

	
feature {NONE}

	process_stone is
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

end 
