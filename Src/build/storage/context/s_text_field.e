

class S_TEXT_FIELD 

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end


creation

	make

	
feature 

	make (node: TEXT_FIELD_C) is
		do
			save_attributes (node);
			if node.max_size_modified then
				maximum_size := node.maximum_size
			else
				maximum_size := Not_set
			end;
		end;

	context (a_parent: COMPOSITE_C): TEXT_FIELD_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

	set_context_attributes (a_context: TEXT_FIELD_C) is
		do
			if maximum_size /= Not_set then
				a_context.set_maximum_size (maximum_size);
			end;
			set_attributes (a_context);
		end;

	
feature {NONE}

	maximum_size: INTEGER;

end

