indexing

	description:	
		"Text windows where tabulation characters are expanded %
			%to `tablength' blank characters. Widget that is able %
			%to edit text.";
	date: "$Date$";
	revision: "$Revision$"

class
	GRAPHICAL_TEXT_WINDOW

inherit

	TABBED_TEXT
		rename
			lower as lower_window,
			make as text_create,
			set_text as st_set_text,
			cursor as widget_cursor,
			set_cursor_position as st_set_cursor_position,
			set_top_character_position as st_set_top_character_position
		undefine
			is_equal, set_font, set_background_color
		redefine
			implementation
		end;

	SCROLLED_TEXT_WINDOW
		rename
			put_address as st_put_address, 
			put_feature_name as st_put_feature_name, 
			put_feature as st_put_feature, 
			put_feature_error as st_put_feature_error, 
			put_error as st_put_error, 	
			put_class as st_put_class, 
			put_classi as st_put_classi, 
			put_cluster as st_put_cluster,
			process_breakpoint as st_process_breakpoint, 
			process_padded as st_process_padded, 
			put_class_syntax as st_put_class_syntax,
			put_quoted_comment as st_put_quoted_comment, 
			put_operator as st_put_operator, 
			put_symbol as st_put_symbol, 	
			put_ace_syntax as st_put_ace_syntax,
			put_keyword as st_put_keyword, 
			put_comment as st_put_comment,
			process_call_stack_item as st_process_call_stack_item,
			clear_window as st_clear_window,
			init_resource_values as st_init_resource_values,
			process_text as st_process_text
		undefine 
			make_word_wrapped, text_create,
			consistent, create_ev_widget_ww, create_ev_widget,
			copy, setup, set_tab_length
		redefine
			implementation, put_stone, put_string, new_line, display,
			put_after_class, put_normal_string, reset, disable_clicking
		end;

	SCROLLED_TEXT_WINDOW
		undefine 
			make_word_wrapped, text_create,
			consistent, create_ev_widget_ww, create_ev_widget,
			copy, setup, set_tab_length
		redefine
			implementation, put_address, put_feature_name, put_feature, 
			put_feature_error, put_error, put_class, put_classi, put_cluster,
			process_breakpoint, process_padded, put_class_syntax,
			put_quoted_comment, put_operator, put_symbol, put_ace_syntax,
			put_keyword, put_comment, process_call_stack_item, put_stone,
			put_string, new_line, display,
			clear_window, init_resource_values, put_after_class, 
			put_normal_string, reset, process_text, disable_clicking
		select
			put_address, put_feature_name, put_feature, put_feature_error,
			put_error, put_class, put_classi, put_cluster,
			process_breakpoint, process_padded, put_class_syntax,
			put_quoted_comment, put_operator, put_symbol,
			put_ace_syntax, put_keyword, put_comment, process_call_stack_item,
			clear_window, init_resource_values, process_text
		end;

	GRAPHICAL_VALUES
		undefine
			setup, copy, consistent, is_equal
		end

creation

	make,
	make_from_tool

feature -- Access

	implementation: TABBED_TEXT_WINDOWS

	dummy_text: WEL_RICH_EDIT

feature -- Output

	clear_window is
			-- Clear the contents of the window.
		do
			set_changed (True);
			st_clear_window;
			set_changed (False)
		end;

	reset is
		do
			clear_window;
			wipe_out_graphical_values
		end;

	display is
			-- Display the `image' to the text window.
		do
			set_read_only;
			set_changed (False)
		end;

	init_resource_values is
			-- Initialize the resource values.
		do
			set_changed (True);
			st_init_resource_values;
			init_graphical_values;
			set_changed (False);
		end;

	process_text (texts: STRUCTURED_TEXT) is
			-- Process structured text `text' to be
			-- generated as output.
		do
			hide_text_window
			set_changed (True);
			st_process_text (texts);
			set_changed (False)
			show_text_window
		end;

	hide_text_window is
		local
			p: WEL_COMPOSITE_WINDOW
		do
			if dummy_text = Void then
				p ?= top.implementation;
				!! dummy_text.make (p, 
					"Dummy", implementation.wel_x + 10, 	
					implementation.wel_y + 10,
					10, 10, 0)
			else
				dummy_text.show
			end;
			implementation.hide;
		end

	show_text_window is
		do
			implementation.wel_show;
			dummy_text.hide
		end

feature -- Update

	disable_clicking is
			-- Feature which needs to be redefined on Windows
		local
			previous_position: INTEGER
		do
			implementation.hide_selection
			previous_position := implementation.cursor_position
			implementation.set_selection (0, implementation.count)
			implementation.set_character_format_word (text_format)
			implementation.set_selection (previous_position, previous_position)
			implementation.show_selection
			{SCROLLED_TEXT_WINDOW} precursor
		end

	put_after_class (e_class: E_CLASS; str: STRING) is
			-- Put "-- class" followed by `t' in the text.
		local
			class_stone: CLASSC_STONE
		do
			put_comment (" -- ");
			put_keyword ("class ");
			put_classi (e_class.lace_class, e_class.name_in_upper);
			new_line
		end;

	put_operator (str: STRING;
			e_feature: E_FEATURE; is_keyword: BOOLEAN) is
		   -- Process operator text.
		do
			if is_keyword then
				implementation.set_character_format_word (keyword_format);
			else
				implementation.set_character_format_word (symbol_format);
			end;
			st_put_feature (e_feature, str)
		end;

	put_string (s: STRING) is
			-- Add text `s'.
		do
			implementation.set_character_format_word (string_text_format);
			implementation.replace_selection (s);
			text_position := text_position + s.count
		end;

	new_line is
			-- Add a new line to text.
		do
			put_string ("%R%N")
		end;

	put_classi (e_class: CLASS_I; str: STRING) is
			-- Put `e_class' with string representation
			-- `str' at current position.
		do
			implementation.set_character_format_word (class_format);
			st_put_classi (e_class, str)
		end;

	put_cluster (e_cluster: CLUSTER_I; str: STRING) is
			-- Put `e_cluster' with string representation
			-- `str' at current position.
		do
			implementation.set_character_format_word (cluster_format);
			put_normal_string (str)
		end;

	put_class (e_class: E_CLASS; str: STRING) is
			-- Put `e_class' with string representation
			-- `str' at current position.
		do
			implementation.set_character_format_word (class_format);
			st_put_class (e_class, str)
		end;

	put_class_syntax (syn: SYNTAX_ERROR; e_class: E_CLASS; str: STRING) is
			-- Put `address' for `e_class'.
		do
			implementation.set_character_format_word (class_format);
			st_put_class_syntax (syn, e_class, str)
		end;

	put_ace_syntax (syn: SYNTAX_ERROR; str: STRING) is
			-- Put `address' for `e_class'.
		do
			st_put_ace_syntax (syn, str)
		end;

	put_error (error: ERROR; str: STRING) is
			-- Put `error' with string representation
			-- `str' at current position.
		do
			implementation.set_character_format_word (error_format);
			st_put_error (error, str)
		end;

	put_feature_error (feat: E_FEATURE; str: STRING; a_pos: INTEGER) is
			-- Put feature `feat' defined in `e_class' with string
			-- representation `str' at current position.
		do
			implementation.set_character_format_word (feature_format);
			st_put_feature_error (feat, str, a_pos)
		end;

	put_feature (feat: E_FEATURE; str: STRING) is
			-- Put feature `feat' defined in `e_class' with string
			-- representation `str' at current position.
		do
			implementation.set_character_format_word (feature_format);
			st_put_feature (feat, str)
		end;

	put_feature_name (f_name: STRING; e_class: E_CLASS) is
			-- Put feature name `f_name' defined in `e_class'.
		do
			implementation.set_character_format_word (feature_format);
			st_put_feature_name (f_name, e_class)
		end;

	put_address (address: STRING; a_name: STRING; e_class: E_CLASS) is
			-- Put `address' with `a_name' for `e_class'.
		do
			implementation.set_character_format_word (object_format);
			st_put_address (address, a_name, e_class)
		end;

	put_comment (s: STRING) is
			-- Add comment text `s'.
		do
			implementation.set_character_format_word (comment_format);
			put_normal_string (s)
		end;

	put_symbol (s: STRING) is
			-- Add special text `s'.
		do
			implementation.set_character_format_word (symbol_format);
			put_normal_string (s)
		end;

	put_keyword (s: STRING) is
			-- Add keyword text `s'.
		do
			implementation.set_character_format_word (keyword_format);
			put_normal_string (s)
		end;

	put_quoted_comment (s: STRING) is
			-- Add quoted text `s'.
		do
			implementation.set_character_format_word (comment_format);
			st_put_quoted_comment (s)
		end;

	put_stone (a_stone: STONE; stone_string: STRING) is
			-- Add `stone_string' to the text image and 
			-- record `a_stone' as clickable.
		local
			p: CLICK_STONE;
			length: INTEGER;
		do
			implementation.replace_selection (stone_string);
			length := stone_string.count;
			!! p.make (a_stone, text_position, text_position + length);
			add_click_stone (p);
			text_position := text_position + length;
		end

