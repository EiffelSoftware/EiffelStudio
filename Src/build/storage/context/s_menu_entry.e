

class S_MENU_ENTRY 

inherit

	S_BUTTON


creation

	make

	
feature 

	make (node: MENU_ENTRY_C) is
		do
			create_node (node);
		end;

	context (a_parent: COMPOSITE_C): MENU_ENTRY_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

end

