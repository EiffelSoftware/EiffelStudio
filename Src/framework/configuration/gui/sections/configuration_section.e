note
	description: "Objects that represent a configuration section."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONFIGURATION_SECTION

inherit
	EV_TREE_ITEM
		redefine
			initialize,
			is_in_default_state
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	make (a_window: like configuration_window)
			-- Create.
		require
			a_window_ok: a_window /= Void and then not a_window.is_destroyed
		do
			configuration_window := a_window
			toolbar := configuration_window.toolbar
			default_create
		ensure
			configuration_window_set: configuration_window = a_window
			toolbar_set: toolbar = configuration_window.toolbar
		end

	initialize
			-- Initialize.
		do
			set_text (name)
			set_pixmap (icon)
			pointer_button_press_actions.extend (agent show_menu_on_right_click)
			select_actions.append (create_select_actions)
			select_actions.extend (agent
				do
					toolbar.reset_sensitive
					update_toolbar_sensitivity
				end)

			Precursor {EV_TREE_ITEM}
		end

feature	-- Access

	configuration_window: CONFIGURATION_WINDOW
			-- Window where to display information.

	name: READABLE_STRING_32
			-- Name of the section.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	icon: EV_PIXMAP
			-- Icon of the section.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	toolbar: CONFIGURATION_TOOLBAR
			-- Toolbar with actions.

	context_menu: ARRAYED_LIST [EV_MENU_ITEM]
			-- Context menu with available actions for `Current'.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Simple operations

	show_context_menu
			-- Show the context menu.
		local
			m: like open_menu
		do
			create m
			open_menu := m
			m.append (context_menu)
			m.show
		end

	update_toolbar_sensitivity
			-- Enable buttons in `toolbar' and assign actions.
		deferred
		end

feature {NONE} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to execute when the item is selected
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	open_menu: detachable EV_MENU
			-- Context menu as class attribute that it doesn't get collected.

feature {NONE} -- Implementation helper

	show_menu_on_right_click (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Check if we clicked the right mouse button and show menu.
		do
			if a_button = 3 then
				show_context_menu
			end
		end

feature {NONE} -- Contract helper

	is_in_default_state: BOOLEAN = True

invariant
	toolbar_not_void: toolbar /= Void
	configuration_window_ok: configuration_window /= Void and then not configuration_window.is_destroyed

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
