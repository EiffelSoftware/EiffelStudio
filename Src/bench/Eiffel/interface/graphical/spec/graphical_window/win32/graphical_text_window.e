indexing
	description:	
			"Text windows where tabulation characters are expanded %
			%to `tablength' blank characters. Widget that is able %
			%to edit text."
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_TEXT_WINDOW

inherit
	SCROLLED_TEXT_WINDOW
		redefine
			clear_window, reset, display, init_resource_values,
			implementation, put_address, put_feature_name, put_feature, 
			put_feature_error, put_error, put_class, put_classi, put_cluster,
			process_breakpoint, process_padded, put_class_syntax,
			put_quoted_comment, put_operator, put_symbol,
			put_keyword, put_comment, put_stone, put_exported_feature_name,
			put_string, new_line,  put_after_class, 
			put_normal_string, process_text, disable_clicking, is_graphical,
			set_text
		end

	GRAPHICAL_VALUES
		undefine
			is_equal, copy
		end

creation
	make,
	make_from_tool

feature -- Access

	implementation: SCROLLED_T_IMP

	dummy_text: WEL_RICH_EDIT

feature -- Output

	clear_window is
			-- Clear the contents of the window.
		do
			set_changed (True)
			{SCROLLED_TEXT_WINDOW} Precursor 
			set_changed (False)
		end

	set_text (t: STRING) is
			-- Set `text' to `t' with `text_format'
		do
			implementation.set_character_format_word (text_format)
			Precursor {SCROLLED_TEXT_WINDOW} (t)
		end

	reset is
		do
			{SCROLLED_TEXT_WINDOW} Precursor
			wipe_out_graphical_values
		end

	display is
			-- Display the `image' to the text window.
		do
			set_read_only
			set_changed (False)
		end

	init_resource_values is
			-- Initialize the resource values.
		do
			set_changed (True)
			init_graphical_values
			{SCROLLED_TEXT_WINDOW} Precursor 
			set_changed (False)
		end

	process_text (texts: STRUCTURED_TEXT) is
			-- Process structured text `text' to be
			-- generated as output.
		do
			hide_text_window
			set_changed (True)
			{SCROLLED_TEXT_WINDOW} Precursor (texts)
			set_changed (False)
			show_text_window
		end

	hide_text_window is
		local
			p: WEL_COMPOSITE_WINDOW
		do
			if dummy_text = Void then
				p ?= top.implementation
				!! dummy_text.make (p, 
						"Dummy", implementation.wel_x + 10, 	
						implementation.wel_y + 10,
						10, 10, 0)
			else
				dummy_text.show
			end
			implementation.wel_hide
		end

	show_text_window is
		do
			implementation.wel_show
			dummy_text.hide
		end

	is_graphical: BOOLEAN is True
			-- The current widget is a graphical one.

feature -- Update

	disable_clicking is
			-- Feature which needs to be redefined on Windows
		local
			previous_position: INTEGER
		do
			if not done then
				done := True
				implementation.hide_selection
				previous_position := implementation.cursor_position
				implementation.set_selection (0, implementation.count)
				implementation.set_character_format_word (text_format)
				implementation.set_selection (previous_position, previous_position)
				implementation.show_selection
				{SCROLLED_TEXT_WINDOW} Precursor
				done := False
			end
		end

	put_after_class (e_class: CLASS_C str: STRING) is
			-- Put "-- class" followed by `t' in the text.
		do
			put_comment (" -- ")
			put_keyword ("class ")
			put_classi (e_class.lace_class, e_class.name_in_upper)
			new_line
		end

	put_operator (str: STRING e_feature: E_FEATURE; is_keyword: BOOLEAN) is
		   -- Process operator text.
		do
			if is_keyword then
				implementation.set_character_format_word (keyword_format)
			else
				implementation.set_character_format_word (symbol_format)
			end
			{SCROLLED_TEXT_WINDOW} Precursor (str, e_feature, is_keyword)
		end

	put_string (s: STRING) is
			-- Add text `s'.
		do
			implementation.set_character_format_word (string_text_format)
			put_normal_string (s)
		end

	new_line is
			-- Add a new line to text.
		do
			put_string ("%R%N")
		end

	put_classi (e_class: CLASS_I str: STRING) is
			-- Put `e_class' with string representation
			-- `str' at current position.
		do
			implementation.set_character_format_word (class_format)
			{SCROLLED_TEXT_WINDOW} Precursor (e_class, str)
		end

	put_cluster (e_cluster: CLUSTER_I str: STRING) is
			-- Put `e_cluster' with string representation
			-- `str' at current position.
		do
			implementation.set_character_format_word (cluster_format)
			put_normal_string (str)
		end

	put_class (e_class: CLASS_C str: STRING) is
			-- Put `e_class' with string representation
			-- `str' at current position.
		do
			implementation.set_character_format_word (class_format)
			{SCROLLED_TEXT_WINDOW} Precursor (e_class, str)
		end

	put_class_syntax (syn: SYNTAX_ERROR e_class: CLASS_C; str: STRING) is
			-- Put `address' for `e_class'.
		do
			implementation.set_character_format_word (class_format)
			{SCROLLED_TEXT_WINDOW} Precursor (syn, e_class, str)
		end

	put_error (error: ERROR str: STRING) is
			-- Put `error' with string representation
			-- `str' at current position.
		do
			implementation.set_character_format_word (error_format)
			{SCROLLED_TEXT_WINDOW} Precursor (error, str)
		end

	put_feature_error (feat: E_FEATURE str: STRING; a_pos: INTEGER) is
			-- Put feature `feat' defined in `e_class' with string
			-- representation `str' at current position.
		do
			implementation.set_character_format_word (feature_format)
			{SCROLLED_TEXT_WINDOW} Precursor (feat, str, a_pos)
		end

	put_feature (feat: E_FEATURE str: STRING) is
			-- Put feature `feat' defined in `e_class' with string
			-- representation `str' at current position.
		do
			implementation.set_character_format_word (feature_format)
			{SCROLLED_TEXT_WINDOW} Precursor (feat, str)
		end

	put_feature_name (f_name: STRING e_class: CLASS_C) is
			-- Put feature name `f_name' defined in `e_class'.
		do
			implementation.set_character_format_word (feature_format)
			{SCROLLED_TEXT_WINDOW} Precursor (f_name, e_class)
		end

	put_exported_feature_name (f_name: STRING; e_class: CLASS_C; alias_name: STRING) is
		do
			implementation.set_character_format_word (feature_format)
			{SCROLLED_TEXT_WINDOW} Precursor (f_name, e_class, alias_name)
		end

	put_address (address: STRING a_name: STRING; e_class: CLASS_C) is
			-- Put `address' with `a_name' for `e_class'.
		do
			implementation.set_character_format_word (object_format)
			{SCROLLED_TEXT_WINDOW} Precursor (address, a_name, e_class)
		end

	put_comment (s: STRING) is
			-- Add comment text `s'.
		do
			implementation.set_character_format_word (comment_format)
			put_normal_string (s)
		end

	put_symbol (s: STRING) is
			-- Add special text `s'.
		do
			implementation.set_character_format_word (symbol_format)
			put_normal_string (s)
		end

	put_keyword (s: STRING) is
			-- Add keyword text `s'.
		do
			implementation.set_character_format_word (keyword_format)
			put_normal_string (s)
		end

	put_quoted_comment (s: STRING) is
			-- Add quoted text `s'.
		do
			implementation.set_character_format_word (comment_format)
			{SCROLLED_TEXT_WINDOW} Precursor (s)
		end

	put_stone (a_stone: STONE stone_string: STRING) is
			-- Add `stone_string' to the text image and 
			-- record `a_stone' as clickable.
		local
			p: CLICK_STONE
			length: INTEGER
		do
			implementation.replace_selection (stone_string)
			length := stone_string.count
			!! p.make (a_stone, text_position, text_position + length)
			add_click_stone (p)
			text_position := text_position + length
		end

