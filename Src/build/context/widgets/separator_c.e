

class SEPARATOR_C 

inherit

	PIXMAPS
		rename
			Separator_pixmap as symbol
		export
			{NONE} all
		end;

	PRIMITIVE_C
		rename
			option_list as old_list,
			create_context as old_create_context,
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			stored_node, context_initialization, widget
		end;

	PRIMITIVE_C
		redefine
			stored_node, reset_modified_flags, copy_attributes, 
			create_context, context_initialization, option_list, widget
		select
			option_list, create_context, copy_attributes, 
			reset_modified_flags
		end;

	SEPARATOR_CONST



	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.primitive_page.separator_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
			set_size (40, 5);
			line_mode := single_line;
		end;

	widget: SEPARATOR;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Separator");
		end;

	
feature 

	eiffel_type: STRING is "SEPARATOR";

	-- ***********************
	-- * specific attributes *
	-- ***********************

	create_context (a_parent: COMPOSITE_C): like Current is
			-- Create a context of the same type
		do
			Result := old_create_context (a_parent);
			if (widget = Void) then
				Result.set_line (line_mode);
				if is_vertical then
					Result.set_vertical (true);
					Result.set_size (5, 40);
				end;
			end;
		end;

	option_list: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			Result := old_list;
			i := Result.upper+2;
			Result.force (separator_form_number, Result.upper+1);
			from
			until
				i > Result.upper
			loop
				Result.put (-1, i);
				i := i + 1
			end
		end;

	is_vertical: BOOLEAN;

	is_vertical_modified: BOOLEAN;

	set_vertical (flag: BOOLEAN) is
		do
			is_vertical_modified := True;
			is_vertical := flag;
			if not (widget = Void) then
				widget.set_horizontal (not flag)
			end;
		end;


	line_mode: INTEGER;

	line_mode_modified: BOOLEAN;

	set_line (mode: INTEGER) is
		do
			line_mode_modified := True;
			line_mode := mode;
			if not (widget = Void) then
				inspect
					mode
				when no_line then
					widget.set_no_line
				when double_line then
					widget.set_double_line
				when single_dashed_line then
					widget.set_single_dashed_line
				when double_dashed_line then
					widget.set_double_dashed_line
				else
					widget.set_single_line
				end
			end
		end;

	reset_modified_flags is
		do
			old_reset_modified_flags;
			is_vertical_modified := False;
			line_mode_modified := False;
		end;
			
	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if is_vertical_modified then
				other_context.set_vertical (is_vertical);
			end;
			if line_mode_modified then
				other_context.set_line (line_mode);
			end;
			old_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		local
			func_name: STRING;
		do
			!!Result.make (0);
			if is_vertical_modified then
				function_bool_to_string (Result, context_name, "set_horizontal", not is_vertical)
			end;
			if line_mode_modified then
				inspect
					line_mode
				when no_line then
					func_name := "set_no_line"
				when double_line then
					func_name := "set_double_line"
				when single_dashed_line then
					func_name := "set_single_dashed_line"
				when double_dashed_line then
					func_name := "set_double_dashed_line"
				else
					func_name := "set_single_line"
				end;
				function_to_string (Result, context_name, func_name);
			end;
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_SEPARATOR is
		do
			!!Result.make (Current);
		end;

end
