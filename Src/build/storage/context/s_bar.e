

class S_BAR 

inherit

	S_CONTEXT


creation

	make

	
feature 

	make (node: BAR_C) is
		do
			save_attributes (node);
		end;

	context (a_parent: COMPOSITE_C): BAR_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

end

