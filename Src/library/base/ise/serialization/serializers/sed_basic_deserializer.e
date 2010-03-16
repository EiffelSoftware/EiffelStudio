note
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

	dynamic_type_table: detachable SPECIAL [INTEGER]
			-- Mapping between old dynamic types and new ones.

	new_dynamic_type_id (a_old_type_id: INTEGER): INTEGER
			-- <Precursor>
		do
			if attached dynamic_type_table as t and then t.valid_index (a_old_type_id) then
				Result := t.item (a_old_type_id)
			else
					-- Mapping was not found, most likely what we are retrieving has been corrupted
					-- since serialization ensures that this could not happen.
				Result := -1
			end
		end

feature {NONE} -- Implementation

	read_header (a_count: NATURAL_32)
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

			check has_version: has_version end
			version := l_deser.read_compressed_natural_32
			if version /= {SED_VERSIONS}.basic_version then
				raise_fatal_error (error_factory.new_format_mismatch (version, {SED_VERSIONS}.basic_version))
			else
					-- Number of dynamic types in storable
				nb := l_deser.read_compressed_natural_32.to_integer_32
				create l_table.make_filled (0, nb)

					-- Read table which will give us mapping between the old dynamic types
					-- and the new ones.
				from
					i := 0
				until
					i = nb
				loop
					l_old_dtype := l_deser.read_compressed_natural_32.to_integer_32
					l_type_str := l_deser.read_string_8
					l_new_dtype := l_int.dynamic_type_from_string (l_type_str)
					if l_new_dtype >= 0 then
						if not l_table.valid_index (l_old_dtype) then
							l_table := l_table.aliased_resized_area_with_default (0, (l_old_dtype + 1).max (l_table.count * 2))
						end
						l_table.put (l_new_dtype, l_old_dtype)
					else
							-- It is a fatal error, but we still continue to make sure
							-- we collect all errors.
						add_error (error_factory.new_missing_type_error (l_type_str, l_type_str))
					end
					i := i + 1
				end
				dynamic_type_table := l_table

				read_object_table (a_count)
			end
		end

feature {NONE} -- Cleaning

	clear_internal_data
			-- Clear all allocated data
		do
			Precursor {SED_SESSION_DESERIALIZER}
			dynamic_type_table := Void
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
