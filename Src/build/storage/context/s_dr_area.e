

class S_DR_AREA 

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end


creation

	make

	
feature 

	make (node: DR_AREA_C) is
		do
			save_attributes (node);
			drawing_area_size_modified :=  node.drawing_area_size_modified;
			drawing_area_width := node.drawing_area_width;
			drawing_area_height := node.drawing_area_height;
		end;

	context (a_parent: COMPOSITE_C): DR_AREA_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

	set_context_attributes (a_context: DR_AREA_C) is
		do
			if drawing_area_size_modified then
				a_context.set_drawing_area_size (drawing_area_width, drawing_area_height);
			end;
			set_attributes (a_context);
		end;

	
feature {NONE}

	drawing_area_size_modified: BOOLEAN;

	drawing_area_width: INTEGER;

	drawing_area_height: INTEGER;

end

