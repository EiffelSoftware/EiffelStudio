indexing
	description:
		"Contains a maximum of two widgets, one on each side of an adjustable%
			%separator. If only one widget is contained then the separator is%
			%hidden."
	status: "See notice at end of class."
	keywords: "container, split, devide"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SPLIT_AREA_IMP

inherit

	EV_SPLIT_AREA_I
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			on_left_button_up,
			on_left_button_down
		redefine
			interface,
			initialize,
			enable_sensitive,
			disable_sensitive,
			propagate_syncpaint,
			update_for_pick_and_drop,
			on_set_cursor
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine	
			top_level_window_imp,
			on_left_button_down
		end

	EV_SYSTEM_PEN_IMP

	WEL_ROP2_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			ev_wel_control_container_make
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_CONTAINER_IMP}
			first_expandable := True
			second_expandable := True
				-- Default look is the standard separator i.e. not flat.
			flat_separator := False
				-- The splitter is not displayed until `Current' contains
				-- two widgets, so setting the width to 0 hides it.
			splitter_width := 0
		end

feature {EV_ANY_I} -- Status Setting

	enable_sensitive is
			-- Set `item' sensitive to user actions.
		do
			if first /= Void and not first_imp.internal_non_sensitive then
				first_imp.enable_sensitive
			end
			if second /= Void and not second_imp.internal_non_sensitive then
				second_imp.enable_sensitive
			end
			Precursor {EV_CONTAINER_IMP}
		end

	disable_sensitive is
			-- Set `item' insensitive to user actions.
		do
			if first /= Void then
				first_imp.disable_sensitive
			end
			if second /= Void then
				second_imp.disable_sensitive
			end
			Precursor {EV_CONTAINER_IMP}
		end
		
feature {EV_ANY_I} -- Implementation

	propagate_syncpaint is
			-- Propagate `wm_syncpaint' message recevived by `top_level_window_imp' to
			-- children. See "WM_SYNCPAINT" in MSDN for more information.
		do
			if first_imp /= Void then
				first_imp.propagate_syncpaint
			end
			if second_imp /= Void then
				second_imp.propagate_syncpaint
			end
		end
		
	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so notify `first_imp' and `second_imp'.
		do
			if first_imp /= Void then
				first_imp.update_for_pick_and_drop (starting)
			end
			if second_imp /= Void then
				second_imp.update_for_pick_and_drop (starting)
			end
		end
		

feature {NONE} -- Implementation

	split_position: INTEGER
		-- Position of the splitter in pixels.
		-- For a vertical split area, the position is the top of the splitter.
		-- For a horizontal split area, the position is the left
		-- of the splitter.

	enable_flat_separator is
			-- Change appearence of `Current' to display the separator
			-- as flat.
		do
			flat_separator := True
			splitter_width := visible_splitter_width
			layout_widgets (True)
		end

	disable_flat_separator is
			-- Change appearence of `Current' to display the separator
			-- as raised.
		do
			flat_separator := False
			splitter_width := visible_splitter_width
			layout_widgets (True)
		end

	is_control_in_window (hwnd_control: POINTER): BOOLEAN is
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		do
			if hwnd_control = wel_item then
				Result := True
			elseif not Result and first /= Void then
				Result := first_imp.is_control_in_window (hwnd_control)
			elseif not Result and second /= Void then
				Result := second_imp.is_control_in_window (hwnd_control)
			end
		end

	prune (v: like item) is
			-- Remove one occurrence of `v' if any.
		local
			v_imp: EV_WIDGET_IMP
		do
			if v /= Void then
				if v = first then
					v_imp := first_imp
					first := Void
					second_expandable := True
					first_expandable := True
						-- Hide the splitter as `Current' only 
					splitter_width := 0
					set_split_position (0)
				elseif v = second then
					v_imp := second_imp
					second := Void
					first_expandable := True
					second_expandable := True
					splitter_width := 0 
					set_split_position (maximum_split_position)
				end
					-- If `v_imp' not Void (meaning `v' is being removed).
				if v_imp /= Void then
						-- Unparent `v_imp' from `Current'.
					v_imp.set_parent (Void)
						-- Reflect the changes by updating the position of the
						-- splitter and laying out the widgets.
					update_split_position
					notify_change (Nc_minsize, Current)
				end
			end
		end

	set_split_position (a_position: INTEGER) is
			-- Assign `a_position' to split position and layout the
			-- widgets accordingly.
		do
			split_position := a_position
			layout_widgets (True)
		end	

	disable_item_expand (v: like item) is
			-- When `Current' is resized, do not resize `v'.
		do
			if v = first then
				first_expandable := False
			elseif v = second then
				second_expandable := False
			end
		end

	enable_item_expand (v: like item) is
			-- When `Current' is resized, resize `an_item' respectively.
		do
			if v = first then
				first_expandable := True
			elseif v = second then
				second_expandable := True
			end
		end
	
	minimum_split_position: INTEGER is
			-- Minimum position in pixels allowed for the splitter.
		deferred
		end

	maximum_split_position: INTEGER is
			-- Maximum position in pixels allowed for the splitter.
		deferred
		end

	layout_widgets (originator: BOOLEAN) is
		deferred
		end

	set_click_position (x_pos, y_pos: INTEGER) is
			-- Assign coordinate relative to click position on splitter to
			-- `click_relative_position'.
		deferred
		end	

	is_child (v: EV_WIDGET_IMP): BOOLEAN is
			-- Is `v' a child of `Current'?
		do
			Result := v.interface = first or v.interface = second
		end

	update_split_position is
			-- Set splitter to a valid position and redraw if necessary.
		do
			split_position := split_position.max (minimum_split_position)
			split_position := split_position.min (maximum_split_position)
		end

