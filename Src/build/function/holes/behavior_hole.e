
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

	PIXMAPS
		export
			{NONE} all
		end;

	LABELS
		export
			{NONE} all
		end;

	ELMT_HOLE
		rename
			make as elmt_hole_make
		redefine
			stone, associated_function,
			associated_symbol, associated_label,
			compatible
		end

creation

	make
	
feature 

	make (a_parent: COMPOSITE; func: STATE_EDITOR) is
		do
			elmt_hole_make (a_parent, func)
		end;

	context: CONTEXT is
		do
			Result := stone.context
		end;

	stone: BEHAVIOR_STONE;

	compatible (s: BEHAVIOR_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	
feature {NONE}

	associated_function: STATE_EDITOR;

	associated_symbol: PIXMAP is
		do
			Result := Behavior_pixmap
		end;

	associated_label: STRING is
		do
			Result := Behavior_label
		end;

end
