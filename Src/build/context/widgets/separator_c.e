

class SEPARATOR_C 

inherit

	PRIMITIVE_C
		rename
			create_context as old_create_context,
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			stored_node, context_initialization, widget
		end;

	PRIMITIVE_C
		redefine
			stored_node, reset_modified_flags, copy_attributes, 
			create_context, context_initialization, widget
		select
			create_context, copy_attributes, 
			reset_modified_flags
		end;
	
feature 

	symbol: PIXMAP is
		do
			Result := Pixmaps.separator_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.primitive_page.separator_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
			set_size (40, 5);
			line_mode := Context_const.single_line;
		end;

	widget: SEPARATOR;

	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Separator");
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
						Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.separator_att_form_nbr,
						Context_const.Attribute_format_nbr);
		end;
	
feature 

	eiffel_type: STRING is "SEPARATOR";

	full_type_name: STRING is "Separator"

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
			if widget /= Void then
				if mode = Context_const.no_line then
					widget.set_no_line
				elseif mode = Context_const.double_line then
					widget.set_double_line
				elseif mode = Context_const.single_dashed_line then
					widget.set_single_dashed_line
				elseif mode = Context_const.double_dashed_line then
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
				function_bool_to_string (Result, context_name, 
						"set_horizontal", not is_vertical)
			end;
			if line_mode_modified then
				if line_mode = Context_const.no_line then
					func_name := "set_no_line"
				elseif line_mode = Context_const.double_line then
					func_name := "set_double_line"
				elseif line_mode = Context_const.single_dashed_line then
					func_name := "set_single_dashed_line"
				elseif line_mode = Context_const.double_dashed_line then
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
