indexing
	description: "Encoding of arbitrary objects graphs between sessions %
		%of programs containing the same types."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			l_dtype_table, l_attr_dtype_table: like type_table
			l_dtype: INTEGER
			l_ser: like serializer
			l_int: like internal
		do
			l_ser := serializer
			l_int := internal

			l_dtype_table := type_table (a_list)

				-- Write mapping dynamic type and their string representation for alive objects.
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
				l_dtype_table.forth
			end

				-- Write mapping dynamic type and their string representation for static type
				-- of attributes of alive objects.
			from
					-- Write number of types being written
				l_attr_dtype_table := attributes_dynamic_types (l_dtype_table)
				l_ser.write_compressed_natural_32 (l_attr_dtype_table.count.to_natural_32)
				l_attr_dtype_table.start
			until
				l_attr_dtype_table.after
			loop
					-- Write dynamic type
				l_dtype := l_attr_dtype_table.item_for_iteration
				l_ser.write_compressed_natural_32 (l_dtype.to_natural_32)
					-- Write type name
				l_ser.write_string_8 (l_int.type_name_of_type (l_dtype))
				l_attr_dtype_table.forth
			end

				-- Write attribute description mapping
			from
				l_ser.write_compressed_natural_32 (l_dtype_table.count.to_natural_32)
				l_dtype_table.start
			until
				l_dtype_table.after
			loop
					-- Write dynamic type
				l_dtype := l_dtype_table.item_for_iteration
				l_ser.write_compressed_natural_32 (l_dtype.to_natural_32)
					-- Write attributes description
				write_attributes (l_dtype)
				l_dtype_table.forth
			end

				-- Write object table if necessary.
			write_object_table (a_list)
		end
	
	attributes_dynamic_types (a_type_table: like type_table): like type_table is
			-- Table of dynamic types of attributes appearing in `a_type_table'.
		require
			a_type_table_not_void: a_type_table /= Void
		local
			l_int: like internal
			i, nb: INTEGER
			l_dtype, l_obj_dtype: INTEGER
		do
			l_int := internal
			from
				a_type_table.start
				create Result.make (500)
			until
				a_type_table.after
			loop
				from
					i := 1
					l_obj_dtype := a_type_table.item_for_iteration
					nb := l_int.field_count_of_type (l_obj_dtype)
					nb := nb + 1
				until
					i = nb
				loop
					l_dtype := l_int.field_static_type_of_type (i, l_obj_dtype)
					if not a_type_table.has (l_dtype) then
							-- Only add types that are not already in `a_type_table'.
						Result.put (l_dtype, l_dtype)
					end
					i := i + 1
				end
				a_type_table.forth
			end
		ensure
			attributes_dynamic_types_not_void: Result /= Void
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
