indexing
	description: "[
		A foundation button window to display a popup widget, or process a actions when a the button on a popup window is selected.
		
		By default pressing the down cursor arrow will expose the popup widget, if a popup widget is available.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_POPUP_BUTTON_WINDOW

inherit
	ES_POPUP_WINDOW
		redefine
			on_focused_out,
			on_handle_key
		end

feature {NONE} -- Initialization

	frozen build_window_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the windows's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		do
			popup_widget_container := a_container
			build_popup_interface (a_container)
			bind_select_actions (agent show_popup_widget)
		ensure then
			popup_widget_container_set: popup_widget_container = a_container
		end

	build_popup_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the popup window's user interface.
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

	bind_select_actions (a_action: PROCEDURE [ANY, TUPLE])
			-- Binds the selection actions the the window's widgets to ensure the pop up widget is display
			-- Note: `propagate_action' can be used to bind the actions to a widget structure, if the struture is deep and all widgets need to process
			--       the show action.
			--
			-- `a_action': The action to beind to any widget select actions of any widgets placed on the popup window.
		require
			a_action_attached: a_action /= Void
		deferred
		end

feature -- Access

	popup_widget: EV_WIDGET assign set_popup_widget
			-- Widget displayed when the popup button is pressed
		do
			Result := internal_popup_widget
			if Result = Void and then popup_widget_fetch_action /= Void then
				Result := popup_widget_fetch_action.item (Void)
				internal_popup_widget := Result
			end
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

feature {NONE} -- Access

	popup_widget_container: EV_VERTICAL_BOX
			-- The primary contain in which to add any popup widget to.

	popup_widget_fetch_action: FUNCTION [ANY, TUPLE [window: ES_POPUP_BUTTON_WINDOW], EV_WIDGET]
			-- Agent used to fetch a popup widget strucutre, shown when `popup_widget' is called.

feature -- Element change

	set_popup_widget (a_widget: like popup_widget)
			-- Assign popup widget to be displayed when the popup button is select
			-- Note: Already displayed widgets will have the UI replaced and reshown.
			--
			-- `a_widget': The widget to display in the popup window, when the popup up widget is requested to be shown.
			--             Use Void to remove the widget.
		require
			is_interface_usable: is_interface_usable
			not_a_widget_is_destroyed: a_widget /= Void implies not a_widget.is_destroyed
		local
			l_old_widget: like internal_popup_widget
			l_container: like popup_widget_container
			l_shown: BOOLEAN
		do
				-- If the old widget is currently shown then we need to remove it and replace
				-- it with the newly set one.
			if is_initializing then
				l_old_widget := internal_popup_widget
				if l_old_widget /= a_widget and then l_old_widget /= Void then

						-- The widget has changed, so remove the old one.
					l_container := popup_widget_container
					if l_container.has (l_old_widget) then
						l_container.prune (l_old_widget)
					end

					l_shown := is_shown and then is_popup_widget_shown
					if l_shown then
						hide_popup_widget
					end
				end
			end

				-- Set new widget
			internal_popup_widget := a_widget

			if is_initializing and then l_old_widget /= a_widget and then a_widget /= Void and then l_shown then
					-- Reshow new widget
				show_popup_widget
			end
		ensure
			popup_widget_set: popup_widget = a_widget
		end

	set_popup_widget_fetch_action (a_action: like popup_widget_fetch_action)
			-- Assign popup widget to be displayed when the popup button is select.
			--
			-- `a_action': An action used to fetch a popup widget strucutre, shown when `popup_widget' is called.
		require
			a_action_attached: a_action /= Void
		local
			l_old_action: like popup_widget_fetch_action
			l_old_widget: like internal_popup_widget
			l_container: like popup_widget_container
			l_shown: BOOLEAN
		do
				-- If the old widget is currently shown then we need to remove it and replace
				-- it with the newly set one.
			if is_initializing then
				l_old_action := popup_widget_fetch_action
				if l_old_action /= a_action then
					l_old_widget := internal_popup_widget
					if l_old_widget /= Void then
							-- The widget has changed, so remove the old one.
						l_container := popup_widget_container
						if l_container.has (l_old_widget) then
							l_container.prune (l_old_widget)
						end

						l_shown := is_shown and then is_popup_widget_shown
						if l_shown then
							hide_popup_widget
						end
					end
				end
			end

				-- Wipe out the old popup widget.
			internal_popup_widget := Void

			popup_widget_fetch_action := a_action

			if is_initializing and then l_old_action /= a_action and then a_action /= Void and then l_shown then
					-- Reshow new widget
				show_popup_widget
			end
		ensure
			internal_popup_widget_detached: not (is_initialized and then is_shown and then is_popup_widget_shown) implies internal_popup_widget = Void
			popup_widget_fetch_action_set: popup_widget_fetch_action = a_action
		end

