

class S_SCALE 

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end


creation

	make

	
feature 

	make (node: SCALE_C) is
		do
			save_attributes (node);
			if node.text_modified then
				text := node.text;
			end;
			if node.maximum_modified then
				maximum := node.maximum
			else
				maximum := Not_set
			end;
			if node.minimum_modified then
				minimum := node.minimum
			else
				minimum := Not_set
			end;
			if node.granularity_modified then
				granularity := node.granularity
			else
				granularity := Not_set
			end;
			direction_modified := node.direction_modified;
			is_vertical := node.is_vertical;
			max_right_bottom_modified := node.max_right_bottom_modified;
			is_maximum_right_bottom := node.is_maximum_right_bottom;
			output_only_modifed := node.output_only_modifed;
			is_output_only := node.is_output_only;
			value_shown_modifed := node.value_shown_modifed;
			is_value_shown := node.is_value_shown;
		end;

	context (a_parent: COMPOSITE_C): SCALE_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

	set_context_attributes (a_context: SCALE_C) is
		do
			if direction_modified then
				a_context.set_vertical (is_vertical)
			end;
			if max_right_bottom_modified then
				a_context.set_maximum_right_bottom (is_maximum_right_bottom)
			end;
			if maximum /= Not_set then
				a_context.set_maximum (maximum)
			end;
			if minimum /= Not_set then
				a_context.set_minimum (minimum)
			end;
			if granularity /= Not_set then
				a_context.set_granularity (granularity)
			end;
			if output_only_modifed then
				a_context.set_output_only (is_output_only)
			end;
			if value_shown_modifed then
				a_context.show_value (is_value_shown)
			end;
			if not (text = Void) then
				a_context.set_text (text)
			end;
			set_attributes (a_context);
		end;

	
feature {NONE}

	text: STRING;

	is_vertical: BOOLEAN;

	is_maximum_right_bottom: BOOLEAN;

	maximum: INTEGER;
	
	minimum: INTEGER;

	granularity: INTEGER;

	is_output_only: BOOLEAN;

	is_value_shown: BOOLEAN;

	direction_modified: BOOLEAN;
	max_right_bottom_modified: BOOLEAN;
	output_only_modifed: BOOLEAN;
	value_shown_modifed: BOOLEAN;

end

