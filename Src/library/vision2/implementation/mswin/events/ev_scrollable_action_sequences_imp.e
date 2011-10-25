note
	description:
		"Action sequences for scrollable area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

class
	EV_SCROLLABLE_ACTION_SEQUENCES_IMP

inherit
	EV_SCROLLABLE_ACTION_SEQUENCE_I

feature -- Event handling

	create_horizontal_scroll_actions: EV_SCROLL_ACTION_SEQUENCE
			-- <Precursor>
		do
			create Result
		end

	create_vertical_scroll_actions: EV_SCROLL_ACTION_SEQUENCE
			-- <Precursor>
		do
			create Result
		end

feature -- Helper

	convert_from_wel_constant (a_wel_constant: INTEGER): INTEGER
			-- Convert from {WEL_SB_CONSTANTS} `a_wel_constant' to {EV_SCROLL_CONSTANTS}
		require
			valid_constant: True
		do
			inspect
				a_wel_constant
			when {WEL_SB_CONSTANTS}.Sb_bottom then
				Result := {EV_SCROLL_CONSTANTS}.bottom
			when {WEL_SB_CONSTANTS}.Sb_endscroll then
				Result := {EV_SCROLL_CONSTANTS}.end_scroll
			when {WEL_SB_CONSTANTS}.Sb_linedown then
				Result := {EV_SCROLL_CONSTANTS}.line_down
			when {WEL_SB_CONSTANTS}.Sb_lineup then
				Result := {EV_SCROLL_CONSTANTS}.line_up
			when {WEL_SB_CONSTANTS}.Sb_pagedown then
				Result := {EV_SCROLL_CONSTANTS}.page_down
			when {WEL_SB_CONSTANTS}.Sb_pageup then
				Result := {EV_SCROLL_CONSTANTS}.page_up
			when {WEL_SB_CONSTANTS}.Sb_thumbposition then
				Result := {EV_SCROLL_CONSTANTS}.thumb_position
			when {WEL_SB_CONSTANTS}.Sb_thumbtrack then
				Result := {EV_SCROLL_CONSTANTS}.thumb_track
			when {WEL_SB_CONSTANTS}.Sb_top then
				Result := {EV_SCROLL_CONSTANTS}.top
			else
				check invalid: False end
			end
		ensure
			valid: (create {EV_SCROLL_CONSTANTS}).is_valid (Result)
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


