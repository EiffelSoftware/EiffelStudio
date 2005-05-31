indexing
	description: "Encoding of arbitrary objects graphs between sessions %
		%of programs containing the same types."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_INDEPENDENT_SERIALIZER

inherit
	SED_BASIC_SERIALIZER
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
			l_dtype: INTEGER
			l_ser: like serializer
			l_int: like internal
		do
			l_ser := serializer
			l_int := internal

			l_dtype_table := type_table (a_list)
			
			from
					-- Write number of types being written
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
					-- Write attributes description
				write_attributes (l_dtype)

				l_dtype_table.forth
			end
			
				-- Write object table if necessary.
			write_object_table (a_list)
		end
		
	write_attributes (a_dtype: INTEGER) is
			-- Write attribute description for type whose dynamic type id is `a_dtype'.
		require
			a_dtype_non_negative: a_dtype >= 0
		local
			l_int: like internal
			l_ser: like serializer
			i, nb: INTEGER
		do
			l_int := internal
			l_ser := serializer
			from
				i := 1
				nb := l_int.field_count_of_type (a_dtype)
				l_ser.write_compressed_natural_32 (nb.to_natural_32)
				nb := nb + 1
			until
				i = nb
			loop
					-- Write attribute static type
				l_ser.write_compressed_natural_32 (l_int.field_static_type_of_type (i, a_dtype).to_natural_32)
					-- Write attribute name
				l_ser.write_string_8 (l_int.field_name_of_type (i, a_dtype))
				
				i := i + 1
			end
		end

end
