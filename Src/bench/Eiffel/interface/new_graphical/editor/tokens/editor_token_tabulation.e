indexing
	description	: "Token that describe one or several tabulations."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_TABULATION

inherit
	EDITOR_TOKEN
		redefine
			display_selected,
			display_half_selected
		end

create
	make

feature -- Initialisation

	make(number: INTEGER) is
		do
			length := number
			create image.make(number)
			image.fill_character('%T')
		end

feature -- Display

	display(d_y: INTEGER; a_dc: WEL_DC) is
		local
			local_position: INTEGER
		do
			local_position := display_tabulations(position, d_y, a_dc, False, 1, length)
		end

	display_selected(d_y: INTEGER; a_dc: WEL_DC) is
		local
			local_position: INTEGER
		do
			local_position := display_tabulations(position, d_y, a_dc, True, 1, length)
		end

	display_half_selected(d_y: INTEGER; start_selection, end_selection: INTEGER; a_dc: WEL_DC) is
		local
			local_position: INTEGER
		do
			local_position := position

				-- if the selection do not start at the beginning of the token,
				-- display the first 'non selected' area
			if start_selection /= 1 then
				local_position := display_tabulations(local_position, d_y, a_dc, False, 1, start_selection-1)
			end

				-- Display the 'selected' area
			local_position := display_tabulations(local_position, d_y, a_dc, True, start_selection, end_selection-1)

				-- if the selection do not end at the end of the token,
				-- Display the last 'non selected' area
			if end_selection <= length then
				local_position := display_tabulations(local_position, d_y, a_dc, False, end_selection,length)
			end
		end

feature -- Width & Height

	width: INTEGER is
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

	display_tabulations(d_x, d_y: INTEGER; a_dc: WEL_DC; selected: BOOLEAN; start_tab, end_tab: INTEGER): INTEGER is
		local
			old_text_color		: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
			the_text_color		: WEL_COLOR_REF
			the_background_brush: WEL_BRUSH
			the_text			: STRING
			local_width			: INTEGER
			symbol_position		: INTEGER
			wel_rect			: WEL_RECT
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
				the_background_brush := selected_background_brush
			else
				the_text_color := text_color
				the_background_brush := normal_background_brush
			end

				-- Backup drawing style & set the new one
			old_text_color := a_dc.text_color
			a_dc.set_text_color(the_text_color)
			a_dc.set_background_transparent
			a_dc.select_font(font)

				-- Display the first tabulation
			from
				i := start_tab
			until
				i > end_tab
			loop
					-- Compute the width of the tabulation
				if start_tab = 1 then
					local_width := get_substring_width(1)
				else
					local_width := tabulation_width
				end
			
					-- Compute the position of the tabulation symbol
				if view_tabulation_symbol then
					symbol_position := local_position + ( local_width - tabulation_symbol_width ) // 2
				end

					-- Fill the rectangle occupied by the tabulation
				create wel_rect.make(local_position, d_y, local_position + local_width, d_y + height)
				a_dc.fill_rect(wel_rect, the_background_brush)

					-- Display the tabulation symbol
				if view_tabulation_symbol then
					a_dc.text_out(symbol_position, d_y, tabulation_symbol)
				end

					-- update the local position & prepare next iteration
				local_position := local_position + local_width
				i := i + 1
			end

				-- Restore old drawing style
			a_dc.unselect_font
			a_dc.set_background_opaque
			a_dc.set_text_color(old_text_color)
		end

feature {NONE} -- Private characteristics & constants

	tabulation_width: INTEGER is
		local
			dc: WEL_MEMORY_DC
		once
				-- Compute the number of pixels represented by a tabulation based on
				-- user preferences.
			create dc.make
			dc.select_font(font)
			Result := editor_preferences.tabulation_spaces * dc.string_width(" ")
			dc.unselect_font
		end

	tabulation_symbol_width: INTEGER is
		local
			dc: WEL_MEMORY_DC
		once
				-- Compute the number of pixels represented by the tabulation symbol
			create dc.make
			dc.select_font(font)
			Result := dc.string_width(tabulation_symbol)
			dc.unselect_font
		end

	tabulation_symbol: STRING is
		once
			Result := "»"
		end

end -- class EDITOR_TOKEN_TABULATION
