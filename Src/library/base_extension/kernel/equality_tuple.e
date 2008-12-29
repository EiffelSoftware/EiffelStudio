note
	description: "TUPLE with different is_equal that checks the values"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	EQUALITY_TUPLE [G -> TUPLE create default_create end]

inherit
	ANY
		redefine
			default_create,
			is_equal
		end

create
	default_create,
	make

convert
	make ({G})

feature {NONE} -- Initialization

	default_create
			-- Process instances of classes with no creation clause.
		do
			Precursor {ANY}
			create item
		end

	make (a_tuple: G)
			-- Initialize wrapper with implementation item
		do
			item := a_tuple
		ensure
			item_set: item = a_tuple
		end

feature -- Access

	item: G
			-- Implementation item

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does table contain the same information as `other'?
		local
			l_item, l_other: ANY
			l_count, i: INTEGER
		do
			l_count := item.count
			Result := l_count = other.item.count
			if Result then
				from i := 1 until i > l_count loop
					l_item := item.item (i)
					l_other := other.item [i]
					Result := equal (l_item, l_other)
					i := i + 1
				end
			end
		end

;note
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

end -- class {EQUALITY_TUPLE}
