indexing
	description:
		"Contains two widgets either side of an adjustable separator."
	status: "See notice at end of class"
	keywords: "container, split, devide"
	date: "$Date$"
	revision: "$Revision$"

	--| FIXME Known problem about combination viewport/split area:
	--| When split area is partially visible, the splitter is still
	--| drawn entirely.

deferred class
	EV_SPLIT_AREA

inherit
	EV_CONTAINER
		rename
			implementation as ev_container_implementation
		export
			{NONE} fill
		undefine
			extend,
			put
		redefine
			item,
			replace,
			client_height,
			client_width,
			initialize,
			merge_radio_button_groups
		end

	EV_WIDGET
		redefine
			implementation,
			create_implementation,
			initialize
		select
			implementation
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize internal widgets and values.
		do
			check
				sep_not_void: sep /= Void
				-- This function should be called after init
				-- of vertical/horizontal split area.
			end
			create split_box
			{EV_WIDGET} Precursor
			create scr
			scr.set_line_width (3)
			scr.set_invert_mode
			create first_cell.make_with_real_parent (Current)
			split_box.extend (first_cell)
			split_box.extend (sep)
			create second_cell.make_with_real_parent (Current)
			split_box.extend (second_cell)
			implementation.box.extend (split_box)
			first_cell.merge_radio_button_groups (second_cell)
			previous_split_position := -1
			split_position := Half_sep_dimension
			sep.pointer_button_press_actions.extend (~on_click)
			split_box.resize_actions.extend (~on_fixed_resized)
			layout_widgets
		end

feature -- Access

	item: EV_WIDGET is
			-- Item at current position.
		do
			if index = 1 then
				Result := first_cell.item
			elseif index = 2 then
				Result := second_cell.item
			end
		end

	first: EV_WIDGET is
			-- First item.
		do
			if first_cell.readable then
				Result := first_cell.item
			end
		end

	second: EV_WIDGET is
			-- Second item.
		do
			if second_cell.readable then
				Result := second_cell.item
			end
		end

	go_to_first is
			-- Make `first' current `item'.
		require
			first_exists: count >= 1
		do
			index := 1
		ensure
			item_is_first: item = first
		end

	go_to_second is
			-- Make `first' current `item'.
		require
			second_exists: count >= 2
		do
			index := 2
		ensure
			item_is_second: item = second
		end

	has (v: like item): BOOLEAN is
			-- Does structure include `v'?
		do
			Result := first_cell.has (v) or second_cell.has (v)
		end

feature -- Status report

	count: INTEGER is
			-- Number of items.
		do
			if first_cell.readable then
				Result := 1
				if second_cell.readable then
					Result := 2
				end
			end
		end

	empty: BOOLEAN is
			-- Is structure empty?
		do
			Result := not (second_cell.readable or first_cell.readable)
		end

	extendible: BOOLEAN is
			-- Is structure not full yet?
		do
			Result := not second_cell.readable
		end

	full: BOOLEAN is
			-- Is structure filled to capacity?
		do
			Result := second_cell.readable
		end

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := item /= Void
		end

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := item /= Void
		end

	prunable: BOOLEAN is True
			-- Items may be removed.

	split_position: INTEGER
			-- Offset of the splitter from left or top.

	minimum_split_position: INTEGER is
			-- Minimum position the splitter can have.
		do
			if first_cell.readable then
				Result := select_from (first.minimum_width,
					first.minimum_height)
			end
			Result := Result + Half_sep_dimension
		ensure
			non_negative: Result >= 0
			coherent_position: Result <= maximum_split_position
		end

	maximum_split_position: INTEGER is
			-- Maximum position the splitter can have.
		local
			sec_item_min_size: INTEGER
			sec : EV_WIDGET
		do
			if second_cell.readable then
				Result := select_from (second.minimum_width,
					second.minimum_height)
			end
			Result := Result + Half_sep_dimension
		ensure
			non_negative: Result >= 0
			coherent_position: Result >= minimum_split_position
		end

feature -- Measurement

	client_width: INTEGER is
			-- Width of the client area of container.
		do
			Result := implementation.box.client_width
		end

	client_height: INTEGER is
			-- Height of the client area of container.
		do
			Result := implementation.box.client_height
		end

feature -- Element change

	put, extend (an_item: like item) is
			-- Assign `an_item' to `first_item' if not already assigned or to
			-- `second_item' otherwise.
		do
			if an_item.parent /= Void then
				an_item.parent.prune_all (an_item)
			end
			if first_cell.empty then
				first_cell.put (an_item)
			else 
				second_cell.put (an_item)
			end
		ensure then
			first_item_used_first:
				old first  = Void implies first = an_item
			second_item_used_second:
				old first /= Void implies second = an_item
			has_an_item: has (an_item)
			item_is_old_item: item = old item
		end

	replace (an_item: like item) is
			-- Replace `item' with `v'.
		do
			if item = second then
				second_cell.replace (an_item)
			else
				first_cell.replace (an_item)
			end
		end

	set_first (an_item: like item) is
			-- Assign `an_item' to `first'.
		require
			an_item_not_void: an_item /= Void
			not_has_an_item: not has (an_item)
		do
			first_cell.put (an_item)
		ensure
			an_item_assigned: first = an_item
		end
		
	set_second (an_item: like item) is
			-- Assign `an_item' to `second'.
		require
			an_item_not_void: an_item /= Void
			not_has_an_item: not has (an_item)
		do
			second_cell.put (an_item)
		ensure
			an_item_assigned: second = an_item
		end	

