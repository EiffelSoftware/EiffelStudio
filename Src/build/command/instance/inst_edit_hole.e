
class INST_EDIT_HOLE 

inherit

	ICON_HOLE
		redefine
			stone
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

	stone: CMD_INST_STONE;

	make (ed: CMD_INST_EDITOR) is
			-- Create the cmd_edit_hole with `ed' 
			-- as instance_editor.
		require
			not_void_ed: not (ed = Void)
		do
			instance_editor := ed;
			set_symbol (Command_instance_pixmap);
		end; -- Create

	
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

end