feature {NONE} -- Implementation

	first_imp: EV_WIDGET_IMP is
			-- `Result' is implementation of first.
		do
			if first /= Void then
				Result ?= first.implementation
				check
					implementation_of_first_not_void: Result /= Void
				end
			end
		end

	second_imp: EV_WIDGET_IMP is
			-- `Result' is implementation of second.
		do
			if second /= Void then
				Result ?= second.implementation
				check
					implementation_of_second_not_void: Result /= Void
				end
			end
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message handling.
		do
				-- Pressing the left button on the splitter to move it, was
				-- not bringing the window it was contained in to the front.
				-- This fixes this.
			top_level_window_imp.move_to_foreground
				-- Start to move the splitter. We capture the mouse
				-- message to be able to move the mouse over the
				-- left or right control without losing the "mouse focus."
			if not has_capture then
				set_click_position (x_pos, y_pos)
				set_capture
			end
		end

	on_set_cursor (hit_code: INTEGER) is
			-- Called when a `Wm_setcursor' message is received.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		local
			wel_point: WEL_POINT
			wel_window: WEL_WINDOW
			our_window: WEL_WINDOW
		do
				--| We need to check that the cursor is currently over `Current'.
				--| We used to query `cursor_on_widget.item', however, this is only
				--| updated when in `on_mouse_move' which is executed after this current
				--| feature. That meant that when leaving `Current', the cursor would
				--| not always be updated correctly.
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			wel_window := wel_point.window_at
			our_window ?= Current				
			if our_window = wel_window then
				class_cursor.set
				set_message_return_value (1)
				disable_default_processing
			else
				Precursor {EV_CONTAINER_IMP} (hit_code)
			end
		end

	invert_rectangle
		(a_dc: WEL_DC; a_left, a_top, a_right, a_bottom: INTEGER) is
			-- Invert the rectangular zone defined by
			-- `a_left', `a_top', `a_right', `a_bottom'
			-- on `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
		local
			old_rop2: INTEGER
		do
			a_dc.get
			old_rop2 := a_dc.rop2
			a_dc.set_rop2 (R2_xorpen)
			a_dc.select_brush (splitter_brush)
			a_dc.rectangle (a_left, a_top, a_right, a_bottom)
			a_dc.set_rop2 (old_rop2)
			a_dc.release
		end

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			widget_imp: EV_WIDGET_IMP
		do
			top_level_window_imp := a_window
			if first /= Void then
				widget_imp ?= first.implementation
				check
					widget_implementation_not_void: widget_imp /= Void
				end
				widget_imp.set_top_level_window_imp (a_window)
			end
			if second /= Void then
				widget_imp ?= second.implementation
				check
					widget_implementation_not_void: widget_imp /= Void
				end
				widget_imp.set_top_level_window_imp (a_window)
			end
		end

	last_dimension: INTEGER
		-- For a horizontal split_area, this contains the last
		-- width of `Current'.
		-- For a vertical split_area, this contains the last
		-- height of `Current'.

	splitter_width: INTEGER
			-- Current width of splitter in pixels.
			-- Should be either `normal_separator_width',
			-- `flat_separator_width' or 0 if splitter is hidden.

	visible_splitter_width: INTEGER is
			-- `Result' is width the visible separator should occupy.
			-- if `flat_separator' then `Result' is `flat_separator_width'.
			-- if not `flat_separator' then `Result' is
			-- `normal_separator_width'.
		do
			if flat_separator then	
				Result := flat_separator_width
			else
				Result := normal_separator_width
			end
		end

	flat_separator_width: INTEGER is 4
		-- Width of flat separator

	normal_separator_width: INTEGER is 6
		-- Width of normal separator. (The one used after creation).

	click_relative_position: INTEGER
		-- Mouse coordinate relative to start of splitter when splitter
		-- is clicked on.
		
	adjust_tab_ordering (ordered_widgets: ARRAYED_LIST [WEL_WINDOW]; widget_depths: ARRAYED_LIST [INTEGER]; depth: INTEGER) is
		-- Adjust tab ordering of children in `Current'.
		-- used when `Current' is a child of an EV_DIALOG_IMP_MODAL
		-- or an EV_DIALOG_IMP_MODELESS. When 
		local
			child: WEL_WINDOW
			container: EV_CONTAINER_IMP
		do
			if first_imp /= Void then
				container ?= first_imp
				if container /= Void then
						-- Reverse tab order of `widget_list'.
					container.adjust_tab_ordering (ordered_widgets, widget_depths, depth + 1)
				end
					-- Add `child' to `ordered_widgets'.
				child ?= first_imp
				check
					child_not_void: child /= Void
				end
				ordered_widgets.force (child)
				widget_depths.force (depth)
			end
			if second_imp /= Void then
				container ?= second_imp
				if container /= Void then
						-- Reverse tab order of `widget_list'.
					container.adjust_tab_ordering (ordered_widgets, widget_depths, depth + 1)
				end
					-- Add `child' to `ordered_widgets'.
				child ?= second_imp
				check
					child_not_void: child /= Void
				end
				ordered_widgets.force (child)
				widget_depths.force (depth)
			end
		end

