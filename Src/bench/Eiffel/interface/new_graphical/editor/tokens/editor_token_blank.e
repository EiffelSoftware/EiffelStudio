indexing
	description	: "Token that describe either space(s) or tabulation(s)."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EDITOR_TOKEN_BLANK

inherit
	EDITOR_TOKEN
		redefine
			display_selected,
			display_half_selected,
			text_color,
			background_color
		end

feature -- Display

	display(d_y: INTEGER; a_dc: WEL_DC) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		local
			local_position: INTEGER
		do
			local_position := display_blanks(position, d_y, a_dc, False, 1, length)
		end

	display_selected(d_y: INTEGER; a_dc: WEL_DC) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state.
		local
			local_position: INTEGER
		do
			local_position := display_blanks(position, d_y, a_dc, True, 1, length)
		end

	display_half_selected(d_y: INTEGER; start_selection, end_selection: INTEGER; a_dc: WEL_DC) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state from beggining to `pivot'
		local
			local_position: INTEGER
		do
			local_position := position

				-- if the selection do not start at the beginning of the token,
				-- display the first 'non selected' area
			if start_selection /= 1 then
				local_position := display_blanks(local_position, d_y, a_dc, False, 1, start_selection-1)
			end

				-- Display the 'selected' area
			local_position := display_blanks(local_position, d_y, a_dc, True, start_selection, end_selection-1)

				-- if the selection do not end at the end of the token,
				-- Display the last 'non selected' area
			if end_selection <= length then
				local_position := display_blanks(local_position, d_y, a_dc, False, end_selection,length)
			end
		end

feature {NONE} -- Implementation

	display_blanks(d_x, d_y: INTEGER; a_dc: WEL_DC; selected: BOOLEAN; start_tab, end_tab: INTEGER): INTEGER is
		deferred
		end

feature {NONE} -- Implementation
	
	text_color: WEL_COLOR_REF is
		do
			Result := editor_preferences.spaces_text_color
		end

	background_color: WEL_COLOR_REF is
		do
			Result := editor_preferences.spaces_background_color
		end

end -- class EDITOR_TOKEN_BLANK