feature -- Text formatting

	process_padded is
			-- Process padded value (used when processing breakpoints).
		do
			implementation.set_character_format_word (breakable_format)
			put_normal_string ("   ")
		end

	process_breakpoint (a_bp: BREAKPOINT_ITEM) is
			-- Process the quoted `text' within a comment.
		local
			breakable_stone: BREAKABLE_STONE
			click_break: CLICK_BREAKABLE
		do
			!! breakable_stone.make (a_bp.e_feature, a_bp.index)
			if a_bp.display_number then
				implementation.set_character_format_word (breakable_format)
				put_stone (breakable_stone, a_bp.index.out)
			else
				!! click_break.make (breakable_stone, text_position, text_position + 3)
				add_click_stone (click_break)
				text_position := text_position + 3
				implementation.set_character_format_word (breakable_format)
				implementation.replace_selection (breakable_stone.sign)
			end
		end

feature {NONE} -- Implementation

	put_normal_string (s: STRING) is
			-- Add non processed text `s'.
		do
			implementation.replace_selection (s)
			text_position := text_position + s.count
		end

feature {NONE} -- Implementation

	done: BOOLEAN
			-- Are we done with `disable_clicking'?
			--| Only one call to `disable_clicking' is allowed at a time.

end -- class GRAPHICAL_TEXT_WINDOW
