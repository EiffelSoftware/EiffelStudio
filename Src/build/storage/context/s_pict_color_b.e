

class S_PICT_COLOR_B 

inherit

	S_BUTTON
		rename
			set_context_attributes as button_set_context_attributes
		
		end;

	S_BUTTON
		redefine
			set_context_attributes
		select
			set_context_attributes
		end


creation

	make

	
feature 

	make (node: PICT_COLOR_C) is
		do
			create_node (node);
			pixmap_name := node.pixmap_name;
		end;

	context (a_parent: COMPOSITE_C): PICT_COLOR_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

	set_context_attributes (a_context: PICT_COLOR_C) is
		do
			if not (pixmap_name = Void) then
				a_context.set_pixmap_name (pixmap_name)
			end;
			button_set_context_attributes (a_context);
		end;

	
feature {NONE}

	pixmap_name: STRING;

end

