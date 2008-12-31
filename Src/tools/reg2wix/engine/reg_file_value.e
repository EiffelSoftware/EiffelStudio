note
	description: "[
		Represents a Windows registry key unnamed value (the default value.)
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	REG_FILE_VALUE

inherit
	ERROR_HANDLER_PROVIDER
		rename
			make as make_empty
		end

create
	make,
	make_empty

feature {NONE} -- Initialization

	make (a_property: INI_PROPERTY; a_handler: like error_handler)
			-- Initialize a new {REG_FILE_VALUE}
		require
			a_property_attached: a_property /= Void
			not_a_property_is_default: not a_property.is_default_property
			a_property_has_value: a_property.has_value
			a_handler_attached: a_handler /= Void
		do
			make_empty (a_handler)
			process_ini_content (a_property)
		ensure
			error_handler_set: error_handler = a_handler
		end

feature -- Access

	value: STRING
			-- Actual value

feature -- Status report

	is_default: BOOLEAN
			-- Indicate if named value is a default value
		do
			Result := True
		end

	has_value: BOOLEAN
			-- Determines if a value is set
		do
			Result := value /= Void
		end

feature -- Query

	is_valid_value (a_value: like value): BOOLEAN
			-- Determines if `a_value' is a valid value.
		do
			Result := True
		end

feature {NONE} -- Basic operations

	prune_quotes (a_value: STRING): STRING
			-- Removes quotation marks from `a_value' and returns the result
		require
			a_value_attached: a_value /= Void
			not_a_value_is_empty: not a_value.is_empty
		do
			Result := a_value.twin
			Result.prune_all_leading ('"')
			Result.prune_all_trailing ('"')
		end

	unescape_value (a_value: STRING): STRING
			-- Unescapes the value `a_value'
		require
			a_value_attached: a_value /= Void
			not_a_value_is_empty: not a_value.is_empty
		local
			l_count, i: INTEGER
			c: CHARACTER
			l_add: BOOLEAN
			l_skip: BOOLEAN
		do
			l_count := a_value.count
			create Result.make (l_count)

			from i := 1 until i > l_count loop
				c := a_value.item (i)
				if l_skip or c /= '\' then
					Result.append_character (c)
					l_skip := False
				else
					l_skip := True
				end
				i := i + 1
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end


feature {NONE} -- Process

	process_ini_content (a_property: INI_PROPERTY)
			-- Processes the content of an INI property `a_property'
		require
			a_property_attached: a_property /= Void
			not_a_property_is_default: not a_property.is_default_property
			a_property_has_value: a_property.has_value
		do
			if a_property.has_value then
				value := unescape_value (prune_quotes (a_property.value))
			else
				value := Void
			end
		end

invariant
	not_value_is_empty: value /= Void implies not value.is_empty
	value_is_valid_value: is_valid_value (value)

;note
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
