note
	description: "[
			An iterable based on another one whose items of one type are mapped to values of another type with a specified function.
			The first parameter specifies the type of elements in the original iterable structure.
			The second parameter specifies the type of elements returned by this iterable structure.
			
			Example. The following expression produces an iterable with a sequence of two values: "no" and "yes":
				
					create {ITERABLE_MAP [BOOLEAN, STRING]}.make
						(agent (v: BOOLEAN)
							do
								Result := if v then "yes" else "no" end
							end,
						<<false, true>>)
		]"

class ITERABLE_MAP [G, H]

inherit
	ITERABLE [H]

create
	make

feature {NONE} -- Creation

	make (map: FUNCTION [G, H]; other: ITERABLE [G])
			-- Associate iteration with `other' which elements are to be transformed using `map'.
		do
			target := other
			mapping_function := map
		ensure
			target = other
			mapping_function = map
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [H]
			-- <Precursor>
		do
			create {ITERABLE_MAP_CURSOR [G, H]} Result.make (mapping_function, target.new_cursor)
		end

feature {NONE} -- Access

	target: ITERABLE [G]
			-- Original structure to be iterated over.

	mapping_function: FUNCTION [G, H]
			-- Function to tranform elements of the original structure `target' to elements of the desired type {H}.

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
