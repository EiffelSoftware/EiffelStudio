

class S_LABEL 

inherit

	S_LABEL_TEXT

creation

	make

feature 

	context (a_parent: COMPOSITE_C): LABEL_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

end

