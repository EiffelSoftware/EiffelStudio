

class S_SEPARATOR 

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end


creation

	make

	
feature 

	make (node: SEPARATOR_C) is
		do
			save_attributes (node);
			is_vertical := node.is_vertical	;
			if node.line_mode_modified then
				line_mode := node.line_mode
			else
				line_mode := Not_set
			end;
			is_vertical_modified := node.is_vertical_modified
		end;

	context (a_parent: COMPOSITE_C): SEPARATOR_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

	set_context_attributes (a_context: SEPARATOR_C) is
		do
			if is_vertical_modified then
				a_context.set_vertical (is_vertical);
			end;
			if line_mode /= Not_set then
				a_context.set_line (line_mode);
			end;
			set_attributes (a_context);
		end;

	
feature {NONE}

	is_vertical, is_vertical_modified: BOOLEAN;

	line_mode: INTEGER

end

