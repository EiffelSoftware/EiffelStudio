
class REFERENCE_HOLE 

inherit

	ICON_HOLE
		redefine
			process_context
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

	stone_type: INTEGER is
		do
			Result := Stone_types.context_type
		end;

	context: CONTEXT;

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
			set_symbol (Pixmaps.context_pixmap);
		end;

	
feature {NONE}

	process_context (dropped: CONTEXT_STONE) is
		do
			if dropped.data.parent = 
					alignment_form.editor.edited_context 
			then
				context :=  dropped.data;
				set_label (dropped.data.label);
				set_symbol (dropped.data.symbol);
				alignment_form.reset_list;
			end;
		end;

end