feature -- Status setting

	merge_radio_button_groups (other: EV_CONTAINER) is
			-- Merge `Current' radio button group with that of `other'.
		do
			first_cell.merge_radio_button_groups (other)
		end

	set_split_position (a_split_position: INTEGER) is
			-- Make `a_split_position' position of splitter in pixels.
		require
			position_in_valid_range:
				(a_split_position >= minimum_split_position
				and a_split_position <= maximum_split_position)
		do
			split_position := a_split_position
			layout_widgets
		ensure
			split_position = a_split_position
		end

	set_proportion (a_proportion: REAL) is
			-- Position `split_position' between minimum and maximum determined
			-- by `a_proportion'.
		require
			proportion_in_valid_range:
				(a_proportion >= 0 and a_proportion <= 1)
		local
			max_sp, min_sp: INTEGER
		do
			max_sp := maximum_split_position
			min_sp := minimum_split_position
			set_split_position (((max_sp - min_sp) / a_proportion).rounded +
				min_sp)
		end

feature -- Removal

	prune (v: like item) is
			-- Remove one occurrence of `v' if any.
		do
			first_cell.prune (v)
			second_cell.prune (v)
		end

	wipe_out is
			-- Remove all items.
		do
			first_cell.wipe_out
			second_cell.wipe_out
		end

feature -- Conversion

	linear_representation: LINEAR [like item] is
			-- Representation as a linear structure
		local
			l: LINKED_LIST [like item]
		do
			create l.make
			if first /= Void then
				l.extend (first)
			end
			if second /= Void then
				l.extend (second)
			end
			Result := l
		end

feature {NONE} -- Implementation

	select_from (a_hor, a_vert: INTEGER): INTEGER is
			-- Return either `a_hor' or `a_vert'.
			--| EV_HORIZONTAL_SPLIT_AREA returns `a_hor'.
			--| EV_VERTICAL_SPLIT_AREA returns `a_vert'.
		deferred
		end
	
