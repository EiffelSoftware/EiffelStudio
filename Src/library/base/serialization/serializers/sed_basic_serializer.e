indexing
	description: "Objects that facilitate encoding and decoding of arbitrary objects %
		%graphs between sessions of a same program."
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
			l_dtype: INTEGER
			l_int: like internal
			l_ser: like serializer
		do
			l_int := internal
			l_ser := serializer

			from
					-- There is no good way to estimate how many different types
					-- there will be in the system, we guessed that 500 should give
					-- us a good initial number in most cases.
				create l_dtype_table.make (500)
				a_list.start
			until
				a_list.after
			loop
				l_dtype := l_int.dynamic_type (a_list.item)				
				l_dtype_table.force (l_int.type_name_of_type (l_dtype), l_dtype)
				a_list.forth
			end
			
			from
				l_ser.write_compressed_natural_32 (l_dtype_table.count.to_natural_32)
				l_dtype_table.start
			until
				l_dtype_table.after
			loop
				l_ser.write_compressed_natural_32 (l_dtype_table.key_for_iteration.to_natural_32)
				l_ser.write_string_8 (l_dtype_table.item_for_iteration)
				l_dtype_table.forth
			end
		end

end
