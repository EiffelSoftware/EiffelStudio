

class S_ARROW_B 

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end


creation

	make

	
feature 

	make (node: ARROW_B_C) is
		do
			save_attributes (node);
			if node.direction_modified then
				direction := node.direction;
			else
				direction := Not_set
			end;
		end;

	context (a_parent: COMPOSITE_C): ARROW_B_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

	
feature {NONE}

	direction: INTEGER;

	
feature 

	set_context_attributes (a_context: ARROW_B_C) is
		do
			if direction /= Not_set then
				a_context.set_direction (direction);
			end;
			set_attributes (a_context);
		end;

end

