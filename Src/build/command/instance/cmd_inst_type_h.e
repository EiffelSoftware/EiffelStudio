
class CMD_INST_TYPE_H 

inherit

	COMMAND
		export
			{NONE} all
		end;

	ICON_HOLE
		rename
			make_visible as make_icon_visible
		
		end;

	ICON_HOLE
		redefine
			make_visible
		select
			make_visible
		end;

	PIXMAPS
		export
			{NONE} all
		end;


creation

	make

	
feature {NONE}

	instance_editor: CMD_INST_EDITOR;
			-- Associated instance editor

	
feature 

	make (ed: CMD_INST_EDITOR) is
			-- Create Current with `ed' 
			-- as instance_editor.
		require
			not_void_ed: not (ed = Void)
		do
			instance_editor := ed;
			set_symbol (Create_command_instance_pixmap);
		end; -- Create

	make_visible (a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_icon_visible (a_parent);
			add_activate_action (Current, Nothing)
		end;

	
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