feature {NONE} -- Implementation

	splitter_position_from_screen_x_or_y (a_x, a_y: INTEGER): INTEGER is
			-- Return splitter position given screen `a_y'.
		do
			Result := select_from (a_x, a_y) - offset -
				select_from (x_origin, y_origin)
			Result := Result.max (minimum_split_position)
			Result := Result.min (maximum_split_position)
		end

	offset: INTEGER
			-- Horizontal or vertical offset where the user
			-- clicked on the separator.

	x_origin: INTEGER
			-- Horizontal screen offset of `Current'.

	y_origin: INTEGER
			-- Vertical screen offset of `Current'.

	Half_sep_dimension: INTEGER is 4
			-- Width or height of separator divided by 2.

	on_click (a_x, a_y, e: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- Start of the drag.
		local
			origin: TUPLE [INTEGER, INTEGER]
		do
			offset := select_from (a_x, a_y)
			x_origin := select_from (
				scr_x - a_x - first_cell.width,
				scr_x - a_x)
			y_origin := select_from (
				scr_y - a_y,
				scr_y - a_y - first_cell.height)
			sep.enable_capture
			sep.pointer_motion_actions.put_front (~on_motion)
			sep.pointer_button_release_actions.put_front (~on_release)
			draw_line (splitter_position_from_screen_x_or_y (scr_x, scr_y))
		end

	on_motion (a_x, a_y: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- Draw separator line.
		local
			new_pos: INTEGER
		do
			new_pos := splitter_position_from_screen_x_or_y (scr_x, scr_y)
			if new_pos /= previous_split_position then
				remove_line
				draw_line (new_pos)
			end
		end

	on_release (a_x, a_y, e: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- End of the drag.
		do
			remove_line
			set_split_position (
				splitter_position_from_screen_x_or_y (scr_x, scr_y)
			)
			sep.disable_capture
			sep.pointer_motion_actions.go_i_th (1)
			sep.pointer_motion_actions.remove
			sep.pointer_button_release_actions.go_i_th (1)
			sep.pointer_button_release_actions.remove
		end

feature {NONE} -- Implementation

	remove_line is
			-- Remove previously drawn line by redrawing it over the old one.
		do
			if previous_split_position >= 0 then
				draw_line (previous_split_position)
				previous_split_position := -1
			end
		end

	draw_line (a_position: INTEGER) is
			-- Draw line on `a_position'.
		do
			if select_from (0, 1) = 0 then
				scr.draw_segment (
					a_position + x_origin + half_sep_dimension,
					y_origin,
					a_position + x_origin + half_sep_dimension,
					y_origin + sep.height
				)
			else
				scr.draw_segment (
					x_origin,
					a_position + y_origin + half_sep_dimension,
					x_origin + sep.width,
					a_position + y_origin + half_sep_dimension
				)
			end
			previous_split_position := a_position
		end

	on_fixed_resized (fx, fy, fwidth, fheight: INTEGER) is
			-- `split_box' is resized by the user.
		do
			--| FIXME Move splitter according to disable item expand.
			--| Three cases:
			--| 1: (1) exp (2) not exp: (2) retains size, splitter moves.
			--| 2: (1) and (2) same: both grow/shrink same, splitter moves.
			--| 3: (1) not exp (2) exp: (1) retains size, (2) resizes.
			io.put_string ("%TRESIZE%N")
			layout_widgets
		end

	layout_widgets is
			-- Set position and dimensions of the children in `split_box'.
			--| Call after split_position or dimensions changed.
		do
			io.put_string ("%TLAYOUT%N")
			if select_from (0, 1) = 0 then
				split_box.set_item_position (first_cell, 0, 0)
				split_box.set_item_size (first_cell,
					split_position - Half_sep_dimension, split_box.height)
				split_box.set_item_position (sep,
					split_position - Half_sep_dimension, 0)
				split_box.set_item_size (sep,
					Half_sep_dimension * 2, split_box.height)
				split_box.set_item_position (first_cell,
					split_position + Half_sep_dimension, 0)
				split_box.set_item_size (first_cell,
					split_box.width - split_position - Half_sep_dimension,
					split_box.height)
			else
				split_box.set_item_position (first_cell, 0, 0)
				split_box.set_item_size (first_cell,
					split_box.width, split_position - Half_sep_dimension)
				split_box.set_item_position (sep,
					0, split_position - Half_sep_dimension)
				split_box.set_item_size (sep,
					split_box.width, Half_sep_dimension * 2)
				split_box.set_item_position (first_cell,
					0, split_position + Half_sep_dimension)
				split_box.set_item_size (first_cell,
					split_box.width,
					split_box.height - split_position - Half_sep_dimension)
			end
		end

feature {NONE} -- Implementation

	index: INTEGER
			-- Current cursor position.

	previous_split_position: INTEGER
			-- Previous split_position.

	first_cell, second_cell: EV_AGGREGATE_CELL
			-- Two client areas.

	split_box: EV_FIXED
			-- Contains `first_cell', `sep' and `second_cell'.

	sep: EV_SEPARATOR
			-- Separator used to split between the two items.

	scr: EV_SCREEN
			-- Used for drawing guideline on screen.

	implementation: EV_AGGREGATE_WIDGET_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_AGGREGATE_WIDGET_IMP} implementation.make (Current)
		end

invariant
	split_box_not_void: is_useable implies split_box /= Void
	separator_not_void: is_useable implies sep /= Void
	first_cell_not_void: is_useable implies first_cell /= Void
	second_cell_not_void: is_useable implies second_cell /= Void
	split_box_has_three_items: is_useable implies split_box.count = 3
	split_box_first_is_first_cell:
		is_useable implies split_box.first = first_cell
	split_box_last_is_second_cell:
		is_useable implies split_box.last = second_cell

