note
	description: "[
		A command line switch configuration setting validator that checks if a setting is seting is the correct way
		and is a valid configuration setting.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SETTING_ARGUMENT_VALIDATOR

inherit
	ARGUMENT_PROPERTY_VALIDATOR
		redefine
			validate_value
		end

feature -- Validation

	validate_value (a_value: READABLE_STRING_GENERAL)
			-- Validates option value against any defined rules.
			-- `is_option_valid' will be set upon completion.
		local
			l_valid: BOOLEAN
			l_pos: INTEGER
			l_name: READABLE_STRING_GENERAL
		do
			l_pos := a_value.index_of ('=', 1)
			if l_pos > 0 and l_pos < a_value.count then
				l_name := a_value.substring (1, l_pos - 1)
				l_valid := True
			end
			if not l_valid then
				invalidate_option ("Setting switches must be defined as <setting>=<value>")
			else
				check
					l_name_attached: l_name /= Void
					not_l_name_is_empty: not l_name.is_empty
				end
				l_valid := validator.is_setting_known (l_name)
				if not l_valid then
					invalidate_option ({STRING_32} "Setting '" + l_name.to_string_32 + "' is not a reconized compiler configuration setting.")
				end
			end
			is_option_valid := l_valid
		end

feature {NONE} -- Configuration validity

	validator: CONF_VALIDITY
			-- Configuration system validator
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
