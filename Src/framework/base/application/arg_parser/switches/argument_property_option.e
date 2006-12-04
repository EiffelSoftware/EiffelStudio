indexing
	description: "Represents a user passed argument property value, that is <property>=<value>."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PROPERTY_OPTION

inherit
	ARGUMENT_OPTION
		redefine
			set_value
		end

create {ARGUMENT_SWITCH}
	make,
	make_with_value

feature -- Access

	property_name: STRING
			-- Name of property

	property_value: STRING
			-- Value of property

feature -- Status report

	has_property_name: BOOLEAN is
			-- Indicicate if option has a property name.
		require
			has_value: has_value
		do
			Result := property_name /= Void or else not property_name.is_empty
		ensure
			result_base_true: Result implies (property_name /= Void and then not property_name.is_empty)
		end

	has_property_value: BOOLEAN is
			-- Indicicate if option has a property value.
		require
			has_value: has_value
		do
			Result := property_value /= Void or else not property_value.is_empty
		ensure
			result_base_true: Result implies (property_value /= Void and then not property_value.is_empty)
		end

feature {ARGUMENT_BASE_PARSER} -- Element Change

	set_value (a_value: like value) is
			-- Sets `value' with `a_value'.
		do
			value := a_value
			split_canonical_value
		end

feature {NONE} -- Implementation

	split_canonical_value is
			-- Splits `value' and set `property_name' and `property_value' base on it.
		local
			l_value: STRING
			l_pval, l_pname: STRING
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
						l_pname	:= l_value.substring (1, l_pos - 1)
					end
				elseif l_pos > 1 then
					l_pname := l_value.substring (1, l_pos - 1)
					if l_pos < l_count then
						l_pval := l_value.substring (l_pos + 1, l_count)
					end
				else
					check l_pos_is_zero: l_pos = 0 end
					l_pval := l_value.twin
				end
			end
			property_name := l_pname
			property_value := l_pval
		end

invariant
	has_name_or_value: has_value implies (has_property_name or has_property_value)
	not_has_name_or_value: not has_value implies (not has_property_name and not has_property_value)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {ARGUMENT_PROPERTY_OPTION}