end -- class EV_SPLIT_AREA

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.38  2000/05/03 17:44:06  brendel
--| Added initialize of split_position.
--|
--| Revision 1.37  2000/05/03 17:29:26  brendel
--| Added call to layout_widgets at initialize.
--|
--| Revision 1.36  2000/05/03 00:09:34  brendel
--| Cosmetics.
--|
--| Revision 1.35  2000/05/02 22:02:52  brendel
--| Started implementing using EV_FIXED.
--|
--| Revision 1.34  2000/05/01 21:40:07  manus
--| `minimum_split_position' should take into account size of separator.
--| `set_split_position' code was using `height' of `first_cell' where it should
--| have depend on the type of EV_SPLIT_AREA and therefore use `select_from'.
--|
--| Revision 1.33  2000/04/25 21:10:01  brendel
--| Improved readibility of draw_lineand splitter_position_from_x_or_y.
--| Improved action sequence handling of separator.
--|
--| Revision 1.32  2000/04/21 22:48:48  bonnard
--| Fixed `maximum_split_position'.
--| Changed `splitter_position_from_screen_x_or_y' to improve speed.
--|
--| Revision 1.31  2000/04/19 00:46:07  brendel
--| Added FIXME.
--|
--| Revision 1.30  2000/04/10 19:43:56  brendel
--| Removed inheritance from FIXED.
--|
--| Revision 1.29  2000/03/21 00:15:01  king
--| Added aggregate cell, now redefining item to avoid seg faults from invariant
--|
--| Revision 1.28  2000/03/20 19:39:52  king
--| Added item_is_old_item postcond on extend
--|
--| Revision 1.27  2000/03/20 18:38:01  king
--| Corrected linear repsentation bug
--|
--| Revision 1.26  2000/03/18 00:52:23  oconnor
--| formatting, layout and comment tweaks
--|
--| Revision 1.25  2000/03/09 16:12:24  brendel
--| Replaced obsolete call width disable_item_expand.
--|
--| Revision 1.24  2000/03/06 20:39:10  brendel
--| Modified implementation of set_split_position to calculate the new sizes
--| before setting any of them.
--|
--| Revision 1.23  2000/03/06 20:22:12  brendel
--| Moved location of 1/2 sep. width calculation.
--|
--| Revision 1.22  2000/03/06 19:50:12  brendel
--| Moved a lot of implementation from descendants into this class to reduce
--| duplication of code in horizontal and vertical split area.
--| Added feature `select_from' to reduce the greater part.
--| Added features set_first_cell_dimension and set_second_cell_dimension.
--|
--| Revision 1.21  2000/03/03 23:00:28  brendel
--| Moved all initialization to `initialize'.
--|
--| Revision 1.20  2000/03/03 20:27:41  brendel
--| Cosmetics.
--|
--| Revision 1.19  2000/03/03 16:50:23  brendel
--| Added feature initialize. Now only to find out why it is not called.
--| Fixed bug in readable.
--|
--| Revision 1.18  2000/03/03 02:52:39  brendel
--| Since `item' is no longer inherited, pre- and postconditions are added.
--|
--| Revision 1.16  2000/03/03 00:33:16  oconnor
--| fixed first and second
--|
--| Revision 1.15  2000/03/01 19:59:07  rogers
--| Fixed writeable and added readable.
--|
--| Revision 1.14  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.13  2000/02/22 01:18:00  rogers
--| Changed the export status of box to NONE.
--|
--| Revision 1.11  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.15  2000/02/08 09:29:35  oconnor
--| added writeable is True
--|
--| Revision 1.10.6.14  2000/02/08 05:18:20  oconnor
--| added perconditions to check for duplicate insertion.
--|
--| Revision 1.10.6.13  2000/02/08 05:12:48  oconnor
--| fixed full to work instead of being completly wrong
--|
--| Revision 1.10.6.12  2000/01/28 20:00:14  oconnor
--| released
--|
--| Revision 1.10.6.11  2000/01/28 16:46:38  oconnor
--| changed first_item to first and second_item to second in line with
--| CHAIN.first -- Item at first position
--|
--| Revision 1.10.6.10  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.9  2000/01/26 02:50:32  king
--| Added set_proportion routine
--|
--| Revision 1.10.6.8  2000/01/25 19:08:01  king
--| Changed position features to split_position
--|
--| Revision 1.10.6.7  2000/01/25 17:19:26  king
--| Added assertions to set_position, removed positioning postcondition as it
--| doesn't hold in gtk when the minimum size is shrunk
--|
--| Revision 1.10.6.6  2000/01/21 23:10:59  oconnor
--| fixed postcond on extend
--|
--| Revision 1.10.6.5  2000/01/20 18:41:32  oconnor
--| reimplemented as decendant of EV_CONTAINER
--|
--| Revision 1.10.6.4  2000/01/19 22:16:12  king
--| First foundation of platform independent split area
--|
--| Revision 1.10.6.3  2000/01/15 02:38:47  oconnor
--| formatting
--|
--| Revision 1.10.6.2  1999/11/24 22:40:59  oconnor
--| added review notes
--|
--| Revision 1.10.6.1  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.4  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.3  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
