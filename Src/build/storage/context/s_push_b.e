

class S_PUSH_B 

inherit

	S_BUTTON


creation

	make

	
feature 

	make (node: PUSH_B_C) is
		do
			create_node (node);
		end;

	context (a_parent: COMPOSITE_C): PUSH_B_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

end