feature {NONE} -- Implementation

	splitter_brush: WEL_BRUSH is
			-- Create the brush used to draw the invert splitter.
			-- For this, it creates a bitmap :	black / white
			--                                  white / black
			-- In the following code, `hexa_number' and `string_bitmap'
			-- are hexadecimal representations of the bitmap. 
			-- Here follows the representation of the picture:
			-- binary: 0 / 1     hexa : 40 / 00     decimal : 128 / 0
			--         1 / 0            80 / 00                64 / 0
		local
			bitmap: WEL_BITMAP
			log: WEL_LOG_BITMAP
			string_bitmap: STRING
			hexa_number: INTEGER
			c: ANY
		once
			string_bitmap := ""
				-- First line of the bitmap
			hexa_number := 128
			string_bitmap.append_character (hexa_number.ascii_char)
			hexa_number := 0
			string_bitmap.append_character (hexa_number.ascii_char)
				-- Second line of the bitmap
			hexa_number := 64
			string_bitmap.append_character (hexa_number.ascii_char)
			hexa_number := 0
			string_bitmap.append_character (hexa_number.ascii_char)
			c := string_bitmap.to_c
				-- Then, we create the brush
			create log.make (2, 2, 2, 1, 1, $c)
			create bitmap.make_indirect (log)
			create Result.make_by_pattern (bitmap)
		end


feature {NONE} -- Implementation

	extend (v: like item) is
		do
			--| This requires no implementation as we are able to implement this
			--| platform independently using set_first and set_second.
			--| See put from EV_SPLIT_AREA_I
		end

feature {EV_ANY_I}

	interface: EV_SPLIT_AREA

