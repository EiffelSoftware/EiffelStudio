indexing
	description	: "Token that describe a generic text."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_TEXT

inherit
	EDITOR_TOKEN

	SHARED_EDITOR_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make(text: STRING) is
		require
			text_valid: text /= Void and then text.count > 0
		do
			image := text
			length := text.count
		ensure
			image_not_void: image /= Void
			length_positive: length > 0
		end

feature -- Miscellaneous

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			dc.select_font(font)
			Result := dc.string_width(image.substring(1,n))
			dc.unselect_font
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			space_width: INTEGER
			current_position: INTEGER
			current_width: INTEGER
			next_width: INTEGER
		do
			dc.select_font(font)

				-- precompute an estimation of the current_position
			space_width := dc.string_width(" ")
			current_position := a_width // space_width

				-- We have now to check that our current position is the good one.
				-- If we are above, we decrease current_position, and the opposite.
			from
				current_width := dc.string_width(image.substring(1,current_position))
				next_width := dc.string_width(image.substring(1,current_position+1))
			until
				a_width >= current_width and then a_width < next_width
			loop
				if a_width < current_width then
					current_position := current_position - 1
					next_width := current_width
					current_width := dc.string_width(image.substring(1,current_position))
				else
					current_position := current_position + 1
					current_width := next_width
					next_width := dc.string_width(image.substring(1,current_position+1))
				end
			end
			dc.unselect_font

			Result := current_position
		end

	display(d_x: INTEGER; d_y: INTEGER; a_dc: WEL_DC): INTEGER is
		local
			old_text_color: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
		do
				-- Remember the device context
			dc := a_dc

				-- Change drawing style here.
			if text_color /= Void then
				old_text_color := dc.text_color
				dc.set_text_color(text_color)
			end
			if background_color /= Void then
				old_background_color := dc.background_color
				dc.set_background_color(background_color)
			end
			if font /= Void then
				dc.select_font(font)
			end

				-- Display the text.
			dc.text_out (d_x, d_y, image)
			Result := d_x + dc.string_width(image)

				-- Restore drawing style here.
			if text_color /= Void then
				dc.set_text_color(old_text_color)
			end
			if background_color /= Void then
				dc.set_background_color(old_background_color)
			end
			if font /= Void then
				dc.unselect_font
			end
				-- update width
			width := Result - d_x
		end

feature {NONE} -- Properties used to display the token

	text_color: WEL_COLOR_REF is
		do
		end

	background_color: WEL_COLOR_REF is
		do
		end

	font: WEL_FONT is
		local
			log_font: WEL_LOG_FONT
		once
				-- create the font
			create log_font.make(editor_preferences.font_size, editor_preferences.font_name)
			create Result.make_indirect(log_font)
		end

	dc: WEL_DC


end -- class EDITOR_TOKEN
