indexing
	description: "Encoding of arbitrary objects graphs between sessions of a same program."
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
			l_dtype_table: HASH_TABLE [STRING, INTEGER]
			l_ser: like serializer
		do
			from
				l_ser := serializer
				l_dtype_table := type_table (a_list)
				l_ser.write_compressed_natural_32 (l_dtype_table.count.to_natural_32)
				l_dtype_table.start
			until
				l_dtype_table.after
			loop
					-- Write dynamic type				
				l_ser.write_compressed_natural_32 (l_dtype_table.key_for_iteration.to_natural_32)
					-- Write type name				
				l_ser.write_string_8 (l_dtype_table.item_for_iteration)

				l_dtype_table.forth
			end
		end
		
	type_table (a_list: ARRAYED_LIST [ANY]): HASH_TABLE [STRING, INTEGER] is
			-- Given a list of objects `a_list', builds a mapping table between their
			-- dynamic type id and their type name.
		require
			a_list_not_void: a_list /= Void
			a_list_not_empty: not a_list.is_empty
		local
			l_dtype: INTEGER
			l_int: like internal
		do
			l_int := internal
			from
					-- There is no good way to estimate how many different types
					-- there will be in the system, we guessed that 500 should give
					-- us a good initial number in most cases.
				create Result.make (500)
				a_list.start
			until
				a_list.after
			loop
				l_dtype := l_int.dynamic_type (a_list.item)				
				Result.force (l_int.type_name_of_type (l_dtype), l_dtype)
				a_list.forth
			end
		ensure
			type_table_not_void: Result /= Void
		end

end
