indexing
	description	: "Preferences of the user for the editor"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_PREFERENCES

inherit
	ANY
		redefine
			default_create
		end

feature -- Default Initialisation

	default_create is
			-- Default Initialisations
		do
			tabulation_spaces := 4
			font_name := "Courier New"
			font_size := 14
			create normal_text_color.make_rgb(255,255,255)
			create normal_background_color.make_rgb(0,0,0)

			create selected_text_color.make_rgb(255,255,255)
			create selected_background_color.make_rgb(0,0,128)

			create string_text_color.make_rgb(255,255,204)
			create string_background_color.make_rgb(153,0,51)

			create keyword_text_color.make_rgb(0,153,255)
			create keyword_background_color.make_rgb(0,0,0)

			create spaces_text_color.make_rgb(0,0,128)
			create spaces_background_color.make_rgb(0,0,0)

			create comments_text_color.make_rgb(204,102,255)
			create comments_background_color.make_rgb(0,0,0)

			create number_text_color.make_rgb(150,255,150)
			create number_background_color.make_rgb(0,0,0)

			create operator_text_color.make_rgb(0,153,255)
			create operator_background_color.make_rgb(0,0,0)

			create normal_background_brush.make_solid(normal_background_color)
			create selected_background_brush.make_solid(selected_background_color)
		end

feature -- Access

		--| General Preferences

	tabulation_spaces: INTEGER
		-- number of spaces characters in a tabulation.

	font_name: STRING
		-- Name of the font used to display
		-- characters in the editor

	font_size: INTEGER
		-- Size of the font used to display
		-- characters in the editor

	view_invisible_symbols: BOOLEAN
		-- Are the spaces, the tabulations and the end_of_line
		-- character visible?

		--| Font color Preferences

	normal_text_color: WEL_COLOR_REF
		-- Color used to display normal text

	normal_background_color: WEL_COLOR_REF
		-- Background color used to display normal text

	normal_background_brush: WEL_BRUSH
		-- Background brush corresponding to `normal_brackground_color'

	selected_text_color: WEL_COLOR_REF
		-- Color used to display selected text

	selected_background_color: WEL_COLOR_REF
		-- Background color used to display selected text

	selected_background_brush: WEL_BRUSH
		-- Backgroun brush corresponding to `selected_brackground_color'

	string_text_color: WEL_COLOR_REF
		-- Color used to display strings

	string_background_color: WEL_COLOR_REF
		-- Background color used to display strings

	keyword_text_color: WEL_COLOR_REF
		-- Color used to display keywords

	keyword_background_color: WEL_COLOR_REF
		-- Background color used to display keywords

	spaces_text_color: WEL_COLOR_REF
		-- Color used to display spaces

	spaces_background_color: WEL_COLOR_REF
		-- Background color used to display spaces

	comments_text_color: WEL_COLOR_REF
		-- Color used to display comments

	comments_background_color: WEL_COLOR_REF
		-- Background color used to display comments

	number_text_color: WEL_COLOR_REF
		-- Color used to display numbers

	number_background_color: WEL_COLOR_REF
		-- Background color used to display numbers

	operator_text_color: WEL_COLOR_REF
		-- Color used to display operator

	operator_background_color: WEL_COLOR_REF
		-- Background color used to display operator

