note
	description: "List used in abstract syntax trees."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CONSTRUCT_LIST [T]

inherit
	ARRAYED_LIST [T]
		redefine
			make, make_filled
		end

create
	make

create {CONSTRUCT_LIST}
	make_filled

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Creation of the list.
		do
			insertion_position := n.min (1)
			Precursor (n)
		end

	make_filled (n: INTEGER)
			-- Creation of the list.
		do
			insertion_position := n
			Precursor (n)
		end

feature -- Special insertion

	reverse_extend (v: T)
			-- Add `v' to `Current'
		require
			extendible: extendible
		local
			l_pos: INTEGER
		do
			l_pos := insertion_position - 1
			insertion_position := l_pos
			area.put (v, l_pos)
		end

feature {NONE} -- Implementation

	insertion_position: INTEGER;
			-- Insertion position for `reverse_extend'.

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
