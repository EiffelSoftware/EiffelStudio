
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

	ELMT_HOLE
		rename
			make as elmt_hole_make
		redefine
			associated_function,
			associated_symbol, associated_label,
			stone_type, process_context
		end

creation

	make
	
feature 

	make (a_parent: COMPOSITE; func: FUNC_EDITOR) is
		do
			elmt_hole_make (a_parent, func);
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.context_type
		end;

feature {NONE}

	associated_function: FUNC_EDITOR;	

	associated_symbol: PIXMAP is
		do
			Result := Pixmaps.context_pixmap
		end;

	associated_label: STRING is
		do
			Result := Widget_names.context_label
		end;

	process_context (dropped: CONTEXT_STONE) is
		do
			associated_function.update_input_hole (dropped);
		end;


end
