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
						-- Call `remove_item_actions' for `Current'.
					remove_item_actions.call ([v_imp.interface])
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
		local
			bitmap: WEL_BITMAP
			string_bitmap: STRING
			i: INTEGER
		once
				-- We create a bitmap 8x8 which follows the pattern:
				-- black / white / black... on one line
				-- and white / black / white... on the other.
				-- The hexa number 0xAA correspond to the first line
				-- and the 0x55 to the other line. Since Windows expects
				-- value aligned on DWORD, we have gap in our strings.

				-- Creating data of bitmaps
			create string_bitmap.make (16)
			string_bitmap.fill_blank
			from
				i := 1
			until
				i > 16
			loop	
				string_bitmap.put ((0xAA).to_character, i)
				string_bitmap.put ((0x55).to_character, i + 2)
				i := i + 4
			end

				-- Then, we create the brush
			create bitmap.make_direct (8, 8, 1, 1, string_bitmap)
			create Result.make_by_pattern (bitmap)
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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

