
class REFERENCE_HOLE 

inherit

	PIXMAPS
		export
			{NONE} all
		end;
	ICON_HOLE
		redefine
			stone, compatible
		end


creation

	make

	
feature {NONE}

	alignment_form: ALIGNMENT_FORM;

	
feature 

	make (a_name: STRING; a_parent: ALIGNMENT_FORM) is
		do
			alignment_form := a_parent;
			associated_label := a_name;
			make_visible (a_parent);
			reset;
		end;

	stone: CONTEXT_STONE;

	compatible (s: CONTEXT_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	
feature {NONE}

	associated_label: STRING;
			-- Label associated with current hole

	
feature 

	reset is
			-- Reset the symbol and label of 
			-- current hole to their default
			-- values
		do
			set_label (associated_label);
			set_symbol (Context_pixmap);
			stone := Void
		end;

	
feature {NONE}

	process_stone is
			-- Replace symbol and label of current
			-- hole by those of received stone
		do
			if stone.original_stone.parent = alignment_form.editor.edited_context then
				context :=  stone.original_stone;
				set_label (stone.label);
				set_symbol (stone.symbol);
				alignment_form.reset_list;
			end;
		end;

	
feature 

	context: CONTEXT;

end
