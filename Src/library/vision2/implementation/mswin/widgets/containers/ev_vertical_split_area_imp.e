indexing
	description: "Displays two widgets one above the other separated by%
		%an adjustable divider"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SPLIT_AREA_IMP

inherit
	
	EV_VERTICAL_SPLIT_AREA_I
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
			on_wm_paint,
			class_cursor,
			on_mouse_move
		end

creation
	make

feature {NONE} -- Status Setting

	set_first (v: like item) is
			-- Assign `v' to `first'.
		do
			first := v
			disable_item_expand (first)
			first_imp.set_parent (interface)
			if second_visible then
				splitter_width := visible_splitter_width
				set_split_position (minimum_split_position)
			else
				set_split_position (maximum_split_position)
			end
			notify_change (Nc_minsize, Current)
			new_item_actions.call ([v])
		end

	set_second (v: like item) is
			-- Assign `v' to `second'.
		do
			second := v
			second_imp.set_parent (interface)
			notify_change (Nc_minsize, Current)
			if first_visible then
				splitter_width := visible_splitter_width
				set_split_position (height - splitter_width - second.minimum_height.min
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
			notify_change (Nc_minsize, Current)
			new_item_actions.call ([v])
		end

feature {NONE} -- Implementation

	set_click_position (x_pos, y_pos: INTEGER) is
			-- Assign coordinate relative to click position on splitter to
			-- `click_relative_position'.
		do
			click_relative_position := y_pos - split_position
		end

	compute_minimum_size is
			-- Recompute the minimum_size of `Current'.
		local
			mh, mw: INTEGER
		do
			if first_visible then
				mw := first.minimum_width
				mh := first.minimum_height
			end
			if second_visible then
				mw := mw.max (second.minimum_width)
				mh := mh + second.minimum_height + splitter_width
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
				mh := mh + second.minimum_height + splitter_width
			end
			ev_set_minimum_height (mh)
		end

	compute_minimum_width is
			-- Recompute the minimum_width of `Current'.
		local
			mw: INTEGER
		do
			if first_visible then
				mw := first.minimum_width
			end
			if second_visible then
				mw := mw.max (second.minimum_width)
			end
			ev_set_minimum_width (mw)
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
		do
			Precursor (size_type, a_width, a_height)
			split_area_resizing (a_height, True)
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			ev_move_and_resize
				(a_x_position, a_y_position, a_width, a_height, repaint)
			split_area_resizing (a_height, False)
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
					first_imp.set_move_and_size (0, 0, width, split_position)
					second_imp.set_move_and_size (0, split_position +
						splitter_width, width, height - split_position -
						splitter_width)
				else
					first_imp.ev_apply_new_size (0, 0, width, split_position,
						True)
					second_imp.ev_apply_new_size (0, split_position +
						splitter_width, width, height - split_position -
						splitter_width, True)
				end
			end

				-- Invalidate separator.
			create rect.make (0, split_position, width,
				split_position + splitter_width)
			invalidate_rect (rect, True)
		end	

	split_area_resizing (a_height: INTEGER; originator: BOOLEAN) is
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
	
					-- Store the number of pixels `Current' has increased
					-- by (negative for a reduction).
				size_change := height - last_dimension

					-- Store the current size as `last_split_position'.
				last_dimension:= a_height
			
					-- Assign the correct movement to `movement', determined
					-- by `splitter_movement_factor' and `size_change'.
				movement := (size_change * splitter_movement_factor).rounded

					-- Move the split position.
				set_split_position (split_position + movement)
			end

			update_split_position
			layout_widgets (originator)
		end

	invert_split (a_dc: WEL_DC) is
			-- Invert the split on `a_dc'.
		do
			invert_rectangle (a_dc, -1, split_position, width, split_position +
				splitter_width)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mousemove message
		local
			t: WEL_SYSTEM_PARAMETERS_INFO
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
				if split_position /= new_pos then
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
						split_position := new_pos
						invert_split (window_dc)
--|					end
				end
			else
				Precursor {EV_SPLIT_AREA_IMP} (keys, x_pos, y_pos)
			end
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
				release_capture
				if y_pos - click_relative_position < minimum_split_position then
					new_pos := minimum_split_position
				elseif y_pos - click_relative_position >
					maximum_split_position then
					new_pos := maximum_split_position
				else
					new_pos := y_pos - click_relative_position
				end
				set_split_position (new_pos)
			end
		end

	on_wm_paint (wparam: INTEGER) is
			-- Wm_paint message handling
			-- A WEL_DC and WEL_PAINT_STRUCT are created and
			-- passed to the `on_paint' routine.
		local
			paint_dc: WEL_PAINT_DC
			bk_pen: WEL_PEN
			pen: WEL_PEN
		do
			create paint_dc.make_by_pointer
				(Current, cwel_integer_to_pointer(wparam))
			paint_dc.get

			if not flat_separator and count = 2 then
				create bk_pen.make_solid (1, wel_background_color)
					-- We draw here the splitter. Add your code here to improve
					-- the look of the splitter
				draw_horizontal_line (paint_dc, bk_pen, split_position)
				pen := highlight_pen
				draw_horizontal_line (paint_dc, pen, split_position + 1)
				pen.delete
				draw_horizontal_line (paint_dc, bk_pen, split_position + 2)
				draw_horizontal_line (paint_dc, bk_pen, split_position + 3)
				pen := shadow_pen
				draw_horizontal_line (paint_dc, pen, split_position + 4)
				pen.delete
				pen := black_pen
				draw_horizontal_line (paint_dc, pen, split_position + 5)
				bk_pen.delete
			end
			paint_dc.release
		end

	draw_horizontal_line
			(paint_dc: WEL_PAINT_DC; a_pen: WEL_PEN; a_y: INTEGER) is
			-- Draw a horizontal line at y position `a_y' from left to right of
			-- `Current' on `paint_dc' using `a_pen'.
		do
			paint_dc.select_pen (a_pen)
			paint_dc.line (0, a_y, wel_width, a_y)
		end

feature {NONE} -- WEL internal

	class_cursor: WEL_CURSOR is
			-- Create the default cursor for `Current'.
		do
				-- If `Current' is empty then we should use the standard arrow cursor.
			if first = Void and second = Void then
				create Result.make_by_predefined_id (Wel_idc_constants.Idc_arrow)			
			else
				create Result.make_by_predefined_id (Wel_idc_constants.Idc_sizens)
			end
		end

feature {NONE} -- Implementation

	interface: EV_VERTICAL_SPLIT_AREA

end -- class EV_VERTICAL_SPLIT_AREA_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.23  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.22  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.21  2001/07/02 21:08:08  rogers
--| `set_first' and `set_second' now call `new_item_actions'.
--|
--| Revision 1.20  2001/06/07 23:08:15  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.17.8.39  2001/04/04 19:48:15  rogers
--| We only draw the separator in on_wm_paint if `Current' contains two
--| widgets. There is no need otherwise as the separator is covered or hidden.
--|
--| Revision 1.17.8.38  2001/04/04 18:42:17  rogers
--| Class_cursor now returns the standard arrow when `Current' is empty.
--|
--| Revision 1.17.8.37  2001/03/04 22:31:01  pichery
--| Cosmetics
--|
--| Revision 1.17.8.36  2001/01/30 22:42:24  rogers
--| Fixed bug in set_second. The new split_position calculation was incorrect.
--|
--| Revision 1.17.8.35  2001/01/19 19:47:59  rogers
--| Layout widgets now always invalidates the separator.
--|
--| Revision 1.17.8.34  2001/01/11 22:59:18  rogers
--| On_left_button_up now calls invert_split, to restore the inverted area.
--| This bug would show up when `Current' contained two trees.
--|
--| Revision 1.17.8.33  2000/12/29 15:39:16  pichery
--| Added comments.
--|
--| Revision 1.17.8.32  2000/12/29 15:37:18  pichery
--| Removed the "real time resizing". As soon as windows
--| get a little complex, it blocks the system for 2 to 3 sec.
--|
--| Revision 1.17.8.31  2000/12/08 03:15:03  manus
--| If `originator' was true we were calling `ev_move_and_resize' instead
--| of `ev_apply_new_size'. This is a mistake in the integration of version
--| 1.17.8.17, since integration of EV_HORIZONTAL_SPLIT_AREA_IMP of version
--| 1.18.4.21 was correct.
--|
--| Revision 1.17.8.30  2000/12/04 23:18:21  rogers
--| Formatting to 80 columns.
--|
--| Revision 1.17.8.29  2000/11/09 01:12:07  rogers
--| Removed deletion of black pen from on_paint as pen is a once function.
--|
--| Revision 1.17.8.28  2000/11/02 05:02:11  manus
--| Updated comment on EV_SYSTEM_PEN_IMP to show that after using one of these
--| WEL_PEN object the Vision2 implementor needs to call `delete' on them to
--| free the allocated GDI object. Updated code of classes which was not doing
--| it.
--|
--| Revision 1.17.8.27  2000/10/27 02:33:12  manus
--| No need to get the background brush, we can just get the
--| `wel_background_color' to draw splitter.
--|
--| Revision 1.17.8.26  2000/10/25 03:11:53  manus
--| Fixed side effects of setting the cursor to a different shape. In
--| `on_set_cursor' we should test the `hit_code' to figure out if we have to
--| change the shape or not, namely it has to be done when the hit_code is
--| either `nowhere' or `client'. The rest is taken care by Windows.
--|
--| Even though doing this fix, does not work for EV_SPLIT_AREA_IMP because
--| the cursor it lost, so I forced the setting of the cursor to its
--| `class_cursor' when it was needed.
--|
--| Fixed a bug in EV_SPLIT_AREA_IMP and descendants where `cursor_on_widget'
--| was not update in `on_mouse_move' because we forgot to call its Precursor.
--|
--| Revision 1.17.8.25  2000/10/22 23:50:17  manus
--| New split area behavior based on the status of `show content while dragging'
--| from the `effects' tab in Windows control panel. When it is enabled we do a
--| live update, otherwise we draw the shade of the splitter and it is updated
--| at the end when user release the button.
--| Relies on new WEL class `WEL_SYSTEM_PARAMETER_INFO'.
--|
--| Revision 1.17.8.24  2000/10/12 15:50:25  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.17.8.23  2000/09/28 19:46:41  rogers
--| Fixed set_second, so when moving the split_position, it takes into
--| account the splitter_width. Postconditions are no longer violated.
--|
--| Revision 1.17.8.22  2000/09/05 19:09:54  rogers
--| Fixed set_second so splitter_in_valid_position invaraiant is no longer
--| broken.
--|
--| Revision 1.17.8.21  2000/08/15 17:33:47  rogers
--| Removed fixme from split_area_resizing, as no fix is required.
--|
--| Revision 1.17.8.19  2000/08/11 22:11:42  rogers
--| Removed unreferenced variable from on_wm_paint.
--|
--| Revision 1.17.8.18  2000/08/11 18:54:21  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.17.8.17  2000/08/08 15:38:08  manus
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| Clean up code with new resizing code and better `on_wm_paint' procedure
--| which collects GDI objects.
--|
--| Revision 1.17.8.16  2000/08/01 20:57:04  rogers
--| Redefined class_name and class_cursor to allow correct cursor to be used.
--|
--| Revision 1.17.8.15  2000/08/01 18:56:38  rogers
--| Comments, formatting.
--|
--| Revision 1.17.8.14  2000/07/29 00:01:10  rogers
--| Correct layout_widgets for when first and second are both displayed.
--|
--| Revision 1.17.8.12  2000/07/28 22:39:18  rogers
--| On mouse move now uses click_relative_position so the splitter is
--| actually set to the exact position required. Layout widgets now invalidates
--| `Current', so as necessary, lone calls to invalidate have been removed.
--|
--| Revision 1.17.8.11  2000/07/28 21:07:37  rogers
--| Corrected drawing of normal separator in on_wm_paint. Set_first and
--| set_second now set the splitter_width to visible_Splitter_width instead
--| of magic number.
--|
--| Revision 1.17.8.10  2000/07/28 19:54:53  rogers
--| Added set_click_position which assigns the horizontal offset into the
--| splitter to `click_relative_position'. Also now call invalidate when the
--| mouse moves, so the separator is drawn correctly.
--|
--| Revision 1.17.8.9  2000/07/28 18:23:15  rogers
--| Really now redefefined on_wm_paint.
--|
--| Revision 1.17.8.8  2000/07/28 18:07:04  rogers
--| Redefined on_wm_paint, so we can draw the splitter ourselves.
--|
--| Revision 1.17.8.7  2000/07/27 20:12:19  rogers
--| Implemented all features necessary for implementation. Added copyright
--| clause and CVS area at end of file.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------


