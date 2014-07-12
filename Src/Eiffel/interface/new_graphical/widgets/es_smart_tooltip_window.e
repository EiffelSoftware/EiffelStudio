note
	description: "[
					A window to display tooltip with a timeout.
					Detective of the mouse position to decide the hiding timing.
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SMART_TOOLTIP_WINDOW

inherit
	ES_POPUP_WINDOW
		rename
			make as make_popup_button_window
		redefine
			on_before_show,
			active_border_color,
			border_color,
			is_pointer_sensitive,
			on_pointer_enter,
			on_pointer_leave,
			on_cancel_popup,
			hide,
			ensure_popup_window_visible_on_screen
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Init with nothing
		do
			make_popup_button_window (False)
				-- Default timeout
			hide_timeout := 8_000
		end

	build_window_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the popup window's user interface.
		local
			l_box: EV_HORIZONTAL_BOX
		do
			widget_container := a_container

			create l_box

				-- Padding
			l_box.extend (create {EV_CELL})

			a_container.extend (l_box)
			a_container.disable_item_expand (l_box)

				-- Propagate background color to set widget structure.
			propagate_colors (a_container, Void, background_color, Void)
		ensure then
			widget_container_set: widget_container = a_container
		end

feature {NONE} -- Access

	background_color: EV_COLOR
			-- Pop up window background color, as well as the token background color
		do
			Result := normal_text_token.background_color
		ensure
			result_attached: Result /= Void
		end

	border_color: EV_COLOR
			-- <Precursor>
		once
			create Result.make_with_8_bit_rgb (58, 123, 252)
		end

	active_border_color: EV_COLOR
			-- <Precursor>
		once
			create Result.make_with_8_bit_rgb (58, 123, 252)
		end

	normal_text_token: EDITOR_TOKEN_TEXT
			-- Token used for getting foreground and background colors.
		once
			create Result.make ("")
		end

feature -- Access

	popup_widget: EV_WIDGET
			-- Widget displayed when the popup button is pressed
		do
			Result := internal_popup_widget
		ensure
			not_result_is_destroyed: Result /= Void implies not Result.is_destroyed
		end

feature -- Element change

	set_popup_widget (a_widget: like popup_widget)
			-- Assign popup widget to be displayed when the popup button is select
			-- Note: Already displayed widgets will have the UI replaced and reshown.
			--
			-- `a_widget': The widget to display in the popup window, when the popup up widget is requested to be shown.
			--             Use Void to remove the widget.
		require
			a_widget_not_void: a_widget /= Void
		do
			internal_popup_widget := a_widget
			on_popup_widget_show_requested

				-- Restart the timer
			if is_shown and popup_widget_activate_timer /= Void then
				setup_hide_timer
			end
		end

	set_hide_timeout (a_timeout: INTEGER)
			-- Set time to hide the window.
		require
			a_timeout_not_negative: a_timeout >= 0
		do
			hide_timeout := a_timeout
		ensure
			hide_timeout_set: hide_timeout = a_timeout
		end

feature -- Status report

	is_recycled_on_close: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

	is_pointer_sensitive: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	hide
			-- Hides the popup window.
		do
			Precursor
			destroy_hide_timer
		end

feature {NONE} -- Action handlers

	on_popup_widget_show_requested
			-- Called when a show of the popup widget is requested.
		local
			l_widget: like popup_widget
		do
			l_widget := popup_widget
			if l_widget.has_parent then
				l_widget.show
			else
					-- If `widget_container' has no widget, we extend it with
					-- `l_widget' (the `popup_widget'). If it already has one
					-- and it is already the same, we do nothing to avoid flickering,
					-- otherwise we remove and add the widget (which might cause some
					-- flickering).
				if not widget_container.is_empty then
					if widget_container.first /= l_widget then
						widget_container.wipe_out
						widget_container.extend (l_widget)
					end
				else
					widget_container.extend (l_widget)
				end
				if not widget_container.is_displayed then
					widget_container.show
				end
			end
		end

	on_before_show
			-- <Precursor>
		do
			Precursor {ES_POPUP_WINDOW}
			setup_hide_timer
		end

	on_pointer_leave
			-- Called when the mouse cursor leave the pop up window.
		do
			Precursor {ES_POPUP_WINDOW}
			setup_hide_timer
		end

	on_pointer_enter
			-- Called when the mouse cursor enter the pop up window.
		do
			Precursor {ES_POPUP_WINDOW}
			destroy_hide_timer
		end

	on_cancel_popup
			-- <Precursor>
		do
		end

feature {NONE} -- User interface elements

	widget_container: EV_VERTICAL_BOX
			-- The container to extend a popup widget with.

	hide_timeout: INTEGER
			-- Timeout to hide the tooltip

feature {NONE} -- Basic operations

	setup_hide_timer
			-- Set up the timer to hide
		do
			destroy_hide_timer
			create popup_widget_activate_timer
			popup_widget_activate_timer.set_interval (hide_timeout)
			popup_widget_activate_timer.actions.extend (agent hide_timer_action)
		end

	hide_timer_action
			-- On hide timer called
		local
			l_screen: EV_SCREEN
			l_p: EV_COORDINATE
			l_w: like popup_window
		do
			if is_interface_usable and then is_shown then
				create l_screen
				l_p := l_screen.pointer_position
				l_w := popup_window
				if
					l_p.x >= l_w.screen_x and then l_p.x <= l_w.screen_x + l_w.width and then
					l_p.y >= l_w.screen_y and then l_p.y <= l_w.screen_y + l_w.height
				then
				else
						-- Hide the window on timeout if mouse cursor is not in the window.
					popup_window.hide
					destroy_hide_timer
				end
			else
				destroy_hide_timer
			end
		end

	destroy_hide_timer
			-- Destroy the hide timer
		do
			if popup_widget_activate_timer /= Void and then not popup_widget_activate_timer.is_destroyed then
				popup_widget_activate_timer.destroy
				popup_widget_activate_timer := Void
			end
		end

feature {NONE} -- Implementation

	ensure_popup_window_visible_on_screen
			-- Ensures the popup window is visible on screen, given the bounding edges
		do
				-- Let the window be smallest possible and grow to fit new widget's size.
			popup_window.resize_actions.block
			popup_window.set_size (popup_window.minimum_width, popup_window.minimum_height)
			popup_window.resize_actions.resume
			Precursor
		end

	popup_widget_activate_timer: EV_TIMEOUT
			-- Timer to hide the window

	internal_popup_widget: like popup_widget
			-- Cached version of `popup_widget'

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
