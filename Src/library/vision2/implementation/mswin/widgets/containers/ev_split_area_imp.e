note
	description:
		"Contains a maximum of two widgets, one on each side of an adjustable%
			%separator. If only one widget is contained then the separator is%
			%hidden."
	legal: "See notice at end of class."
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
			make,
			enable_sensitive,
			disable_sensitive,
			on_set_cursor,
			next_tabstop_widget
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		undefine
			on_wm_dropfiles
		redefine
			top_level_window_imp,
			on_erase_background,
			default_style
		end

	EV_SYSTEM_PEN_IMP

	WEL_ROP2_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			ev_wel_control_container_make
			Precursor {EV_CONTAINER_IMP}
			first_expandable := True
			second_expandable := True
		end

feature {EV_ANY_I} -- Status Setting

	enable_sensitive
			-- Set `item' sensitive to user actions.
		do
			if attached first as l_first and then not l_first.implementation.internal_non_sensitive then
				l_first.enable_sensitive
			end
			if attached second as l_second and then not l_second.implementation.internal_non_sensitive then
				l_second.enable_sensitive
			end
			Precursor {EV_CONTAINER_IMP}
		end

	disable_sensitive
			-- Set `item' insensitive to user actions.
		do
			if attached first as l_first then
				l_first.implementation.disable_sensitive
			end
			if attached second as l_second then
				l_second.implementation.disable_sensitive
			end
			Precursor {EV_CONTAINER_IMP}
		end

feature {NONE} -- Implementation

	split_position: INTEGER
			--
		do
			if first /= Void and second /= Void then
				Result := internal_split_position.max (minimum_split_position).min (maximum_split_position)
			else
				Result := internal_split_position
			end
		end

	internal_split_position: INTEGER
		-- Position of the splitter in pixels.
		-- For a vertical split area, the position is the top of the splitter.
		-- For a horizontal split area, the position is the left
		-- of the splitter.

	is_control_in_window (hwnd_control: POINTER): BOOLEAN
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		local
			l_widget_imp: detachable EV_WIDGET_IMP
		do
			if hwnd_control = wel_item then
				Result := True
			elseif not Result and first /= Void then
				l_widget_imp := first_imp
				check l_widget_imp /= Void end
				Result := l_widget_imp.is_control_in_window (hwnd_control)
			elseif not Result and second /= Void then
				l_widget_imp := second_imp
				check l_widget_imp /= Void end
				Result := l_widget_imp.is_control_in_window (hwnd_control)
			end
		end

	prune (v: like item)
			-- Remove one occurrence of `v' if any.
		local
			v_imp: detachable EV_WIDGET_IMP
		do
			is_maximum_split_position_computed := False
			if v /= Void then
				if v = first then
					v_imp := first_imp
					first := Void
					second_expandable := True
					first_expandable := True
						-- Hide the splitter as `Current' only
					--internal_splitter_width := 0
					set_split_position (0)
				elseif v = second then
					v_imp := second_imp
					second := Void
					first_expandable := True
					second_expandable := True
					--internal_splitter_width := 0
					set_split_position (maximum_split_position)
				end
					-- If `v_imp' not Void (meaning `v' is being removed).
				if v_imp /= Void then
						-- Unparent `v_imp' from `Current'.
					v_imp.set_parent_imp (Void)
						-- Call `remove_item_actions' for `Current'.
					remove_item_actions.call ([v_imp.attached_interface])
						-- Reflect the changes by updating the position of the
						-- splitter and laying out the widgets.
					update_split_position
					notify_change (Nc_minsize, Current, False)
				end
			end
		end

	set_split_position (a_position: INTEGER)
			-- Assign `a_position' to split position and layout the
			-- widgets accordingly.
		do
			internal_split_position := a_position
			layout_widgets (width, height, True)
		end

	disable_item_expand (v: EV_WIDGET)
			-- When `Current' is resized, do not resize `v'.
		do
			if v = first then
				first_expandable := False
			elseif v = second then
				second_expandable := False
			end
		end

	enable_item_expand (v: EV_WIDGET)
			-- When `Current' is resized, resize `an_item' respectively.
		do
			if v = first then
				first_expandable := True
			elseif v = second then
				second_expandable := True
			end
		end

	minimum_split_position: INTEGER
			-- Minimum position in pixels allowed for the splitter.
		deferred
		end

	maximum_split_position: INTEGER
			-- Maximum position in pixels allowed for the splitter.
		deferred
		end

	is_maximum_split_position_computed: BOOLEAN
			-- To prevent recursion when computing the maximum position of the splitter.

	layout_widgets (a_width, a_height: INTEGER; originator: BOOLEAN)
		deferred
		end

	set_click_position (x_pos, y_pos: INTEGER)
			-- Assign coordinate relative to click position on splitter to
			-- `click_relative_position'.
		deferred
		end

	is_child (v: EV_WIDGET_IMP): BOOLEAN
			-- Is `v' a child of `Current'?
		do
			Result := v.interface = first or v.interface = second
		end

	update_split_position
			-- Set splitter to a valid position and redraw if necessary.
		do
			internal_split_position := internal_split_position.max (minimum_split_position)
			internal_split_position := internal_split_position.min (maximum_split_position)
		end

