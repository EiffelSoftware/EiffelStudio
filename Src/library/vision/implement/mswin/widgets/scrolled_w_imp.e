indexing
	description: "Specially created scrolled window";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SCROLLED_W_IMP

inherit

	MANAGER_IMP
		redefine
			child_has_resized,
			unrealize,
			realized,
			realize,
			on_size
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
			class_background,
			background_brush,
			on_show,
			on_hide,
			on_size,
			on_move,
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
			class_name,
			default_style,
			default_ex_style,
			horizontal_update,
			vertical_update,
			on_size
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

	realize_current is
			-- Realize current widget.
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
				realized := True
			end
		end

feature -- Initialization

	realize is
			-- Realize current widget and children.
		do
			if not realized then
				realize_current
				realize_children
				shown := true
			--	resize_for_working_area
				update_scrolling
			end
				-- set initial focus
			if initial_focus /= void then
				initial_focus.wel_set_focus
			end			
		end

feature -- Access

	working_area: WIDGET
			-- Working area of window which will be moved using scrollbars

feature -- Status report

	realized: BOOLEAN
			-- Is current widget realized?

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
			if exists then
				working_area.set_x_y (0, 0)
				update_scrolling
			end
		end

feature -- Removal

	unrealize is
			-- Unrealize current composite and its children.
		local
			unrealize_list: LIST [WIDGET_IMP]
		do
			unrealize_list := children_list
			from
				unrealize_list.start
			until
				unrealize_list.after
			loop
				if unrealize_list.item.realized then
					unrealize_list.item.unrealize
				end
				unrealize_list.forth
			end
			if exists then
				wel_destroy
			end
			realized := False
				-- This will destroy all children as well
		end

feature {NONE} -- Implementation

	update_scrolling is
			-- Initialize working_area
		do
				set_scroll_range
				set_scroll_position
				if scroller /= Void then
					scroller.set_horizontal_line (client_rect.width // 4)
					scroller.set_horizontal_page (client_rect.width)
					scroller.set_vertical_line (client_rect.height // 4)
					scroller.set_vertical_page (client_rect.height)
				end
		end

	resize_for_working_area is
			-- Set size to working area
		do
			if working_area /= Void and then working_area.realized then
				if exists then
					set_form_width (working_area.width)
					set_form_height (working_area.height)
				end
			end
		end

	on_size (hit_code, a_width, a_height: INTEGER) is
			-- Respond to a size message.
		do
			update_scrolling
			resize_actions.execute (Current, Void)
		end

	horizontal_update (inc, position: INTEGER) is
			-- Respond to an horizontal update of the scroller.
		local
			cd: SCROLLING_DATA_WINDOWS
		do
			if working_area /= Void then
				wel_set_horizontal_position (position)
				working_area.set_x (- position)
				!! cd.make (widget_oui, 0, position, False)
				value_changed_actions.execute (Current, cd)
			end
		end

	vertical_update (inc, position: INTEGER) is
			-- Respond to a vertical update of the scroller.
		local
			cd: SCROLLING_DATA_WINDOWS
		do
			if working_area /= Void then
				wel_set_vertical_position (position)
				working_area.set_y (- position)
				!! cd.make (widget_oui, 0, position, True)
				value_changed_actions.execute (Current, cd)
			end
		end

	set_default is
			-- Set default values for current widget.
		do
			granularity := 1
		end

	set_scroll_range is
			-- Set the correct scroll range.
		require
			exists: exists
		local
			has_vertical_bar: BOOLEAN
			has_horizontal_bar: BOOLEAN
		do
			if working_area /= Void and then realized then
				has_horizontal_bar := (working_area.width > width)
				has_vertical_bar := (working_area.height  > height)
				if has_horizontal_bar then
					has_vertical_bar := (working_area.height > height - horizontal_scroll_bar_arrow_height)
				end
				if has_vertical_bar then
					has_horizontal_bar := (working_area.width > width - vertical_scroll_bar_arrow_width)
				end
				if has_horizontal_bar then
					has_vertical_bar := (working_area.height > height - horizontal_scroll_bar_arrow_height)
				end
				if has_horizontal_bar then
					if has_vertical_bar then
						maximum_x := working_area.width - width + vertical_scroll_bar_arrow_width + 2
					else
						maximum_x := working_area.width - width + 2
					end
					set_horizontal_range (0, maximum_x)
					show_horizontal_scroll_bar
				else
					hide_horizontal_scroll_bar
					working_area.set_x_y (0, working_area.y)
					maximum_x := 0
				end
				if has_vertical_bar then
					if has_horizontal_bar then
						maximum_y := working_area.height - height + horizontal_scroll_bar_arrow_height + 2
					else
						maximum_y := working_area.height - height + 2
					end
					set_vertical_range (0, maximum_y)
					show_vertical_scroll_bar
				else
					hide_vertical_scroll_bar
					working_area.set_x_y (working_area.x, 0)
					maximum_y := 0
				end
			end
		end

	set_scroll_position is
			-- Set the appropriate scroll_position.
		require
			exists: exists
		do
			if working_area /= Void and then realized then
				if has_horizontal_scroll_bar then
					if has_vertical_scroll_bar then
						working_area.set_x_y (working_area.x.max (width -
							vertical_scroll_bar_arrow_width - working_area.width).min (0),
							working_area.y)
					else
						working_area.set_x_y (working_area.x.max (width -
							working_area.width).min (0),
							working_area.y)
					end
					wel_set_horizontal_position ( - working_area.x)
				end
				if has_vertical_scroll_bar then
					if has_horizontal_scroll_bar then
						working_area.set_x_y (working_area.x,
							working_area.y.max (height -
							horizontal_scroll_bar_arrow_height - working_area.height).min (0))
					else
						working_area.set_x_y (working_area.x,
							working_area.y.max (height -
							working_area.height).min (0))						
					end
					wel_set_vertical_position ( - working_area.y)
				end
			end
		end

	child_has_resized is
			-- A child has resized
		do
			if exists then
				set_scroll_range
				set_scroll_position
			end
		end

	granularity: INTEGER
			-- Value of the amount to move the slider and modify
			-- the slide position value when a move action occurs

	minimum_x: INTEGER is 0
			-- Minimum scrolling value in x axis

	maximum_x: INTEGER
			-- Maximum scrolling value in x axis

	minimum_y: INTEGER is 0
			-- Minimum scrolling value in y axis

	maximum_y: INTEGER
			-- Maximum scrolling value in x axis

	default_style: INTEGER is
		do
			Result := Ws_child + Ws_visible + Ws_border
		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_clientedge
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionScrolledWindow"
		end

end -- class SCROLLED_W_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------

