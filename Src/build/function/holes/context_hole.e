
--=========================== class CONTEXT_HOLE ====================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- Hole which can receive context stones.
-- Input of state function.
--
--===================================================================

class CONTEXT_HOLE 

inherit

	LABELS;
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

	make (a_parent: COMPOSITE; func: FUNC_EDITOR) is
		do
			elmt_hole_make (a_parent, func);
		end;

	stone: CONTEXT_STONE;
	
	compatible (s: CONTEXT_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

feature {NONE}

	associated_function: FUNC_EDITOR;	

	associated_symbol: PIXMAP is
		do
			Result := Pixmaps.context_pixmap
		end;

	associated_label: STRING is
		do
			Result := Context_label
		end;

end
