note
	description: "[
		Base core for all EiffelStudio foundations widgets and tools.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_TOOL_FOUNDATIONS

inherit
	ES_RECYCLABLE

	ES_SHARED_FONTS_AND_COLORS
		export
			{NONE} all
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

	ES_SHARED_FOUNDATION_HELPERS
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	frozen make
			-- Initialize foundation tool
		local
			l_init: BOOLEAN
		do
			l_init := is_initializing
			is_initializing := True

			on_before_initialize
			build_interface

			is_initialized := True
			is_initializing := l_init

			on_after_initialized
		ensure
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
		end

    on_before_initialize
            -- Use to perform additional creation initializations, before the UI has been created.
			-- Note: No user interface initialization should be done here! Use `build_dialog_interface' instead
		require
			not_is_initialized: not is_initialized
		do
        end

    on_after_initialized
            -- Performs additional initialization of the UI, after the widget structure has been created.
            --
            --| Here is it safe to perform operations on widgets created in `build_interface'
        require
        	is_initialized: is_initialized
        do
        	register_action (foundation_widget.key_press_actions, agent on_key_pressed)
        	register_action (foundation_widget.key_release_actions, agent on_key_released)
        end

feature {NONE} -- User interface initialization

	build_interface
			-- Builds the foundataion tool's user interface.
		require
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
			is_initialized := False
		ensure then
			not_is_initialized: not is_initialized
		end

feature {NONE} -- Access

	foundation_widget: EV_WIDGET
			-- Widget used by tool foundation implementation
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result = foundation_widget
		end

	frozen session_data: SESSION_I
			-- Provides access to the environment session data
		require
			is_interface_usable: is_interface_usable
			is_session_manager_available: session_manager.is_service_available
		do
			Result := session_manager.service.retrieve (False)
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

feature -- Status report

	is_initialized: BOOLEAN
			-- Indicates if the user interface has been initialized

	is_shown: BOOLEAN
			-- Indicates if foundataion tool is current visible
		do
			if is_interface_usable and then is_initialized then
				Result := not foundation_widget.is_destroyed and then foundation_widget.is_displayed
			end
		end

feature {NONE} -- Status report

	is_initializing: BOOLEAN
			-- Indicates if the user interface is currently being initialized

