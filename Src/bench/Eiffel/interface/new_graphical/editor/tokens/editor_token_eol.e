indexing
	description	: "Token that describe the end of a line."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_EOL

inherit
	EDITOR_TOKEN
		redefine
			display_selected,
			display_half_selected
		end

	SHARED_EDITOR_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make is
			-- Create the token (image is an empty string)
		do
			image := ""
			length := 1
		end

feature -- Miscellaneous

	width: INTEGER is
		do
			Result := 0
		end

	display(d_y: INTEGER; a_dc: WEL_DC) is
		do
			if font /= Void then
				a_dc.select_font(font)
			end

				-- Display the text.
			a_dc.text_out (position, d_y, "¶")

			if font /= Void then
				a_dc.unselect_font
			end
		end


	display_selected(d_y: INTEGER; a_dc: WEL_DC) is
		-- FIXME ARNAUD: To be done better than this.
		local
			old_text_color: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
			displayed_string: STRING
		do
				-- Change drawing style here.
			old_text_color := a_dc.text_color
			old_background_color := a_dc.background_color
			a_dc.set_text_color(selected_text_color)
			a_dc.set_background_color(selected_background_color)
			a_dc.select_font(font)

				-- Display the text.
			create displayed_string.make(255)
			displayed_string.fill_character(' ')
			a_dc.text_out (position, d_y, displayed_string)

				-- Restore drawing style here.
			a_dc.set_text_color(old_text_color)
			a_dc.set_background_color(old_background_color)
			a_dc.unselect_font
		end

	display_half_selected(d_y: INTEGER; start_selection, end_selection: INTEGER; a_dc: WEL_DC) is
		local
			old_text_color: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
			displayed_string: STRING
		do
				-- Change drawing style here.
			old_text_color := a_dc.text_color
			old_background_color := a_dc.background_color
			a_dc.set_text_color(selected_text_color)
			a_dc.set_background_color(selected_background_color)
			a_dc.select_font(font)

				-- Display the text.
			create displayed_string.make(255)
			displayed_string.fill_character(' ')
			a_dc.text_out (position, d_y, displayed_string)

				-- Restore drawing style here.
			a_dc.set_text_color(old_text_color)
			a_dc.set_background_color(old_background_color)
			a_dc.unselect_font
		end

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

feature {NONE} -- Properties used to display the token

	font: WEL_FONT is
		local
			log_font: WEL_LOG_FONT
		once
				-- create the font
			create log_font.make(editor_preferences.font_size, editor_preferences.font_name)
			create Result.make_indirect(log_font)
		end

end -- class EDITOR_COMMENT
