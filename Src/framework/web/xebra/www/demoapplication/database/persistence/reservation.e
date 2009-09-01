note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	RESERVATION

create
	make, make_with_arguments

feature {NONE} -- Initialization

	make_with_arguments (a_id: INTEGER; a_name: STRING; a_date: DATE; a_persons: INTEGER; a_description: STRING)
			-- Initialization for `Current'.
		require
			not_a_name_is_detached_or_not_empty: a_name /= Void implies not a_name.is_empty
			not_a_date_is_detached_or_empty: a_date /= Void
			not_a_description_is_detached_or_empty: a_description /= Void and then not a_description.is_empty
		do
			id := a_id
			name := a_name
			date:= a_date
			persons:= a_persons
			description:= a_description
		ensure
			id_set:  id ~ a_id
			name_set:  name ~ a_name
			date_set: date ~ a_date
			persons_set: persons ~ a_persons
			description_set: description ~ a_description
		end

	make
		do
			id := 0
			name := "default_name"
			create date.make_now
			persons := 1
			description := ""
		end

feature -- Access

	id: INTEGER
	name: STRING assign set_name
	set_name (a_name: STRING)
		do
			name := a_name
		end
	date:  DATE assign set_date
	set_date (a_date: DATE)
		do
			date := a_date
		end
	persons: INTEGER
	s_persons: STRING assign set_s_persons
		do
			Result := persons.out
		end
	set_s_persons (a_s_persons: STRING)
		do
			persons := a_s_persons.to_integer
		end
	description: STRING assign set_description
	set_description (a_desc: STRING)
		do
			description := a_desc
		end


invariant
	not_name_is_detached_or_empty: name /= Void and then not name.is_empty
	not_date_is_detached_or_empty: date /= Void
	not_description_is_detached_or_empty: description /= Void
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
