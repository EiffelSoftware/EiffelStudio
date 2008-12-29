note
	description: "[
		Represents an INI document literal property.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	INI_LITERAL

inherit
	DEBUG_OUTPUT
		export
			{NONE}
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_container: like container)
			-- Initialize library with name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_container_attached: a_container /= Void
		do
			name := a_name
			container := a_container
		ensure
			name_set: name = a_name
			contain_set: container = a_container
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

	name: STRING assign set_name
			-- Property name (optional)

feature -- Element Change

	set_name (a_name: like name)
			-- Set `name' with `a_name'
		require
			a_name_attached: a_name /= Void
			non_a_name_is_empty: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

feature {NONE} -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (name)
		ensure then
			result_not_empty: not Result.is_empty
		end

invariant
	name_attached: name /= Void
	not_name_is_empty: not name.is_empty
	container_attached: container /= Void

note
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

end -- class {INI_LITERAL}
