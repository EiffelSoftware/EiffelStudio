
--=========================== class BEHAVIOR_HOLE ===================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- Hole which can receive behavior stones.
-- Output of state function.
--
--===================================================================

class BEHAVIOR_HOLE 

inherit

	ELMT_HOLE
		rename
			make as elmt_hole_make
		redefine
			associated_function,
			associated_symbol, associated_label,
			process_behavior, stone_type
		end

creation

	make
	
feature 

	make (a_parent: COMPOSITE; func: STATE_EDITOR) is
		do
			elmt_hole_make (a_parent, func)
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.behavior_type
		end;

feature {NONE}

	associated_function: STATE_EDITOR;

	associated_symbol: PIXMAP is
		do
			Result := Pixmaps.behavior_pixmap
		end;

	associated_label: STRING is
		do
			Result := Widget_names.behaviour_label
		end;

	process_behavior (b_stone: BEHAVIOR_STONE) is
		do
			associated_function.update_output_hole (b_stone)
		end;

end
