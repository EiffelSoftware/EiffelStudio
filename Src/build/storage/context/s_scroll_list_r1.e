-- Introduced for version 3.3 

class S_SCROLL_LIST_R1

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end

creation

	make
	
feature 

	make (node: SCROLL_LIST_C) is
		do
			save_attributes (node);
			visible_item_count := node.visible_item_count;
		end;

	context (a_parent: COMPOSITE_C): SCROLL_LIST_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

	set_context_attributes (a_context: SCROLL_LIST_C) is
		do
			set_attributes (a_context);
			a_context.set_visible_item_count (visible_item_count);
		end;
	
feature {NONE}

	visible_item_count: INTEGER;

end

