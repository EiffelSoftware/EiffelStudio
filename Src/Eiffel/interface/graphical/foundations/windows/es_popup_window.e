indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_POPUP_WINDOW

inherit
	ES_WINDOW_FOUNDATIONS
		rename
			make as make_window_foundations,
			foundation_window as popup_window
		redefine
			internal_recycle,
			on_after_initialized,
			on_shown,
			on_hidden
		end

convert
	to_popup_window: {EV_POPUP_WINDOW}

feature {NONE} -- Initialization

	frozen make (a_use_drop_shadow: like has_drop_shadow)
			-- Initializes a new popup window.
			--
			-- `a_use_drop_shadow': True to set a drop shadow on the popup window, False otherwise.
		do
			has_drop_shadow := a_use_drop_shadow

				-- Create action lists
			create show_actions
			create hide_actions

				-- Do actual initialization
			make_window_foundations
		ensure
			is_initialized: is_initialized
		end

    on_after_initialized
            -- Use to perform additional creation initializations, after the UI has been created.
        do
        	Precursor {ES_WINDOW_FOUNDATIONS}

        	if has_border then
        			-- Set border color
        		update_border_color
        	end
        end

feature {NONE} -- User interface initialization

	frozen build_interface
			-- Builds the popup windows's user interface.
		local
			l_main_container: EV_VERTICAL_BOX
			l_container: EV_VERTICAL_BOX
		do
			create l_main_container
			l_main_container.set_padding (0)
			if has_border then
					-- Create border
				l_main_container.set_border_width (border_width)
				l_main_container.set_background_color (border_color)
				border_widget := l_main_container

				create l_container
				l_main_container.extend (l_container)
				popup_window.extend (l_main_container)
			else
					-- Ignore border
				l_main_container.set_border_width (popup_window_border_width)
				l_container := l_main_container
				popup_window.extend (l_container)
			end
			l_container.set_padding (0)
			l_container.set_border_width (popup_window_border_width)

			build_window_interface (l_container)

				-- Register focus actions to handle focus sensitivity. See `is_focus_sensitive' for more information
			register_action (popup_window.focus_out_actions, agent do
					if is_interface_usable then
							-- Protect the call because is the window is pointer sensitive then the
							-- window may be closed before the actions are called.
						on_focused_out
					end
				end)
		ensure then
			popup_window_attached: popup_window /= Void
			border_widget_attached: has_border implies border_widget /= Void
		end

	build_window_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the windows's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		require
			a_container_attached: a_container /= Void
			not_a_container_is_destoryed: not a_container.is_destroyed
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		deferred
		ensure
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- To be called when the window has became useless.
		do
			if is_initialized then
				if internal_popup_window /= Void then
					internal_popup_window.hide
					internal_popup_window.destroy
				end
			end
			Precursor {ES_WINDOW_FOUNDATIONS}
		ensure then
			not_is_initialized: not is_initialized
		end

feature {NONE} -- Access

	popup_window: EV_POPUP_WINDOW
			-- Actual window
		do
			Result := internal_popup_window
			if Result = Void then
				Result := create_popup_window
				auto_recycle (Result)
				internal_popup_window := Result
			end
		end

	popup_window_border_width: INTEGER
			-- Pop up window border width between the edge of the window and the containing widgets.
		do
			Result := {ES_UI_CONSTANTS}.popup_window_border_width
		ensure
			result_positive: Result > 0
		end

	border_color: EV_COLOR
			-- Pop up window border color
		require
			has_border: has_border
		once
			Result := active_border_color.twin
			Result.set_rgb ((Result.red * 0.7).max (.0), (Result.green * 0.7).max (.0), (Result.blue * 0.7).max (.0))
		ensure
			result_attached: Result /= Void
		end

	active_border_color: EV_COLOR
			-- Pop up window border color, when considered "active"
		require
			has_border: has_border
		once
			Result := colors.grid_focus_selection_color.twin
		ensure
			result_attached: Result /= Void
		end

	border_width: NATURAL_8
			-- Pop up window border width.
			-- Note: Return 0 to hide the border
		do
			Result := 1
		end

feature -- Status report

	is_focus_sensitive: BOOLEAN
			-- Indicates if the window is sensitive to focus. By default, if the window loses focus then
			-- is it closed.
		do
			Result := True
		end

	is_pointer_sensitive: BOOLEAN
			-- Indicates if the window is sensitive to having a mouse pointer. By default, if the mouse pointer leaves the
			-- window, is it remains open.
		do
			Result := False
		end

