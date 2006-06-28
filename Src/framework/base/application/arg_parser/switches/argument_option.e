indexing
	description: "Represents a user passed argument option."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_OPTION

create
	make,
	make_with_value

feature {NONE} -- Initialization

	make (a_name: like name) is
			-- Initializes option with just a name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			name  := a_name
		ensure
			name_set: name = a_name
		end

	make_with_value (a_name: like name; a_value: like value) is
			-- Initializes option with a name and an associated value.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_value_attached: a_value /= Void
		do
			make (a_name)
			value := a_value
		ensure
			name_set: name = a_name
			value_set: value = a_value
		end

feature -- Access

	name: STRING
			-- Option name

	value: STRING
			-- Option value, if any

feature -- Status Report

	has_value: BOOLEAN is
			-- Indicicate if option has an associated value.
		do
			Result := value /= Void
		end

invariant
	name_attached: name /= Void
	not_name_is_empty: not name.is_empty

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

end -- class {ARGUMENT_OPTION}
