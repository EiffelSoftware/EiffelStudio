class S_TOGGLE_B_R333

inherit
	S_TOGGLE_B_R1
		rename
			make as old_make,
			set_context_attributes as old_set_context_attributes
		end
	S_TOGGLE_B_R1
		redefine
			set_context_attributes, make
		select
			set_context_attributes, make
		end

creation
	make

feature

	is_armed: BOOLEAN;

	armed_modified: BOOLEAN;

	make (node: TOGGLE_B_C) is
		do
			old_make (node);
			is_armed := node.is_armed
			armed_modified := node.is_armed_modified
		end;

	set_context_attributes (a_context: TOGGLE_B_C) is
		do
			old_set_context_attributes (a_context)
			if armed_modified then
				a_context.set_toggle_state (is_armed)
			end
		end;

end