feature {NONE} -- Implementation

	first_imp: detachable EV_WIDGET_IMP
			-- `Result' is implementation of first.
		do
			if attached first as l_first then
				Result ?= l_first.implementation
				check
					implementation_of_first_not_void: Result /= Void
				end
			end
		end

	second_imp: detachable EV_WIDGET_IMP
			-- `Result' is implementation of second.
		do
			if attached second as l_second then
				Result ?= l_second.implementation
				check
					implementation_of_second_not_void: Result /= Void
				end
			end
		end

	on_set_cursor (hit_code: INTEGER)
			-- Called when a `Wm_setcursor' message is received.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		local
			wel_point: WEL_POINT
			l_is_cursor_on_splitter: BOOLEAN
		do
				-- We must check that we are not currently executing
				-- a pick/drag as if we are, we should not do anything.
				-- This is because the setting of the cursor should only
				-- be performed by us, not windows when in transport.
			if application_imp.pick_and_drop_source /= Void then
				disable_default_processing
			elseif (hit_code = ({WEL_HT_CONSTANTS}.Htnowhere) or else hit_code = ({WEL_HT_CONSTANTS}.Htclient)) then
					--| We need to check that the cursor is currently over `Current'.
					--| We used to query `cursor_on_widget.item', however, this is only
					--| updated when in `on_mouse_move' which is executed after this current
					--| feature. That meant that when leaving `Current', the cursor would
					--| not always be updated correctly.
				create wel_point.make (0, 0)
				wel_point.set_cursor_position
				wel_point.screen_to_client (Current)

				if attached {EV_HORIZONTAL_SPLIT_AREA_IMP} Current then
					l_is_cursor_on_splitter := position_is_over_splitter (wel_point.x)
				else
					l_is_cursor_on_splitter := position_is_over_splitter (wel_point.y)
				end

				if l_is_cursor_on_splitter then
					class_cursor.set
					set_message_return_value (to_lresult (1))
					disable_default_processing
				elseif cursor_pixmap /= Void then
					internal_on_set_cursor
					set_message_return_value (to_lresult (1))
					disable_default_processing
				end
			end
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- <Precursor>
		local
			l_first_visible, l_second_visible: BOOLEAN
		do
			l_first_visible := attached first_imp as l_first and then l_first.is_show_requested
			l_second_visible := attached second_imp as l_second and then l_second.is_show_requested
			if l_first_visible xor l_second_visible then
					-- Only one children is visible, therefore there is nothing to clear.
				disable_default_processing
				set_message_return_value (to_lresult (1))
			else
				if l_first_visible and l_second_visible then
						-- Both children are visible, we just need to erase background where
						-- the splitter is. The children will take care of redrawing their background.
						-- We simply do that by shrinking `invalid_rect'.
					if attached {EV_HORIZONTAL_SPLIT_AREA_IMP} Current then
						invalid_rect.set_rect (internal_split_position, -1, internal_split_position + splitter_width, height)
					else
						invalid_rect.set_rect (-1, internal_split_position, width, internal_split_position + splitter_width)
					end
				end
					-- If the above code is not executed, the whole content will be cleared
					-- as there is no items in the split area.
				Precursor (paint_dc, invalid_rect)
			end
		end

	default_style: INTEGER
			-- <Precursor>
		do
				-- We do not use `Ws_clipchildren' because we can do the job ourself.
			Result := Ws_child | Ws_visible | ws_clipsiblings
		end

	invert_rectangle
		(a_dc: WEL_DC; a_left, a_top, a_right, a_bottom: INTEGER)
			-- Invert the rectangular zone defined by
			-- `a_left', `a_top', `a_right', `a_bottom'
			-- on `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
		local
			old_rop2: INTEGER
		do
			if attached splitter_brush as l_splitter_brush then
				a_dc.get
				old_rop2 := a_dc.rop2
				a_dc.set_rop2 (R2_xorpen)
				a_dc.select_brush (l_splitter_brush)
				a_dc.rectangle (a_left, a_top, a_right, a_bottom)
				a_dc.set_rop2 (old_rop2)
				a_dc.unselect_brush
				a_dc.release
			end
		end

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			widget_imp: detachable EV_WIDGET_IMP
		do
			top_level_window_imp := a_window
			if attached first as l_first then
				widget_imp ?= l_first.implementation
				check
					widget_implementation_not_void: widget_imp /= Void
				end
				widget_imp.set_top_level_window_imp (a_window)
			end
			if attached second as l_second then
				widget_imp ?= l_second.implementation
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

	splitter_width: INTEGER = 5
			-- `Result' is space in pixels the visible separator should occupy.

	click_relative_position: INTEGER
			-- Mouse coordinate relative to start of splitter when splitter
			-- is clicked on.

	position_is_over_splitter (a_pos: INTEGER): BOOLEAN
			-- Does `a_pos' fall within the splitter?
		deferred
		end

	index_of_child (child: EV_WIDGET_IMP): INTEGER
			-- `Result' is 1 based index of `child' within `Current'.
		do
			if first_imp = child then
				Result := 1
			else
				Result := 2
			end
		end

	next_tabstop_widget (start_widget: EV_WIDGET; search_pos: INTEGER; forwards: BOOLEAN): EV_WIDGET_IMP
			-- Return the next widget that may by tabbed to as a result of pressing the tab key from `start_widget'.
			-- `search_pos' is the index where searching must start from for containers, and `forwards' determines the
			-- tabbing direction. If `search_pos' is less then 1 or more than `count' for containers, the parent of the
			-- container must be searched next.
		require else
			valid_search_pos: search_pos >= 0 and search_pos <= count + 1
		local
			w: detachable EV_WIDGET_IMP
			container: detachable EV_CONTAINER
			l_result: detachable EV_WIDGET_IMP
		do
			l_result := return_current_if_next_tabstop_widget (start_widget, search_pos, forwards)
			if l_result = Void and is_sensitive then
					-- Otherwise iterate through children and search each but only if
					-- we are sensitive. In the case of a non-sensitive container, no
					-- children should recieve the tab stop.
				if search_pos >= 1 and search_pos <= count then
					if forwards then
						if search_pos = 1 and then attached first as l_first then
							w ?= l_first.implementation
							check w /= Void end
							l_result := w.next_tabstop_widget (start_widget, 1, forwards)
						end
						if l_result = Void and then attached second as l_second then
							w ?= l_second.implementation
							check w /= Void end
							l_result := w.next_tabstop_widget (start_widget, 1, forwards)
						end
					else
						if search_pos = 2 and attached second as l_second then
							w ?= l_second.implementation
							check w /= Void end
							container ?= w.interface
							if container /= Void then
								l_result := w.next_tabstop_widget (start_widget, container.count, forwards)
							else
								l_result := w.next_tabstop_widget (start_widget, 1, forwards)
							end
						end
						if l_result = Void and then attached first as l_first then
							w ?= l_first.implementation
							check w /= Void end
							container ?= w.interface
							if container /= Void then
								l_result := w.next_tabstop_widget (start_widget, container.count, forwards)
							else
								l_result := w.next_tabstop_widget (start_widget, 1, forwards)
							end
						end
					end
				end
			end
			if l_result = Void then
				l_result := next_tabstop_widget_from_parent (start_widget, search_pos, forwards)
			end
			check l_result /= Void end
			Result := l_result
		end

