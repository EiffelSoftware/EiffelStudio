
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

	ICON_HOLE

creation

	make

feature {NONE}

	make (a_parent: COMPOSITE; func: FUNC_EDITOR) is
		do
			associated_function := func;
			set_label (associated_label);
			make_visible (a_parent);
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
	
feature {NONE}

	stone_type: INTEGER is 
		do
		end;

end
