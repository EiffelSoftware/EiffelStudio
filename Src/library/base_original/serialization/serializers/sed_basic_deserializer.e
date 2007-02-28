indexing
	description: "Decoding of arbitrary objects graphs between sessions of a same program."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	dynamic_type_table: SPECIAL [INTEGER]
			-- Mapping between old dynamic types and new ones.

	new_dynamic_type_id (a_old_type_id: INTEGER): INTEGER is
			-- Given `a_old_type_id', dynamic type id in stored system, retrieve dynamic
			-- type id in current system.
		do
			check
				dynamic_type_table.valid_index (a_old_type_id)
				dynamic_type_table.item (a_old_type_id) >= 0
			end
			Result := dynamic_type_table.item (a_old_type_id)
		end
		
feature {NONE} -- Implementation

	read_header (a_count: NATURAL_32) is
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
			until
				i = nb
			loop
				l_old_dtype := l_deser.read_compressed_natural_32.to_integer_32
				l_new_dtype := l_int.dynamic_type_from_string (l_deser.read_string_8)
				if l_new_dtype = -1 then
					set_has_error
					i := nb - 1 -- Jump out of loop
				else
					if not l_table.valid_index (l_old_dtype) then
						l_table := l_table.resized_area ((l_old_dtype + 1).max (l_table.count * 2))
					end
					l_table.put (l_new_dtype, l_old_dtype)
				end
				i := i + 1
			end
			dynamic_type_table := l_table

			read_object_table (a_count)
		end

feature {NONE} -- Cleaning

	clear_internal_data is
			-- Clear all allocated data
		do
			Precursor {SED_SESSION_DESERIALIZER}
			dynamic_type_table := Void
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
