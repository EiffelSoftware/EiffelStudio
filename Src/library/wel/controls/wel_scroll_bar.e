note
	description: "A bar with a scroll box which indicates a position."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCROLL_BAR

inherit
	WEL_BAR
		redefine
			on_size, make_by_id, valid_maximum
		end

	WEL_SCROLL_BAR_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONTROL

create
	make_vertical,
	make_horizontal,
	make_by_id

feature {NONE} -- Initialization

	make_vertical (a_parent: WEL_WINDOW;
			a_x, a_y, a_width, a_height, an_id: INTEGER)
			-- Make a vertical scroll bar.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			create scroll_info_struct.make
			internal_window_make (a_parent, Void,
				default_style + Sbs_vert,
				a_x, a_y, a_width, a_height, an_id,
				default_pointer)
			id := an_id
			set_line (Default_line_value)
		ensure
			parent_set: parent = a_parent
			exists: exists
			id_set: id = an_id
			position_equal_zero: position = 0
			minimum_equal_zero: minimum = 0
			maximum_equal_zero: maximum = 0
		end

	make_horizontal (a_parent: WEL_WINDOW;
			a_x, a_y, a_width, a_height, an_id: INTEGER)
			-- Make a horizontal scroll bar.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			create scroll_info_struct.make
			internal_window_make (a_parent, Void,
				default_style + Sbs_horz,
				a_x, a_y, a_width, a_height, an_id,
				default_pointer)
			id := an_id
			set_line (Default_line_value)
		ensure
			parent_set: parent = a_parent
			exists: exists
			id_set: id = an_id
			position_equal_zero: position = 0
			minimum_equal_zero: minimum = 0
			maximum_equal_zero: maximum = 0
		end

	make_by_id (a_parent: WEL_DIALOG; an_id: INTEGER)
			-- Make a control identified by `an_id' with `a_parent'
			-- as parent.
		do
			create scroll_info_struct.make
			Precursor {WEL_BAR} (a_parent, an_id)
			set_line (Default_line_value)
		end

feature -- Access

	line: INTEGER
			-- Number of scroll units per line

	page: INTEGER
			-- Number of scroll units per page
		do
			retrieve_scroll_info (sif_page)
			Result := scroll_info_struct.page
		end

	position: INTEGER
			-- Current position of the scroll box
		do
			retrieve_scroll_info (sif_pos)
			Result := scroll_info_struct.position
		end

	minimum: INTEGER
			-- Minimum position
		do
			retrieve_scroll_info (Sif_range)
			Result := scroll_info_struct.minimum
		end

	maximum: INTEGER
			-- Maximum position
		do
			retrieve_scroll_info (Sif_range)
			Result := scroll_info_struct.maximum
		end

	background_color: WEL_COLOR_REF
			-- Background color used for the background of the
			-- control
			-- Can be redefined by the user
		do
			create Result.make_system (color_scrollbar)
		end

feature -- Status report

	is_horizontal: BOOLEAN
			-- Is current scrollbar an horizontal one?
		do
				-- Bit at position 0 (i.e. value 1) in `style'
				-- represents the orientation of scrollbar.
			Result := (style & 1) = Sbs_horz
		end

	valid_maximum (a_position: INTEGER): BOOLEAN
			-- Is `a_position' valid as a maximum?
		do
			Result := a_position <= (maximum - (page - 1).max (0))
		end

