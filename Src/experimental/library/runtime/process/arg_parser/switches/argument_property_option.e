note
	description: "[
			Represents a user passed argument property value, that is <property>=<value>.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PROPERTY_OPTION

inherit
	ARGUMENT_OPTION
		redefine
			make,
			set_value
		end

create {ARGUMENT_SWITCH}
	make,
	make_with_value

feature {NONE} -- Initialization

	make (a_switch: like switch)
			-- <Precursor>
		do
			create property_name.make_empty
			create property_value.make_empty
			Precursor (a_switch)
		end

feature -- Access

	property_name: IMMUTABLE_STRING_32
			-- Name of property

	property_value: IMMUTABLE_STRING_32
			-- Value of property

feature -- Status report

	has_property_name: BOOLEAN
			-- Indicicate if option has a property name.
		do
			Result := not property_name.is_empty
		ensure
			result_base_true: Result implies not property_name.is_empty
		end

	has_property_value: BOOLEAN
			-- Indicicate if option has a property value.
		do
			Result := not property_value.is_empty
		ensure
			result_base_true: Result implies not property_value.is_empty
		end

feature {ARGUMENT_BASE_PARSER} -- Element Change

	set_value (a_value: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			Precursor (a_value)
			split_canonical_value
		end

feature {NONE} -- Basic operations

	split_canonical_value
			-- Splits the value into a property name and associated property value.
			-- Note: It is fine to call this even when the switch does not have a set value, the property
			--       name and value will consequently be Void also.
		local
			l_value: like value
			l_pval, l_pname: detachable IMMUTABLE_STRING_32
			l_count: INTEGER
			l_pos: INTEGER
		do
			if has_value then
				l_value := value
				l_count := l_value.count
				l_pos := l_value.index_of ('=', 1)
				if l_pos = l_count then
					if l_count > 1 then
							-- No value, just a name
						l_pname	:= l_value.shared_substring (1, l_pos - 1)
					end
				elseif l_pos > 1 then
					l_pname := l_value.shared_substring (1, l_pos - 1)
					if l_pos < l_count then
						l_pval := l_value.shared_substring (l_pos + 1, l_count)
					end
				else
					check
						l_pos_is_zero: l_pos = 0
					end
					l_pval := l_value.twin
				end
			end
			if l_pname /= Void then
				property_name := l_pname
			else
				create property_name.make_empty
			end
			if l_pval /= Void then
				property_value := l_pval
			else
				create property_value.make_empty
			end
		end

invariant
	property_name_attached: property_name /= Void
	property_value_attached: property_value /= Void
	has_name_or_value: has_value implies (has_property_name or has_property_value)
	not_has_name_or_value: not has_value implies (not has_property_name and not has_property_value)

note
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
