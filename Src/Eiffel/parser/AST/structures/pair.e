indexing
	description: "Objects that contain 2 objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Emmanuel Stapf"
	date: "$Date$"
	revision: "$Revision$"

class
	PAIR [G,H]

create
	default_create,
	make

feature {NONE} -- Initialization

	make (a_first: G; a_second: H) is
			-- New pair made of `a_first' and `a_second'.
		do
			first := a_first
			second := a_second
		ensure
			first_set: first = a_first
			second_set: second = a_second
		end

feature -- Access

	first: G
			-- First item of pair.

	second: H
			-- Second item of pair.

feature -- Settings

	set_first (v: G) is
			-- Set `first' with `v'.
		do
			first := v
		ensure
			first_set: first = v
		end

	set_second (v: H) is
			-- Set `second' with `v'.
		do
			second := v
		ensure
			second_set: second = v
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class PAIR
