indexing
	description: "Encoding of arbitrary objects graphs between sessions of a same program."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_BASIC_SERIALIZER

inherit
	SED_SESSION_SERIALIZER
		redefine
			write_header
		end

create
	make

feature {NONE} -- Implementation

	write_header (a_list: ARRAYED_LIST [ANY]) is
			-- Write header of storable.
		local
			l_dtype_table: like type_table
			l_ser: like serializer
			l_int: like internal
			l_dtype: INTEGER
		do
			from
				l_ser := serializer
				l_int := internal
				l_dtype_table := type_table (a_list)
				l_ser.write_compressed_natural_32 (l_dtype_table.count.to_natural_32)
				l_dtype_table.start
			until
				l_dtype_table.after
			loop
					-- Write dynamic type
				l_dtype := l_dtype_table.item_for_iteration
				l_ser.write_compressed_natural_32 (l_dtype.to_natural_32)
					-- Write type name
				l_ser.write_string_8 (l_int.type_name_of_type (l_dtype))

				l_dtype_table.forth
			end
			
			write_object_table (a_list)
		end
		
	type_table (a_list: ARRAYED_LIST [ANY]): HASH_TABLE [INTEGER, INTEGER] is
			-- Given a list of objects `a_list', builds a compact table of the
			-- dynamic type IDs present in `a_list'.
		require
			a_list_not_void: a_list /= Void
			a_list_not_empty: not a_list.is_empty
		local
			l_dtype: INTEGER
			l_int: like internal
			l_array: ARRAY [ANY]
			l_area: SPECIAL [ANY]
			i, nb: INTEGER
		do
			l_int := internal
			from
					-- There is no good way to estimate how many different types
					-- there will be in the system, we guessed that 500 should give
					-- us a good initial number in most cases.
				create Result.make (500)
				l_array := a_list
				l_area := l_array.area
				l_array := Void
				i := 0
				nb := a_list.count
			until
				i = nb
			loop
				l_dtype := l_int.dynamic_type (l_area.item (i))				
				Result.put (l_dtype, l_dtype)
				i := i + 1
			end
		ensure
			type_table_not_void: Result /= Void
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
