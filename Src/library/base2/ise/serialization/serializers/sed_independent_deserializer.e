indexing
	description: "Decoding of arbitrary objects graphs between sessions of programs %
		%containing the same types. It basically takes care of potential reordering %
		%of attributes from one system to the other."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_INDEPENDENT_DESERIALIZER

inherit
	SED_BASIC_DESERIALIZER
		redefine
			read_header,
			new_attribute_offset,
			clear_internal_data
		end

create
	make

feature {NONE} -- Implementation: access

	attributes_mapping: SPECIAL [SPECIAL [INTEGER]]
			-- Mapping for each dynamic type id between old attribute location
			-- and new attribute location.

	new_attribute_offset (a_new_type_id, a_old_offset: INTEGER): INTEGER is
			-- Given attribute offset `a_old_offset' in the stored object whose dynamic type id 
			-- is now `a_new_type_id', retrieve new offset in `a_new_type_id'.
		do
			check
				attributes_mapping_not_void: attributes_mapping /= Void
				attributes_mapping_has_dtype: attributes_mapping.valid_index (a_new_type_id)
				attributes_mapping_not_void_item: attributes_mapping.item (a_new_type_id) /= Void
				attributes_mapping_has_offset: attributes_mapping.item (a_new_type_id).valid_index (a_old_offset)
				attributes_mapping_has_mapping: attributes_mapping.item (a_new_type_id).item (a_old_offset) >= 0
			end
			Result := attributes_mapping.item (a_new_type_id).item (a_old_offset)
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
			l_type_str: STRING
		do
			l_int := internal
			l_deser := deserializer

				-- Number of dynamic types in storable
			nb := l_deser.read_compressed_natural_32.to_integer_32
			create l_table.make (nb)
			create attributes_mapping.make (nb)

				-- Read table which will give us mapping between the old dynamic types
				-- and the new ones.
			from
				i := 0
			until
				i = nb
			loop
					-- Read old dynamic type
				l_old_dtype := l_deser.read_compressed_natural_32.to_integer_32

					-- Read type string associated to `l_old_dtype' and find dynamic type
					-- in current system.
				l_type_str := l_deser.read_string_8
				l_new_dtype := l_int.dynamic_type_from_string (l_type_str)
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

			if not has_error then
					-- Read table which will give us mapping between the old dynamic types
					-- and the new ones.
				from
					i := 0
					nb := l_deser.read_compressed_natural_32.to_integer_32
				until
					i = nb
				loop
						-- Read old dynamic type
					l_old_dtype := l_deser.read_compressed_natural_32.to_integer_32
	
						-- Read type string associated to `l_old_dtype' and find dynamic type
						-- in current system.
					l_type_str := l_deser.read_string_8
					l_new_dtype := l_int.dynamic_type_from_string (l_type_str)
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

				if not has_error then
						-- Now set `dynamic_type_table' as all old dynamic type IDs have
						-- be read and resolved.
					dynamic_type_table := l_table
	
						-- Read attributes map for each dynamic type.
					from
						i := 0
						nb := l_deser.read_compressed_natural_32.to_integer_32
					until
						i = nb
					loop
							-- Read old dynamic type.
						l_old_dtype := l_deser.read_compressed_natural_32.to_integer_32
	
							-- Read attributes description
						read_attributes (l_table.item (l_old_dtype))
						if has_error then
								-- We had an error while retrieving stored attributes
								-- for `l_old_dtype'.
							i := nb - 1	-- Jump out of loop
						end
						i := i + 1
					end

					if not has_error then
							-- Read object_table if any.
						read_object_table (a_count)
					end
				end
			end
		end

	read_attributes (a_dtype: INTEGER) is
			-- Read attribute description for `a_dtype' where `a_dtype' is a dynamic type
			-- from the current system.
		require
			a_dtype_non_negative: a_dtype >= 0
			attributes_mapping_not_void: attributes_mapping /= Void
		local
			l_deser: like deserializer
			l_map: like attributes_map
			l_mapping: SPECIAL [INTEGER]
			l_name: STRING
			l_dtype, l_field_count: INTEGER
			i, nb: INTEGER
		do
			l_deser := deserializer

				-- Compare count of attributes
			l_field_count := internal.field_count_of_type (a_dtype)
			nb := l_deser.read_compressed_natural_32.to_integer_32

			if nb /= l_field_count then
					-- Stored type has a different number of attributes than the type
					-- from the retrieving system.
				set_has_error
			else
				from
					i := 1
					l_map := attributes_map (a_dtype, l_field_count)
					nb := nb + 1				
					create l_mapping.make (nb)
				until
					i = nb
				loop
						-- Read attribute static type
					l_dtype := new_dynamic_type_id (l_deser.read_compressed_natural_32.to_integer_32)
						-- Write attribute name
					l_name := l_deser.read_string_8

					l_map.search (l_name)
					if l_map.found then
						if l_map.found_item.integer_32_item (2) /= l_dtype then
							set_has_error
							i := nb - 1 -- Jump out of loop
						else
							l_mapping.put (l_map.found_item.integer_32_item (1), i)
						end
					else
						set_has_error
						i := nb	- 1 -- Jump out of loop
					end
					i := i + 1
				end
				if not has_error then
					if not attributes_mapping.valid_index (a_dtype) then
						attributes_mapping := attributes_mapping.resized_area ((a_dtype + 1).max (
							attributes_mapping.count * 2))
					end
					attributes_mapping.put (l_mapping, a_dtype)
				end
			end
		end

	attributes_map (a_dtype, a_field_count: INTEGER): HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			-- Attribute map for dynamic type `a_dtype' which records
			-- position and dynamic type for a given attribute name.
		require
			a_dtype_non_negative: a_dtype >= 0
			a_field_count_non_negative: a_field_count >= 0
		local
			l_int: like internal
			i, nb: INTEGER
		do
			l_int := internal

			from
				i := 1
				create Result.make (a_field_count)
				nb := a_field_count + 1
			until
				i = nb
			loop
				Result.put (
					[i, l_int.field_static_type_of_type (i, a_dtype)], 
					l_int.field_name_of_type (i, a_dtype))
				i := i + 1
			end
		ensure
			attributes_map_not_void: Result /= Void
		end

feature {NONE} -- Cleaning

	clear_internal_data is
			-- Clear all allocated data
		do
			Precursor {SED_BASIC_DESERIALIZER}
			attributes_mapping := Void
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
