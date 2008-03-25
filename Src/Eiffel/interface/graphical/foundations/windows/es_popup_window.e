indexing
	description: "[
		A foundation popup window, with customizable behavior.
		
		The foundation provides built-in behavior for closing the window on focus-out or pointer leave actions based on the respective
		`is_focus_sensitive' and `is_pointer_sensitive'. Support actions such as `execute_unfocusing_action' can be used to prevent
		lose of focus senstivity for focus sensitive windows.
		
		Also supported is the notion of window-commit and window-cancel operations. A commited window is one that is commited using `hide_commit'
		or via a widget calling `hide_commit'. `is_committed_on_close' is set based on `hide_cancel' and `hide_commit'. By default pressing CTRL+ENTER
		will perform a commit hide. Pressing ESC or hiding due to sensitivity behavior will perform a cancel hide.
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
			is_shown,
			on_after_initialized,
			on_shown,
			on_hidden,
			on_handle_key
		end

convert
	popup_window: {EV_POPUP_WINDOW}

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

				-- Register visiblity actions
			register_action (popup_window.resize_actions, agent (a_ia_x: INTEGER; a_ia_y: INTEGER; a_ia_w: INTEGER; a_ia_h: INTEGER)
				do
					if is_interface_usable and then not is_allowed_off_screen and then is_shown then
						ensure_popup_window_visible_on_screen
					end
				end)
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
			-- `a_container': The dialog's container where the user interface elements should be extended.
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

	internal_recycle
			-- To be called when the window has became useless.
		do
			if is_initialized then
				if internal_popup_window /= Void and not internal_popup_window.is_destroyed then
					internal_popup_window.hide
					internal_popup_window.destroy
				end
			end
			Precursor {ES_WINDOW_FOUNDATIONS}
		end

feature -- Access

	popup_window: EV_POPUP_WINDOW
			-- Actual popup window
		do
			Result := internal_popup_window
			if Result = Void then
				Result := create_popup_window
				internal_popup_window := Result
			end
		end

feature {NONE} -- Access

	popup_window_border_width: INTEGER
			-- Pop up window border width between the edge of the window and the containing widgets.
		do
			Result := {ES_UI_CONSTANTS}.popup_window_border_width
		ensure
			result_positive: Result > 0
		end

	border_color: EV_COLOR
			-- Pop up window border color.
		require
			has_border: has_border
		once
			Result := active_border_color.twin
			Result.set_rgb (.6, .6, .7)
		ensure
			result_attached: Result /= Void
		end

	active_border_color: EV_COLOR
			-- Pop up window border color, when considered "active".
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

	has_mouse_pointer: BOOLEAN
			-- Indicates if the mouse cursor is within the bounds of the popup window.

	is_shown: BOOLEAN
			-- Indicates if foundataion tool is current visible.
		do
			Result :=  is_interface_usable and then
				is_initialized and then
				internal_popup_window /= Void and then
				not internal_popup_window.is_destroyed and then
				internal_popup_window.is_displayed
		end

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

	is_allowed_off_screen: BOOLEAN
			-- Indicates if the window is allow to be displayed off-screen.
			-- Note: This is used during initialization to determine whether or not to add the actions to ensure the window is always presented
			--       on screen.
		do
			Result := False
		end

	is_committed_on_closed: BOOLEAN
			-- Indicates if the window was committed when closed, based on a call to `on_commit' or `on_cancel'.

feature {NONE} -- Status report

	has_border: BOOLEAN
			-- Indicates if the window should display a border.
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

	is_executing_unfocused_action: BOOLEAN
			-- Indicates if an action is being performed that will cause the popup window to loose focus.

feature {NONE} -- Positioning

	requested_x_position: INTEGER
			-- Requested show X position

	requested_y_position: INTEGER
			-- Requested show Y position

	relative_widget: ?EV_WIDGET
			-- The widget the popup window is shown relative to

feature {NONE} -- Query

	window_on_screen_position (a_widget: EV_WIDGET; a_constrain_to_widget: BOOLEAN): TUPLE [x, y: INTEGER]
			-- Fetches the on-screen position based on the requested X and Y positions.
			--
			-- `a_widget': The parent widget/window to fetch the top-level window for.
			-- `a_constrain_to_widget': True if the popup window should remain within the bounds of the specified widget/window.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_allowed_off_screen: not is_allowed_off_screen
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		local
			l_widget: EV_WIDGET
			l_window: like popup_window
		do
			l_window := popup_window
			if a_constrain_to_widget then
				l_widget := a_widget
			else
				l_widget := l_window
			end
			Result := helpers.suggest_pop_up_widget_location_with_size (l_widget,
				requested_x_position,
				requested_y_position,
				l_window.width,
				l_window.height)
		ensure
			result_attached: Result /= Void
			result_x_non_negative: Result.x >= 0
			result_y_non_negative: Result.y >= 0
		end

