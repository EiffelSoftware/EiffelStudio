indexing
	description	: "Token that describe either space(s) or tabulation(s)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			is_blank,
			text_color_id,
			background_color_id
		end

feature -- Status Report

	is_blank: BOOLEAN is True

feature -- Display

	display (d_y: INTEGER; a_device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		local
			useless: INTEGER
		do
			useless := display_blanks (position, d_y, a_device, False, 1, length, panel)
		end

	display_with_offset (x_offset, d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc' at the coordinates (`x_offset',`d_y')
		local
			useless: INTEGER
		do
			useless := display_blanks (x_offset, d_y, device, False, 1, length, panel)
		end

	display_selected (d_y: INTEGER; a_device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state.
		local
			useless: INTEGER
		do
			useless := display_blanks (position, d_y, a_device, True, 1, length, panel)
		end

	display_half_selected (d_y: INTEGER; start_selection, end_selection: INTEGER; a_device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state from begining to `pivot'
		local
			local_position: INTEGER
		do
			local_position := position

				-- if the selection does not start at the beginning of the token,
				-- display the first 'non selected' area
			if start_selection /= 1 then
				local_position := display_blanks (local_position, d_y, a_device, False, 1, start_selection - 1, panel)
			end

			if start_selection < end_selection then
					-- Display the 'selected' area
				local_position := display_blanks (local_position, d_y, a_device, True, start_selection, end_selection - 1, panel)
			end

				-- if the selection does not end at the end of the token,
				-- Display the last 'non selected' area
			if end_selection <= length then
				local_position := display_blanks (local_position, d_y, a_device, False, end_selection,length, panel)
			end
		end

feature -- Color ids

	text_color_id: INTEGER is
		do
			Result := spaces_text_color_id
		end

	background_color_id: INTEGER is
			-- Background color
		do
			if is_highlighted then
				Result := highlight_color_id
			else
				Result := spaces_background_color_id
			end
		end

feature {NONE} -- Implementation

	display_blanks (d_x, d_y: INTEGER; device: EV_DRAWABLE; selected: BOOLEAN; start_tab, end_tab: INTEGER; panel: TEXT_PANEL): INTEGER is
		require
			valid_selection: start_tab <= end_tab
		deferred
		end

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




end -- class EDITOR_TOKEN_BLANK
