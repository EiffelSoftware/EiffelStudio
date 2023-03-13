note
	description: "General editor preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_DATA

inherit
	EV_FONT_CONSTANTS

	DOCUMENT_TYPE_MANAGER

	SHARED_EDITOR_FONT

	SHARED_EDITOR_DATA

	EDITOR_TOKEN_IDS

create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES)
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialized_cell.put (True)
			initialize_preferences
			init_colors
			init_fonts
			editor_preferences_cell.put (Current)
		ensure
			preferences_not_void: preferences /= Void
		end

	update
		do
			init_colors
			panel_manager.refresh_all
		end

	update_font
			-- Font was changed, must redraw tokens due to possible width change.
		do
			init_fonts

			line_height_cell.put (calculate_line_height)
			font_offset_cell.put (calculate_font_offset)
			is_fixed_width_cell.put (
				(not font.is_proportional and not keyword_font.is_proportional) and then
				font.width = keyword_font.width)
			font_width_cell.put (font_with_zoom_factor_cell.item.width)

			across
				panel_manager.panels as ic
			loop
				if attached ic as l_panel then
					l_panel.on_font_changed
				end
			end
			update
		end

feature -- Value

	color_of_id (a_id: INTEGER): EV_COLOR
			-- Color of `a_id'
		require
			a_id_positive: a_id > 0
		do
			Result := colors.item (a_id)
		ensure
			color_of_id_not_void: Result /= Void
		end

	font_of_id (a_id: INTEGER): EV_FONT
			-- Font of `a_id'
		require
			a_id_positive: a_id > 0
		do
			Result := fonts.item (a_id)
		ensure
			font_of_id_not_void: Result /= Void
		end

	smart_indentation: BOOLEAN
			-- Is smart indentation enabled?
		do
			Result := smart_indentation_preference.value
		end

	tabulation_spaces: INTEGER
			-- Number of space characters in a tabulation.
			-- TODO: neilc.  Make sure user does not enter a negative value for this.
		do
			if tabulation_spaces_preference.value <= 0 then
				tabulation_spaces_preference.set_value (1)
			end
			Result := tabulation_spaces_preference.value
		ensure
			tabulation_spaces_positive: Result > 0
		end

	automatic_update: BOOLEAN
			-- If the text has been modified by an external editor, should we
			-- reload the file automatically if no change has been made here?
		do
			Result := automatic_update_preference.value
		end

	use_tab_for_indentation: BOOLEAN
			-- Use tabulations (not spaces) for auto-indenting?
		do
			Result := use_tab_for_indentation_preference.value
		end

	scrolling_common_line_count: INTEGER
			-- Number of common lines staying on screen after scrolling
			-- by one page up or down.
		do
			Result := scrolling_common_line_count_preference.value
		end

	mouse_wheel_scroll_full_page: BOOLEAN
			-- Should a mouse wheel scroll event scroll full page?
		do
			Result := mouse_wheel_scroll_full_page_preference.value
		end

	mouse_wheel_scroll_size: INTEGER
			-- Number of lines to scroll when a mouse wheel scroll event is received.
			-- Overriden by `mouse_wheel_scroll_full_page'.
		do
			Result := mouse_wheel_scroll_size_preference.value
		end

	remove_trailing_white_space: BOOLEAN
			-- Indicates if trailing white space should be removed from lines during editing
		do
			Result := remove_trailing_white_space_preference.value
		end

	left_margin_width: INTEGER
			-- Width of left margin in pixels (not the breakpoint/line number margin margin)
		do
			Result := left_margin_width_preference.value
		end

	margin_background_color: EV_COLOR
			-- Color for margin background
		do
			Result := margin_background_color_preference.value
		end

	margin_separator_color: EV_COLOR
			-- Color for margin separator
		do
			Result := margin_separator_color_preference.value
		end

	line_number_text_color: EV_COLOR
			-- Color for line number text
		do
			Result := line_number_text_color_preference.value
		end

	show_line_numbers: BOOLEAN
			-- Indicates if the editor should display the line numbers
		do
			Result := show_line_numbers_preference.value
		end

	smart_home: BOOLEAN
			-- Indicates if editor should go to the beginning on the first non-whitespace character, on a line, when the HOME key is pressed
		do
			Result := smart_home_preference.value
		end

	blinking_cursor: BOOLEAN
			-- Indicates if editor cursor should blick
		do
			Result := blinking_cursor_preference.value
		end

	normal_text_color: EV_COLOR
			-- Color used to display normal text
		do
			Result := normal_text_color_preference.value
		end

	normal_background_color: EV_COLOR
			-- Background color used to display normal text
		do
			Result := normal_background_color_preference.value
		end

	selection_text_color: EV_COLOR
			-- Color used to display selected text
		do
			Result := selection_text_color_preference.value
		end

	selection_background_color: EV_COLOR
			-- Background color used to display selected text when has focus
		do
			Result := selection_background_color_preference.value
		end

	focus_out_selection_background_color: EV_COLOR
			-- Background color used to display selected text when focus losed
		do
			Result := focus_out_selection_background_color_preference.value
		end

	string_text_color: EV_COLOR
			-- Color used to display strings
		do
			Result := string_text_color_preference.value
		end

	string_background_color: EV_COLOR
			-- Background color used to display strings
		do
			Result := string_background_color_preference.value
		end

	keyword_text_color: EV_COLOR
			-- Color used to display keywords
		do
			Result := keyword_text_color_preference.value
		end

	keyword_background_color: EV_COLOR
			-- Background color used to display keywords
		do
			Result := keyword_background_color_preference.value
		end

	spaces_text_color: EV_COLOR
			-- Color used to display spaces
		do
			Result := spaces_text_color_preference.value
		end

	spaces_background_color: EV_COLOR
			-- Background color used to display spaces
		do
			Result := spaces_background_color_preference.value
		end

	comments_text_color: EV_COLOR
			-- Color used to display comments
		do
			Result := comments_text_color_preference.value
		end

	comments_background_color: EV_COLOR
			-- Color used to display comments background
		do
			Result := comments_background_color_preference.value
		end

	quoted_feature_text_color: EV_COLOR
			-- Color used to display quoted feature in comments
		do
			Result := quoted_feature_text_color_preference.value
		end

	quoted_feature_background_color: EV_COLOR
			-- Color used to display quoted feature in comments background
		do
			Result := quoted_feature_background_color_preference.value
		end

	number_text_color: EV_COLOR
			-- Color used to display numbers
		do
			Result := number_text_color_preference.value
		end

	number_background_color: EV_COLOR
			-- Background color used to display numbers
		do
			Result := number_background_color_preference.value
		end

	operator_text_color: EV_COLOR
			-- Color used to display operator
		do
			Result := operator_text_color_preference.value
		end

	operator_background_color: EV_COLOR
			-- Background color used to display operator
		do
			Result := operator_background_color_preference.value
		end

	highlight_text_color: EV_COLOR
			-- Text color used to highlight lines
		do
			Result := highlight_text_color_preference.value
		end

	highlight_background_color: EV_COLOR
			-- Background color used to highlight lines
		do
			Result := highlight_background_color_preference.value
		end

	cursor_line_highlight_color: EV_COLOR
			-- Background color used to highlight line with cursor in it
		do
			Result := cursor_line_highlight_color_preference.value
		end

	link_color: EV_COLOR
			-- Color for links
		do
			Result := link_color_preference.value
		end

	link_background_color: EV_COLOR
			-- Background color for links
		do
			Result := link_background_color_preference.value
		end

	mouse_over_link_color: EV_COLOR
			-- Color for links when mouse is over.
		do
			Result := mouse_over_link_color_preference.value
		end

	mouse_over_link_background_color: EV_COLOR
			-- Color for links when mouse is over.
		do
			Result := mouse_over_link_background_color_preference.value
		end

	quadruple_click_enabled: BOOLEAN
			-- is quadruple click (select all) enabled ?
		do
			Result := quadruple_click_enabled_preference.value
		end

	use_buffered_line: BOOLEAN
			--
		do
			Result := use_buffered_line_preference.value
		end

feature {ANY} -- Preferences

	editor_font_preference: FONT_PREFERENCE
			-- Current text font.

	keyword_font_preference: FONT_PREFERENCE
			-- Font for keywords.

	font_zoom_factor_preference: INTEGER_PREFERENCE
			-- Zoom factor which setting by `ctrl + mouse wheel'

	header_font_preference: FONT_PREFERENCE
			-- Font for header panel tabs preference

	tabulation_spaces_preference: INTEGER_PREFERENCE

	automatic_update_preference: BOOLEAN_PREFERENCE
			-- If the text has been modified by an external editor, should we
			-- reload the file automatically if no change has been made here?

	use_tab_for_indentation_preference: BOOLEAN_PREFERENCE
			-- Use tabulations (not spaces) for auto-indenting?

	scrolling_common_line_count_preference: INTEGER_PREFERENCE
			-- Number of common lines staying on screen after scrolling
			-- by one page up or down.

	mouse_wheel_scroll_full_page_preference: BOOLEAN_PREFERENCE
			-- Should a mouse wheel scroll event scroll full page?

	mouse_wheel_scroll_size_preference: INTEGER_PREFERENCE
			-- Number of lines to scroll when a mouse wheel scroll event is received.
			-- Overriden by `mouse_wheel_scroll_full_page'.

	remove_trailing_white_space_preference: BOOLEAN_PREFERENCE
			-- Indicates if trailing white space should be removed from lines during editing

	left_margin_width_preference: INTEGER_PREFERENCE
			-- Width of left margin in pixels (not the breakpoint/line number margin margin)

	margin_background_color_preference: COLOR_PREFERENCE
			-- Color for margin background

	margin_separator_color_preference: COLOR_PREFERENCE
			-- Color for margin separator

	line_number_text_color_preference: COLOR_PREFERENCE
			-- Color for line number text

	show_line_numbers_preference: BOOLEAN_PREFERENCE
			-- Indicates if line numbers should be shown in the editor

	smart_home_preference: BOOLEAN_PREFERENCE
			-- Indicates if editor should go to the beginning on the first non-whitespace character, on a line, when the HOME key is pressed

	blinking_cursor_preference: BOOLEAN_PREFERENCE
			-- Indicates if editor cursor should blick

	normal_text_color_preference: COLOR_PREFERENCE
			-- Color used to display normal text

	normal_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display normal text

	selection_text_color_preference: COLOR_PREFERENCE
			-- Color used to display selected text

	selection_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display selected text when has focus

	focus_out_selection_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display selected text when focus losed

	string_text_color_preference: COLOR_PREFERENCE
			-- Color used to display strings

	string_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display strings

	keyword_text_color_preference: COLOR_PREFERENCE
			-- Color used to display keywords

	keyword_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display keywords

	spaces_text_color_preference: COLOR_PREFERENCE
			-- Color used to display spaces

	spaces_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display spaces

	comments_text_color_preference: COLOR_PREFERENCE
			-- Color used to display comments

	comments_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display comments

	quoted_feature_text_color_preference: COLOR_PREFERENCE
			-- Color used to display quoted feature in comments

	quoted_feature_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display quoted feature in comments

	number_text_color_preference: COLOR_PREFERENCE
			-- Color used to display numbers

	number_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display numbers

	operator_text_color_preference: COLOR_PREFERENCE
			-- Color used to display operator

	operator_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display operator

	highlight_text_color_preference: COLOR_PREFERENCE
			-- Highlight text color

	highlight_background_color_preference: COLOR_PREFERENCE
			-- Highlight background color

	cursor_line_highlight_color_preference: COLOR_PREFERENCE
			-- Cursor line highlight color

	link_color_preference: COLOR_PREFERENCE
			-- Link color

	link_background_color_preference: COLOR_PREFERENCE
			-- Background color for links

	mouse_over_link_color_preference: COLOR_PREFERENCE
			-- Mouse over link color

	mouse_over_link_background_color_preference: COLOR_PREFERENCE
			-- Mouse over background color for links

	smart_indentation_preference: BOOLEAN_PREFERENCE
			-- Is smart indentation enabled?

	quadruple_click_enabled_preference: BOOLEAN_PREFERENCE
			-- is quadruple click (select all) enabled ?

	use_buffered_line_preference: BOOLEAN_PREFERENCE
			-- Use buffered line when drawing?

feature -- Misc

	plain_white: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 255, 255)
		end

	plain_gray: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (64, 64, 64)
		end

	dark_gray: EV_COLOR
		once
			Result := (create {EV_STOCK_COLORS}).dark_grey
		end

	plain_black: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (0, 0, 0)
		end

feature {NONE} -- Preference Strings

	tabulation_spaces_string: STRING = "editor.general.tab_step"
	left_margin_width_string: STRING = "editor.general.left_margin_width"
	margin_background_color_string: STRING = "editor.general.colors.margin_background_color"
	margin_separator_color_string: STRING = "editor.general.colors.margin_separator_color"
	line_number_text_color_string: STRING = "editor.general.colors.line_number_text_color"
	show_line_numbers_string: STRING = "editor.general.show_line_numbers"
	smart_home_string: STRING = "editor.general.smart_home"
	use_tab_for_indentation_string: STRING = "editor.general.use_tab_for_indentation"
	scrolling_common_line_count_string: STRING = "editor.general.scrolling_common_line_count"
	mouse_wheel_scroll_full_page_string: STRING = "editor.general.mouse_wheel_scroll_full_page"
	mouse_wheel_scroll_size_string: STRING = "editor.general.mouse_wheel_scroll_size"
	remove_trailing_white_space_string: STRING = "editor.general.remove_trailing_white_space"
	blinking_cursor_string: STRING = "editor.general.blinking_cursor"
	automatic_update_string: STRING = "editor.general.automatic_update"
	editor_font_string: STRING = "editor.general.editor_font"
	keyword_font_string: STRING = "editor.general.keyword_font"
	font_zoom_factor_string: STRING = "editor.general.font_zoom_factor"
	header_font_string: STRING = "editor.general.header_font"
	highlight_document_changes_string: STRING = "editor.general.highlight_document_changes_between_saves"

	normal_text_color_string: STRING = "editor.general.colors.normal_text_color"
			-- Color used to display normal text

	normal_background_color_string: STRING = "editor.general.colors.normal_background_color"
			-- Background color used to display normal text

	selection_text_color_string: STRING = "editor.general.colors.selection_text_color"
			-- Color used to display selected text

	selection_background_color_string: STRING = "editor.general.colors.selection_background_color"
			-- Background color used to display selected text when has focus

	focus_out_selection_background_color_string: STRING = "editor.general.colors.focus_out_selection_background_color"
			-- Background color used to display selected text when focus losed.

	string_text_color_string: STRING = "editor.general.colors.string_text_color"
			-- Color used to display strings

	string_background_color_string: STRING = "editor.general.colors.string_background_color"
			-- Background color used to display strings

	keyword_text_color_string: STRING = "editor.general.colors.keyword_text_color"
			-- Color used to display keywords

	keyword_background_color_string: STRING = "editor.general.colors.keyword_background_color"
			-- Background color used to display keywords

	spaces_text_color_string: STRING = "editor.general.colors.spaces_text_color"
			-- Color used to display spaces

	spaces_background_color_string: STRING = "editor.general.colors.spaces_background_color"
			-- Background color used to display spaces

	comments_text_color_string: STRING = "editor.general.colors.comments_text_color"
			-- Color used to display comments

	comments_background_color_string: STRING = "editor.general.colors.comments_background_color"
			-- Background color used to display comments

	number_text_color_string: STRING = "editor.general.colors.number_text_color"
			-- Color used to display numbers

	number_background_color_string: STRING = "editor.general.colors.number_background_color"
			-- Background color used to display numbers

	operator_text_color_string: STRING = "editor.general.colors.operator_text_color"
			-- Color used to display operator

	operator_background_color_string: STRING = "editor.general.colors.operator_background_color"
			-- Background color used to display operator

	highlight_text_color_string: STRING = "editor.general.colors.highlight_text_color"
			-- Highlight text color

	highlight_background_color_string: STRING = "editor.general.colors.highlight_background_color"
			-- Highlight background color

	cursor_line_highlight_color_string: STRING = "editor.general.colors.cursor_line_highlight_color"
			-- Cursor line highlight color

	link_color_string: STRING = "editor.general.colors.link_color"
			-- Link color

	link_background_color_string: STRING = "editor.general.colors.link_background_color"
			-- Background color for links

	mouse_over_link_color_string: STRING = "editor.general.colors.mouse_over_link_color"
			-- Mouse over link color

	mouse_over_link_background_color_string: STRING = "editor.general.colors.mouse_over_link_background_color"
			-- Mouse over background color for links

	quoted_feature_text_color_string: STRING = "editor.general.colors.quoted_feature_text_color"
			-- Quoted feature in comment link color

	quoted_feature_background_color_string: STRING = "editor.general.colors.quoted_feature_background_color"
			-- Quoted feature background color for links

	smart_indentation_string: STRING = "editor.general.smart_indentation"
			-- Is smart indentation enabled?

	quadruple_click_enabled_string: STRING = "editor.general.quadruple_click_enabled"
			-- is quadruple click (select all) enabled ?

	use_buffered_line_string: STRING = "editor.general.use_buffered_line"

feature {NONE} -- Implementation

	colors: SPECIAL [EV_COLOR]
			-- Color table
		once
			create Result.make_filled ((create {EV_STOCK_COLORS}).black, max_color_id + 1)
		end

	fonts: SPECIAL [EV_FONT]
			-- Font table
		once
			create Result.make_filled ((create {EV_LABEL}).font, max_font_id + 1)
		end

	init_colors
			-- Init `colors'.
		do
			colors.put (margin_background_color_preference.value, margin_background_color_id)
			colors.put (margin_separator_color_preference.value, margin_separator_color_id)
			colors.put (line_number_text_color_preference.value, line_number_text_color_id)
			colors.put (normal_text_color_preference.value, normal_text_color_id)
			colors.put (normal_background_color_preference.value, normal_background_color_id)
			colors.put (selection_text_color_preference.value, selection_text_color_id)
			colors.put (selection_background_color_preference.value, selection_background_color_id)
			colors.put (focus_out_selection_background_color_preference.value, focus_out_selection_background_color_id)
			colors.put (string_text_color_preference.value, string_text_color_id)
			colors.put (string_background_color_preference.value, string_background_color_id)
			colors.put (keyword_text_color_preference.value, keyword_text_color_id)
			colors.put (keyword_background_color_preference.value, keyword_background_color_id)
			colors.put (spaces_text_color_preference.value, spaces_text_color_id)
			colors.put (spaces_background_color_preference.value, spaces_background_color_id)
			colors.put (comments_text_color_preference.value, comments_text_color_id)
			colors.put (comments_background_color_preference.value, comments_background_color_id)
			colors.put (number_text_color_preference.value, number_text_color_id)
			colors.put (number_background_color_preference.value, number_background_color_id)
			colors.put (operator_text_color_preference.value, operator_text_color_id)
			colors.put (operator_background_color_preference.value, operator_background_color_id)
			colors.put (highlight_text_color_preference.value, highlight_text_color_id)
			colors.put (highlight_background_color_preference.value, highlight_background_color_id)
			colors.put (cursor_line_highlight_color_preference.value, cursor_line_highlight_color_id)
			colors.put (link_color_preference.value, link_color_id)
			colors.put (link_background_color_preference.value, link_background_color_id)
			colors.put (mouse_over_link_color_preference.value, mouse_over_link_color_id)
			colors.put (mouse_over_link_background_color_preference.value, mouse_over_link_background_color_id)
			colors.put (quoted_feature_text_color_preference.value, quoted_feature_text_color_id)
			colors.put (quoted_feature_background_color_preference.value, quoted_feature_background_color_id)
		end

	init_fonts
			-- Init `fonts'.
		do
			font_with_zoom_factor_cell.put (calculate_font_with_zoom_factor)
			keyword_font_with_zoom_factor_cell.put (calculate_keyword_font_with_zoom_factor)

			fonts.put (font_with_zoom_factor_cell.item, editor_font_id)
			fonts.put (keyword_font_with_zoom_factor_cell.item, keyword_font_id)
		ensure
			set: font_of_id (editor_font_id) /= Void
			set: font_of_id (keyword_font_id) /= Void
		end

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EDITOR_PREFERENCE_MANAGER
			l_bold_font: EV_FONT
		do
			create l_manager.make (preferences, "editor")

				-- Preferences

			smart_indentation_preference := l_manager.new_boolean_preference_value (l_manager, smart_indentation_string, True)
			tabulation_spaces_preference := l_manager.new_integer_preference_value (l_manager, tabulation_spaces_string, 4)
			left_margin_width_preference := l_manager.new_integer_preference_value (l_manager, left_margin_width_string, 10)
			margin_background_color_preference := l_manager.new_color_preference_value (l_manager, margin_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			margin_separator_color_preference := l_manager.new_color_preference_value (l_manager, margin_separator_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			line_number_text_color_preference := l_manager.new_color_preference_value (l_manager, line_number_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (192, 192, 192))
			use_tab_for_indentation_preference := l_manager.new_boolean_preference_value (l_manager, use_tab_for_indentation_string, True)
			scrolling_common_line_count_preference := l_manager.new_integer_preference_value (l_manager, scrolling_common_line_count_string, 1)
			mouse_wheel_scroll_full_page_preference := l_manager.new_boolean_preference_value (l_manager, mouse_wheel_scroll_full_page_string, False)
			mouse_wheel_scroll_size_preference := l_manager.new_integer_preference_value (l_manager, mouse_wheel_scroll_size_string, 3)
			remove_trailing_white_space_preference := l_manager.new_boolean_preference_value (l_manager, remove_trailing_white_space_string, False)
			blinking_cursor_preference := l_manager.new_boolean_preference_value (l_manager, blinking_cursor_string, False)
			automatic_update_preference := l_manager.new_boolean_preference_value (l_manager, automatic_update_string, True)
			show_line_numbers_preference := l_manager.new_boolean_preference_value (l_manager, show_line_numbers_string, False)
			smart_home_preference := l_manager.new_boolean_preference_value (l_manager, smart_home_string, True)
			font_zoom_factor_preference := l_manager.new_integer_preference_value (l_manager, font_zoom_factor_string, 0)
			font_zoom_factor_preference.set_default_value ("0")
			font_zoom_factor_cell.put (font_zoom_factor_preference)
			editor_font_preference := l_manager.new_font_preference_value (l_manager, editor_font_string, create {EV_FONT})
			font_cell.put (editor_font_preference)
			header_font_preference := l_manager.new_font_preference_value (l_manager, header_font_string, create {EV_FONT})
			header_font_cell.put (header_font_preference)
			create l_bold_font
			l_bold_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			keyword_font_preference := l_manager.new_font_preference_value (l_manager, keyword_font_string, l_bold_font)
			keyword_font_cell.put (keyword_font_preference)
			is_fixed_width_cell.put (
				(not font.is_proportional and not keyword_font.is_proportional) and then
				font.width = keyword_font.width)

			normal_text_color_preference := l_manager.new_color_preference_value (l_manager, normal_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			normal_background_color_preference := l_manager.new_color_preference_value (l_manager, normal_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			selection_text_color_preference := l_manager.new_color_preference_value (l_manager, selection_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 128))
			selection_background_color_preference := l_manager.new_color_preference_value (l_manager, selection_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 128))
			focus_out_selection_background_color_preference := l_manager.new_color_preference_value (l_manager, focus_out_selection_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (236, 233, 216))
			string_text_color_preference := l_manager.new_color_preference_value (l_manager, string_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (115, 85, 0))
			string_background_color_preference := l_manager.new_color_preference_value (l_manager, string_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			keyword_text_color_preference := l_manager.new_color_preference_value (l_manager, keyword_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 128))
			keyword_background_color_preference := l_manager.new_color_preference_value (l_manager, keyword_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			spaces_text_color_preference := l_manager.new_color_preference_value (l_manager, spaces_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (128, 128, 128))
			spaces_background_color_preference := l_manager.new_color_preference_value (l_manager, spaces_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			comments_text_color_preference := l_manager.new_color_preference_value (l_manager, comments_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (128, 0, 0))
			comments_background_color_preference := l_manager.new_color_preference_value (l_manager, comments_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			quoted_feature_text_color_preference := l_manager.new_color_preference_value (l_manager, quoted_feature_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (64, 0, 0))
			quoted_feature_background_color_preference := l_manager.new_color_preference_value (l_manager, quoted_feature_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			operator_text_color_preference := l_manager.new_color_preference_value (l_manager, operator_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (224, 0, 0))
			operator_background_color_preference := l_manager.new_color_preference_value (l_manager, operator_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			number_text_color_preference := l_manager.new_color_preference_value (l_manager, number_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (128, 0, 255))
			number_background_color_preference := l_manager.new_color_preference_value (l_manager, number_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			highlight_text_color_preference := l_manager.new_color_preference_value (l_manager, highlight_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			highlight_background_color_preference := l_manager.new_color_preference_value (l_manager, highlight_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (50, 250, 30))
			cursor_line_highlight_color_preference := l_manager.new_color_preference_value (l_manager, cursor_line_highlight_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 128, 128))
			link_color_preference := l_manager.new_color_preference_value (l_manager, link_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 255))
			link_background_color_preference := l_manager.new_color_preference_value (l_manager, link_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			mouse_over_link_color_preference := l_manager.new_color_preference_value (l_manager, mouse_over_link_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 153, 0))
			mouse_over_link_background_color_preference := l_manager.new_color_preference_value (l_manager, mouse_over_link_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			quadruple_click_enabled_preference := l_manager.new_boolean_preference_value (l_manager, quadruple_click_enabled_string, True)
			use_buffered_line_preference := l_manager.new_boolean_preference_value (l_manager, use_buffered_line_string, True)

				-- Auto colors
			spaces_background_color_preference.set_auto_preference (normal_background_color_preference)
			keyword_background_color_preference.set_auto_preference (normal_background_color_preference)
			comments_background_color_preference.set_auto_preference (normal_background_color_preference)
			number_background_color_preference.set_auto_preference (normal_background_color_preference)
			operator_background_color_preference.set_auto_preference (normal_background_color_preference)
			string_background_color_preference.set_auto_preference (normal_background_color_preference)
			link_background_color_preference.set_auto_preference (normal_background_color_preference)
			mouse_over_link_background_color_preference.set_auto_preference (normal_background_color_preference)

				-- Ensure that the value is never negative
			if tabulation_spaces_preference.value <= 0 then
				tabulation_spaces_preference.set_value (1)
			end
			tabulation_spaces_preference.change_actions.extend (agent update)
			left_margin_width_preference.change_actions.extend (agent update)
			show_line_numbers_preference.change_actions.extend (agent update)
			margin_background_color_preference.change_actions.extend (agent update)
			margin_separator_color_preference.change_actions.extend (agent update)
			line_number_text_color_preference.change_actions.extend (agent update)
			normal_text_color_preference.change_actions.extend (agent update)
			normal_background_color_preference.change_actions.extend (agent update)
			selection_text_color_preference.change_actions.extend (agent update)
			selection_background_color_preference.change_actions.extend (agent update)
			focus_out_selection_background_color_preference.change_actions.extend (agent update)
			string_text_color_preference.change_actions.extend (agent update)
			string_background_color_preference.change_actions.extend (agent update)
			keyword_text_color_preference.change_actions.extend (agent update)
			keyword_background_color_preference.change_actions.extend (agent update)
			spaces_text_color_preference.change_actions.extend (agent update)
			spaces_background_color_preference.change_actions.extend (agent update)
			comments_text_color_preference.change_actions.extend (agent update)
			comments_background_color_preference.change_actions.extend (agent update)
			quoted_feature_text_color_preference.change_actions.extend (agent update)
			quoted_feature_background_color_preference.change_actions.extend (agent update)
			number_text_color_preference.change_actions.extend (agent update)
			number_background_color_preference.change_actions.extend (agent update)
			operator_text_color_preference.change_actions.extend (agent update)
			operator_background_color_preference.change_actions.extend (agent update)
			highlight_text_color_preference.change_actions.extend (agent update)
			highlight_background_color_preference.change_actions.extend (agent update)
			cursor_line_highlight_color_preference.change_actions.extend (agent update)
			use_tab_for_indentation_preference.change_actions.extend (agent update)
			mouse_wheel_scroll_full_page_preference.change_actions.extend (agent update)
			mouse_wheel_scroll_size_preference.change_actions.extend (agent update)
			blinking_cursor_preference.change_actions.extend (agent update)
			automatic_update_preference.change_actions.extend (agent update)
			editor_font_preference.change_actions.extend (agent update_font)
			keyword_font_preference.change_actions.extend (agent update_font)
			font_zoom_factor_preference.change_actions.extend (agent update_font)
			header_font_preference.change_actions.extend (agent update)
			link_color_preference.change_actions.extend (agent update)
			link_background_color_preference.change_actions.extend (agent update)
			mouse_over_link_color_preference.change_actions.extend (agent update)
			mouse_over_link_background_color_preference.change_actions.extend (agent update)
		end

	preferences: PREFERENCES
			-- Preferences
		attribute end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