feature {NONE} -- Query

	is_widget_applicable_for_color_propagation (a_widget: attached EV_COLORIZABLE; a_fg: BOOLEAN; a_bg: BOOLEAN): BOOLEAN
			-- Determines if a widget is applicable for propagation of either a foreground or background color.
			--
			-- `a_widget': The widget to determine if the applicable colors can be propagated.
			-- `a_fg': True if a request is being made to change the foreground color; False otherwise.
			-- `a_bg': True if a request is being made to change the background color; False otherwise.
		require
			a_fg_a_gb_exclusive: (a_fg and not a_bg) or (a_bg and not a_fg)
		do
			if a_fg then
				Result := True
			elseif a_bg then
				Result := attached {attached EV_CELL} a_widget as l_cell or
					attached {attached EV_CHECK_BUTTON} a_widget as l_check or
					attached {attached EV_RADIO_BUTTON} a_widget as l_rbutton or
					attached {attached EV_LABEL} a_widget as l_label or
					attached {attached EV_HORIZONTAL_BOX} a_widget as l_hbox or
					attached {attached EV_VERTICAL_BOX} a_widget as l_vbox or
					attached {attached EV_DRAWABLE} a_widget as l_drawable or
					attached {attached EV_SEPARATOR} a_widget as l_separator
			end
		end

feature {NONE} -- Helpers

	frozen interface_messages: attached INTERFACE_MESSAGES
			-- Access to EiffelStudio's interface messages
		once
			create Result
		end

	frozen session_manager: attached SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Access to the session manager service {SESSION_MANAGER_S} consumer
		once
			create Result
		end

feature {NONE} -- Basic operations

    execute_with_busy_cursor (a_action: PROCEDURE [ANY, TUPLE])
            -- Executes a action with a wait cursor
            --
            -- `a_action': An action to execute with a wait cursor displayed until the action has been completed
        require
            is_interface_usable: is_interface_usable
            is_initialized: is_initialized
            a_action_attached: a_action /= Void
        local
            l_style: EV_POINTER_STYLE
            l_widget: like foundation_widget
        do
        	l_widget := foundation_widget
			l_style := l_widget.pointer_style
			l_widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)
			a_action.call (Void)
			l_widget.set_pointer_style (l_style)
		rescue
				-- Action may raise an exception, so we need to restore the
				-- cursor
			if l_style /= Void then
				l_widget.set_pointer_style (l_style)
			end
		end

	propagate_colors (a_start_widget: EV_WIDGET; a_fg_color: EV_COLOR; a_bg_color: EV_COLOR; a_excluded: ARRAY [EV_WIDGET])
			-- Propagates setting of foreground and background colors to applicable widgets. The propagation respects the type of
			-- widget and will only perform setting of background colors on "transparent" style widgets.
			--
			-- `a_start_widget': The starting widget to apply an action, as well as to all it's children widgets.
			-- `a_fg_color': A foreground color. Can be Void to skip setting of a foreground color.
			-- `a_bg_color': A background color. Can be Void to skip setting of a background color.
			-- `a_excluded': An array of widgets to exluding the the propagation of colors, or Void to include all applicable widgets (see is applicable color widget)
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
			a_start_widget_attached: a_start_widget /= Void
			not_a_start_widget_is_destroyed: not a_start_widget.is_destroyed
			color_change: a_fg_color /= Void or a_bg_color /= Void
		local
			l_cursor: CURSOR
			l_propagate: BOOLEAN
		do
			if a_excluded = Void or else not a_excluded.has (a_start_widget) then
				if attached {attached EV_COLORIZABLE} a_start_widget as l_colorizable then
					if a_fg_color /= Void and then is_widget_applicable_for_color_propagation (l_colorizable, True, False) then
						l_colorizable.set_foreground_color (a_fg_color)
						l_propagate := True
					end
					if a_bg_color /= Void and then is_widget_applicable_for_color_propagation (l_colorizable, False, True) then
						l_colorizable.set_background_color (a_bg_color)
						l_propagate := True
					end
				end
			end

			if l_propagate and then attached {attached EV_WIDGET_LIST} a_start_widget as l_list then
				l_cursor := l_list.cursor
				from l_list.start until l_list.after loop
					if attached {attached EV_WIDGET} l_list.item as l_widget and then not l_widget.is_destroyed then
						propagate_colors (l_widget, a_fg_color, a_bg_color, a_excluded)
					end
					l_list.forth
				end
				l_list.go_to (l_cursor)
			end
		end

	propagate_action (a_start_widget: EV_WIDGET; a_action: PROCEDURE [ANY, TUPLE [EV_WIDGET]]; a_excluded: ARRAY [EV_WIDGET])
			-- Propagates a performed action to all child widgets of an initial widget.
			--
			-- `a_start_widget': The starting widget to apply an action, as well as to all it's children widgets.
			-- `a_action': The action to be performed.
			-- `a_excluded': An array of widgets to exluding the the propagation of actions, or Void to include all widgets
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
			a_start_widget_attached: a_start_widget /= Void
			not_a_start_widget_is_destroyed: not a_start_widget.is_destroyed
			a_action_attached: a_action /= Void
		local
			l_cursor: CURSOR
		do
			if a_excluded = Void or else not a_excluded.has (a_start_widget) then
					-- Perform action
				a_action.call ([a_start_widget])
			end

			if attached {attached EV_WIDGET_LIST} a_start_widget as l_list then
				l_cursor := l_list.cursor
				from l_list.start until l_list.after loop
					if attached {attached EV_WIDGET} l_list.item as l_widget and then not l_widget.is_destroyed then
							-- Perform action on all child widgets
						propagate_action (l_widget, a_action, a_excluded)
					end
					l_list.forth
				end
				l_list.go_to (l_cursor)
			elseif attached {EV_SPLIT_AREA} a_start_widget as l_split then
				if attached {attached EV_WIDGET} l_split.first as l_first and then not l_first.is_destroyed then
					propagate_action (l_first, a_action, a_excluded)
				end
				if attached {attached EV_WIDGET} l_split.second as l_second and then not l_second.is_destroyed then
					propagate_action (l_second, a_action, a_excluded)
				end
			end
		end

	propagate_register_action (a_start_widget: EV_WIDGET; a_sequence: FUNCTION [ANY, TUPLE [EV_WIDGET], ACTION_SEQUENCE [TUPLE]]; a_action: PROCEDURE [ANY, TUPLE]; a_excluded: ARRAY [EV_WIDGET])
			-- Propagates an actions to all child widgets
			--
			-- `a_exclude': An array of widgets to exluding the the propagation of actions, or Void to include all widgets
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
			a_start_widget_attached: a_start_widget /= Void
			not_a_start_widget_is_destroyed: not a_start_widget.is_destroyed
			a_action_attached: a_action /= Void
		local
			l_sequence: ACTION_SEQUENCE [TUPLE]
			l_cursor: CURSOR
			l_start_widget: EV_WIDGET
		do
			if a_excluded = Void or else not a_excluded.has (a_start_widget) then
				l_sequence := a_sequence.item ([a_start_widget])
				if l_sequence /= Void then
						-- Add action
					register_action (l_sequence, a_action)
				end
			end

			if attached {attached EV_WINDOW} a_start_widget as l_window then
				if not l_window.is_empty then
					l_start_widget := l_window.item
				end
			else
				l_start_widget := a_start_widget
			end

			if attached {attached EV_WIDGET_LIST} l_start_widget as l_list then
				l_cursor := l_list.cursor
				from l_list.start until l_list.after loop
					if attached {attached EV_WIDGET} l_list.item as l_widget and then not l_widget.is_destroyed then
							-- Apply addition to all child widgets
						propagate_register_action (l_widget, a_sequence, a_action, a_excluded)
					end
					l_list.forth
				end
				l_list.go_to (l_cursor)
			elseif attached {EV_SPLIT_AREA} l_start_widget as l_split then
				if attached {attached EV_WIDGET} l_split.first as l_first and then not l_first.is_destroyed then
					propagate_register_action (l_first, a_sequence, a_action, a_excluded)
				end
				if attached {attached EV_WIDGET} l_split.second as l_second and then not l_second.is_destroyed then
					propagate_register_action (l_second, a_sequence, a_action, a_excluded)
				end
			end
		end

