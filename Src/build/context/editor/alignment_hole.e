
class ALIGNMENT_HOLE 

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
			make_visible (a_parent);
			set_label (a_name);
			set_symbol (Context_pixmap);
		end;

	stone: CONTEXT_STONE;

	compatible (s: CONTEXT_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;
	
feature {NONE}

	process_stone is
			-- Add the context in the list of contexts
			-- to align if it is valid
		local
			list: LINKED_LIST [CONTEXT]
		do
			if stone.original_stone.grouped then
				from
					list := stone.original_stone.group;
					list.start;
				until
					list.after
				loop
					if is_context_valid (list.item) then
						alignment_form.add_item (list.item)
					end;
					list.forth;
				end;
			elseif is_context_valid (stone.original_stone) then
				alignment_form.add_item (stone.original_stone)
			end
		end;

	is_context_valid (a_context: CONTEXT): BOOLEAN is
			-- Can the new context be aligned
			-- with the reference ?
		local
			reference: CONTEXT;
		do
			reference := alignment_form.reference_context;
			Result := not (reference = Void) and then
				reference.parent = a_context.parent and then
				reference /= a_context
		end;

end
