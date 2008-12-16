indexing
	description: "Displays up to two widgets side by side, separated by an%
		%adjustable divider."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_SPLIT_AREA_IMP

inherit

	EV_HORIZONTAL_SPLIT_AREA_I
		redefine
			interface
		end

	EV_SPLIT_AREA_IMP
		redefine
			interface,
			compute_minimum_size,
			compute_minimum_width,
			compute_minimum_height,
			on_size,
			class_cursor,
			on_mouse_move,
			on_left_button_down
		end

create
	make

feature {NONE} -- Status Setting

	set_first (v: like item) is
			-- Assign `v' to `first'.
		do
			first := v
			first.implementation.on_parented
			disable_item_expand (first)
			first_imp.set_parent (interface)
			notify_change (nc_minsize, Current)
			if second_visible then
				set_split_position (minimum_split_position)
			else
				set_split_position (maximum_split_position)
			end
			notify_change (Nc_minsize, Current)
			new_item_actions.call ([v])
		end

	set_second (v: like item) is
			-- Assign `v' to second.
		do
			second := v
			second.implementation.on_parented
			second_imp.set_parent (interface)
			notify_change (Nc_minsize, Current)
			if first_visible then
				set_split_position (width - splitter_width - second.minimum_width.min
					(width - minimum_split_position - splitter_width))
			else
				set_split_position (0)
			end
				--| Notify change is called twice, as we need
				--| the sizing calculations performed once before
				--| we call set_split_position, so we can use `width'
				--| and be sure it is correct. Then we call notify change
				--| again after the split position has been set,
				--| to reflect these changes.
			notify_change (Nc_minsize, Current)
			new_item_actions.call ([v])
		end

