
class ALIGNMENT_HOLE 

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
			make_visible (a_parent);
			set_label (a_name);
			set_symbol (Pixmaps.context_pixmap);
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.context_type
		end;

feature {NONE}

	process_context (dropped: CONTEXT_STONE) is
			-- Add the context in the list of contexts
			-- to align if it is valid
		local
			list: LINKED_LIST [CONTEXT]
		do
			if dropped.data.grouped then
				from
					list := dropped.data.group;
					list.start;
				until
					list.after
				loop
					if is_context_valid (list.item) then
						alignment_form.add_item (list.item)
					end;
					list.forth;
				end;
			elseif is_context_valid (dropped.data) then
				alignment_form.add_item (dropped.data)
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
