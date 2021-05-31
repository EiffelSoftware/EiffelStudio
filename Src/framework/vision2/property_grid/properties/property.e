note
	description: "Properties that can be displayed in a property grid."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROPERTY

inherit
	EV_GRID_EDITABLE_ITEM
		export
			{NONE} data, set_data
		redefine
			is_in_default_state,
			activate,
			initialize
		end

	EV_STOCK_COLORS
		rename
			implementation as color_implementation
		export
			{NONE} all
		undefine
			default_create, copy
		end

	PROPERTY_GRID_LAYOUT
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	make (a_name: like name)
			-- Create.
		require
			a_name_ok: a_name /= Void
		do
			name := a_name
			create {STRING_32} description.make_empty
			default_create
			pointer_button_press_actions.extend (agent check_right_click)
		ensure
			name_set: name = a_name
		end

	initialize
			-- Initialize
		do
			Precursor
			activate_when_pointer_is_pressed
		end

feature  -- Access

	name: READABLE_STRING_GENERAL
			-- Name of the property.

	description: READABLE_STRING_GENERAL
			-- Description of the property.

	is_inherited: BOOLEAN
			-- Is the value of the property inherited and not overriden?

	is_overriden: BOOLEAN
			-- Is the value of the property a value that overrides an inherited value?

	is_forcable: BOOLEAN
			-- Is it possible to force inheritance on "child" values?

	is_readonly: BOOLEAN
			-- Is the value readonly?

	name_item: detachable EV_GRID_ITEM
			-- Grid item with the name (if any).

feature  -- Update

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_description (a_description: like description)
			-- Set `description' to `a_description'.
		require
			a_description_ok: a_description /= Void and then not a_description.is_empty
		do
			description := a_description
			set_tooltip (description)
		ensure
			description_set: description = a_description
		end

	enable_inherited
			-- Make the value inherited.
		do
			is_inherited := True
			is_overriden := False
			set_background_color (inherit_color)
		ensure
			inherited: is_inherited
			not_overriden: not is_overriden
		end

	enable_overriden
			-- Make the value overriden.
		do
			is_inherited := False
			is_overriden := True
			set_background_color (override_color)
		ensure
			not_inherited: not is_inherited
			overriden: is_overriden
		end

	enable_forcable
			-- Make the value forcable.
		do
			is_forcable := True
		ensure
			forcable: is_forcable
		end

	enable_readonly
			-- Enable `is_readonly'.
		do
			is_readonly := True
			set_foreground_color (gray)
			if attached name_item as l_name_item then
				l_name_item.set_foreground_color (gray)
			end
		ensure
			is_readonly: is_readonly
		end

	refresh
			-- Refresh current data.
		do
		end

feature {PROPERTY_GRID, TYPED_PROPERTY} -- Agents

	check_right_click (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Check if we clicked the right mouse button and show inheritance menu.
		do
			if a_button = 3 then
				show_inheritance_menu
			end
		end

feature {PROPERTY_GRID} -- Update during insert into grid

	set_name_item (an_item: attached like name_item)
			-- Set `name_item' to `an_item'.
		require
			an_item_not_void: an_item /= Void
		do
			name_item := an_item
			if is_readonly then
				an_item.set_foreground_color (gray)
			end
		ensure
			name_item_set: name_item = an_item
		end

feature -- Actions

	activate
			-- Activate.
		do
			if not is_readonly then
				Precursor
			end
		end

	activate_when_pointer_is_pressed
		do
			pointer_button_press_actions.extend (agent (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
					do
						activate
					end
				)
		end

	activate_when_pointer_is_double_pressed
		do
			pointer_double_press_actions.extend (agent (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
					do
						activate
					end
				)
		end

feature {NONE} -- Actions

	show_inheritance_menu
			-- Show menu that allows to control inheritance.
		local
			l_menu: EV_MENU
			l_item: EV_MENU_ITEM
		do
			create l_menu
			if is_overriden or is_forcable then
				if is_overriden then
					create l_item.make_with_text (use_inherited)
					l_menu.extend (l_item)
					l_item.select_actions.extend (agent on_use_inherited)
				end
				if is_forcable then
					create l_item.make_with_text (force_inheritance)
					l_menu.extend (l_item)
					l_item.select_actions.extend (agent on_force_inheritance)
				end
			end
			l_menu.show
		end

	on_use_inherited
			-- Called if we have to use the inherited value.
		do
		end

	on_force_inheritance
			-- Called if child properties should use the inherited value.
		do
		end

feature {NONE} -- Contract

	is_in_default_state: BOOLEAN = True
			-- Default state.

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