feature -- Status report

	is_popup_widget_available: BOOLEAN
			-- Determines if a popup widget is available
		require
			is_interface_usable: is_interface_usable
		do
			Result := (internal_popup_widget /= Void and then not internal_popup_widget.is_destroyed) or else
				(popup_widget_fetch_action /= Void)
		ensure
			popup_widget_is_available: Result implies
				(internal_popup_widget /= Void and then not internal_popup_widget.is_destroyed) or else (popup_widget_fetch_action /= Void)
		end

	is_popup_widget_shown: BOOLEAN
			-- Indicates if the popup widget is currently shown
		require
			is_interface_usable: is_interface_usable
		do
			Result := (is_initialized and then is_popup_widget_available and then internal_popup_widget.is_displayed)
		ensure
			is_initialized: Result implies is_initialized
			is_popup_widget_available: Result implies is_popup_widget_available
			internal_popup_widget_is_displayed: Result implies internal_popup_widget.is_displayed
		end

feature {NONE} -- Status report

	is_popup_widget_show_requested: BOOLEAN
			-- Indicates if the popup widget has been requested to be shown

feature -- Basic operation

	frozen show_popup_widget
			-- Called to show the popup widget
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_popup_widget_available: is_popup_widget_available
		do
			if not is_popup_widget_show_requested and then not is_popup_widget_shown then
				is_popup_widget_show_requested := True
				on_popup_widget_show_requested
				is_popup_widget_show_requested := False
				register_kamikaze_action (hide_actions, agent
						-- Hide the popup widget when the window is hidden
					do
						if is_interface_usable and then is_popup_widget_available then
							hide_popup_widget
						end
					end)
			end
		end

	frozen hide_popup_widget
			-- Called to hide the popup widget
		require
			is_interface_usable: is_interface_usable
			is_popup_widget_available: is_popup_widget_available
		do
			internal_popup_widget.hide
			on_popup_widget_hidden
		end

feature {NONE} -- Action handlers

	on_popup_widget_show_requested
			-- Called when a show of the popup widget is requested.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_popup_widget_show_requested: is_popup_widget_show_requested
			not_is_popup_widget_shown: not is_popup_widget_shown
		local
			l_widget: like popup_widget
			l_container: like popup_widget_container
		do
			l_container := popup_widget_container

			l_widget := popup_widget
			if internal_popup_widget /= l_widget then
					-- The widget has changed, so remove the old one.
				if l_container.has (internal_popup_widget) then
					l_container.prune (internal_popup_widget)
				end
			end

			if l_widget /= Void then
					-- Extend the popup widget to the container
				check
					not_l_widget_is_destroyed: not l_widget.is_destroyed
					not_l_widget_has_parent: not l_widget.has_parent
				end
				l_container.extend (l_widget)
				if not l_container.is_displayed then
					l_container.show
				end
			end
		end

	on_popup_widget_hidden
			-- Called when the popup widget is hidden.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_popup_widget_shown: not is_popup_widget_shown
		do
				-- Set a small size to ensure the window size information is retracted
			popup_window.set_size (1, 1)
		end

	on_focused_out
			-- Called when the window loses focus
		do
			if
				not is_popup_widget_show_requested and then
				(internal_popup_widget = Void or else not
					 internal_popup_widget.is_displayed or else
					 not internal_popup_widget.has_focus)
			then
				Precursor {ES_POPUP_WINDOW}
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
					when {EV_KEY_CONSTANTS}.key_down then
						if is_popup_widget_available then
							show_popup_widget
							Result := True
						end
					else
					end
				end
			end
			Result := Result or Precursor {ES_POPUP_WINDOW}(a_key, a_alt, a_ctrl, a_shift, a_released)
		end

feature {NONE} -- Internal implementation cache

	internal_popup_widget: like popup_widget
			-- Cached version of `popup_widget'
			-- Note: Do not use directly!

invariant
	popup_widget_container_attached: (is_initialized and is_interface_usable) implies popup_widget_container /= Void

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
