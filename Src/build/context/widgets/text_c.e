

class TEXT_C 

inherit

	PIXMAPS
		rename
			Scrolled_t_pixmap as symbol
		export
			{NONE} all
		end;

	PRIMITIVE_C
		rename
			option_list as old_list,
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			stored_node, is_fontable, context_initialization,
			widget
		end;

	PRIMITIVE_C
		redefine
			stored_node, reset_modified_flags, copy_attributes, 
			is_fontable, context_initialization, option_list, widget
		select
			option_list, copy_attributes, reset_modified_flags
		end



	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.text_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
			set_size (100, 100);
		end;

	widget: SCROLLED_T;

	option_list: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			Result := old_list;
			i := Result.upper+2;
			Result.force (text_form_number, Result.upper+1);
			from
			until
				 i > Result.upper
			loop
				 Result.put (-1, i);
				 i := i + 1
			end
		end;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Scrolled_text");
		end;

	
feature 

	eiffel_type: STRING is "SCROLLED_T";

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
		do
			word_wrap_modified := true;
			if flag then
				widget.enable_word_wrap
			else
				widget.disable_word_wrap
			end;
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
			old_reset_modified_flags;
			max_size_modified := False;
			read_only_modified := False;
			word_wrap_modified := False;
			height_resizable_modified := False;
			width_resizable_modified := False;
			margin_height_modified := False;
			margin_width_modified := False;
		end;
 
	
feature {NONE}

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
			if word_wrap_modified then
				other_context.enable_word_wrap (is_word_wrap_enable);
			end;
			if height_resizable_modified then
				other_context.enable_resize_height (is_height_resizable);
			end;
			if width_resizable_modified then
				other_context.enable_resize_width (is_width_resizable);
			end;
			old_copy_attributes (other_context);
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
			if word_wrap_modified then
				cond_f_to_string (Result, is_word_wrap_enable, context_name, "enable_word_wrap", "disable_word_wrap")
			end;
			if height_resizable_modified then
				cond_f_to_string (Result, is_height_resizable, context_name, "enable_resize_height", "disable_resize_height")
			end;
			if width_resizable_modified then
				cond_f_to_string (Result, is_width_resizable, context_name, "enable_resize_width", "disable_resize_width")
			end;
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
