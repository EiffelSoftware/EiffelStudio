note
	description: "Objects contains ids for editor. i.e. color ids and font ids."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_IDS

feature -- Color ids

	margin_background_color_id: INTEGER = 1
			-- Color for margin background

	margin_separator_color_id: INTEGER = 2
			-- Color for margin separator

	line_number_text_color_id: INTEGER = 3
			-- Color for line number text

	normal_text_color_id: INTEGER = 4
			-- Color used to display normal text

	normal_background_color_id: INTEGER = 5
			-- Background color used to display normal text

	selection_text_color_id: INTEGER = 6
			-- Color used to display selected text

	selection_background_color_id: INTEGER = 7
			-- Background color used to display selected text when has focus

	focus_out_selection_background_color_id: INTEGER = 8
			-- Background color used to display selected text when focus losed

	string_text_color_id: INTEGER = 9
			-- Color used to display strings

	string_background_color_id: INTEGER = 10
			-- Background color used to display strings

	keyword_text_color_id: INTEGER = 11
			-- Color used to display keywords

	keyword_background_color_id: INTEGER = 12
			-- Background color used to display keywords

	spaces_text_color_id: INTEGER = 13
			-- Color used to display spaces

	spaces_background_color_id: INTEGER = 14
			-- Background color used to display spaces

	comments_text_color_id: INTEGER = 15
			-- Color used to display comments

	comments_background_color_id: INTEGER = 16
			-- Color used to display comments background

	number_text_color_id: INTEGER = 17
			-- Color used to display numbers

	number_background_color_id: INTEGER = 18
			-- Background color used to display numbers

	operator_text_color_id: INTEGER = 19
			-- Color used to display operator

	operator_background_color_id: INTEGER = 20
			-- Background color used to display operator	

	highlight_color_id: INTEGER = 21
			-- Background color used to highlight lines

	cursor_line_highlight_color_id: INTEGER = 22
			-- Background color used to highlight line with cursor in it

	max_color_id: INTEGER
			-- Maximal id of color.
		do
			Result := cursor_line_highlight_color_id
		end

feature -- Font ids

	editor_font_id: INTEGER = 1

	keyword_font_id: INTEGER = 2

	max_font_id: INTEGER
			-- Maximal id of font
		do
			Result := keyword_font_id
		end

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
