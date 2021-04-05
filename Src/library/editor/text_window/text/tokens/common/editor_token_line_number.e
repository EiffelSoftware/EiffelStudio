note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_LINE_NUMBER

inherit
	EDITOR_TOKEN_MARGIN
		redefine
			update_position,
			update_width,
			text_color_id
		end

	SINGLE_MATH

create
	make

feature -- Initialization

	make
			-- Initialize
		do
			wide_image := ""
			internal_image := ""
			length := wide_image.count
		end

feature -- Width & height

	width: INTEGER
			-- Width in pixels

	separator_width: INTEGER = 1
			-- Width in pixels of separator

	get_substring_width (n: INTEGER): INTEGER
			-- Compute the width in pixels of the first
			-- `n' characters of the current string.
		local
			i: INTEGER
		do
			if n = 0 then
				Result := 0
			else
				if internal_image.has ('%T') then
					from
						i := 1
					until
						i > n or else i > internal_image.count
					loop
						if internal_image [i] = '%T' then
							Result := (position + Result + 1) - position
						else
							Result := Result + font.string_width (create {STRING_32}.make_filled (internal_image [i], 1))
						end
						i := i + 1
					end
				else
					Result := font.string_width (internal_image.substring(1,n))
				end
			end
		end

	retrieve_position_by_width (a_width: INTEGER): INTEGER
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := 1
		end

feature -- Miscellaneous

	update_position
			-- Update the value of `position' to
			-- its correct value
		do
			if attached previous as l_previous then
				-- Update current position
				position := l_previous.width
			end

			update_width
		end

	display (d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL)
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		do
			update_width

				-- Display the image	
			if panel.text_is_fully_loaded then
				display_with_colors (d_y, text_color, background_color, device)
			else
				display_with_colors (d_y, gray_text_color, background_color, device)
			end
		end

	display_with_offset (x_offset, d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL)
			-- Display the current token on device context `dc' at the coordinates (`position + x_offset',`d_y')
		do
			update_width
			if panel.text_is_fully_loaded then
				display_with_colors_offset (x_offset, d_y, text_color, background_color, device)
			else
				display_with_colors_offset (x_offset, d_y, gray_text_color, background_color, device)
			end
		end

	hide
			-- Hide Current
		do
			width := 0
		end

feature -- Visitor

	process (a_visitor: TOKEN_VISITOR)
			-- Visitor
		do
			a_visitor.process_editor_token_line_number (Current)
		end

feature {MARGIN_WIDGET, MARGIN} -- Implementation

	update_width
			-- Update value of `width'
		do
			width := get_substring_width (internal_image.count) + 1 + separator_width
		end

	text_color_id: INTEGER
			-- Color of text
		do
			Result := line_number_text_color_id
		end

	gray_text_color: EV_COLOR
			-- Gray text color.  Used for dimming text until fully loaded
		local
			lightness: REAL
		once
			lightness := sqrt (text_color.lightness)
			create Result.make_with_rgb (lightness, lightness, lightness)
		end

	display_with_colors (d_y: INTEGER; a_text_color: EV_COLOR; a_background_color: EV_COLOR; device: EV_DRAWABLE)
			-- Display token with coloring
		local
			text_to_be_drawn: like wide_image
			l_pos: INTEGER
		do
 				-- Change drawing style here.
			if a_background_color /= Void then
				device.set_background_color (a_background_color)
				device.clear_rectangle (position, d_y, get_substring_width (internal_image.count), height)
			end

			text_to_be_drawn := internal_image.twin
			text_to_be_drawn.prune_all_leading ('0')

 				-- Change drawing style here.
 			device.set_font (font)
			device.set_foreground_color (text_color)

			l_pos := position + width - font.string_width (text_to_be_drawn) - separator_width - 1

 				-- Display the text.
 			draw_text_top_left (l_pos, d_y, text_to_be_drawn, device)
		end

	display_with_colors_offset (x_offset, d_y: INTEGER; a_text_color: EV_COLOR; a_background_color: EV_COLOR; device: EV_DRAWABLE)
			-- Display token with coloring
		local
			text_to_be_drawn: like wide_image
			l_pos: INTEGER
		do
 				-- Change drawing style here.
			if a_background_color /= Void then
				device.set_background_color (a_background_color)
				device.clear_rectangle (x_offset, d_y, get_substring_width (internal_image.count), height)
			end

			text_to_be_drawn := internal_image.twin
			text_to_be_drawn.prune_all_leading ('0')

 				-- Change drawing style here.
 			device.set_font (font)
			device.set_foreground_color (text_color)

			l_pos := x_offset + width - font.string_width (text_to_be_drawn) - separator_width - 1

 				-- Display the text.
 			draw_text_top_left (l_pos, d_y, text_to_be_drawn, device)
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
