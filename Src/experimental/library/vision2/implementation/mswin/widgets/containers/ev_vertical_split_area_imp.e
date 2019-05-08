note
	description: "Displays two widgets one above the other separated by%
		%an adjustable divider"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SPLIT_AREA_IMP

inherit

	EV_VERTICAL_SPLIT_AREA_I
		redefine
			interface, maximum_split_position
		end

	EV_SPLIT_AREA_IMP
		redefine
			interface,
			on_size,
			class_cursor,
			on_mouse_move
		end

create
	make

feature -- Status Report

	maximum_split_position: INTEGER
			-- Maximum position the splitter can have.
		local
			a_sec_height: INTEGER
		do
				-- We force a resize of current if the split is parented but not visible and the position has never been calculated yet		
			if not is_maximum_split_position_computed and then not is_displayed and then attached parent_imp as l_parent then
				is_maximum_split_position_computed := True
				l_parent.notify_change (nc_minheight, Current, True)
			end
			if second_visible and then attached second as l_second then
				a_sec_height := l_second.minimum_height
			end
			Result := height - a_sec_height - splitter_width
			if Result < minimum_split_position then
				Result := minimum_split_position
			end
		end

feature {NONE} -- Status Setting

	set_first (v: EV_WIDGET)
			-- Assign `v' to `first'.
		local
			l_imp: detachable EV_WIDGET_IMP
		do
			is_maximum_split_position_computed := False
			v.implementation.on_parented
			l_imp ?= v.implementation
			check l_imp_not_void: l_imp /= Void then end
			l_imp.set_parent_imp (Current)
			first := v
			disable_item_expand (v)
			if second_visible then
				set_split_position (minimum_split_position)
			else
				set_split_position (maximum_split_position)
			end
			notify_change (Nc_minsize, Current, False)
			new_item_actions.call ([v])
		end

	set_second (v: EV_WIDGET)
			-- Assign `v' to `second'.
		local
			l_imp: detachable EV_WIDGET_IMP
		do
			is_maximum_split_position_computed := False
			v.implementation.on_parented
			l_imp ?= v.implementation
			check l_imp_not_void: l_imp /= Void then end
			l_imp.set_parent_imp (Current)
			second := v
			notify_change (Nc_minsize, Current, False)
			if first_visible then
				set_split_position (height - splitter_width - v.minimum_height.min
					(height - minimum_split_position - splitter_width))
			else
				set_split_position (0)
			end
				--| Notify change is called twice, as we need
				--| the sizing calculations performed once before
				--| we call set_split_position, so we can use `height'
				--| and be sure it is correct. Then we call notify change
				--| again after the split position has been set,
				--| to reflect these changes.
			notify_change (Nc_minsize, Current, False)
			new_item_actions.call ([v])
		end

feature {NONE} -- Implementation

	set_click_position (x_pos, y_pos: INTEGER)
			-- Assign coordinate relative to click position on splitter to
			-- `click_relative_position'.
		do
			click_relative_position := y_pos - internal_split_position
		end

	compute_minimum_size (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum_size of `Current'.
		local
			mh, mw, sep_wid: INTEGER
		do
			if first_visible and then attached first as l_first then
				mw := l_first.minimum_width
				mh := l_first.minimum_height
				sep_wid := splitter_width
			end
			if second_visible and then attached second as l_second then
				mw := mw.max (l_second.minimum_width)
				mh := mh + l_second.minimum_height + sep_wid
			end
			ev_set_minimum_size (mw, mh, a_is_size_forced)
		end

	compute_minimum_height (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum_height of `Current'.
		local
			mh, sep_wid: INTEGER
		do
			if first_visible and then attached first as l_first then
				mh := l_first.minimum_height
				sep_wid := splitter_width
			end
			if second_visible and then attached second as l_second then
				mh := mh + l_second.minimum_height + sep_wid
			end
			ev_set_minimum_height (mh, a_is_size_forced)
		end

	compute_minimum_width (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum_width of `Current'.
		local
			mw: INTEGER
		do
			if first_visible and then attached first as l_first then
				mw := l_first.minimum_width
			end
			if second_visible and then attached second as l_second then
				mw := mw.max (l_second.minimum_width)
			end
			ev_set_minimum_width (mw, a_is_size_forced)
		end

	on_size (size_type, a_width, a_height: INTEGER)
			-- Wm_size message
		do
			split_area_resizing (a_width, a_height, True)
			Precursor {EV_SPLIT_AREA_IMP} (size_type, a_width, a_height)
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			split_area_resizing (a_width, a_height, False)
		end

	layout_widgets (a_width, a_height: INTEGER; originator: BOOLEAN)
		local
			l_first_imp: like first_imp
			l_second_imp: like second_imp
		do
			if first_visible and not second_visible then
				l_first_imp := first_imp
				check l_first_imp /= Void then end
				if originator then
					l_first_imp.set_move_and_size (0, 0, a_width, a_height)
				else
					l_first_imp.ev_apply_new_size (0, 0, a_width, a_height, True)
				end
			end

			if second_visible and not first_visible then
				l_second_imp := second_imp
				check l_second_imp /= Void then end
				if originator then
					l_second_imp.set_move_and_size (0, 0, a_width, a_height)
				else
					l_second_imp.ev_apply_new_size (0, 0, a_width, a_height, True)
				end
			end

			if first_visible and second_visible then
				l_first_imp := first_imp
				l_second_imp := second_imp
				check l_first_imp /= Void and l_second_imp /= Void then end
				if originator then
					l_first_imp.set_move_and_size (0, 0, a_width, internal_split_position)
					l_second_imp.set_move_and_size (0, internal_split_position +
						splitter_width, a_width, a_height - internal_split_position -
						splitter_width)
				else
					l_first_imp.ev_apply_new_size (0, 0, a_width, internal_split_position, True)
					l_second_imp.ev_apply_new_size (0, internal_split_position +
						splitter_width, a_width, a_height - internal_split_position -
						splitter_width, True)
				end
			end
		end

	split_area_resizing (a_width, a_height: INTEGER; originator: BOOLEAN)
			-- Wm_size message
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

				if originator then
						-- Store the number of pixels `Current' has increased
						-- by (negative for a reduction).
					size_change := height - last_dimension
				end

					-- Store dimension for the next resize.
				last_dimension := a_height

					-- Assign the correct movement to `movement', determined
					-- by `splitter_movement_factor' and `size_change'.
				movement := (size_change * splitter_movement_factor).rounded

					-- Update internal split position to the new value.
				internal_split_position := internal_split_position + movement
			end
			update_split_position
			layout_widgets (a_width, a_height, originator)
		end

	invert_split (a_dc: WEL_DC)
			-- Invert the split on `a_dc'.
		do
				-- We do `-1' and `+1' on the axis because `invert_rectangle' exclude the border.			
			invert_rectangle (a_dc, -1, internal_split_position - 1, width, internal_split_position + splitter_width + 1)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER)
			-- Wm_mousemove message
		local
			new_pos: INTEGER
			window_dc: WEL_WINDOW_DC
		do
				-- Are we moving the splitter?
			if has_capture then
				if y_pos - click_relative_position < minimum_split_position then
					new_pos := minimum_split_position
				elseif y_pos - click_relative_position >
					maximum_split_position then
					new_pos := maximum_split_position
				else
					new_pos := y_pos - click_relative_position
				end
				if internal_split_position /= new_pos then
					if use_realtime_splitter_positioning then
							-- Move the splitter to the mouse position and
							-- update content when dragging.
						set_split_position (new_pos)
							-- We need to refresh now to avoid traces of the splitter on screen.
						cwin_redraw_window (wel_item, default_pointer, default_pointer, {WEL_RDW_CONSTANTS}.rdw_updatenow)
					else
							-- Move shade of splitter and do not update content.
						create window_dc.make (Current)
						invert_split (window_dc)
						internal_split_position := new_pos
						invert_split (window_dc)
						window_dc.delete
					end
				end
			else
				Precursor {EV_SPLIT_AREA_IMP} (keys, x_pos, y_pos)
			end
		end

	position_is_over_splitter (y_pos: INTEGER): BOOLEAN
			-- Does `y_position' fall within the splitter?
		do
			Result := (first_visible and then second_visible) and then y_pos >= internal_split_position and then (y_pos - (internal_split_position + splitter_width)) < 0
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER)
			-- Wm_lbuttondown message handling.
		local
			splitter_bitmap: WEL_BITMAP
			l_top_level_window_imp: like top_level_window_imp
			window_dc: WEL_WINDOW_DC
		do
				-- We have to call pointer actions here
				-- See bug#14692
			on_button_down (x_pos, y_pos, {EV_POINTER_CONSTANTS}.left)

				-- Pressing the left button on the splitter to move it, was
				-- not bringing the window it was contained in to the front.
				-- This fixes this.
			l_top_level_window_imp := top_level_window_imp
			check l_top_level_window_imp /= Void then end
			l_top_level_window_imp.move_to_foreground
				-- We must check that we are in the correct location for the split area,
				-- as if a notebook is placed inside, there are areas of `Current' that receive
				-- the left button click. For example, to the right of the tabs.
				-- This ensures that the splitter is only moved when it really should be. Julian
			if not has_capture and position_is_over_splitter (y_pos) then
				-- Start to move the splitter. We capture the mouse
				-- message to be able to move the mouse over the
				-- left or right control without losing the "mouse focus."
				if not use_realtime_splitter_positioning then
					create splitter_bitmap.make_direct (8, 8, 1, 1, splitter_string_bitmap)
					create splitter_brush.make_by_pattern (splitter_bitmap)
					splitter_bitmap.delete
						-- Move shade of splitter and do not update content.
					create window_dc.make (Current)
					invert_split (window_dc)
					window_dc.delete
				end
				set_click_position (x_pos, y_pos)
				set_capture
			end
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER)
			-- Wm_lbuttondown message handling.
		local
			new_pos: INTEGER
			window_dc: WEL_WINDOW_DC
		do
				-- Stop the splitter moving.
			if has_capture then
				release_capture
				if not use_realtime_splitter_positioning then
					create window_dc.make (Current)
					invert_split (window_dc)

					if y_pos - click_relative_position < minimum_split_position then
						new_pos := minimum_split_position
					elseif y_pos - click_relative_position > maximum_split_position then
						new_pos := maximum_split_position
					else
						new_pos := y_pos - click_relative_position
					end
					set_split_position (new_pos)
				end
				if attached splitter_brush as l_splitter_brush then
					l_splitter_brush.delete
					splitter_brush := Void
				end
			end

				-- We have to call pointer actions here
				-- See bug#14692
			on_button_up (x_pos, y_pos, {EV_POINTER_CONSTANTS}.left)
		end

	draw_horizontal_line
			(paint_dc: WEL_PAINT_DC; a_pen: WEL_PEN; a_y: INTEGER)
			-- Draw a horizontal line at y position `a_y' from left to right of
			-- `Current' on `paint_dc' using `a_pen'.
		do
			paint_dc.select_pen (a_pen)
			paint_dc.line (0, a_y, wel_width, a_y)
			paint_dc.unselect_pen
		end

	is_computing_max_position: BOOLEAN
			-- To prevent recursion when computing the maximum position of the splitter.

feature {NONE} -- WEL internal

	class_cursor: WEL_CURSOR
			-- Create the default cursor for `Current'.
		do
				-- If `Current' is empty then we should use the standard arrow cursor.
			if first = Void and second = Void then
				create Result.make_by_predefined_id (Wel_idc_constants.Idc_arrow)
			else
				create Result.make_by_predefined_id (Wel_idc_constants.Idc_sizens)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SPLIT_AREA note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
