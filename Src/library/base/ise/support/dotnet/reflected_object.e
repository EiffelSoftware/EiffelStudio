note
	description: "Common ancestor for object inspection."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REFLECTED_OBJECT

inherit
	REFLECTOR_CONSTANTS

feature -- Access

	object: ANY
			-- Associated object for Current.
			-- It might be a copy if Current is expanded.
		deferred
		end

	class_name: STRING
			-- Name of the class associated with `object'
		do
			Result := helper.class_name_of_type (dynamic_type)
		end

	type_name: STRING
			-- Name of `object''s generating type (type of which `object'
			-- is a direct instance).
		do
			Result := helper.type_name_of_type (dynamic_type)
		end

	dynamic_type: INTEGER
			-- Dynamic type of `object'

	generic_count: INTEGER
			-- Number of generic parameter in base type of `object'.
		do
			Result := helper.generic_count_of_type (dynamic_type)
		end

	generic_dynamic_type (i: INTEGER): INTEGER
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		require
			object_generic: generic_count > 0
			i_valid: i > 0 and i <= generic_count
		do
			Result := helper.generic_dynamic_type_of_type (dynamic_type, i)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	field (i: INTEGER): detachable ANY
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
			-- Use specific version of `xxx_field' to get best performance.
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			not_special: not is_special
		do
			inspect field_type (i)
			when integer_8_type then Result := integer_8_field (i)
			when integer_16_type then Result := integer_16_field (i)
			when integer_32_type then Result := integer_32_field (i)
			when integer_64_type then Result := integer_64_field (i)
			when natural_8_type then Result := natural_8_field (i)
			when natural_16_type then Result := natural_16_field (i)
			when natural_32_type then Result := natural_32_field (i)
			when natural_64_type then Result := natural_64_field (i)
			when real_32_type then Result := real_32_field (i)
			when real_64_type then Result := real_64_field (i)
			when character_8_type then Result := character_8_field (i)
			when character_32_type then Result := character_32_field (i)
			when boolean_type then Result := boolean_field (i)
			when pointer_type then Result := pointer_field (i)
			when expanded_type, reference_type then Result := reference_field (i)
			end
		end

	reference_field (i: INTEGER): detachable ANY
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			not_special: not is_special
			reference_field: field_type (i) = reference_type or field_type (i) = expanded_type
		do
			Result := internal_field (i)
		end

feature {REFLECTED_OBJECT} -- Access

	physical_offset: INTEGER
			-- In classic Eiffel, actual offset in bytes of `object' in `enclosing_object'.
			-- In .NET Eiffel, field offset of `object' in `enclosing_object'.

	enclosing_object: separate ANY
			-- Enclosing object containing `object' or a reference to `object.

	reflected_parent_object: detachable REFLECTED_OBJECT
			-- Path to Current attribute.

	field_info: detachable FIELD_INFO
			-- Field used by `reflected_parent_object' object to access `object'.

feature -- Status report

	is_instance_of (type_id: INTEGER): BOOLEAN
			-- Is `object' an instance of type `type_id'?
		require
			object_not_void: object /= Void
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.type_conforms_to (dynamic_type, type_id)
		end

	is_special: BOOLEAN
			-- Is `object' special?
		do
			Result := helper.is_special_type (dynamic_type)
		end

	is_special_of_expanded: BOOLEAN
			-- Is Current a SPECIAL [XX] where `XX' is a user defined expanded type?
		require
			is_special: is_special
		do
			Result := helper.is_special_expanded_type (dynamic_type)
		end

	is_special_of_reference: BOOLEAN
			-- Is Current a SPECIAL [XX] where `XX' is a reference type?
		require
			is_special: is_special
		do
			Result := helper.is_special_any_type (dynamic_type)
		end

	is_expanded: BOOLEAN
			-- Is Current an instance of an expanded type?
		do
			Result := helper.is_expanded_type (dynamic_type)
		end

	is_tuple: BOOLEAN
			-- Is `object' a TUPLE?
		do
			Result := helper.is_tuple_type (dynamic_type)
		end

	is_field_transient (i: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' a transient attribute?
			-- I.e. an attribute that does not need to be stored?
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		do
			Result := helper.is_field_transient_of_type (i, dynamic_type)
		end

	is_field_statically_expanded (i: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' a user-defined expanded attribute?
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		do
			Result := helper.is_field_expanded_of_type (i, dynamic_type)
		end

	is_copy_semantics_field (i: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' a reference with copy-semantics properties?
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			is_reference_field: field_type (i) = reference_type
		local
			l_obj: detachable SYSTEM_OBJECT
		do
			l_obj := internal_field (i)
			Result := l_obj /= Void and then attached l_obj.get_type as l_type and then l_type.is_value_type
		end

	is_special_copy_semantics_item (i: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' a reference with copy-semantics properties?
		require
			is_specail: is_special
			is_special_of_reference: is_special_of_reference
			valid_index: attached {ABSTRACT_SPECIAL} object as l_spec and then l_spec.valid_index (i)
		local
			l_obj: detachable SYSTEM_OBJECT
		do
			if attached {SPECIAL [detachable separate SYSTEM_OBJECT]} object as l_spec then
				l_obj := l_spec.item (i)
				Result := l_obj /= Void and then attached l_obj.get_type as l_type and then l_type.is_value_type
			end
		end

	is_field_statically_attached (i: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' defined as attached?
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		do
			Result := False
		end

	field_conforms_to (a_source_type, a_field_type: INTEGER): BOOLEAN
			-- Does `a_source_type' conform to `a_field_type'?
			--| Different from `type_conforms_to' since possible attachment mark of `a_field_type'
			--| is discarded.
		require
			a_source_type_non_negative: a_source_type >= 0
			a_field_type_non_negative: a_field_type >= 0
		do
			Result := helper.field_conforms_to (a_source_type, a_field_type)
		end

feature -- Access

	field_name (i: INTEGER): STRING
			-- Name of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			not_special: not is_special
		do
			Result := helper.field_name_of_type (i, dynamic_type)
		ensure
			Result_exists: Result /= Void
		end

	field_offset (i: INTEGER): INTEGER
			-- Offset of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			not_special: not is_special
		do
			check False then end
			Result := i * 4
		end

	field_type (i: INTEGER): INTEGER
			-- Abstract type of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		do
			Result := helper.field_type_of_type (i, dynamic_type)
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_static_type (i: INTEGER): INTEGER
			-- Static type of declared `i'-th field of dynamic type `dynamic_type'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		do
			Result := helper.field_static_type_of_type (i, dynamic_type)
		ensure
			field_type_nonnegative: Result >= 0
		end

	copy_semantics_field (i: INTEGER): REFLECTED_COPY_SEMANTICS_OBJECT
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			not_special: not is_special
			reference_field: field_type (i) = reference_type and is_copy_semantics_field (i)
		deferred
		end

	special_copy_semantics_item (i: INTEGER): REFLECTED_COPY_SEMANTICS_OBJECT
			-- Object attached to the `i'th item of special.
		require
			is_special: is_special
			is_special_reference: is_special_of_reference
			valid_index: attached {ABSTRACT_SPECIAL} object as l_spec and then l_spec.valid_index (i)
		do
				-- We create a copy of `Current' otherwise if we update it with a new object
				-- the newly created instance would become invalid.
			create Result.make_special (twin, i)
		end

	expanded_field (i: INTEGER): REFLECTED_OBJECT
			-- Object representation of the `i'-th field of `object'
			-- which is expanded. We provide a wrapper that enables
			-- direct editing of the field without duplicating
			-- the expanded object.
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			expanded_field: field_type (i) = expanded_type
			not_special: not is_special
		deferred
		end

	character_8_field (i: INTEGER): CHARACTER_8
			-- CHARACTER_8 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			character_8_field: field_type (i) = Character_8_type
		do
			if attached {CHARACTER_8} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	character_32_field (i: INTEGER): CHARACTER_32
			-- CHARACTER_32 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			character_32_field: field_type (i) = Character_32_type
		do
			if attached {CHARACTER_32} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	boolean_field (i: INTEGER): BOOLEAN
			-- Boolean value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			boolean_field: field_type (i) = Boolean_type
		do
			if attached {BOOLEAN} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	natural_8_field (i: INTEGER): NATURAL_8
			-- NATURAL_8 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_8_field: field_type (i) = natural_8_type
		do
			if attached {NATURAL_8} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	natural_16_field (i: INTEGER): NATURAL_16
			-- NATURAL_16 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_16_field: field_type (i) = natural_16_type
		do
			if attached {NATURAL_16} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	natural_32_field (i: INTEGER): NATURAL_32
			-- NATURAL_32 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_32_field: field_type (i) = natural_32_type
		do
			if attached {NATURAL_32} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	natural_64_field (i: INTEGER): NATURAL_64
			-- NATURAL_64 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_64_field: field_type (i) = natural_64_type
		do
			if attached {NATURAL_64} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	integer_8_field (i: INTEGER): INTEGER_8
			-- INTEGER_8 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_8_field: field_type (i) = Integer_8_type
		do
			if attached {INTEGER_8} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	integer_16_field (i: INTEGER): INTEGER_16
			-- INTEGER_16 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_16_field: field_type (i) = Integer_16_type
		do
			if attached {INTEGER_16} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	integer_32_field (i: INTEGER): INTEGER
			-- INTEGER_32 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_32_field: field_type (i) = Integer_32_type
		do
			if attached {INTEGER} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	integer_64_field (i: INTEGER): INTEGER_64
			-- INTEGER_64 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_64_field: field_type (i) = Integer_64_type
		do
			if attached {INTEGER_64} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	real_32_field (i: INTEGER): REAL_32
			-- Real value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			real_32_field: field_type (i) = real_32_type
		do
			if attached {REAL_32} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	pointer_field (i: INTEGER): POINTER
			-- Pointer value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			pointer_field: field_type (i) = Pointer_type
		do
			if attached {POINTER} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

	real_64_field (i: INTEGER): REAL_64
			-- Double precision value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			real_64_field: field_type (i) = real_64_type
		do
			if attached {REAL_64} internal_field (i) as v then
				Result := v
			else
				check False end
			end
		end

feature -- Element change

	set_reference_field (i: INTEGER; value: detachable ANY)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			reference_field: field_type (i) = Reference_type
			valid_value:  is_field_statically_attached (i) implies value /= Void
			value_conforms_to_field_static_type:
				value /= Void implies field_conforms_to (value.generating_type.type_id, field_static_type (i))
		do
			internal_set_field (i, value)
		end

	set_real_64_field, set_double_field (i: INTEGER; value: REAL_64)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			real_64_field: field_type (i) = real_64_type
		do
			internal_set_field (i, value)
		end

	set_character_8_field, set_character_field (i: INTEGER; value: CHARACTER_8)
			-- Set character value of `i'-th field of `object' to `value'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			character_field: field_type (i) = Character_8_type
		do
			internal_set_field (i, value)
		end

	set_character_32_field (i: INTEGER; value: CHARACTER_32)
			-- Set character 32 value of `i'-th field of `object' to `value'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			character_field: field_type (i) = Character_32_type
		do
			internal_set_field (i, value)
		end

	set_boolean_field (i: INTEGER; value: BOOLEAN)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			boolean_field: field_type (i) = Boolean_type
		do
			internal_set_field (i, value)
		end

	set_natural_8_field (i: INTEGER; value: NATURAL_8)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_8_field: field_type (i) = natural_8_type
		do
			internal_set_field (i, value)
		end

	set_natural_16_field (i: INTEGER; value: NATURAL_16)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_16_field: field_type (i) = natural_16_type
		do
			internal_set_field (i, value)
		end

	set_natural_32_field (i: INTEGER; value: NATURAL_32)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_32_field: field_type (i) = natural_32_type
		do
			internal_set_field (i, value)
		end

	set_natural_64_field (i: INTEGER; value: NATURAL_64)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_64_field: field_type (i) = natural_64_type
		do
			internal_set_field (i, value)
		end

	set_integer_8_field (i: INTEGER; value: INTEGER_8)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_8_field: field_type (i) = Integer_8_type
		do
			internal_set_field (i, value)
		end

	set_integer_16_field (i: INTEGER; value: INTEGER_16)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_16_field: field_type (i) = Integer_16_type
		do
			internal_set_field (i, value)
		end

	set_integer_field, set_integer_32_field (i: INTEGER; value: INTEGER)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_32_field: field_type (i) = Integer_32_type
		do
			internal_set_field (i, value)
		end

	set_integer_64_field (i: INTEGER; value: INTEGER_64)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_64_field: field_type (i) = Integer_64_type
		do
			internal_set_field (i, value)
		end

	set_real_32_field, set_real_field (i: INTEGER; value: REAL_32)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			real_32_field: field_type (i) = real_32_type
		do
			internal_set_field (i, value)
		end

	set_pointer_field (i: INTEGER; value: POINTER)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			pointer_field: field_type (i) = Pointer_type
		do
			internal_set_field (i, value)
		end

feature -- Measurement

	field_count: INTEGER
			-- Number of logical fields in `object'
		do
			Result := helper.field_count_of_type (dynamic_type)
		end

	persistent_field_count: INTEGER
			-- Number of logical fields in `object' that are not transient.
		do
			Result := helper.persistent_field_count_of_type (dynamic_type)
		ensure
			count_positive: Result >= 0
		end

	physical_size: INTEGER
			-- Space occupied by `object' in bytes
		local
			l_size: NATURAL_64
		do
			l_size := physical_size_64
				-- Prevent overflow by giving the maximum INTEGER_32 value when it is very large.
			Result := l_size.min ({INTEGER_32}.max_value.as_natural_64).as_integer_32
		end

	deep_physical_size: INTEGER
			-- Space occupied by `object' and its children in bytes
		local
			l_size: NATURAL_64
		do
			l_size := deep_physical_size_64
				-- Prevent overflow by giving the maximum INTEGER_32 value when it is very large.
			Result := l_size.min ({INTEGER_32}.max_value.as_natural_64).as_integer_32
		end

	physical_size_64: NATURAL_64
			-- Space occupied by `object' in bytes
		do
			Result := {ISE_RUNTIME}.object_size (object)
		end

	deep_physical_size_64: NATURAL_64
			-- Space occupied by `object' and its children in bytes
		local
			l_traverse: OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE
		do
			create l_traverse
			l_traverse.set_root_object (object)
			l_traverse.set_is_skip_transient (False)
			l_traverse.traverse
			if attached l_traverse.visited_objects as l_objects then
				from
					l_objects.start
				until
					l_objects.after
				loop
					Result := Result + {ISE_RUNTIME}.object_size (l_objects.item)
					l_objects.forth
				end
			end
		end

feature {REFLECTED_OBJECT} -- Helper

	depth: INTEGER
			-- Depth from `enclosing_object' to reach Current.
		do
			if attached reflected_parent_object as l_parent then
					-- Only recurse if necessary
				if l_parent.physical_offset = 0 then
					Result := 1
				else
					Result := l_parent.depth + 1
				end
			end
		end

	fill_field_infos (l_fields: like single_field_info_array; a_index: INTEGER)
			-- Fill `l_fields' to build a path of FieldInfo instances from `enclosing_object' to `Current'.
		require
			valid_bounds: l_fields.count >= a_index
		do
			if attached reflected_parent_object as l_parent then
				l_fields.put (a_index - 1, field_info)
					-- Only recurse if necessary
				if l_parent.physical_offset > 0 then
					l_parent.fill_field_infos (l_fields, a_index - 1)
				end
			end
		end

feature {NONE} -- Implementation

	helper: DOTNET_REFLECTOR
			-- Helper that tell us all about types in a .NET system.
		once
			create Result
		end

	internal_field (i: INTEGER): detachable SYSTEM_OBJECT
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			not_special: not is_special
		local
			l_fields: like single_field_info_array
			l_field: FIELD_INFO
			l_depth: INTEGER
		do
			if physical_offset = 0 then
				Result := helper.get_members (dynamic_type).i_th (i).get_value (enclosing_object)
			else
				l_depth := depth
				if l_depth = 1 then
						-- Optimization when it is not a deeply nested object.
					l_fields := single_field_info_array
				else
					create l_fields.make (l_depth)
				end
				fill_field_infos (l_fields, l_depth)
				l_field := helper.get_members (dynamic_type).i_th (i)
				Result := {ISE_RUNTIME}.field_of_expanded (enclosing_object, l_fields, l_field)
			end
		end

	internal_set_field (i: INTEGER; value: detachable SYSTEM_OBJECT)
			-- Set `i'-th field of `object' with `value'.
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		local
			l_fields: like single_field_info_array
			l_field: FIELD_INFO
			l_depth: INTEGER
		do
			if physical_offset = 0 then
				helper.get_members (dynamic_type).i_th (i).set_value (enclosing_object, value)
			else
				l_depth := depth
				if l_depth = 1 then
						-- Optimization when it is not a deeply nested object.
					l_fields := single_field_info_array
				else
					create l_fields.make (l_depth)
				end
				fill_field_infos (l_fields, l_depth)
				l_field := helper.get_members (dynamic_type).i_th (i)
				{ISE_RUNTIME}.set_field_of_expanded (enclosing_object, l_fields, l_field, value)
			end
		end

	single_field_info_array: NATIVE_ARRAY [detachable FIELD_INFO]
			-- Single element array use to optimize `internal_field' and `internal_set_field'.
		once
			create Result.make (1)
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
