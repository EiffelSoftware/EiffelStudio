note
	description: "Encoding of arbitrary objects graphs between different version %
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
			write_header, is_transient_storage_required, setup_version
		end

create
	make

feature {NONE} -- Status Report

	is_transient_storage_required: BOOLEAN
			-- <Precursor>
		do
				-- We do not need transient attribute to be stored, only persistent one.
			Result := False
		end

feature {NONE} -- Implementation

	setup_version
			-- Set `version' with the appropriate version number.
			--| By default it is 0 for SED_INDEPENDENT_SERIALIZER and different of 0 for descendants.
			--| See SED_VERSIONS for a complete list of version numbers
		do
			version := 0
		end

	write_header (a_list: ARRAYED_LIST [ANY])
			-- Write header of storable.
		local
			l_dtype_table, l_attr_dtype_table: like type_table
			l_dtype: INTEGER
			l_ser: like serializer
			l_int: like internal
		do
			l_ser := serializer
			l_int := internal

				-- Write the version of storable used to create it.
				-- This is useful for versioning of formats upon retrieval to
				-- quickly detect incompatibilities.
				-- However to not break old SED_INDEPENDENT_SERIALIZER instances,
				-- we do not store it, it will be stored if we have a non-zero
				-- version which is the case for the descendants of this class.
			if version > 0 then
				l_ser.write_compressed_natural_32 (version)
			end

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
					-- Write the storable version number for that type, but only
					-- if the format supports it.
				if version >= {SED_VERSIONS}.recoverable_version_6_6 then
					if attached l_int.storable_version_of_type (l_dtype) as l_version and then not l_version.is_empty then
						l_ser.write_boolean (True)
						l_ser.write_immutable_string_8 (l_version)
					else
						l_ser.write_boolean (False)
					end
				end
			end

				-- Write mapping dynamic type and their string representation for static type
				-- of attributes of alive objects. We do not store the version number because
				-- there is no instances of those types present in the storable.
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

	attributes_dynamic_types (a_type_table: like type_table): like type_table
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
					if not l_int.is_field_transient_of_type (i, l_obj_dtype) then
						l_dtype := l_int.field_static_type_of_type (i, l_obj_dtype)
						if not a_type_table.has (l_dtype) then
								-- Only add types that are not already in `a_type_table'.
							Result.put (l_dtype, l_dtype)
						end
					end
					i := i + 1
				end
				a_type_table.forth
			end
		ensure
			attributes_dynamic_types_not_void: Result /= Void
		end

	write_attributes (a_dtype: INTEGER)
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
				l_ser.write_compressed_natural_32 (l_int.persistent_field_count_of_type (a_dtype).to_natural_32)
				nb := l_int.field_count_of_type (a_dtype) + 1
			until
				i = nb
			loop
				if not l_int.is_field_transient_of_type (i, a_dtype) then
						-- Write attribute static type
					l_ser.write_compressed_natural_32 (l_int.field_static_type_of_type (i, a_dtype).to_natural_32)
						-- Write attribute name
					l_ser.write_string_8 (l_int.field_name_of_type (i, a_dtype))
				end
				i := i + 1
			end
		end

note
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
