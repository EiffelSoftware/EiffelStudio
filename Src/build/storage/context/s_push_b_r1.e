

class S_PUSH_B_R1

inherit

	S_BUTTON_R1

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

