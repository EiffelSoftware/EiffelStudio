
--=========================== class COMMAND_HOLE ====================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- Hole which can receive command stones.
-- Output of behavior function.
--
--===================================================================

class COMMAND_HOLE 

inherit

	ELMT_HOLE
		rename
			make as elmt_hole_make
		redefine
			associated_function,
			associated_symbol, associated_label,
			stone_type, process_instance
		end


creation

	make

	
feature 

	make (a_parent: COMPOSITE; func: BEHAVIOR_EDITOR) is
		do
			elmt_hole_make (a_parent, func);
		end;

	stone_type: INTEGER is
		do
--			Result := Stone_types.instance_type	
			Result := Stone_types.command_type	
		end;

feature {NONE}

	associated_function: BEHAVIOR_EDITOR;

	associated_symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_pixmap
		end;

	associated_label: STRING is
		do
			Result := Widget_names.command_label
		end;

	process_instance (cmd_instance: CMD_INST_STONE) is
        do
            associated_function.update_output_hole (cmd_instance);
        end;

end
