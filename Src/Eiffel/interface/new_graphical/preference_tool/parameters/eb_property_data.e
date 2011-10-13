note
	description	: "All shared attributes specific to dialogs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROPERTY_DATA

inherit
	EB_SHARED_GRAPHICAL_COMMANDS
	EB_CLUSTER_MANAGER_OBSERVER

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES)
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end

feature {EB_SHARED_PREFERENCES} -- Value

	property_inherit_background_color: EV_COLOR
			-- Backgound color used to display inherited properties.
		do
			Result := property_inherit_background_color_preference.value
		end

	property_override_background_color: EV_COLOR
			-- Backgound color used to display overridden properties.
		do
			Result := property_override_background_color_preference.value
		end

feature {EB_SHARED_PREFERENCES, EB_TOOL} -- Preference

	property_inherit_background_color_preference: COLOR_PREFERENCE

	property_override_background_color_preference: COLOR_PREFERENCE

feature -- Preference strings

	property_inherit_background_color_preference_string: STRING = "interface.property.inherit_background_color"
	property_override_background_color_preference_string: STRING = "interface.property.override_background_color"

feature {NONE} -- Implementation

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "property")
			property_inherit_background_color_preference := l_manager.new_color_preference_value (l_manager, property_inherit_background_color_preference_string, create {EV_COLOR}.make_with_8_bit_rgb (245, 245, 245))
			property_override_background_color_preference := l_manager.new_color_preference_value (l_manager, property_override_background_color_preference_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 245, 245))

			property_inherit_background_color_preference.change_actions.extend (agent redraw_properties)
			property_override_background_color_preference.change_actions.extend (agent redraw_properties)

			set_property_preferences
		end

	preferences: PREFERENCES
			-- Preferences

feature {NONE} -- Refresh

	set_property_preferences
			-- Set property preferences using current values.
		do
			property_settings.set_inherit_color (property_inherit_background_color)
			property_settings.set_override_color (property_override_background_color)
		end

	redraw_properties
			-- Redraw properties using current preferences.
		do
			set_property_preferences
			system_cmd.refresh
			manager.refresh
		end

	property_settings: PROPERTY_GRID_LAYOUT
			-- Global property settings.
		once
			create Result
		end

invariant
	preferences_not_void: preferences /= Void

	property_inherit_background_color_preference_attached: attached property_inherit_background_color_preference
	property_override_background_color_preference_attached: attached property_override_background_color_preference

note
	copyright:	"Copyright (c) 2011, Eiffel Software"
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
