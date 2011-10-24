note
	description: "[
		Constants used by scroll bar scroll action
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLL_CONSTANTS

feature -- Enumeration

	bottom: INTEGER = 1
			-- Scrolls to the lower right

	end_scroll: INTEGER = 2
		-- Ends scroll

	line_down: INTEGER = 3
		-- Scrolls one line down.

	line_up: INTEGER = 4
		-- Scrolls one line up.

	page_down: INTEGER = 5
		-- Scrolls one page down.

	page_up: INTEGER = 6
		-- Scrolls one page up.

	thumb_position: INTEGER = 7
		-- The user has dragged the scroll box (thumb) and released the mouse button. The HIWORD indicates the position of the scroll box at the end of the drag operation.

	thumb_track: INTEGER = 8
		-- The user is dragging the scroll box. This message is sent repeatedly until the user releases the mouse button. The HIWORD indicates the position that the scroll box has been dragged to.

	top: INTEGER = 9
		--Scrolls to the upper left.	

feature -- Command

	convert_from_wel_constant (a_wel_constant: INTEGER): INTEGER
			-- Convert current from {WEL_SB_CONSTANTS} `a_wel_constant'
		require
			valid_constant: True
		do
			inspect
				a_wel_constant
			when {WEL_SB_CONSTANTS}.Sb_bottom then
				Result := bottom
			when {WEL_SB_CONSTANTS}.Sb_endscroll then
				Result := end_scroll
			when {WEL_SB_CONSTANTS}.Sb_linedown then
				Result := line_down
			when {WEL_SB_CONSTANTS}.Sb_lineup then
				Result := line_up
			when {WEL_SB_CONSTANTS}.Sb_pagedown then
				Result := page_down
			when {WEL_SB_CONSTANTS}.Sb_pageup then
				Result := page_up
			when {WEL_SB_CONSTANTS}.Sb_thumbposition then
				Result := thumb_position
			when {WEL_SB_CONSTANTS}.Sb_thumbtrack then
				Result := thumb_track
			when {WEL_SB_CONSTANTS}.Sb_top then
				Result := top
			else
				check invalid: False end
			end
		ensure
			valid: is_valid (Result)
		end

feature -- Query

	is_valid (a_action_type: INTEGER): BOOLEAN
			-- If `a_action_type' valid?
		do
			if a_action_type = bottom or else
				a_action_type = end_scroll or else
				a_action_type = line_down or else
				a_action_type = line_up or else
				a_action_type = page_down or else
				a_action_type = page_up or else
				a_action_type = thumb_position or else
				a_action_type = thumb_track or else
				a_action_type = top then
				Result := True
			end
		end
note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end


