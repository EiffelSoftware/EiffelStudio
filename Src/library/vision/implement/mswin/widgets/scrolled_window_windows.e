indexing
	description: "Specially created scrolled window";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SCROLLED_WINDOW_WINDOWS

inherit

	MANAGER_WINDOWS
		redefine
			child_has_resized
		end

	SCROLLED_W_I
		export
			{NONE} all
		end

	WEL_CONTROL_WINDOW
		rename
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			height as wel_height,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			shown as wel_shown,
			parent as wel_parent,
			text as wel_text,
			text_length as wel_text_length,
			set_text as wel_set_text,
			move as wel_move,
			set_focus as wel_set_focus,
			set_capture as wel_set_capture,
			release_capture as wel_release_capture,
			item as wel_item,
			children as wel_children,
			draw_menu as wel_draw_menu,
			set_menu as wel_set_menu,
			menu as wel_menu,
			make as wel_make,
			horizontal_position as wel_horizontal_position,
			vertical_position as wel_vertical_position,
			set_horizontal_position as wel_set_horizontal_position,
			set_vertical_position as wel_set_vertical_position
		undefine
			on_right_button_up,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_destroy,
			on_key_up,
			on_key_down,
			on_set_cursor,
			on_menu_command,
			on_draw_item
		redefine
			on_horizontal_scroll,
			on_vertical_scroll,
			class_name,
			default_style
		end

	SIZEABLE_WINDOWS

creation

	make

feature {NONE} -- Initialization


	make (a_scrolled_window: SCROLLED_W; man: BOOLEAN; oui_parent: COMPOSITE) is
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			managed := man
			set_default
			private_attributes.set_width (100)
			private_attributes.set_height (100)
		end

feature -- Status setting

	realize_current is
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not exists then
				resize_for_shell
				wc ?= parent
				make_with_coordinates (wc, "", x, y, width, height)
				!! scroller.make_with_options (Current, 0, 1, 0, 1,
					granularity, granularity * 10,
					granularity, granularity * 10)
				debug ("SCROLLED_W")
					print ("SCROLLED_WINDOW_WINDOWS.realize")
				end
				show_scroll_bars
			end
		end

feature -- Status report

	working_area: WIDGET
			-- Working area of window which will
			-- be moved using scrollbars

feature -- Status setting

	set_working_area (a_widget: WIDGET) is
			-- Set working area of window to `a_widget'.
		do
			if working_area /= a_widget then
				if working_area /= Void and then working_area.realized then
					working_area.hide
				end
				working_area := a_widget
				if working_area.realized and then not working_area.shown then
					working_area.show
				end
			end
			set_scroll_range
		end

feature -- Element change

	add_move_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved
		require
			not_a_command_void: a_command /= Void
		do
			move_actions.add (Current, a_command, arg)
		end

	add_value_changed_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require
			not_a_command_void: a_command /= Void
		do
			value_changed_actions.add (Current, a_command, arg)
		end

feature {NONE} -- Implementation

	set_default is
		do
			granularity := 1
		end

	set_scroll_range is
		do
			if working_area /= Void and then exists then
                                if working_area.width > width then
					show_horizontal_scroll_bar
					set_horizontal_range (0, maximum_x)
				else
					hide_horizontal_scroll_bar
				end
                                if working_area.height > height then
					show_vertical_scroll_bar
					set_vertical_range (0, maximum_y)
				else
					hide_vertical_scroll_bar
				end
			end
		end

	on_vertical_scroll (scroll_code, a_position: INTEGER) is
		local
			position: INTEGER
		do
			if working_area /= Void then
				position := working_area.x
				if scroll_code = Sb_linedown or else scroll_code = Sb_lineright then
					position := (position + granularity).min (maximum_x)
				elseif  scroll_code = Sb_pagedown or else scroll_code = Sb_pageright then
					position := (position + granularity * 10).min (maximum_x)
				elseif  scroll_code = Sb_lineup or else scroll_code = Sb_lineleft then
					position := (position - granularity).max (minimum_x)
				elseif  scroll_code = Sb_pageup or else scroll_code = Sb_pageleft then
					position := (position - granularity * 10).max (minimum_x)
				elseif scroll_code = Sb_bottom or else scroll_code = Sb_right then
					position := maximum_x
				elseif scroll_code = Sb_top or else scroll_code = Sb_left then
					position := minimum_x
				elseif scroll_code = Sb_thumbposition then
					position := a_position
				elseif scroll_code = Sb_thumbtrack then
					position := a_position
					--- !! sc_data.make (widget_oui, position)
					move_actions.execute (Current, Void)
				end
				working_area.set_x (position)
			end
			value_changed_actions.execute (Current, Void)
		end

	on_horizontal_scroll  (scroll_code, position: INTEGER) is
		do
			value_changed_actions.execute (Current, Void)
			move_actions.execute (Current, Void)
		end

	child_has_resized is
			-- A child has resized
		do
			set_scroll_range
		end

	granularity: INTEGER
			-- Value of the amount to move the slider and modify
			-- the slide position value when a move action occurs

	maximum_x: INTEGER is
			-- Maximum scrolling value in x axis
		require
			working_area_not_void: working_area /= Void
		do
			Result := (working_area.width - width).max (1)
		ensure
			positive_result: Result > 0
		end

	minimum_x: INTEGER is 0
			-- Minimum scrolling value in x axis

	maximum_y: INTEGER is
			-- Maximum scrolling value in x axis
		require
			working_area_not_void: working_area /= Void
		do
			Result := (working_area.height - height).max (1)
		ensure
			positive_result: Result > 0
		end

	default_style: INTEGER is
		once
			Result := Ws_child + Ws_visible + Ws_border
		end

	minimum_y: INTEGER is 0
			-- Minimum scrolling value in y axis

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionScrolledWindow"
		end

end -- class SCROLLED_WINDOW_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
