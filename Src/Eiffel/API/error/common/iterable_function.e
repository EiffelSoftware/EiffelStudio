note
	description: "[
			Structure that can be iterated over based on another iterable structure and a function that performs a required conversion.
			First parameter specifies a type of elements returned by this iterable structure.
			Second parameter specifies a type of elements in the original iterable structure.
		]"

class ITERABLE_FUNCTION [G, H]

inherit
	ITERABLE [G]

create
	make

feature {NONE} -- Creation

	make (map: FUNCTION [H, G]; other: ITERABLE [H])
			-- Associate iteration with `other' which elements are to be transformed using `map'.
		do
			target := other
			mapping_function := map
		ensure
			target = other
			mapping_function = map
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [G]
			-- <Precursor>
		do
			create {ITERABLE_FUNCTION_CURSOR [G, H]} Result.make (mapping_function, target.new_cursor)
		end

feature {NONE} -- Access

	target: ITERABLE [H]
			-- Original structure to be iterated over.

	mapping_function: FUNCTION [H, G]
			-- Function to tranform elements of the original structure `target' to elements of the desired type {G}.

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