feature -- Text formatting

	process_padded is
			-- Process padded value (used when processing breakpoints).
		do
			if last_click_break /= Void then
				last_click_break.set_end_position (text_position);
				last_click_break := Void
			end;
			implementation.set_character_format_word (breakable_format);
			put_normal_string ("   ");
		end;

	process_breakpoint (a_bp: BREAKPOINT_ITEM) is
			-- Process the quoted `text' within a comment.
		local
			breakable_stone: BREAKABLE_STONE;
			debug_mark: STRING
		do
			!! breakable_stone.make (a_bp.e_feature, a_bp.index);
			if a_bp.display_number then
				implementation.set_character_format_word (breakable_format);
				put_stone (breakable_stone, a_bp.index.out)
			else
				if last_click_break /= Void then
					last_click_break.set_end_position (text_position);
					last_click_break := Void
				end;
				put_string (" ");
				!! last_click_break.make (breakable_stone,
						text_position, text_position + 3);
				add_click_stone (last_click_break);
				text_position := text_position + 3;
				implementation.set_character_format_word (breakable_format);
				implementation.replace_selection (breakable_stone.sign);
				put_string (" ")
			end
		end;

	process_call_stack_item (t: CALL_STACK_ITEM) is
			-- Process the current callstack text.
		do
			st_process_call_stack_item (t)
		end;

feature {NONE} -- Implementation

	put_normal_string (s: STRING) is
			-- Add non processed text `s'.
		do
			implementation.replace_selection (s);
			text_position := text_position + s.count
		end;

end -- class GRAPHICAL_TEXT_WINDOW
