

class ARROW_B_C 

inherit

	PIXMAPS
		rename
			Arrow_b_pixmap as symbol
		export
			{NONE} all
		end;

	BUTTON_C
		rename
			copy_attributes as button_copy_attributes,
			context_initialization as old_context_initialization,
			reset_modified_flags as button_reset_modified_flags,
			create_context as button_create_context
		redefine
			stored_node, is_fontable, widget, option_list
		end;

	BUTTON_C
		redefine
			create_context, stored_node, reset_modified_flags, 
			copy_attributes, is_fontable, context_initialization, option_list, widget
		select
			copy_attributes, context_initialization, reset_modified_flags,
			create_context
		end;

	ARROW_B_CONST
	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.primitive_page.arrow_b_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
		end;

	widget: ARROW_B;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Arrow_b");
		end;

	
feature 

	eiffel_type: STRING is "ARROW_B";

	create_context (a_parent: COMPOSITE_C): like Current is
			-- Create a context of the same type
		do
			Result := button_create_context (a_parent);
			if (widget = Void) and Result /= Void then
				Result.set_direction (direction)
			end;
		end;

	-- ***********************
	-- * Specific attributes *
	-- ***********************

	is_fontable: BOOLEAN is
			-- Is current context fontable
		do
			Result := false
		end;

	option_list: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			Result := old_list;
			i := Result.upper+2;
			Result.force (arrow_b_form_number, Result.upper+1);
			from
			until
				i > Result.upper
			loop
				Result.put (-1, i);
				i := i + 1;
			end
		end;

	direction: INTEGER;

	direction_modified: BOOLEAN;

	set_direction (new_direction: INTEGER) is
			-- Set the direction of the arrow
		do
			direction_modified := True;
			direction := new_direction;
			if not (widget = Void) then
				inspect
					new_direction
				when up then
					widget.set_up
				when down then
					widget.set_down
				when right then
					widget.set_right
				else
					widget.set_left
				end;
			end;
		end;

	reset_modified_flags is
		do
			button_reset_modified_flags;
			direction_modified := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if direction_modified then
				other_context.set_direction (direction);
			end;
			button_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		local
			func_name: STRING;
		do
			Result := old_context_initialization (context_name);
			if direction_modified then
				inspect
					direction
				when down then
					func_name := "set_down"
				when left then
					func_name := "set_left"
				when right then
					func_name := "set_right"
				else
					func_name := "set_up"
				end;
				function_to_string (Result, context_name, func_name);
			end;
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_ARROW_B is
		do
			!!Result.make (Current);
		end;

end