feature {NONE} -- Implementation

	wel_system_parameters_info: WEL_SYSTEM_PARAMETERS_INFO
			-- Used for determining
		once
			create Result
		end

	use_realtime_splitter_positioning: BOOLEAN
			-- Will `Current' use realtime splitter positioning
			-- Default is False until sizing optimizations can be found for containers with many descendents.
		do
			if application_imp.ctrl_pressed then
				Result := True
			else
--				Result := wel_system_parameters_info.has_drag_full_windows
			end
		end

	splitter_string_bitmap: STRING
			-- `Result' is a STRING used to generate the splitter
			-- brush used in the redrawing of the splitter while
			-- movement is underway.
		local
			i: INTEGER
		once
				-- We create a bitmap 8x8 which follows the pattern:
				-- black / white / black... on one line
				-- and white / black / white... on the other.
				-- The hexa number 0xAA correspond to the first line
				-- and the 0x55 to the other line. Since Windows expects
				-- value aligned on DWORD, we have gap in our strings.

				-- Creating data of bitmaps
			create Result.make (16)
			Result.fill_blank
			from
				i := 1
			until
				i > 16
			loop
				Result.put ((0x000000AA).to_character_8, i)
				Result.put ((0x00000055).to_character_8, i + 2)
				i := i + 4
			end
		ensure
			result_not_void: Result /= Void
		end

	splitter_brush: detachable WEL_BRUSH
		-- Brush used to redraw the splitter while it is moving.
		-- Created and destroyed at the start and end of splitter resizing.
		-- Prevents keeping a reference to GDI objects when not required.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SPLIT_AREA note option: stable attribute end

feature {NONE} -- WEL internal

	Wel_idc_constants: WEL_IDC_CONSTANTS
			-- Default Cursors constants
		once
			create Result
		end

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

end -- class EV_SPLIT_AREA_IMP
