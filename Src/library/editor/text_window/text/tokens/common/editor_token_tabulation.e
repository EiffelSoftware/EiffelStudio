indexing
	description	: "Token that describe one or several tabulations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_TABULATION

inherit
	EDITOR_TOKEN_BLANK
		redefine
			process
		end

create
	make

feature -- Visitor

	process (a_token_visitor: TOKEN_VISITOR) is
			--  Process
		do
			a_token_visitor.process_tabulation_token (image)
		end

feature -- Initialisation

	make (number: INTEGER) is
		require
			number_valid: number > 0
		do
			length := number
			create image.make (number)
			image.fill_character('%T')
		ensure
			image_not_void: image /= Void
			length_positive: length > 0
		end

feature -- Width & Height

	width: INTEGER is
			-- Width in pixel of the entire token.
		local
			l_tab_width: INTEGER
		do
			l_tab_width := tabulation_width

				-- Width of first tabulation.
			Result := (((position // l_tab_width) + 1 ) * l_tab_width) - position

				-- Handle next tabulations.
			Result := Result + (l_tab_width * (length - 1))
		end

	get_substring_width (n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		local
			l_tab_width: INTEGER
		do
			if n = 0 then
				Result := 0
			else
				l_tab_width := tabulation_width

					-- Width of first tabulation.
				Result := (((position // l_tab_width) + 1 ) * l_tab_width) - position

					-- Handle next tabulations.
				Result := Result + l_tab_width * (n - 1)
			end
		end

	retrieve_position_by_width (a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			width_first_tab: INTEGER
			l_tab_width: INTEGER
		do
			l_tab_width := tabulation_width
			width_first_tab := (((position // l_tab_width) + 1 ) * l_tab_width ) - position

			if a_width < width_first_tab then
				Result := 1
			else
				Result := 2 + (a_width - width_first_tab) // l_tab_width
			end
		end

feature {NONE} -- Implementation

	display_blanks (d_x, d_y: INTEGER; device: EV_DRAWABLE; selected: BOOLEAN; start_tab, end_tab: INTEGER; panel: TEXT_PANEL): INTEGER is
		local
			the_text_color: EV_COLOR
			the_background_color: EV_COLOR
			local_width: INTEGER
			symbol_position: INTEGER
			view_tabulation_symbol: BOOLEAN
			i: INTEGER
			local_position: INTEGER
		do
 				-- Initialisations
 			view_tabulation_symbol := panel.view_invisible_symbols
 			local_position := d_x
 
 				-- Select the drawing style we will use.
 			if selected then
 				if panel.has_focus then
	 				the_text_color := selected_text_color
	 				the_background_color := selected_background_color
	 			else	
	 				the_text_color := text_color
	 				the_background_color := focus_out_selected_background_color
 				end
 			else
 				the_text_color := text_color
 				the_background_color := background_color
 			end
 
 				-- Backup drawing style & set the new one
 			device.set_font (font)
 			device.set_foreground_color (the_text_color)
			if the_background_color /= Void then
				device.set_background_color (the_background_color)
			end
 
 				-- Display the first tabulation
 			from
 				i := start_tab
 			until
 				i > end_tab
 			loop
 					-- Compute the width of the tabulation
 				if i = 1 then
 					local_width := get_substring_width (1)
 				else
 					local_width := tabulation_width
 				end
 			
 					-- Compute the position of the tabulation symbol
 				if view_tabulation_symbol then
 					symbol_position := local_position + ( local_width - tabulation_symbol_width ) // 2
 				end
 
 					-- Fill the rectangle occupied by the tabulation
				if the_background_color /= Void then
	 				device.clear_rectangle(local_position, d_y, local_width, height)
				end
 
 					-- Display the tabulation symbol
 				if view_tabulation_symbol then
 					draw_text_top_left (symbol_position, d_y, tabulation_symbol, device)
 				end
 
 					-- update the local position & prepare next iteration
 				local_position := local_position + local_width
 				i := i + 1
 				
 				Result := local_position
 			end
		end

feature {NONE} -- Private characteristics & constants

	tabulation_width: INTEGER is
			-- Compute the number of pixels represented by a tabulation based on
			-- user preferences number of spaces per tabulation.
		do
			if is_fixed_width then
				Result := editor_preferences.tabulation_spaces * font_width
			else
				Result := editor_preferences.tabulation_spaces * font.string_width (once " ")
			end
		end

	tabulation_symbol_width: INTEGER is
			-- Compute the number of pixels represented by the tabulation symbol.
		do
			Result := font.string_width (tabulation_symbol)
		end

	tabulation_symbol: STRING is "»";
			-- Symbol for tabulation when formatting marks are shown.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EDITOR_TOKEN_TABULATION
