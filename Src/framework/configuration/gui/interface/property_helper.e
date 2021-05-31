note
	description: "Property helper"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROPERTY_HELPER

inherit
	CONF_INTERFACE_CONSTANTS

feature -- Property builder

	new_boolean_property (a_name: like {BOOLEAN_PROPERTY}.name; a_value: BOOLEAN): BOOLEAN_PROPERTY
			-- Create new boolean property with translated strings.
		require
			a_name_not_void: a_name /= Void
		do
			create Result.make_with_value (a_name, a_value)
			Result.set_display_agent (agent displayed_boolean)
			Result.set_convert_to_data_agent (agent convert_boolean_value)
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	displayed_boolean (a_value: BOOLEAN): STRING_32
			-- Displayed boolean value
		do
			if a_value then
				Result := conf_interface_names.boolean_true
			else
				Result := conf_interface_names.boolean_false
			end
		ensure
			Result_not_void: Result /= Void
		end

	convert_boolean_value (a_string: STRING_32): BOOLEAN
			-- Convert `a_string' to a boolean value.
		require
			a_string_not_void: a_string /= Void
		do
			Result := conf_interface_names.boolean_values.item (a_string)
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
