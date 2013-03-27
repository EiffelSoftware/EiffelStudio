note
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
			write_header, setup_version
		end

create
	make

feature {NONE} -- Implementation

	setup_version
			-- <Precursor>
		do
			version := {SED_VERSIONS}.basic_version_6_6
		end

	write_header (a_list: ARRAYED_LIST [separate ANY])
			-- Write header of storable.
		local
			l_dtype_table: like type_table
			l_ser: like serializer
			l_reflector: like reflector
			l_dtype: INTEGER
		do
			l_ser := serializer
				-- Write the version of storable used to create it.
				-- This is useful for versioning of formats upon retrieval to
				-- quickly detect incompatibilities.
			l_ser.write_compressed_natural_32 (version)
			from
				l_reflector := reflector
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
				l_ser.write_string_8 (l_reflector.type_name_of_type (l_dtype))
				l_dtype_table.forth
			end

			write_object_table (a_list)
		end

	type_table (a_list: ARRAYED_LIST [separate ANY]): HASH_TABLE [INTEGER, INTEGER]
			-- Given a list of objects `a_list', builds a compact table of the
			-- dynamic type IDs present in `a_list'.
		require
			a_list_not_void: a_list /= Void
			a_list_not_empty: not a_list.is_empty
		local
			l_dtype: INTEGER
			l_reflector_object: like reflected_object
			l_area: SPECIAL [separate ANY]
			i, nb: INTEGER
		do
			l_reflector_object := reflected_object
			from
					-- There is no good way to estimate how many different types
					-- there will be in the system, we guessed that 500 should give
					-- us a good initial number in most cases.
				create Result.make (500)
				l_area := a_list.area
				i := 0
				nb := a_list.count
			until
				i = nb
			loop
				l_reflector_object.set_object (l_area.item (i))
				l_dtype := l_reflector_object.dynamic_type
				Result.put (l_dtype, l_dtype)
				i := i + 1
			end
		ensure
			type_table_not_void: Result /= Void
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
