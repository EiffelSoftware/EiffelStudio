

class SCALE_C 

inherit

	PIXMAPS
		rename
			Scale_pixmap as symbol
		export
			{NONE} all
		end;

	PRIMITIVE_C
		rename
			option_list as old_list,
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			stored_node, context_initialization, widget	
		end;

	PRIMITIVE_C
		redefine
			stored_node, reset_modified_flags, copy_attributes, 
			context_initialization, option_list, widget
		select
			option_list, copy_attributes, reset_modified_flags
		end



	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.primitive_page.scale_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
			widget.set_horizontal (False);
			set_size (24, 105);
		end;

	widget: SCALE;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Scale");
		end;

	
feature 

	eiffel_type: STRING is "SCALE";

	-- ***********************
	-- * specific attributes *
	-- ***********************

	option_list: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			Result := old_list;
			i := Result.upper+2;
			Result.force (scale_form_number, Result.upper+1);
			from
			until
				i > Result.upper
			loop
				Result.put (-1, i);
				i := i + 1
			end
		end;

	is_vertical: BOOLEAN is
		do
			Result := not widget.is_horizontal
		end;

	direction_modified: BOOLEAN;

	set_vertical (flag: BOOLEAN) is
		do
			direction_modified := True;
			widget.set_horizontal (not flag)
		end;

	text: STRING;
			-- Scale text

	text_modified: BOOLEAN;

	set_text (a_string: STRING) is
			-- Set `text' to `a_string'
		do
			text_modified := True;
			text := a_string;
			widget.set_text (a_string)
		end;

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		do
			Result := widget.is_maximum_right_bottom
		end;

	max_right_bottom_modified: BOOLEAN;

	set_maximum_right_bottom (flag: BOOLEAN) is
			-- Set maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical if `flag', and at the opposite side otherwise.
		do
			max_right_bottom_modified := True;
			widget.set_maximum_right_bottom (flag);
		end;

	maximum: INTEGER is
		do
			Result := widget.maximum
		end;

	maximum_modified: BOOLEAN;

	set_maximum (new_max: INTEGER) is
		do
			if new_max > minimum then
				maximum_modified := True;
				widget.set_value (new_max);
				widget.set_maximum (new_max)
			end
		end;

	minimum: INTEGER is
		do
			Result := widget.minimum
		end;

	minimum_modified: BOOLEAN;

	set_minimum (new_min: INTEGER) is
		do
			if new_min < maximum then
				minimum_modified := True;
				widget.set_value (new_min);
				widget.set_minimum (new_min)
			end
		end;

	granularity: INTEGER is
		do
			Result := widget.granularity
		end;

	granularity_modified: BOOLEAN;

	set_granularity (new_granularity: INTEGER) is
		do
			if new_granularity >= 1 and new_granularity <= (maximum-minimum) then
				granularity_modified := True;
				widget.set_granularity (new_granularity);
			end;
		end;

	is_output_only: BOOLEAN;

	output_only_modifed: BOOLEAN;

	set_output_only (flag: BOOLEAN) is
		do
			output_only_modifed := True;
			is_output_only := flag;
				-- Not performed on widget because
				-- the widget cannot be moved/resized
				-- any more after a change to read only
				-- mode
--			widget.set_output_only (flag)
		end;

	is_value_shown: BOOLEAN is
		do
			Result := widget.is_value_shown
		end;

	value_shown_modifed: BOOLEAN;

	show_value (flag: BOOLEAN) is
		do
			value_shown_modifed := True;
			widget.show_value (flag);
		end;

	reset_modified_flags is
		do
			old_reset_modified_flags;
			direction_modified := False;
			max_right_bottom_modified := False;
			maximum_modified := False;
			minimum_modified := False;
			granularity_modified := False;
			output_only_modifed := False;
			value_shown_modifed := False;
			text_modified := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if direction_modified then
				other_context.set_vertical (is_vertical);
			end;
			if max_right_bottom_modified then
				other_context.set_maximum_right_bottom (is_maximum_right_bottom);
			end;
			if maximum_modified then
				other_context.set_maximum (maximum);
			end;
			if minimum_modified then
				other_context.set_minimum (minimum);
			end;
			if granularity_modified then
				other_context.set_granularity (granularity);
			end;
			if output_only_modifed then
				other_context.set_output_only (is_output_only);
			end;
			if value_shown_modifed then
				other_context.show_value (is_value_shown);
			end;
			if text_modified then
				other_context.set_text (text);
			end;
			old_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if direction_modified then
				function_bool_to_string (Result, context_name, "set_horizontal", not is_vertical)
			end;
			if max_right_bottom_modified then
				function_bool_to_string (Result, context_name, "set_maximum_right_bottom", is_maximum_right_bottom)
			end;
			if maximum_modified then
				function_int_to_string (Result, context_name, "set_maximum", maximum)
			end;
			if minimum_modified then
				function_int_to_string (Result, context_name, "set_minimum", minimum)
			end;
			if granularity_modified then
				function_int_to_string (Result, context_name, "set_granularity", granularity)
			end;
			if output_only_modifed then
				function_bool_to_string (Result, context_name, "set_output_only", is_output_only)
			end;
			if value_shown_modifed then
				function_bool_to_string (Result, context_name, "show_value", is_value_shown)
			end;
			if text_modified then
				function_string_to_string (Result, context_name, "set_text", text)
			end;
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_SCALE is
		do
			!!Result.make (Current);
		end;

end