feature {NONE} -- Action Handlers

	frozen on_key_pressed (a_key: EV_KEY)
			-- Called when the tool recieves a key press
			--
			-- `a_key': The key pressed.
		local
			l_application: like ev_application
			l_handled: BOOLEAN
			l_widget: EV_WIDGET
		do
			if a_key /= Void and then is_interface_usable and then is_initialized then
				l_application := ev_application
				l_widget := l_application.focused_widget
				if l_widget /= Void and then l_widget.default_key_processing_handler /= Void then
					l_handled := l_widget.default_key_processing_handler.item ([a_key])
				end
				if not l_handled and then is_interface_usable then
						-- We have to check is the interface is usable because the window may have been closed/destroyed
						-- but the key processor opts not to return it being handled.
					l_handled := on_handle_key (a_key, l_application.alt_pressed, l_application.ctrl_pressed, l_application.shift_pressed, False)
				end
			end
		end

	frozen on_key_released (a_key: EV_KEY)
			-- Called when the tool recieves a key release
			--
			-- `a_key': The key released.
		local
			l_application: like ev_application
			l_handled: BOOLEAN
		do
			if a_key /= Void and then is_interface_usable and then is_initialized then
				l_application := ev_application
				l_handled := on_handle_key (a_key, l_application.alt_pressed, l_application.ctrl_pressed, l_application.shift_pressed, True)
			end
		end

	on_handle_key (a_key: EV_KEY; a_alt: BOOLEAN; a_ctrl: BOOLEAN; a_shift: BOOLEAN; a_released: BOOLEAN): BOOLEAN
			-- Called when the tool recieve a key event
			--
			-- `a_key': The key pressed.
			-- `a_alt': True if the ALT key was pressed; False otherwise
			-- `a_ctrl': True if the CTRL key was pressed; False otherwise
			-- `a_shift': True if the SHIFT key was pressed; False otherwise
			-- `a_released': True if the key event pertains to the release of a key, False to indicate a press.
			-- `Result': True to indicate the key was handled
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_key_attached: a_key /= Void
		do
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
