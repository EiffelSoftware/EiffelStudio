indexing
	description	: "Token that describe one or several tabulations."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_TABULATION

inherit
	EDITOR_TOKEN_BLANK

create
	make

feature -- Initialisation

	make(number: INTEGER) is
		require
			number_valid: number > 0
		do
			length := number
			create image.make(number)
			image.fill_character('%T')
		ensure
			image_not_void: image /= Void
			length_positive: length > 0
		end

feature -- Width & Height

	width: INTEGER is
			-- Width in pixel of the entire token.
		do
				-- Width of first tabulation.
			Result := ((position // tabulation_width) + 1 ) * tabulation_width - position

				-- Handle next tabulations.
			Result := Result + tabulation_width * (length - 1)
		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			if n = 0 then
				Result := 0
			else
					-- Width of first tabulation.
				Result := (((position // tabulation_width) + 1 ) * tabulation_width ) - position

					-- Handle next tabulations.
				Result := Result + tabulation_width * (n - 1)
			end
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			width_first_tab: INTEGER
		do
			width_first_tab := (((position // tabulation_width) + 1 ) * tabulation_width ) - position

			if a_width < width_first_tab then
				Result := 1
			else
				Result := 2 + (a_width - width_first_tab) // tabulation_width
			end
		end

feature {NONE} -- Implementation

	display_blanks(d_x, d_y: INTEGER; device: EV_PIXMAP; selected: BOOLEAN; start_tab, end_tab: INTEGER): INTEGER is
		local
			old_text_color		: EV_COLOR
			old_background_color: EV_COLOR
			the_text_color		: EV_COLOR
			the_background_color: EV_COLOR
			the_text			: STRING
			local_width			: INTEGER
			symbol_position		: INTEGER
			view_tabulation_symbol: BOOLEAN
			i					: INTEGER
			local_position		: INTEGER
		do
 				-- Initialisations
 			view_tabulation_symbol := editor_preferences.view_invisible_symbols
 			local_position := d_x
 
 				-- Select the drawing style we will use.
 			if selected then
 				the_text_color := selected_text_color
 				the_background_color := selected_background_color
 			else
 				the_text_color := text_color
 				the_background_color := background_color
 			end
 
 				-- Backup drawing style & set the new one
 			device.set_font(font)
 			device.set_foreground_color(the_text_color)
			if the_background_color /= Void then
				device.set_background_color(the_background_color)
			end
 
 				-- Display the first tabulation
 			from
 				i := start_tab
 			until
 				i > end_tab
 			loop
 					-- Compute the width of the tabulation
 				if i = start_tab then
 					local_width := get_substring_width(1)
 				else
 					local_width := tabulation_width
 				end
 			
 					-- Compute the position of the tabulation symbol
 				if view_tabulation_symbol then
 					symbol_position := local_position + ( local_width - tabulation_symbol_width ) // 2
 				end
 
 					-- Fill the rectangle occupied by the tabulation
				if the_background_color /= Void then
	 				device.clear_rectangle(local_position, d_y, local_position + local_width, d_y + height)
				end
 
 					-- Display the tabulation symbol
 				if view_tabulation_symbol then
 					device.draw_text(symbol_position, d_y, tabulation_symbol)
 				end
 
 					-- update the local position & prepare next iteration
 				local_position := local_position + local_width
 				i := i + 1
 			end
 
 			Result := local_position
		end

feature {NONE} -- Private characteristics & constants

	tabulation_width: INTEGER is
		do
				-- Compute the number of pixels represented by a tabulation based on
				-- user preferences number of spaces per tabulation.
			Result := editor_preferences.tabulation_spaces * font.string_width(" ")
		end

	tabulation_symbol_width: INTEGER is
		do
				-- Compute the number of pixels represented by the tabulation symbol
			Result := font.string_width(tabulation_symbol)
		end

	tabulation_symbol: STRING is
		once
			Result := "�"
		end

end -- class EDITOR_TOKEN_TABULATION
