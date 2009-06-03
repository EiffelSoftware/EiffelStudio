note
	description: "Specially created scrolled window"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

create
	make

feature {NONE} -- Initialization

	make (a_scrolled_window: SCROLLED_W; man: BOOLEAN; oui_parent: COMPOSITE)
		do
			create private_attributes
			parent ?= oui_parent.implementation
			managed := man
			set_default
			private_attributes.set_width (100)
			private_attributes.set_height (100)
		end

	realize_current
			-- Realize current widget.
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not exists then
				resize_for_shell
				wc ?= parent
				make_with_coordinates (wc, "", x, y, width, height)
				create scroller.make_with_options (Current, 0, 1, 0, 1,
					granularity, granularity * 10,
					granularity, granularity * 10)
				realized := True
			end
		end

feature -- Initialization

	realize
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

	add_move_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute when slide
			-- is moved
		require
			not_a_command_void: a_command /= Void
		do
			move_actions.add (Current, a_command, arg)
		end

	add_value_changed_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require
			not_a_command_void: a_command /= Void
		do
			value_changed_actions.add (Current, a_command, arg)
		end

	set_working_area (a_widget: WIDGET)
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

	unrealize
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

	update_scrolling
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

	resize_for_working_area
			-- Set size to working area
		do
			if working_area /= Void and then working_area.realized then
				if exists then
					set_form_width (working_area.width)
					set_form_height (working_area.height)
				end
			end
		end

	on_size (hit_code, a_width, a_height: INTEGER)
			-- Respond to a size message.
		do
			update_scrolling
			resize_actions.execute (Current, Void)
		end

	horizontal_update (inc, position: INTEGER)
			-- Respond to an horizontal update of the scroller.
		local
			cd: SCROLLING_DATA_WINDOWS
		do
			if working_area /= Void then
				wel_set_horizontal_position (position)
				working_area.set_x (- position)
				create cd.make (widget_oui, 0, position, False)
				value_changed_actions.execute (Current, cd)
			end
		end

	vertical_update (inc, position: INTEGER)
			-- Respond to a vertical update of the scroller.
		local
			cd: SCROLLING_DATA_WINDOWS
		do
			if working_area /= Void then
				wel_set_vertical_position (position)
				working_area.set_y (- position)
				create cd.make (widget_oui, 0, position, True)
				value_changed_actions.execute (Current, cd)
			end
		end

	set_default
			-- Set default values for current widget.
		do
			granularity := 1
		end

	set_scroll_range
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
					set_horizontal_range (0, working_area.width)
					show_horizontal_scroll_bar
				else
					hide_horizontal_scroll_bar
				end
				if has_vertical_bar then
					set_vertical_range (0, working_area.height)
					show_vertical_scroll_bar
				else
					hide_vertical_scroll_bar
				end
			end
		end

	set_scroll_position
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

	child_has_resized
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

	default_style: INTEGER
		do
			Result := Ws_child + Ws_visible + Ws_border
		end

	default_ex_style: INTEGER
		do
			Result := Ws_ex_clientedge
		end

	class_name: STRING_32
			-- Class name
		once
			Result := "EvisionScrolledWindow"
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




end -- class SCROLLED_W_IMP