feature -- Element change

	set_position (new_position: INTEGER)
			-- Set `position' with `new_position'
		local
			l_previous: INTEGER
		do
			scroll_info_struct.set_mask (Sif_pos)
			scroll_info_struct.set_position (new_position)
			l_previous := {WEL_API}.set_control_scroll_info (item, scroll_info_struct.item, True)
		end

	set_range (a_minimum, a_maximum: INTEGER)
			-- Set `minimum' and `maximum' with
			-- `a_minimum' and `a_maximum'
		local
			l_previous: INTEGER
		do
			scroll_info_struct.set_mask (Sif_range)
			scroll_info_struct.set_minimum (a_minimum)
			scroll_info_struct.set_maximum (a_maximum)
			l_previous := {WEL_API}.set_control_scroll_info (item, scroll_info_struct.item, True)
		end

	set_line (line_magnitude: INTEGER)
			-- Set `line' with `line_magnitude'.
		require
			positive_line: line >= 0
		do
			line := line_magnitude
		ensure
			line_set: line = line_magnitude
		end

	set_page (page_magnitude: INTEGER)
			-- Set `page' with `page_magnitude'.
		require
			positive_page: page_magnitude >= 0
		local
			l_previous: INTEGER
		do
			scroll_info_struct.set_mask (Sif_page)
			scroll_info_struct.set_page (page_magnitude)
			l_previous := {WEL_API}.set_control_scroll_info (item, scroll_info_struct.item, True)
		ensure
			page_set: page = page_magnitude
		end

feature -- Basic operations

	on_scroll (scroll_code, pos: INTEGER)
			-- Process the scroll messages.
			-- Typically, this routine will be called from
			-- `on_vertical_scroll_control' or
			-- `on_horizontal_scroll_control' of the parent window.
		require
			exists: exists
		local
			old_pos, new_pos: INTEGER
			min, max, p: INTEGER
			l_success: INTEGER
		do
			if scroll_code /= Sb_endscroll then
				old_pos := position
				p := page
				min := minimum
				max := maximum
				if scroll_code = Sb_pagedown then
					new_pos := old_pos + p
				elseif scroll_code = Sb_pageup then
					new_pos := old_pos - p
				elseif scroll_code = Sb_linedown then
					new_pos := old_pos + line
				elseif scroll_code = Sb_lineup then
					new_pos := old_pos - line
				elseif scroll_code = Sb_thumbposition then
					scroll_info_struct.set_mask (sif_trackpos)
					l_success := {WEL_API}.get_control_scroll_info (item, scroll_info_struct.item)
					new_pos := scroll_info_struct.track_position
				elseif scroll_code = Sb_thumbtrack then
					scroll_info_struct.set_mask (sif_trackpos)
					l_success := {WEL_API}.get_control_scroll_info (item, scroll_info_struct.item)
					new_pos := scroll_info_struct.track_position
				elseif scroll_code = Sb_top then
					new_pos := min
				elseif scroll_code = Sb_bottom then
					new_pos := max - p + 1
				end
				if new_pos > max - p + 1 then
					new_pos := max - p + 1
				elseif new_pos < min then
					new_pos := min
				end
				set_position (new_pos)
			end
		end

	on_size (size_type, a_width, a_height: INTEGER)
		local
			l_previous: INTEGER
		do
			scroll_info_struct.set_mask (Sif_range + Sif_page)
			l_previous := {WEL_API}.set_control_scroll_info (item, scroll_info_struct.item, True)
		end

feature {NONE} -- Inapplicable

	foreground_color: WEL_COLOR_REF
			-- Foreground color has no effect with SCROLL_BAR.
			-- Cannot be Void.
		do
			create Result.make_system (Color_windowtext)
		end

feature {NONE} -- Implementation

	Default_line_value: INTEGER = 1
			-- Default scroll units per line

	class_name: STRING_32
			-- Window class name to create
		once
			Result := "ScrollBar"
		end

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group
		end

	scroll_info_struct: WEL_SCROLL_BAR_INFO
		-- Associated SCROLLINFO struct to current toolbar.

	retrieve_scroll_info (mask: INTEGER)
			-- Retrieve `mask' into `scroll_info_struct' and then restore original mask.
		local
			original_mask: INTEGER
			l_success: INTEGER
		do
			original_mask := scroll_info_struct.mask
			scroll_info_struct.set_mask (mask)
			l_success := {WEL_API}.get_control_scroll_info (item, scroll_info_struct.item)
			scroll_info_struct.set_mask (original_mask)
		ensure
			msk_not_changed: old scroll_info_struct.mask = scroll_info_struct.mask
		end

invariant
	positive_line: line >= 0
	positive_page: page >= 0

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_SCROLL_BAR

