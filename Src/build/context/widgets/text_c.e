class TEXT_C 

inherit

	PRIMITIVE_C
		redefine
			stored_node, reset_modified_flags, copy_attributes, 
			is_fontable, context_initialization, widget,
			eiffel_creation, display_resize_squares
		end
	
feature 

	widget: SCROLLED_T;

	symbol: PIXMAP is
		do
			Result := Pixmaps.scrolled_t_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.text_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!! widget.make_unmanaged (entity_name, a_parent);
			size_modified := True;
			widget.set_size (110, 100)
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
					Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.text_att_form_nbr,
					Context_const.Attribute_format_nbr);
		end;

feature -- Default event

	default_event: TEXT_MODIFIED_EV is
		do
			Result := text_modify_ev
		end

feature {SELECTION_MANAGER}

	display_resize_squares (logical_mode: INTEGER) is
			-- Draw squares in the corners of the context, used to resize it.
		local
			x_position, y_position, corner_side: INTEGER
			previous_logical_mode: INTEGER
		do
			set_drawing (eb_screen)
			previous_logical_mode := drawing_i.logical_mode
			set_logical_mode (logical_mode)
			set_subwindow_mode (1)
			corner_side := Eb_selection_mgr.corner_side // 2
			x_position := real_x + corner_side // 2
			y_position := real_y + corner_side // 2
			draw_squares (x_position, y_position)
			set_logical_mode (previous_logical_mode)
		end

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Scrolled_text");
		end;

	
feature 

	eiffel_type: STRING is "SCROLLED_T";

	full_type_name: STRING is "Scrolled text"

	-- ***********************
	-- * specific attributes *
	-- ***********************

	is_fontable: BOOLEAN is
			-- Is current context fontable
		do
			Result := true
		end;

	maximum_size: INTEGER is
			-- Maximum number of characters in current text
		do
			Result:= widget.maximum_size
		end;

	max_size_modified: BOOLEAN;

	set_maximum_size (new_size: INTEGER) is
			-- Set maximum_size to `new_size'.
		do
			max_size_modified := True;
			widget.set_maximum_size (new_size);
		end;

	is_read_only: BOOLEAN is
			-- Is text in read only mode?
		do
			Result := widget.is_read_only
		end;

	read_only_modified: BOOLEAN;

	set_read_only (flag: BOOLEAN) is
			-- set widget to read only if flag
		do
			read_only_modified := True;
			if flag then
				widget.set_read_only
			else
				widget.set_editable
			end;
		end;

	margin_height: INTEGER is
			-- Distance between top edge of text window and current text,
			-- and between bottom edge of text window and current text.
		do
			Result := widget.margin_height
		end;

	margin_height_modified: BOOLEAN;

	set_margin_height (new_height: INTEGER) is
			-- Set `margin_height' to `new_height'.
		do
			margin_height_modified := True;
			widget.set_margin_height (new_height)
		end;

	margin_width: INTEGER is
			-- Distance between left edge of text window and current text,
			-- and between right edge of text window and current text.
		do
			Result := widget.margin_width
		end;

	margin_width_modified: BOOLEAN;

	set_margin_width (new_width: INTEGER) is
			-- Set `margin_width' to `new_width'.
		do
			margin_width_modified := True;
			widget.set_margin_width (new_width)
		end;

	is_word_wrap_enable: BOOLEAN is
			-- Is word wrap enabled?
		do
			Result := widget.is_word_wrap_mode
		end;

	word_wrap_modified: BOOLEAN;

	enable_word_wrap (flag: BOOLEAN) is
			-- enable wordwrap if flag
		local
			p: COMPOSITE;
			new_widget: like widget;
			cloned_current: like Current
		do
			p := widget.parent;
			if widget.realized then
				widget.hide;
			end;
			cloned_current := clone (Current);
			if flag then
				!! widget.make_word_wrapped (entity_name, p);
			else
				!! widget.make (entity_name, p);
			end;
			cloned_current.copy_attributes (Current);
			widget.set_x_y (cloned_current.widget.x, cloned_current.widget.y);
			cloned_current.widget.destroy;
			add_widget_callbacks
		end;

	is_height_resizable: BOOLEAN is
			-- Is height of current text resizable?
		do
			Result := widget.is_height_resizable
		end;

	height_resizable_modified: BOOLEAN;

	enable_resize_height (flag: BOOLEAN) is
			-- Allow height resize if flag
		do
			height_resizable_modified := true;
			if flag then
				widget.enable_resize_height
			else
				widget.disable_resize_height
			end
		end;

	is_width_resizable: BOOLEAN is
			-- Is width of current text resizable?
		do
			Result := widget.is_width_resizable
		end;

	width_resizable_modified: BOOLEAN;

	enable_resize_width (flag: BOOLEAN) is
			-- Allow width resize if flag
		do
			width_resizable_modified := true;
			if flag then
				widget.enable_resize_width
			else
				widget.disable_resize_width
			end
		end;

	reset_modified_flags is
		do
			Precursor
			max_size_modified := False;
			read_only_modified := False;
			word_wrap_modified := False;
			height_resizable_modified := False;
			width_resizable_modified := False;
			margin_height_modified := False;
			margin_width_modified := False;
		end;
 
	
feature {NONE, TEXT_C}

	copy_attributes (other_context: like Current) is
		do
			if margin_width_modified then
				other_context.set_margin_width (margin_width);
			end;
			if margin_height_modified then
				other_context.set_margin_height (margin_height);
			end;
			if max_size_modified then
				other_context.set_maximum_size (maximum_size);
			end;
			if read_only_modified then
				other_context.set_read_only (is_read_only);
			end;
			if height_resizable_modified then
				other_context.enable_resize_height (is_height_resizable);
			end;
			if width_resizable_modified then
				other_context.enable_resize_width (is_width_resizable);
			end;
			Precursor (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if margin_width_modified then
				function_int_to_string (Result, context_name, "set_margin_width", margin_width)
			end;
			if margin_height_modified then
				function_int_to_string (Result, context_name, "set_margin_height", margin_height)
			end;
			if max_size_modified then
				function_int_to_string (Result, context_name, "set_maximum_size", maximum_size)
			end;
			if read_only_modified then
				cond_f_to_string (Result, is_read_only, context_name, "set_read_only", "set_editable")
			end;
			if height_resizable_modified then
				cond_f_to_string (Result, is_height_resizable, context_name, "enable_resize_height", "disable_resize_height")
			end;
			if width_resizable_modified then
				cond_f_to_string (Result, is_width_resizable, context_name, "enable_resize_width", "disable_resize_width")
			end;
		end;

	eiffel_creation (parent_name: STRING): STRING is
			-- Generated string for the creation of current context
			-- and all its children
		do
			!!Result.make (0);
			Result.append ("%T%T%T!! ");
			Result.append (entity_name_in_lower_case);
			if is_word_wrap_enable then
				Result.append (".make_word_wrapped (%"");
			else
				Result.append (".make (%"");
			end;
			Result.append (entity_name);
			Result.append ("%", ");
			Result.append (parent_name);
			Result.append (")");
			if not (visual_name = Void) then
				Result.append ("%T-- ");
				Result.append (visual_name);
			end;
			Result.append ("%N");
			Result.append (children_creation (entity_name))
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_TEXT is
		do
			!!Result.make (Current);
		end;


end