feature {NONE} -- Implementation

	set_click_position (x_pos, y_pos: INTEGER) is
			-- Assign coordinate relative to click position on splitter to
			-- `click_relative_position'.
		do
			click_relative_position := x_pos - internal_split_position
		end

	compute_minimum_size is
			-- Recompute the minimum_size of `Current'.
		local
			mh, mw, sep_wid: INTEGER
		do
			if first_visible then
				mw := first.minimum_width
				mh := first.minimum_height
				sep_wid := splitter_width
			end
			if second_visible then
				mw := mw + second.minimum_width + sep_wid
				mh := mh.max (second.minimum_height)
			end
			ev_set_minimum_size (mw, mh)
		end

	compute_minimum_height is
			-- Recompute the minimum_height of `Current'.
		local
			mh: INTEGER
		do
			if first_visible then
				mh := first.minimum_height
			end
			if second_visible then
				mh := mh.max (second.minimum_height)
			end
			ev_set_minimum_height (mh)
		end

	compute_minimum_width is
			-- Recompute the minimum_width of `Current'.
		local
			mw: INTEGER
			sep_wid: INTEGER
		do
			if first_visible then
				mw := first.minimum_width
				sep_wid := splitter_width
			end
			if second_visible then
				mw := mw + second.minimum_width + sep_wid
			end
			ev_set_minimum_width (mw)
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
		do
			Precursor {EV_SPLIT_AREA_IMP} (size_type, a_width, a_height)
			split_area_resizing (a_width, True)
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			ev_move_and_resize
				(a_x_position, a_y_position, a_width, a_height, repaint)
			split_area_resizing (a_width, False)
		end

	layout_widgets (originator: BOOLEAN) is
		local
			rect: WEL_RECT
		do
			if first_visible and not second_visible then
				if originator then
					first_imp.set_move_and_size (0, 0, width, height)
				else
					first_imp.ev_apply_new_size (0, 0, width, height, True)
				end
			end

			if second_visible and not first_visible then
				if originator then
					second_imp.set_move_and_size (0, 0, width, height)
				else
					second_imp.ev_apply_new_size (0, 0, width, height, True)
				end
			end

			if first_visible and second_visible then
				if originator then
					first_imp.set_move_and_size (0, 0, internal_split_position, height)
					second_imp.set_move_and_size
						(internal_split_position + splitter_width, 0, width -
						internal_split_position - splitter_width, height)
				else
					first_imp.ev_apply_new_size (0, 0, internal_split_position, height,
						True)
					second_imp.ev_apply_new_size
						(internal_split_position + splitter_width, 0, width -
						internal_split_position - splitter_width, height, True)
				end
			end

				-- Invalidate separator.
			create rect.make (internal_split_position, 0, internal_split_position +
				splitter_width, height)
			invalidate_rect (rect, True)
		end

	split_area_resizing (a_width: INTEGER; originator: BOOLEAN) is
			-- Compute new size
		local
			splitter_movement_factor: DOUBLE
			movement, size_change: INTEGER
		do
				-- We only need to move the splitter if first is
				-- not void. Otherwise the split position remains at 0.
			if first_visible then

					-- We now determine what factor of movement is
					-- required by the splitter.
				if not second_visible then
					splitter_movement_factor := 1.0
				else
					if first_expandable = second_expandable then
						splitter_movement_factor := 0.5
					elseif first_expandable then
						splitter_movement_factor := 1.0
					elseif second_expandable then
						splitter_movement_factor := 0.0
					end
				end

					-- Store the number of pixels `Current' has increased
					-- by (negative for a reduction).
				size_change := width - last_dimension

					-- Store the current size as `last_split_position'.
				last_dimension := a_width

					-- Assign the correct movement to `movement', determined
					-- by `splitter_movement_factor' and `size_change'.
				movement := (size_change * splitter_movement_factor).rounded

					-- Move the split position.
				set_split_position (internal_split_position + movement)
			end
			update_split_position
			layout_widgets (originator)
		end

	invert_split (a_dc: WEL_DC) is
			-- Invert the split on `a_dc'.
		do
			invert_rectangle (a_dc, internal_split_position, -1, internal_split_position +
				splitter_width, height)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mousemove message
		local
			t: WEL_SYSTEM_PARAMETERS_INFO
			new_pos: INTEGER
			window_dc: WEL_WINDOW_DC
			wel_cursor: WEL_CURSOR
		do
				-- Are we moving the splitter?
			if has_capture then
					-- Move the splitter to the mouse position.
				if x_pos - click_relative_position < minimum_split_position then
					new_pos := minimum_split_position
				elseif x_pos - click_relative_position >
					maximum_split_position then
					new_pos := maximum_split_position
				else
					new_pos := x_pos - click_relative_position
				end
				if internal_split_position /= new_pos then
					create t
 --|--------------------------------------------------------------
 --| Removed the "real time resizing". As soon as windows
 --| get a little complex, it blocks the system for 2 to 3 sec.
 --|
 --| Uncomment the following lines to add it again.
 --|--------------------------------------------------------------
 --|					if t.has_drag_full_windows then
 --|							-- Move the splitter to the mouse position and
 --|							-- update content when dragging.
 --|						set_split_position (new_pos)
 --|					else
							-- Move shade of splitter and do not update content.
						create window_dc.make (Current)
						invert_split (window_dc)
						internal_split_position := new_pos
						invert_split (window_dc)
						window_dc.delete
 --|					end
				end
			else
					-- Ensure that the cursor is up to date when widgets are
					-- contained that do not fully cover the background of `Current',
					-- such as EV_NOTEBOOK.
				if position_is_over_splitter (x_pos) then
					create wel_cursor.make_by_predefined_id ((create {WEL_IDC_CONSTANTS}).Idc_sizewe)
					wel_cursor.enable_reference_tracking
					wel_cursor.set
					wel_cursor.decrement_reference
				else
					create wel_cursor.make_by_predefined_id ((create {WEL_IDC_CONSTANTS}).Idc_arrow)
					wel_cursor.enable_reference_tracking
					wel_cursor.set
					wel_cursor.decrement_reference
				end
				Precursor {EV_SPLIT_AREA_IMP} (keys, x_pos, y_pos)
			end
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message handling.
		local
			splitter_bitmap: WEL_BITMAP
		do
			-- We have to call pointer actions here
			-- See bug#14692
			on_button_down (x_pos, y_pos, {EV_POINTER_CONSTANTS}.left)

				-- Pressing the left button on the splitter to move it, was
				-- not bringing the window it was contained in to the front.
				-- This fixes this.
			top_level_window_imp.move_to_foreground
				-- We must check that we are in the correct location for the split area,
				-- as if a notebook is placed inside, there are areas of `Current' that receive
				-- the left button click. For example, to the right of the tabs.
				-- This ensures that the splitter is only moved when it really should be. Julian
			if not has_capture and position_is_over_splitter (x_pos) then
				-- Start to move the splitter. We capture the mouse
				-- message to be able to move the mouse over the
				-- left or right control without losing the "mouse focus."
				create splitter_bitmap.make_direct (8, 8, 1, 1, splitter_string_bitmap)
				create splitter_brush.make_by_pattern (splitter_bitmap)
				splitter_bitmap.delete
				splitter_bitmap := Void
				set_click_position (x_pos, y_pos)
				set_capture
			end
		end

	position_is_over_splitter (x_pos: INTEGER): BOOLEAN is
			-- Does `x_position' fall within the splitter?
		require
			x_pos_valid: x_pos >= 0 and x_pos <= width
		do
			Result := x_pos - (internal_split_position + 1) <= splitter_width
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message handling.
		local
			new_pos: INTEGER
			window_dc: WEL_WINDOW_DC
		do
				-- Stop the splitter moving.
			if has_capture then
				create window_dc.make (Current)
				invert_split (window_dc)
				invalidate
				release_capture
				if x_pos - click_relative_position < minimum_split_position then
					new_pos := minimum_split_position
				elseif x_pos - click_relative_position >
					maximum_split_position then
					new_pos := maximum_split_position
				else
					new_pos := x_pos - click_relative_position
				end
				set_split_position (new_pos)
				splitter_brush.delete
				splitter_brush := Void
			end

			-- We have to call pointer actions here
			-- See bug#14692
			on_button_up (x_pos, y_pos, {EV_POINTER_CONSTANTS}.left)
		end

	draw_vertical_line (paint_dc: WEL_PAINT_DC; a_pen: WEL_PEN; a_x: INTEGER) is
			-- Draw a vertical line at x position `a_x' from top to bottom
			-- of current on `paint_dc' using `a_pen'.
		do
			paint_dc.select_pen (a_pen)
			paint_dc.line (a_x, 0, a_x, wel_height)
			paint_dc.unselect_pen
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SPLIT_AREA

feature {NONE} -- WEL internal

	class_cursor: WEL_CURSOR is
			-- Standard arrow cursor used to create the window
			-- class.
			-- Can be redefined to return a user-defined cursor.
		do
				-- If `Current' is empty then we should use the standard arrow cursor.
			if first = Void and second = Void then
				create Result.make_by_predefined_id (Wel_idc_constants.Idc_arrow)
			else
				create Result.make_by_predefined_id (Wel_idc_constants.Idc_sizewe)
			end
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




end -- class EV_HORIZONTAL_SPLIT_AREA_IMP

