
class CMD_EDIT_HOLE 

inherit

	ICON_HOLE;

	PIXMAPS
		export
			{NONE} all
		end;


creation

	make

	
feature {NONE}

	command_editor: CMD_EDITOR;
			-- Associated command editor

	
feature 

	make (cmd_editor: CMD_EDITOR) is
			-- Create the cmd_edit_hole with `cmd_editor' 
			-- as command_editor.
		require
			not_void_cmd_editor: not (cmd_editor = Void)
		do
			command_editor := cmd_editor;
			set_symbol (Command_pixmap);
		end; -- Create

	
feature {NONE}

	process_stone is
		local
			cmd_type: CMD_STONE;
			cmd_inst: CMD_INST_STONE
		do
			cmd_type ?= stone;
			cmd_inst ?= stone;
			if not (cmd_type = Void) then 
				if cmd_type.original_stone.edited then
					cmd_type.original_stone.command_editor.raise
				else
					command_editor.set_command (cmd_type.original_stone)
				end
			elseif not (cmd_inst = Void) then
				if cmd_inst.associated_command.edited then
					cmd_inst.associated_command.command_editor.raise
				else	
					command_editor.set_command (cmd_inst.associated_command)
				end
			end
		end; -- process_stone

end -- class CMD_EDIT_HOLE
