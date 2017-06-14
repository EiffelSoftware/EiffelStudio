note
	description: "[
		Represents an INI document property.

		Properties can be either named or default (unnamed) properties.
		Default properties are declared as:
			=<value>
		in a given INI text, where are named properties are declared as:
			<name>=[<value>]
		where [<value>] represents an optional value.

		Default properties will always have a value where as named properties
		may be declared with no value.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	INI_PROPERTY

inherit
	ANY

	DEBUG_OUTPUT
		export
			{NONE} all
		end

create
	make,
	make_default

feature {NONE} -- Initialization

	make (a_name: like name; a_value: like value; a_container: like container)
			-- Initialize property with name `a_name' and associated value `a_value'.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_value_attached: a_value /= Void
			a_container_attached: a_container /= Void
		do
			name := a_name
			set_value (a_value)
			container := a_container
		ensure
			name_set: name = a_name
			value_set: value = a_value
			contain_set: container = a_container
			not_is_default_property: not is_default_property
		end

	make_default (a_value: like value; a_container: like container)
			-- Initialize property with no name with a value `a_value'.
		require
			a_value_attached: a_value /= Void
			a_container_attached: a_container /= Void
		do
			set_value (a_value)
			container := a_container
		ensure
			value_set: value = a_value
			contain_set: container = a_container
			is_default_property: is_default_property
		end

feature -- Access

	document: INI_DOCUMENT
			-- Document property is contained within
		do
			Result := container.document
		ensure
			result_attached: Result /= Void
		end

	container: INI_PROPERTY_CONTAINER
			-- Property container property is contained within

	name: detachable STRING assign set_name
			-- Property name (optional)

	value: STRING assign set_value
			-- Property string value

	is_default_property: BOOLEAN
			-- Is property an unnamed default property?
		do
			Result := name = Void
		end

	is_empty: BOOLEAN
			-- Does propery have an empty value?
		do
			Result := value.is_empty
		end

feature -- Status Report

	has_value: BOOLEAN
			-- Indiciates if property has an associated value
		do
			Result := not value.is_empty
		end

feature -- Element Change

	set_name (a_name: like name)
			-- Set `name' with `a_name'
		require
			non_a_name_is_empty: a_name /= Void implies not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_value (a_value: like value)
			-- Set `value' with `a_value'
		require
			a_value_attached: a_value /= Void
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

feature {NONE} -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		local
			l_value: like value
			l_name: like name
		do
			l_name := name
			if l_name = Void then
				l_name := once "@"
			end
			l_value := value
			create Result.make (l_name.count + l_value.count + 1)
			Result.append (l_name)
			Result.append_character ('=')
			Result.append (l_value)
		ensure then
			result_not_empty: not Result.is_empty
		end

invariant
	not_name_is_empty: attached name as n implies not n.is_empty
	value_attached: value /= Void
	not_value_is_empty: name = Void implies not value.is_empty
	container_attached: container /= Void
	is_default_property_correct: (name /= Void implies not is_default_property) or (name = Void implies is_default_property)

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
