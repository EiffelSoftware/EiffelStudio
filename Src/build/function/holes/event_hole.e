
--=========================== class EVENT_HOLE =====================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- Hole which can receive event stones.
-- Input of behavior function.
--
--===================================================================

class EVENT_HOLE 

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
			associated_symbol, associated_label
		end

creation

	make

feature 

	make (a_parent: COMPOSITE; func: BEHAVIOR_EDITOR) is
		do
			elmt_hole_make (a_parent, func);
		end;

	stone: EVENT_STONE;

	
feature {NONE}

	associated_function: BEHAVIOR_EDITOR;

	associated_symbol: PIXMAP is
		do
			Result := Event_pixmap
		end;

	associated_label: STRING is
		do
			Result := Event_label
		end;

end