feature -- Element Change (General preferences)

	set_font_size(a_font_size: INTEGER) is
			-- Set `font_size' to `a_font_size'
		require
			a_font_size_valid: a_font_size > 0
		do
			font_size := a_font_size
		ensure
			font_size_set: font_size = a_font_size
		end

	set_font_name(a_font_name: STRING) is
			-- Set `font_name' to `a_font_name'
		require
			a_font_name_valid: a_font_name /= Void and then not a_font_name.empty
		do
			font_name := a_font_name
		ensure
			font_name_set: font_name = a_font_name
		end

	set_tabulation_spaces(number_of_spaces: INTEGER) is
			-- Set the number of spaces inside a tabulation
			-- to `number_of_spaces'.
		require
			number_of_spaces_valid: number_of_spaces >= 1 
		do
			tabulation_spaces := number_of_spaces
		ensure
			tabulation_spaces_set : tabulation_spaces = number_of_spaces
		end

	show_invisible_symbols is
			-- Set `view_invisible_symbols' to True
		do
			view_invisible_symbols := True
		ensure
			view_invisible_symbols_set: view_invisible_symbols
		end

	hide_invisible_symbols is
			-- Set `view_invisible_symbols' to True
		do
			view_invisible_symbols := False
		ensure
			view_invisible_symbols_set: not view_invisible_symbols
		end

feature -- Element Change (Font color Preferences)

	set_normal_text_color(a_normal_text_color: WEL_COLOR_REF) is
			-- Set the color used to display normal text
		require
			a_normal_text_color_not_void: a_normal_text_color /= Void
		do
			normal_text_color := a_normal_text_color
		ensure
			normal_text_color = a_normal_text_color
		end

	set_normal_background_color(a_normal_background_color: WEL_COLOR_REF) is
			-- Set the background color used to display normal text
		require
			a_normal_background_color_not_void: a_normal_background_color /= Void
		do
			normal_background_color := a_normal_background_color
			create normal_background_brush.make_solid(a_normal_background_color)
		ensure
			normal_background_color = a_normal_background_color
		end

	set_selected_text_color(a_selected_text_color: WEL_COLOR_REF) is
			-- Set the color used to display selected text
		require
			a_selected_text_color_not_void: a_selected_text_color /= Void
		do
			selected_text_color := a_selected_text_color
		ensure
			selected_text_color = a_selected_text_color
		end

	set_selected_background_color(a_selected_background_color: WEL_COLOR_REF) is
			-- Set the background color used to display selected text
		require
			a_selected_background_color_not_void: a_selected_background_color /= Void
		do
			selected_background_color := a_selected_background_color
			create selected_background_brush.make_solid(a_selected_background_color)
		ensure
			selected_background_color = a_selected_background_color
		end

	set_string_text_color(a_string_text_color: WEL_COLOR_REF) is
			-- Set the color used to display string text
		require
			a_string_text_color_not_void: a_string_text_color /= Void
		do
			string_text_color := a_string_text_color
		ensure
			string_text_color = a_string_text_color
		end

	set_string_background_color(a_string_background_color: WEL_COLOR_REF) is
			-- Set the background color used to display string text
		require
			a_string_background_color_not_void: a_string_background_color /= Void
		do
			string_background_color := a_string_background_color
		ensure
			string_background_color = a_string_background_color
		end

	set_keyword_text_color(a_keyword_text_color: WEL_COLOR_REF) is
			-- Set the color used to display keyword text
		require
			a_keyword_text_color_not_void: a_keyword_text_color /= Void
		do
			keyword_text_color := a_keyword_text_color
		ensure
			keyword_text_color = a_keyword_text_color
		end

	set_keyword_background_color(a_keyword_background_color: WEL_COLOR_REF) is
			-- Set the background color used to display keyword text
		require
			a_keyword_background_color_not_void: a_keyword_background_color /= Void
		do
			keyword_background_color := a_keyword_background_color
		ensure
			keyword_background_color = a_keyword_background_color
		end

	set_spaces_text_color(a_spaces_text_color: WEL_COLOR_REF) is
			-- Set the color used to display spaces text
		require
			a_spaces_text_color_not_void: a_spaces_text_color /= Void
		do
			spaces_text_color := a_spaces_text_color
		ensure
			spaces_text_color = a_spaces_text_color
		end

	set_spaces_background_color(a_spaces_background_color: WEL_COLOR_REF) is
			-- Set the background color used to display spaces text
		require
			a_spaces_background_color_not_void: a_spaces_background_color /= Void
		do
			spaces_background_color := a_spaces_background_color
		ensure
			spaces_background_color = a_spaces_background_color
		end

	set_comments_text_color(a_comments_text_color: WEL_COLOR_REF) is
			-- Set the color used to display comments text
		require
			a_comments_text_color_not_void: a_comments_text_color /= Void
		do
			comments_text_color := a_comments_text_color
		ensure
			comments_text_color = a_comments_text_color
		end

	set_comments_background_color(a_comments_background_color: WEL_COLOR_REF) is
			-- Set the background color used to display comments text
		require
			a_comments_background_color_not_void: a_comments_background_color /= Void
		do
			comments_background_color := a_comments_background_color
		ensure
			comments_background_color = a_comments_background_color
		end

	set_number_text_color(a_number_text_color: WEL_COLOR_REF) is
			-- Set the color used to display number text
		require
			a_number_text_color_not_void: a_number_text_color /= Void
		do
			number_text_color := a_number_text_color
		ensure
			number_text_color = a_number_text_color
		end

	set_number_background_color(a_number_background_color: WEL_COLOR_REF) is
			-- Set the background color used to display number text
		require
			a_number_background_color_not_void: a_number_background_color /= Void
		do
			number_background_color := a_number_background_color
		ensure
			number_background_color = a_number_background_color
		end

	set_operator_text_color(a_operator_text_color: WEL_COLOR_REF) is
			-- Set the color used to display operator text
		require
			a_operator_text_color_not_void: a_operator_text_color /= Void
		do
			operator_text_color := a_operator_text_color
		ensure
			operator_text_color = a_operator_text_color
		end

	set_operator_background_color(a_operator_background_color: WEL_COLOR_REF) is
			-- Set the background color used to display operator text
		require
			a_operator_background_color_not_void: a_operator_background_color /= Void
		do
			operator_background_color := a_operator_background_color
		ensure
			operator_background_color = a_operator_background_color
		end

invariant
	font_name_not_void					: font_name /= Void
	normal_text_color_not_void			: normal_text_color /= Void
	normal_background_color_not_void	: normal_background_color /= Void
	selected_text_color_not_void		: selected_text_color /= Void
	selected_background_color_not_void	: selected_background_color /= Void
	string_text_color_not_void			: string_text_color /= Void
	string_background_color_not_void	: string_background_color /= Void
	keyword_text_color_not_void			: keyword_text_color /= Void
	keyword_background_color_not_void	: keyword_background_color /= Void
	spaces_text_color_not_void			: spaces_text_color /= Void
	spaces_background_color_not_void	: spaces_background_color /= Void
	comments_text_color_not_void		: comments_text_color /= Void
	comments_background_color_not_void	: comments_background_color /= Void
	number_text_color_not_void			: number_text_color /= Void
	number_background_color_not_void	: number_background_color /= Void
	operator_text_color_not_void		: operator_text_color /= Void
	operator_background_color_not_void	: operator_background_color /= Void

end -- class SHARED_EDITOR_PREFERENCES