feature {NONE} -- WEL internal

	Wel_idc_constants: WEL_IDC_CONSTANTS is
			-- Default Cursors constants
		once
			create Result
		end

end -- class EV_SPLIT_AREA_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.28  2001/06/29 01:00:22  rogers
--| Fixed bug in prune with expandable items after calling wipe_out.
--|
--| Revision 1.27  2001/06/07 23:08:15  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.24.8.63  2001/04/04 22:24:01  rogers
--| Tabbing.
--|
--| Revision 1.24.8.62  2001/04/04 18:00:41  rogers
--| Corrected first_imp and second_imp, so they may return a Void result.
--|
--| Revision 1.24.8.61  2001/03/30 20:03:30  rogers
--| Fixed bug in on_set_cursor, where the splitter cursor was still being
--| set, even after moving a couple of pixels outside of `Current'.
--|
--| Revision 1.24.8.60  2001/03/29 19:12:01  rogers
--| Implemented adjust_tab_ordering.
--|
--| Revision 1.24.8.59  2001/03/29 18:23:17  rogers
--| Renamed reverse_tab_order to adjust_tab_ordering.
--|
--| Revision 1.24.8.58  2001/03/28 21:40:28  rogers
--| Changed signature of reverse_tab_order.
--|
--| Revision 1.24.8.57  2001/03/28 19:18:47  rogers
--| Added reverse_tab_order, still to be implemented.
--|
--| Revision 1.24.8.56  2001/03/16 19:15:54  rogers
--| previous commit should have read : implemented update_for_pick_and_drop.
--|
--| Revision 1.24.8.55  2001/03/16 19:07:18  rogers
--| Added update_for
--|
--| Revision 1.24.8.54  2001/03/15 00:50:04  rogers
--| Redefined propagate_syncpaint.
--|
--| Revision 1.24.8.53  2001/02/08 17:54:01  rogers
--| Comment.
--|
--| Revision 1.24.8.52  2001/01/26 23:33:37  rogers
--| Removed undefinition of on_sys_key_down as this is already done in the
--| ancestor EV_WEL_CONTROL_CONTAINER_IMP.
--|
--| Revision 1.24.8.51  2000/12/04 23:14:11  rogers
--| Formatting to 80 columns.
--|
--| Revision 1.24.8.50  2000/11/14 21:08:51  rogers
--| Changed instances of `bang bang' to create.
--|
--| Revision 1.24.8.49  2000/11/10 04:59:08  manus
--| `first_imp' and `second_imp' can be Void and therefore we should never use
--| those features when either `first' or `second' are void. Having `first' or
--| `second' not void implies that `first_imp' or `second_imp' are not void.
--| Fixed `prune' so that it does not do anything when item to be pruned if `Void'.
--|
--| Revision 1.24.8.48  2000/11/06 18:02:12  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.24.8.47  2000/10/26 17:13:53  manus
--| `on_set_cursor' now works on the split area, except the splitter where we force the splitter
--| cursor shape.
--|
--| Revision 1.24.8.46  2000/10/25 17:06:58  manus
--| Fixed a bad precondition specification due to old code.
--|
--| Revision 1.24.8.45  2000/10/25 03:11:53  manus
--| Fixed side effects of setting the cursor to a different shape. In `on_set_cursor' we should
--| test the `hit_code' to figure out if we have to change the shape or not, namely it has to be
--| done when the hit_code is either `nowhere' or `client'. The rest is taken care by Windows.
--|
--| Even though doing this fix, does not work for EV_SPLIT_AREA_IMP because the cursor it lost,
--| so I forced the setting of the cursor to its `class_cursor' when it was needed.
--|
--| Fixed a bug in EV_SPLIT_AREA_IMP and descendants where `cursor_on_widget' was not updated
--| in `on_mouse_move' because we forgot to call its Precursor.
--|
--| Revision 1.24.8.44  2000/10/22 23:50:16  manus
--| New split area behavior based on the status of `show content while dragging' from the
--| `effects' tab in Windows control panel. When it is enabled we do a live update, otherwise
--| we draw the shade of the splitter and it is updated at the end when user release the button.
--| Relies on new WEL class `WEL_SYSTEM_PARAMETER_INFO'.
--|
--| Revision 1.24.8.43  2000/10/20 22:36:21  rogers
--| Fixed bug where clicking on the splitter did not rasise the containing window.
--|
--| Revision 1.24.8.42  2000/09/13 22:11:59  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.24.8.41  2000/08/15 23:41:51  rogers
--| Enable_sensitive now only enables children which have been made insensitive
--| non directly. i.e. placed in a container which has sensitivity disabled.
--|
--| Revision 1.24.8.40  2000/08/15 23:28:03  rogers
--| Redefined enable_Sensitive and disable_sensitive to enable and disable
--| the children's implementation.
--|
--| Revision 1.24.8.39  2000/08/15 16:40:09  rogers
--| Removed replace as the correct implementation is now inherited, platform
--| independently, from EV_SPLIT_AREA_I.
--|
--| Revision 1.24.8.38  2000/08/11 18:55:46  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.24.8.37  2000/08/08 18:17:46  manus
--| Moved `first_visible' and `second_visible' to EV_SPLIT_AREA_I since it is needed for
--| `EV_HORIZONTAL_SPLIT_AREA_I' and `EV_VERTICAL_SPLIT_AREA_I' to compute a correct
--| `minimum_split_position' and `maximum_split_position'. This is only exported to
--| EV_SPLIT_AREA_I and descendants, not to the interface.
--|
--| Revision 1.24.8.36  2000/08/08 15:38:08  manus
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| Clean up code with new resizing code and better `on_wm_paint' procedure which
--| collects GDI objects.
--|
--| Revision 1.24.8.35  2000/08/01 20:59:11  rogers
--| Comments, formatting.
--|
--| Revision 1.24.8.34  2000/07/28 23:52:16  rogers
--| Added first_visible and second_visible which are used internally to see if
--| a first or second are not void and displayed. This is a very common query
--| for the re-sizing code. Comments, formatting.
--|
--| Revision 1.24.8.33  2000/07/28 23:00:24  rogers
--| Fixed set_split_position so it actually lays out the widgets.
--|
--| Revision 1.24.8.32  2000/07/28 22:49:35  rogers
--| Redefined initialize from EV_CONTAINER_IMP for intialization of variables.
--|
--| Revision 1.24.8.31  2000/07/28 22:37:20  rogers
--| Layout widgets in EV_HORIZONTAL_SPLIT_AREA_IMP and
--| EV_VERTICAL_SPLIT_AREA now invalidates `Current', so all calls to
--| invalidate have been removed.
--|
--| Revision 1.24.8.30  2000/07/28 21:10:07  rogers
--| Added visible_splitter_width which returns the correct width for the
--| splitter when displayed. Aded flat_Separator_width and
--| normal_separator_width to get rid of magic numbers. Implemented
--| enable_flat_Separator and disable_flat_Separator.
--|
--| Revision 1.24.8.29  2000/07/28 19:58:51  rogers
--| Added set_click_position as deferred, and click_relative_position to
--| store offset of click into separator. Fixed prune, so that expandable
--| status of any widgets is correct.
--|
--| Revision 1.24.8.28  2000/07/27 23:33:32  rogers
--| Added inheritance from EV_SYSTEM_PEN_IMP. Class comment modified.
--|
--| Revision 1.24.8.27  2000/07/27 23:12:34  rogers
--| Implemented enable_flat_separator and disable_flat_separator.
--|
--| Revision 1.24.8.25  2000/07/27 22:28:47  rogers
--| Fixed bug in set_top_level_window_imp which would not set
--| top_level_window_imp for the second widget. Implemented replace.
--|
--| Revision 1.24.8.24  2000/07/27 20:13:51  rogers
--| last_split_position renamed to last_dimension. On_mouse_move and
--| layout_widgets have been made deferred.
--|
--| Revision 1.24.8.23  2000/07/27 19:34:14  rogers
--| Splitter_width is now initizlized to 0.
--|
--| Revision 1.24.8.20  2000/07/27 17:37:32  rogers
--| Added splitter width, as it was previously inherited from EV_SPLIT_AREA_I.
--| Mofified prune, and added copyright clause at end of file.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
