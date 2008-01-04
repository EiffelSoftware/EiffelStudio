indexing
	description: "List used in abstract syntax trees."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CONSTRUCT_LIST [T]

inherit
	ARRAYED_LIST [T]
		export
			{ANY} all_default
		redefine
			make, make_filled
		end

create
	make

create {CONSTRUCT_LIST}
	make_filled

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Creation of the list.
		do
				-- We always use 1 for lower so we can optimize array setup.
			lower := 1
			upper := n
			create area.make (n)
		end

	make_filled (n: INTEGER) is
			-- Creation of the list.
		do
				-- We always use 1 for lower so we can optimize array setup.
			lower := 1
			upper := n
			count := n
			create area.make (n)
		end

feature -- Special insertion

	reverse_extend (v: T) is
			-- Add `v' to `Current'
		require
			extendible: extendible
		local
			l_count: INTEGER
		do
			l_count := count
			area.put (v, capacity - l_count - 1)
			count := l_count + 1
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

end
