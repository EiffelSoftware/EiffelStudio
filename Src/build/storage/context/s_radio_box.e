

class S_RADIO_BOX 

inherit

	S_CONTEXT


creation

	make

	
feature 

	make (node: RADIO_BOX_C) is
		do
			save_attributes (node);
		end;

	context (a_parent: COMPOSITE_C): RADIO_BOX_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

end