feature -- Basic operations

	show (a_x: INTEGER; a_y: INTEGER; a_mouse_x: INTEGER; a_mouse_y: INTEGER)
			-- Displays the pop up window at a designated position on screen.
			--
			-- `a_x': Window screen X position.
			-- `a_y': Window screen Y position.
			-- `a_mouse_x': Mouse screen X position. Use -1 to ignore position
			-- `a_mouse_y': Mouse screen Y position, Use -1 to ingore position
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_mouse_x_big_enough: a_mouse_x >= -1
			a_mouse_y_big_enough: a_mouse_y >= -1
		local
			l_screen: SD_SCREEN
		do
			requested_x_position := a_x
			requested_y_position := a_y

			is_committed_on_closed := False

					-- Show initially off-screen to retrieve width and height.
			create l_screen
			popup_window.set_position (l_screen.width + 1, l_screen.height + 1)
			register_kamikaze_action (show_actions, agent ensure_popup_window_visible_on_screen)
			register_kamikaze_action (show_actions, agent on_application_pointer_motion (popup_window, a_mouse_x, a_mouse_y))

			on_before_show
			popup_window.show
		ensure
			popup_window_is_displayed: popup_window.is_displayed
			not_is_committed_on_closed: not is_committed_on_closed
		end

	show_relative_to_widget (a_widget: !EV_WIDGET; a_x: INTEGER a_y: INTEGER; a_mouse_x: INTEGER; a_mouse_y: INTEGER)
			-- Displays the pop up window at a position relative to a widget.
			--
			-- `a_widget': A widget to show the window relative to.
			-- `a_x': Relative X position to the specified widget.
			-- `a_y': Relative Y position to the specified widget.
			-- `a_mouse_x': Relative mouse X position to the specified widget.
			-- `a_mouse_y': Relative mouse Y position to the specified widget.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		do
			relative_widget := a_widget
			show (a_widget.screen_x + a_x, a_widget.screen_y + a_y, a_widget.screen_x + a_mouse_x, a_widget.screen_y + a_mouse_y)
		ensure
			relative_widget_set: relative_widget = a_widget
			popup_window_is_displayed: popup_window.is_displayed
			not_is_committed_on_closed: not is_committed_on_closed
		end

	show_relative_to_window (a_window: !EV_WINDOW)
			-- Shows popup window centered to a parent window.
			--
			-- `a_window': The window to show the popup window centered to.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_window_is_displayed: a_window.is_displayed
			a_window_is_detroyed: not a_window.is_destroyed
		local
			l_screen: SD_SCREEN
		do
			is_committed_on_closed := False

					-- Show initially off-screen to retrieve width and height.
			create l_screen
			popup_window.set_position (l_screen.width + 1, l_screen.height + 1)
			register_kamikaze_action (show_actions, agent (a_ia_window: !EV_WINDOW)
				do
					if is_interface_usable and is_initialized and then not a_ia_window.is_destroyed and then a_ia_window.is_displayed then
							-- Set requested x and y positions so `ensure_popup_window_visible_on_screen' will make the necessary correct
							-- popup window placement
						requested_x_position := a_ia_window.screen_x + ((a_ia_window.width - popup_window.width) / 2).truncated_to_integer
						requested_y_position := a_ia_window.screen_y + ((a_ia_window.height - popup_window.height) / 2).truncated_to_integer
					end
				end (a_window))
			register_kamikaze_action (show_actions, agent ensure_popup_window_visible_on_screen)

			on_before_show
			popup_window.show
		ensure
			popup_window_is_displayed: popup_window.is_displayed
			not_is_committed_on_closed: not is_committed_on_closed
		end

	hide
			-- Hides the popup window.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if not is_executing_unfocused_action then
				if internal_popup_window /= Void and then not internal_popup_window.is_destroyed then
					popup_window.hide
				end
				if is_recycled_on_closing then
					recycle
				end
			end
		ensure
			relative_widget_detached: not is_shown implies relative_widget = Void
			not_popup_window_is_displayed: not is_shown implies not popup_window.is_displayed
			not_is_interface_usable: not is_shown implies (is_recycled_on_closing implies not is_interface_usable)
		end

	hide_confirm
			-- Hides popup window by performing a confirm operation.
			-- Note: Descendant may call this from a button or other UI to perform any commit-to-change actions.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			is_committed_on_closed := True
			on_confirm_popup
		ensure
			is_committed_on_closed: is_committed_on_closed
			relative_widget_detached: not is_shown implies relative_widget = Void
			not_popup_window_is_displayed: not is_shown implies not popup_window.is_displayed
		end

	hide_cancel
			-- Hides popup window by performing a cancel operation.
			-- Note: Descendant may call this from a button or other UI to perform any cancel changes actions.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			is_committed_on_closed := False
			on_cancel_popup
		ensure
			not_is_committed_on_closed: not is_committed_on_closed
			relative_widget_detached: not is_shown implies relative_widget = Void
			not_popup_window_is_displayed: not is_shown implies not popup_window.is_displayed
		end

	frozen execute_unfocusing_action (a_action: PROCEDURE [ANY, TUPLE])
			-- Performs an action that will cause the popup window to loose focus, but protects the popup window
			-- from closing if `is_focus_sensitive' is true.
			--
			-- `a_action': The action to perform possibly causing the window to lose focus.
		require
			is_interface_usable: is_interface_usable
			is_shown: is_shown
			a_action_attached: a_action /= Void
		local
			l_performing: like is_executing_unfocused_action
		do
			if is_initialized then
				l_performing := is_executing_unfocused_action
				is_executing_unfocused_action := True
				a_action.call (Void)
				is_executing_unfocused_action := l_performing

				if not l_performing then
					if is_pointer_sensitive and then not has_mouse_pointer then
							-- Forward call because the actions will not be called when `is_executing_unfocused_action' is True
						has_mouse_pointer := True
						on_pointer_leave
					end
					if is_focus_sensitive and then is_interface_usable and then not popup_window.has_focus then
							-- Forward call because the actions will not be called when `is_executing_unfocused_action' is True
						on_focused_out
					end
				end
			else
				a_action.call (Void)
			end
		rescue
			is_executing_unfocused_action := l_performing
		end

feature {NONE} -- Basic operation

	update_border_color
			-- Changes the pop up window border color based on an active (`has_mouse_pointer') state.
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

	ensure_popup_window_visible_on_screen
			-- Ensures the popup window is visible on screen, given the bounding edges
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_allowed_off_screen: not is_allowed_off_screen
		local
			l_manager: EB_SHARED_WINDOW_MANAGER
			l_window: EB_WINDOW
			l_position: like window_on_screen_position
		do
			if {l_widget: !EV_WIDGET} relative_widget then
				l_position := window_on_screen_position (l_widget, False)
			else
				create l_manager
				l_window := l_manager.window_manager.last_focused_development_window
				if l_window /= Void then
					l_position := window_on_screen_position (l_window.window, False)
				else
					l_position := window_on_screen_position (popup_window, False)
				end
			end

			check l_position_attached: l_position /= Void end

			popup_window.set_position (l_position.x, l_position.y)
		end

feature {NONE} -- User interface elements

	border_widget: EV_WIDGET
			-- The widget used to display the pop up window's border.

feature -- Actions

	frozen show_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the window is shown

	frozen hide_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the window is shown

feature {NONE} -- Action handlers

	on_before_show
			-- Called prior to the window being shown, programmatically.
		require
			is_interface_usable: is_interface_usable
		do

		end

	on_shown
			-- Called once the foundation widget has been shown.
		do
			Precursor {ES_WINDOW_FOUNDATIONS}

			popup_window.refresh_now

				-- Hook up to application pointer mtion actions
			register_action (ev_application.pointer_motion_actions, agent on_application_pointer_motion)
		end

	on_hidden
			-- Called once the foundation widget has been hidden.
		do
			Precursor {ES_WINDOW_FOUNDATIONS}

				-- Remove application pointer motion actions
			unregister_action (ev_application.pointer_motion_actions, agent on_application_pointer_motion)

				-- Unset the relative widget, if any
			relative_widget := Void
		ensure then
			relative_widget_detached: relative_widget = Void
		end

	on_confirm_popup
			-- Called when an action is perform that classifies as a confirm action. Typically when the user presses CTRL+ENTER
			-- this action will be called.
			-- Note: Descendant may call `hide_commit' from a button or other UI to perform any commit-to-change actions.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_committed_on_closed: is_committed_on_closed
		do
			hide
		end

	on_cancel_popup
			-- Called when an action is perform that classifies as a cancel action. Typically when the user presses ESC
			-- this action will be called.
			-- Note: Descendant may call `hide_cancel' from a button or other UI to perform any cancel changes actions.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_committed_on_closed: not is_committed_on_closed
		do
			hide
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

			if is_pointer_sensitive and then not is_executing_unfocused_action then
				on_cancel_popup
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
			if is_focus_sensitive and then not is_executing_unfocused_action and then is_shown then
				hide_cancel
			end
		end

	on_handle_key (a_key: EV_KEY; a_alt: BOOLEAN; a_ctrl: BOOLEAN; a_shift: BOOLEAN; a_released: BOOLEAN): BOOLEAN
			-- Called when the popup window recieve a key event
			--
			-- `a_key': The key pressed.
			-- `a_alt': True if the ALT key was pressed; False otherwise
			-- `a_ctrl': True if the CTRL key was pressed; False otherwise
			-- `a_shift': True if the SHIFT key was pressed; False otherwise
			-- `a_released': True if the key event pertains to the release of a key, False to indicate a press.
			-- `Result': True to indicate the key was handled
		do
			if a_released then
				if not a_alt and not a_ctrl and not a_shift then
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_escape then
						hide_cancel
						Result := True
					else
					end
				end

				if not Result and then a_ctrl and not a_alt and not a_shift then
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_enter then
						hide_confirm
						Result := True
					else
					end
				end
			end

			if not Result then
				Result := Precursor {ES_WINDOW_FOUNDATIONS} (a_key, a_alt, a_ctrl, a_shift, a_released)
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
					if l_in_window and a_widget /= Void then
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
