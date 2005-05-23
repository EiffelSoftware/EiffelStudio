indexing
	description: "Decoding of arbitrary objects graphs between sessions of a same program."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_BASIC_DESERIALIZER

inherit
	SED_SESSION_DESERIALIZER
		redefine
			read_header,
			new_dynamic_type_id,
			clear_internal_data
		end

create
	make

feature {NONE} -- Implementation: Access

	dynamic_type_table: HASH_TABLE [INTEGER, INTEGER]
			-- Mapping between old dynamic types and new ones.

	new_dynamic_type_id (a_old_type_id: INTEGER): INTEGER is
			-- Given `a_old_type_id', dynamic type id in stored system, retrieve dynamic
			-- type id in current system.
		do
			check
				dynamic_type_table.has (a_old_type_id)
			end
			Result := dynamic_type_table.item (a_old_type_id)
		end
		
feature {NONE} -- Implementation

	read_header is
			-- Read header which contains mapping between dynamic type and their
			-- string representation.
		local
			i, nb: INTEGER
			l_deser: like deserializer
			l_int: like internal
			l_table: like dynamic_type_table
			l_old_dtype, l_new_dtype: INTEGER
		do
			l_int := internal
			l_deser := deserializer

				-- Number of dynamic types in storable
			nb := l_deser.read_compressed_natural_32.to_integer_32
			create l_table.make (nb)

				-- Read table which will give us mapping between the old dynamic types
				-- and the new ones.
			from
				i := 0
				nb := nb
			until
				i = nb
			loop
				l_old_dtype := l_deser.read_compressed_natural_32.to_integer_32
				l_new_dtype := l_int.dynamic_type_from_string (l_deser.read_string_8)
				if l_new_dtype = -1 then
					has_error := True
					i := nb - 1 -- Jump out of loop
				else
					l_table.put (l_new_dtype, l_old_dtype)
				end
				i := i + 1
			end
			dynamic_type_table := l_table
		end

feature {NONE} -- Cleaning

	clear_internal_data is
			-- Clear all allocated data
		do
			Precursor {SED_SESSION_DESERIALIZER}
			dynamic_type_table := Void
		end

end
