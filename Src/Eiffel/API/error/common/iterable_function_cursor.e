note
	description: "[
			External iteration cursor based on another iteration cursor and a function that performs a required conversion.
			First parameter specifies a type of elements produced by this cursor.
			Second parameter specifies a type of elements returned by the original iteration cursor.
		]"

class ITERABLE_FUNCTION_CURSOR [G, H]

inherit
	ITERATION_CURSOR [G]

create
	make

feature {NONE} -- Creation

	make (map: FUNCTION [H, G]; other: ITERATION_CURSOR [H])
			-- Associate iteration with `other' which elements are to be transformed using `map'.
		do
			target := other
			mapping_function := map
		ensure
			target = other
			mapping_function = map
		end

feature -- Access

	item: G
			-- <Precursor>
		do
			Result := mapping_function (target.item)
		end

feature -- Status report	

	after: BOOLEAN
			-- <Precursor>
		do
			Result := target.after
		end

feature -- Cursor movement

	forth
			-- <Precursor>
		do
			target.forth
		end

feature {NONE} -- Access

	target: ITERATION_CURSOR [H]
			-- Original iteration cursor.

	mapping_function: FUNCTION [H, G]
			-- Function to tranform elements produced by `target' to elements of the desired type {G}.

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
