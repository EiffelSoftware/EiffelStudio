indexing
	description	: "Token that describe the end of a line."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_EOL

inherit
	EDITOR_TOKEN

create
	make

feature -- Initialisation

	make is
			-- Create the token (image is an empty string)
		do
			image := ""
			length := 1
		end

feature -- Display

	width: INTEGER is
		do
			Result := 0
		end
	
	display_end_token_normal(d_y: INTEGER; a_dc: WEL_DC; a_width: INTEGER) is
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_dc', with a screen width of `a_width'.
			-- The token is displayed in its normal state.
		do
			display_end_token(d_y, a_dc, a_width, False)
		end

	display_end_token_selected(d_y: INTEGER; a_dc: WEL_DC; a_width: INTEGER) is
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_dc', with a screen width of `a_width'.
			-- The token is displayed in its selected state.
		do
			display_end_token(d_y, a_dc, a_width, True)
		end

	display(d_y: INTEGER; a_dc: WEL_DC) is
		do
			-- Do nothing.
		end

feature -- Width & height

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			Result := 0
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := 1
		end

feature {NONE} -- Private Constants

	eol_symbol: STRING is
		once
			Result := "¶"
		end

feature {NONE} -- Implementation

	display_end_token(d_y: INTEGER; a_dc: WEL_DC; a_width: INTEGER; selected: BOOLEAN) is
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_dc', with a screen width of `a_width'.
			-- If `selected' is set, then the token is displayed in its selected
			-- state.
		local
			old_text_color		: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
			the_text_color		: WEL_COLOR_REF
			the_background_color: WEL_COLOR_REF
			the_background_brush: WEL_BRUSH
			wel_rect			: WEL_RECT
			curr_position		: INTEGER
		do
			curr_position := position

				-- Select the drawing style we will use.
			if selected then
				the_text_color := selected_text_color
				the_background_color := selected_background_color
				the_background_brush := selected_background_brush
			else
				the_text_color := text_color
				the_background_color := background_color
				the_background_brush := normal_background_brush
			end

				-- Display the ¶ only if the option is set.
			if editor_preferences.view_invisible_symbols then
					-- Backup old drawing style and set the new one.
				old_text_color := a_dc.text_color
				old_background_color := a_dc.background_color
				a_dc.set_text_color(the_text_color)
				a_dc.set_background_color(the_background_color)
				a_dc.select_font(font)

					-- Display the text.
				a_dc.text_out (curr_position, d_y, eol_symbol)
				curr_position := curr_position + a_dc.string_width(eol_symbol)
				
					-- Restore drawing style here.
				a_dc.set_text_color(old_text_color)
				a_dc.set_background_color(old_background_color)
				a_dc.unselect_font
			end

				-- Fill the end of the line with the specified background brush.
			create wel_rect.make(curr_position, d_y, a_width, d_y+height)
			a_dc.fill_rect(wel_rect, the_background_brush)
		end

end -- class EDITOR_COMMENT
