indexing
	description: "Abstraction of a GUID data structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_GUID

create
	make,
	make_empty
	
feature {NONE} -- Initialization

	make (data1: INTEGER; data2, data3: INTEGER_16; data4: ARRAY [NATURAL_8]) is
			-- Create Current using provided above information.
		require
			data4_not_void: data4 /= Void
			data4_valid_count: data4.count = 8
		do
			create item.make (size)
			item.put_integer_32 (data1, 0)
			item.put_integer_16 (data2, 4)
			item.put_integer_16 (data3, 6)
			item.put_array (data4, 8)
		end

	make_empty is
			-- Create a GUID with null data.
		do
			make (0, 0, 0, <<0,0,0,0,0,0,0,0>>)
		end

feature -- Access

	item: MANAGED_POINTER
			-- To hold data of Current.
			
	size: INTEGER is 16
			-- Size of structure.

invariant
	item_not_void: item /= Void

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

end -- class COM_GUID
