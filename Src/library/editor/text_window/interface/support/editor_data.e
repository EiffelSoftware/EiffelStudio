indexing
	description: "General editor preferences."
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_DATA

inherit
	EV_FONT_CONSTANTS
		redefine
		    default_create
		end
		
	DOCUMENT_TYPE_MANAGER

	SHARED_EDITOR_FONT
		redefine
			default_create
		end
		
	SHARED_EDITOR_DATA

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			editor_preferences_cell.put (Current)
			initialized_cell.put (True)
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end	

	update is
		do
			panel_manager.refresh_all
		end

	update_font is
			-- Font was changed, must redraw tokens due to possible width change.
		do
			line_height_cell.put (calculate_line_height)
			font_offset_cell.put (line_height_font.ascent)
			from
				panel_manager.panels.start
			until
				panel_manager.panels.after
			loop
				if panel_manager.panels.item /= Void then					
					panel_manager.panels.item.reload_text
				end
				panel_manager.panels.forth
			end			
			update
		end

feature -- Value
		
	smart_identation: BOOLEAN is
			-- Is smart identation enabled?
		do
			Result := smart_identation_preference.value
		end	
		
	tabulation_spaces: INTEGER is
			-- Number of spaces characters in a tabulation.  
			-- TODO: neilc.  Make sure user does not enter 0 for this.
		do
			Result := tabulation_spaces_preference.value
		end

	automatic_update: BOOLEAN is
			-- If the text has been modified by an external editor, should we
			-- reload the file automatically if no change has been made here?
		do
			Result := automatic_update_preference.value
		end
			
	use_tab_for_indentation: BOOLEAN is
			-- Use tabulations (not spaces) for auto-indenting?
		do
			Result := use_tab_for_indentation_preference.value
		end
			
	mouse_wheel_scroll_full_page: BOOLEAN is
			-- Should a mouse wheel scroll event scroll full page?
		do
			Result := mouse_wheel_scroll_full_page_preference.value
		end
			
	mouse_wheel_scroll_size: INTEGER is
			-- Number of lines to scroll when a mouse wheel scroll event is received.
			-- Overriden by `mouse_wheel_scroll_full_page'.
		do
			Result := mouse_wheel_scroll_size_preference.value
		end

	remove_trailing_white_space: BOOLEAN is
			-- Indicates if trailing white space should be removed from lines during editing
		do
			Result := remove_trailing_white_space_preference.value
		end

	left_margin_width: INTEGER is
			-- Width of left margin in pixels (not the breakpoint/line number margin margin)
		do
			Result := left_margin_width_preference.value
		end
	
	margin_background_color: EV_COLOR is
			-- Color for margin background
		do
			Result := margin_background_color_preference.value
		end
	
	margin_separator_color: EV_COLOR is
			-- Color for margin separator
		do
			Result := margin_separator_color_preference.value
		end
	
	line_number_text_color: EV_COLOR is
			-- Color for line number text
		do
			Result := line_number_text_color_preference.value
		end
	
	blinking_cursor: BOOLEAN is
			-- Indicates if editor cursor should blick
		do
			Result := blinking_cursor_preference.value
		end
		
	normal_text_color: EV_COLOR is
			-- Color used to display normal text
		do
			Result := normal_text_color_preference.value
		end

	normal_background_color: EV_COLOR is
			-- Background color used to display normal text
		do
			Result := normal_background_color_preference.value
		end

	selection_text_color: EV_COLOR is
			-- Color used to display selected text
		do
			Result := selection_text_color_preference.value
		end

	selection_background_color: EV_COLOR is
			-- Background color used to display selected text
		do
			Result := selection_background_color_preference.value
		end

	string_text_color: EV_COLOR is
			-- Color used to display strings
		do
			Result := string_text_color_preference.value
		end

	string_background_color: EV_COLOR is
			-- Background color used to display strings
		do
			Result := string_background_color_preference.value
		end

	keyword_text_color: EV_COLOR is
			-- Color used to display keywords
		do
			Result := keyword_text_color_preference.value
		end

	keyword_background_color: EV_COLOR is
			-- Background color used to display keywords
		do
			Result := keyword_background_color_preference.value
		end

	spaces_text_color: EV_COLOR is
			-- Color used to display spaces
		do
			Result := spaces_text_color_preference.value
		end

	spaces_background_color: EV_COLOR is
			-- Background color used to display spaces
		do
			Result := spaces_background_color_preference.value
		end

	comments_text_color: EV_COLOR is
			-- Color used to display comments
		do
			Result := comments_text_color_preference.value
		end
		
	comments_background_color: EV_COLOR is
			-- Color used to display comments background
		do
			Result := comments_background_color_preference.value
		end

	number_text_color: EV_COLOR is
			-- Color used to display numbers
		do
			Result := number_text_color_preference.value
		end

	number_background_color: EV_COLOR is
			-- Background color used to display numbers
		do
			Result := number_background_color_preference.value
		end

	operator_text_color: EV_COLOR is
			-- Color used to display operator
		do
			Result := operator_text_color_preference.value
		end

	operator_background_color: EV_COLOR is
			-- Background color used to display operator	
		do
			Result := operator_background_color_preference.value
		end

	highlight_color: EV_COLOR is
			-- Background color used to highlight lines
		do
			Result := highlight_color_preference.value
		end
		
	cursor_line_highlight_color: EV_COLOR is
			-- Background color used to highlight line with cursor in it
		do
			Result := cursor_line_highlight_color_preference.value
		end	
		
	highlight_document_changes: BOOLEAN is
			-- Should editor highlight changes in document between saves?
		do
			Result := highlight_document_changes_preference.value
		end

feature {NONE} -- Preferences

	editor_font_preference: FONT_PREFERENCE
			-- Current text font.

	keyword_font_preference: FONT_PREFERENCE
			-- Font for keywords.

	header_font_preference: FONT_PREFERENCE
			-- Font for header panel tabs preference

	tabulation_spaces_preference: INTEGER_PREFERENCE
	
	automatic_update_preference: BOOLEAN_PREFERENCE
			-- If the text has been modified by an external editor, should we
			-- reload the file automatically if no change has been made here?
			
	use_tab_for_indentation_preference: BOOLEAN_PREFERENCE
			-- Use tabulations (not spaces) for auto-indenting?
			
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
	
	blinking_cursor_preference: BOOLEAN_PREFERENCE
			-- Indicates if editor cursor should blick

	normal_text_color_preference: COLOR_PREFERENCE
			-- Color used to display normal text

	normal_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display normal text

	selection_text_color_preference: COLOR_PREFERENCE
			-- Color used to display selected text

	selection_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display selected text

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

	number_text_color_preference: COLOR_PREFERENCE
			-- Color used to display numbers

	number_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display numbers

	operator_text_color_preference: COLOR_PREFERENCE
			-- Color used to display operator

	operator_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display operator
	     	
    highlight_color_preference : COLOR_PREFERENCE

	cursor_line_highlight_color_preference : COLOR_PREFERENCE

	highlight_document_changes_preference: BOOLEAN_PREFERENCE

	smart_identation_preference: BOOLEAN_PREFERENCE
			-- Is smart identation enabled?	

feature -- Misc

	tab_size_cell: CELL [INTEGER] is
	        -- Temporary, dont make as once
	   	once
	   	    create Result
	   	    Result.put (tabulation_spaces)
	   	end		

	plain_white: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (255, 255, 255)
		end

	plain_gray: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (64, 64, 64)
		end
		
	plain_black: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (0, 0, 0)
		end

feature {NONE} -- Preference Strings

	tabulation_spaces_string: STRING is "editor.tab_step"
	left_margin_width_string: STRING is "editor.left_margin_width"	
	margin_background_color_string: STRING is "editor.margin_background_color"	
	margin_separator_color_string: STRING is "editor.margin_separator_color"
	line_number_text_color_string: STRING is "editor.line_number_text_color"
	use_tab_for_indentation_string: STRING is "editor.use_tab_for_indentation"
	mouse_wheel_scroll_full_page_string: STRING is "editor.mouse_wheel_scroll_full_page"
	mouse_wheel_scroll_size_string: STRING is "editor.mouse_wheel_scroll_size"
	remove_trailing_white_space_string: STRING is "editor.remove_trailing_white_space"
	blinking_cursor_string: STRING is "editor.blinking_cursor"
	automatic_update_string: STRING is "editor.automatic_update"
	editor_font_string: STRING is "editor.editor_font"
	keyword_font_string: STRING is "editor.keyword_font"
	header_font_string: STRING is "editor.header_font"
	highlight_document_changes_string: STRING is "editor.highlight_document_changes_between_saves"
	
	normal_text_color_string: STRING is "editor.normal_text_color"
			-- Color used to display normal text

	normal_background_color_string: STRING is "editor.normal_background_color"
			-- Background color used to display normal text

	selection_text_color_string: STRING is "editor.selection_text_color"
			-- Color used to display selected text

	selection_background_color_string: STRING is "editor.selection_background_color"
			-- Background color used to display selected text

	string_text_color_string: STRING is "editor.string_text_color"
			-- Color used to display strings

	string_background_color_string: STRING is "editor.string_background_color"
			-- Background color used to display strings

	keyword_text_color_string: STRING is "editor.keyword_text_color"
			-- Color used to display keywords

	keyword_background_color_string: STRING is "editor.keyword_background_color" 
			-- Background color used to display keywords

	spaces_text_color_string: STRING is "editor.spaces_text_color"
			-- Color used to display spaces

	spaces_background_color_string: STRING is "editor.spaces_background_color" 
			-- Background color used to display spaces

	comments_text_color_string: STRING is "editor.comments_text_color" 
			-- Color used to display comments

	comments_background_color_string: STRING is "editor.comments_background_color" 
			-- Background color used to display comments

	number_text_color_string: STRING is "editor.number_text_color" 
			-- Color used to display numbers

	number_background_color_string: STRING is "editor.number_background_color" 
			-- Background color used to display numbers

	operator_text_color_string: STRING is "editor.operator_text_color" 
			-- Color used to display operator

	operator_background_color_string: STRING is "editor.operator_background_color" 
			-- Background color used to display operator	
		
	highlight_color_string: STRING is "editor.highlight_color" 
	
	cursor_line_highlight_color_string: STRING is "editor.cursor_line_highlight_color" 

	smart_identation_string: STRING is "editor.smart_identation"
			-- Is smart identation enabled?	


feature {NONE} -- Implementation
		
	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EDITOR_PREFERENCE_MANAGER		
		do
			create l_manager.make (preferences, "editor")
			
				-- Preferences
				
			smart_identation_preference := l_manager.new_boolean_resource_value (l_manager, smart_identation_string, True)	
			tabulation_spaces_preference := l_manager.new_integer_resource_value (l_manager, tabulation_spaces_string, 4)	
			left_margin_width_preference := l_manager.new_integer_resource_value (l_manager, left_margin_width_string, 10)		
			margin_background_color_preference := l_manager.new_color_resource_value (l_manager, margin_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))		
			margin_separator_color_preference := l_manager.new_color_resource_value (l_manager, margin_separator_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))			
			line_number_text_color_preference := l_manager.new_color_resource_value (l_manager, line_number_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (192, 192, 192))	
			use_tab_for_indentation_preference := l_manager.new_boolean_resource_value (l_manager, use_tab_for_indentation_string, True)		
			mouse_wheel_scroll_full_page_preference := l_manager.new_boolean_resource_value (l_manager, mouse_wheel_scroll_full_page_string, False)			
			mouse_wheel_scroll_size_preference := l_manager.new_integer_resource_value (l_manager, mouse_wheel_scroll_size_string, 3)
			remove_trailing_white_space_preference := l_manager.new_boolean_resource_value (l_manager, remove_trailing_white_space_string, False)
			blinking_cursor_preference := l_manager.new_boolean_resource_value (l_manager, blinking_cursor_string, False)
			automatic_update_preference := l_manager.new_boolean_resource_value (l_manager, automatic_update_string, True)	
			
			editor_font_preference := l_manager.new_font_resource_value (l_manager, editor_font_string, create {EV_FONT})	
			font_cell.put (editor_font_preference)			
			header_font_preference := l_manager.new_font_resource_value (l_manager, header_font_string, create {EV_FONT})
			header_font_cell.put (header_font_preference)
			keyword_font_preference := l_manager.new_font_resource_value (l_manager, keyword_font_string, create {EV_FONT})	
			keyword_font_cell.put (keyword_font_preference)
			
			normal_text_color_preference := l_manager.new_color_resource_value (l_manager, normal_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			normal_background_color_preference := l_manager.new_color_resource_value (l_manager, normal_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			selection_text_color_preference := l_manager.new_color_resource_value (l_manager, selection_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 128))
			selection_background_color_preference := l_manager.new_color_resource_value (l_manager, selection_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 128))
			string_text_color_preference := l_manager.new_color_resource_value (l_manager, string_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (115, 85, 0))			
			string_background_color_preference := l_manager.new_color_resource_value (l_manager, string_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			keyword_text_color_preference := l_manager.new_color_resource_value (l_manager, keyword_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 128))
			keyword_background_color_preference := l_manager.new_color_resource_value (l_manager, keyword_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			spaces_text_color_preference := l_manager.new_color_resource_value (l_manager, spaces_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (128, 128, 128))
			spaces_background_color_preference := l_manager.new_color_resource_value (l_manager, spaces_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			comments_text_color_preference := l_manager.new_color_resource_value (l_manager, comments_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (128, 0, 0))
			comments_background_color_preference := l_manager.new_color_resource_value (l_manager, comments_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			operator_text_color_preference := l_manager.new_color_resource_value (l_manager, operator_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
			operator_background_color_preference := l_manager.new_color_resource_value (l_manager, operator_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			number_text_color_preference := l_manager.new_color_resource_value (l_manager, number_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (128, 0, 255))
			number_background_color_preference := l_manager.new_color_resource_value (l_manager, number_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			highlight_color_preference := l_manager.new_color_resource_value (l_manager, highlight_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 128))
			cursor_line_highlight_color_preference := l_manager.new_color_resource_value (l_manager, cursor_line_highlight_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 128, 128))
			
			tabulation_spaces_preference.change_actions.extend (agent update)
			left_margin_width_preference.change_actions.extend (agent update)
			margin_background_color_preference.change_actions.extend (agent update)
			margin_separator_color_preference.change_actions.extend (agent update)
			line_number_text_color_preference.change_actions.extend (agent update)
			use_tab_for_indentation_preference.change_actions.extend (agent update)
			mouse_wheel_scroll_full_page_preference.change_actions.extend (agent update)
			mouse_wheel_scroll_size_preference.change_actions.extend (agent update)
			blinking_cursor_preference.change_actions.extend (agent update)
			automatic_update_preference.change_actions.extend (agent update)			
			editor_font_preference.change_actions.extend (agent update_font)
			keyword_font_preference.change_actions.extend (agent update_font)
			header_font_preference.change_actions.extend (agent update)
		end

	preferences: PREFERENCES
			-- Preferences

end -- class EDITOR_DATA