feature {NONE} -- Status report

	has_border: BOOLEAN
			-- Indicates if the window should display a border
		do
			Result := border_width > 0
		ensure
			border_width_positive: Result implies border_width > 0
		end

	has_drop_shadow: BOOLEAN
			-- Indicates if the window should use a drop shadow.
			-- Note: Due to the nature of pop up windows, this flag is used during
			--       initialization only. Once `create_popup_window' is called altering
			--       the state will not have any affect.

	has_mouse_pointer: BOOLEAN
			-- Indicates if the mouse cursor is within the bounds of the popup window

feature -- Basic operations

	show (a_x: INTEGER a_y: INTEGER) is
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		require
			is_interface_usable: is_interface_usable
		do
			popup_window.set_position (a_x, a_y)
			on_before_show
			popup_window.show
		ensure
			popup_window_is_displayed: popup_window.is_displayed
		end

	show_relative_to_widget (a_widget: !EV_WIDGET; a_x: INTEGER a_y: INTEGER) is
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		require
			is_interface_usable: is_interface_usable
		do
			show (a_widget.screen_x + a_x, a_widget.screen_y + a_y)
		ensure
			popup_window_is_displayed: popup_window.is_displayed
		end

	hide
			-- Hides popup window.
		require
			is_interface_usable: is_interface_usable
		do
			if is_recycled_on_closing then
				recycle
			else
				popup_window.hide
			end
		ensure
			not_popup_window_is_displayed: not popup_window.is_displayed
		end

feature {NONE} -- Basic operation

	update_border_color
			-- Changes the pop up window border color based on an active state.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
			has_border: has_border
		do
			if {l_colorizable: !EV_COLORIZABLE} border_widget then
				if has_mouse_pointer then
					l_colorizable.set_background_color (active_border_color)
				else
					l_colorizable.set_background_color (border_color)
				end
			end
		end

feature {NONE} -- User interface elements

	border_widget: EV_WIDGET
			-- The widget used to display the pop up window's border.

feature -- Actions

	show_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the window is shown

	hide_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the window is shown

feature {NONE} -- Action handlers

	on_before_show
			-- Called prior to the window being shown, programmatically.
		require
			is_interface_usable: is_interface_usable
		do
			--| Do nothing	
		end

	on_shown
			-- Called once the foundation widget has been shown.

		do
			Precursor {ES_WINDOW_FOUNDATIONS}

				-- Hook up to application pointer mtion actions
			register_action (ev_application.pointer_motion_actions, agent on_application_pointer_motion)
		end

	on_hidden
			-- Called once the foundation widget has been hidden.
		do
			Precursor {ES_WINDOW_FOUNDATIONS}

				-- Remove application pointer motion actions
			unregister_action (ev_application.pointer_motion_actions, agent on_application_pointer_motion)
		end

	on_pointer_enter
			-- Called when the mouse cursor enters the pop up window.
		require
			is_interface_usable: is_interface_usable
			not_has_mouse_pointer: not has_mouse_pointer
		do
			has_mouse_pointer := True
			update_border_color
		ensure
			has_mouse_pointer: has_mouse_pointer
		end

	on_pointer_leave
			-- Called when the mouse cursor leaves the pop up window.
		require
			is_interface_usable: is_interface_usable
			has_mouse_pointer: has_mouse_pointer
		do
			has_mouse_pointer := False

				-- We still update the border even if the dialog is going to be hidden because of window reuse.
			update_border_color

			if is_pointer_sensitive then
				hide
			end
		ensure
			not_has_mouse_pointer: not has_mouse_pointer
		end

	on_focused_out
			-- Called when the window loses focus
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if is_focus_sensitive and then is_shown then
				hide
			end
		end

	on_application_pointer_motion (a_widget: EV_WIDGET; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- Called when the pointer moves during execution of the application.
			--
			-- `a_widget': The widget the move was performed on.
			-- `a_screen_x': Position of mouse cusor on the x-axis.
			-- `a_screen_y': Position of mouse cusor on the y-axis.
		require
			a_screen_x_non_negative: a_screen_x >= 0
			a_screen_y_non_negative: a_screen_y >= 0
		local
			l_window: like popup_window
			l_sx, l_sy: INTEGER
			l_in_window: BOOLEAN
		do
			if is_initialized then
				if a_widget /= Void then
						-- If no widget is passed then the motion was not on the window.
					l_window := popup_window
					l_sx := l_window.screen_x
					if a_screen_x >= l_sx and then a_screen_x <= l_sx + l_window.width then
						l_sy := l_window.screen_y
						l_in_window := a_screen_y >= l_sy and then a_screen_y <= l_sy + l_window.height
					end
				end

				if l_in_window /= has_mouse_pointer then
					if l_in_window then
							-- Ensure we are processing this window!
						l_in_window := helpers.widget_top_level_window (a_widget, False) = popup_window
					end

					if l_in_window then
						if not has_mouse_pointer then
							on_pointer_enter
						end
					else
						if has_mouse_pointer then
							on_pointer_leave
						end
					end
				end
			end
		end

feature {NONE} -- Internal action handlers

	frozen internal_on_pointer_enter
			-- Called by the propagated action when every widget recieves a enter actions
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if not has_mouse_pointer then
					-- Ensures enter is called only once.
				on_pointer_enter
			end
		end

feature -- Conversion

	to_popup_window: EV_POPUP_WINDOW
			-- Converts Current to an actual EiffelVision2 dialog
		require
			is_interface_usable: is_interface_usable
		do
			Result := popup_window
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

feature {NONE} -- Factory

	create_popup_window: !EV_POPUP_WINDOW
			-- Creates an implementation popup window
		require
			is_interface_usable: is_interface_usable
			is_initializing: is_initializing
		do
			if has_drop_shadow then
				create Result.make_with_shadow
			else
				create Result
			end
			register_action (Result.show_actions, agent show_actions.call ([]))
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

feature {NONE} -- Internal implementation cache

	internal_popup_window: like popup_window
			-- Cached version of `popup_window'
			-- Note: Do not use directly.

invariant
	border_widget_attached: has_border implies border_widget /= Void

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
