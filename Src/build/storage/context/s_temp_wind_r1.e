
class S_TEMP_WIND_R1 

	inherit
		S_TEMP_WIND
			rename
				set_context_attributes as old_set_attributes,
				make as old_make
			end;
		S_TEMP_WIND
			redefine
				set_context_attributes, make
			select
				set_context_attributes, make
			end;

creation

	make

feature

	make (node: TEMP_WIND_C) is
		do
			old_make (node);
			start_hidden := node.start_hidden;
		end;

	set_context_attributes (a_context: TEMP_WIND_C) is
		do
			old_set_attributes (a_context);
			a_context.set_start_hidden (start_hidden);
				-- Set x and y regardless if position is not modified
			a_context.set_x_y (x, y);
			a_context.set_default_position (position_modified)
		end;
			

	start_hidden: BOOLEAN;

	start_hidden_modified: BOOLEAN;
		-- To be removed

end
