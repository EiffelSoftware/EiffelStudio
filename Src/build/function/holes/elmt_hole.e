
--=========================== class FUN_HOLE =======================
--
-- Author: Deramat
-- Last revision: 03/25/92
--
-- General notion of function (input or output) hole.
--
--===================================================================

class ELMT_HOLE 

inherit

	PIXMAPS
		export
			{NONE} all
		end;

	ICON_HOLE

creation

	make

feature {NONE}

	make (a_parent: COMPOSITE; func: FUNC_EDITOR) is
		do
			associated_function := func;
			make_visible (a_parent);
			set_label (associated_label);
			set_symbol (associated_symbol);
		end;

	associated_function: FUNC_EDITOR;
			-- Function associated with current hole

	associated_symbol: PIXMAP is
			-- Symbol associated with current hole
		do
		end;

	associated_label: STRING is
			-- Label associated with current hole
		do
			Result := ""
		end;
	
feature 

	reset is
			-- Reset the symbol and label of 
			-- current hole to their default
			-- values.
		do
			set_label (associated_label);
			set_symbol (associated_symbol);
		end;

	set_stone (st: STONE) is
		do
			stone := st
		end; -- set_stone

	
feature {NONE}

	process_stone is
			-- Replace symbol and label of current
			-- hole by those of received stone
			-- and update associated function.
		do
			associated_function.update (Current);
		end;

end
