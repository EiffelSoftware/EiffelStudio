-- Context type for group_composites
-- (check_box and radio_box)
class GROUP_COMPOSITE_TYPE

inherit

	CONTEXT_TYPE
		rename
			initialize_callbacks as old_initialize_callbacks
		redefine
			dummy_context
		end
	CONTEXT_TYPE
		redefine
			initialize_callbacks,
			dummy_context
		select
			initialize_callbacks
		end

creation

	make

feature

	dummy_context: GROUP_COMPOSITE_C;

	initialize_callbacks (a_source: COMPOSITE) is
		local
			children: ARRAYED_LIST [WIDGET]
		do
			old_initialize_callbacks (a_source);
			source.set_action ("<Btn3Down>", 
						transport_command, Current)
			children := a_source.children;
			from
				children.start
			until
				children.after
			loop
				children.item.set_action ("<Btn3Down>", 
						transport_command, Current)
				children.forth
			end
		end;

end
