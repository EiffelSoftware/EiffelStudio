note
	description: "[
		Accessor to an object. Useful to manipulate fields of an object, or
		an expanded field of an object without causing any copying.
		If applied to an expanded type, a copy will be manipulated.
		]"
	implementation_details: "[
		The GC might be moving objects, some of the routines are actually builtin.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	REFLECTED_OBJECT

inherit
	ABSTRACT_REFLECTED_OBJECT

	REFLECTOR_CONSTANTS

create
	make

create {REFLECTED_OBJECT, RT_DBG_INTERNAL}
	make_for_expanded_field, make_for_expanded_field_at

feature {NONE} -- Initialization

	make (a_object: ANY)
			-- Setup a proxy to `a_object'.
		require
			not_expanded_object: True
		do
			enclosing_object := a_object
			dynamic_type := {ISE_RUNTIME}.dynamic_type (a_object)
			physical_offset := 0
		ensure
			enclosing_object_set: enclosing_object = a_object
			no_physical_offset: physical_offset = 0
		end

	make_for_expanded_field (a_enclosing_object: REFLECTED_OBJECT; i: INTEGER)
			-- Setup a proxy to expanded field located at the `i'-th field of `a_enclosing_object'.
		require
			i_th_field_is_expanded: a_enclosing_object.is_field_statically_expanded (i)
		do
			enclosing_object := a_enclosing_object.enclosing_object
				-- To compute the type ID of the object at the `i'-th field.
			physical_offset := a_enclosing_object.physical_offset + a_enclosing_object.field_offset (i)
			dynamic_type := {ISE_RUNTIME}.dynamic_type_at_offset ($enclosing_object, physical_offset)
		ensure
			enclosing_object_set: enclosing_object = a_enclosing_object.enclosing_object
		end

	make_for_expanded_field_at (a_enclosing_object: ANY; a_physical_offset: INTEGER)
			-- Setup a proxy to expanded field located at the `a_physical_offset' of `a_enclosing_object'.
		require
			not_dotnet: not {PLATFORM}.is_dotnet
		do
			enclosing_object := a_enclosing_object
			physical_offset := a_physical_offset
			dynamic_type := {ISE_RUNTIME}.dynamic_type_at_offset ($a_enclosing_object, a_physical_offset)
		ensure
			enclosing_object_set: enclosing_object = a_enclosing_object
		end

feature -- Access

	object: ANY
			-- <Precursor>
		do
			Result := {ISE_RUNTIME}.reference_field_at_offset ($enclosing_object, physical_offset)
		end

	object_address: POINTER
			-- <Precursor>
		note
			compiler: no_gc
		do
			Result := {ISE_RUNTIME}.raw_reference_field_at_offset ($enclosing_object, physical_offset)
		end

	enclosing_object: separate ANY
			-- Enclosing object containing `object' or a reference to `object.

	physical_offset: INTEGER
			-- Actual offset in bytes of `object' in `enclosing_object'.

feature -- Status report

	is_instance_of (type_id: INTEGER): BOOLEAN
			-- Is `object' an instance of type `type_id'?
		require
			object_not_void: object /= Void
			type_id_nonnegative: type_id >= 0
		do
			Result := {ISE_RUNTIME}.type_conforms_to (dynamic_type, type_id)
		end

	is_special: BOOLEAN
			-- Is `object' special?
		do
			Result := {ISE_RUNTIME}.is_special ($enclosing_object)
		ensure
			definition: physical_offset /= 0 implies not Result
		end

	is_special_of_reference: BOOLEAN
			-- Is Current a SPECIAL [XX] where `XX' is a reference type?
		do
			Result := {ISE_RUNTIME}.is_special_of_reference ($enclosing_object)
		end

	is_tuple: BOOLEAN
			-- Is `object' a TUPLE?
		do
			Result := {ISE_RUNTIME}.is_tuple ($enclosing_object)
		ensure
			definition: physical_offset /= 0 implies not Result
		end

	is_field_transient (i: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' a transient attribute?
			-- I.e. an attribute that does not need to be stored?
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		do
			Result := {ISE_RUNTIME}.is_field_transient_of_type (i, dynamic_type)
		end

	is_field_statically_expanded (i: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' a user-defined expanded attribute?
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		do
			Result := {ISE_RUNTIME}.is_field_expanded_of_type (i, dynamic_type)
		end

	is_copy_semantics_field (i: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' a reference with copy-semantics properties?
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			is_reference_field: field_type (i) = reference_type
		do
			Result := {ISE_RUNTIME}.is_copy_semantics_field (i, $enclosing_object, physical_offset)
		end

	is_field_statically_attached (i: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' defined as attached?
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		do
			Result := {ISE_RUNTIME}.is_attached_type (field_static_type (i))
		end

	field_conforms_to (a_source_type, a_field_type: INTEGER): BOOLEAN
			-- Does `a_source_type' conform to `a_field_type'?
			--| Different from `type_conforms_to' since possible attachment mark of `a_field_type'
			--| is discarded.
		require
			a_source_type_non_negative: a_source_type >= 0
			a_field_type_non_negative: a_field_type >= 0
		do
			Result := {ISE_RUNTIME}.type_conforms_to (a_source_type, {ISE_RUNTIME}.detachable_type (a_field_type))
		end

feature -- Settings

	set_object (a_obj: separate ANY)
			-- Update Current to represent a new reflected object.
		require
			physical_offset_not_set: physical_offset = 0
		do
			enclosing_object := a_obj
			physical_offset := 0
			dynamic_type := {ISE_RUNTIME}.dynamic_type (a_obj)
		ensure
			enclosing_object_set: enclosing_object = a_obj
			no_physical_offset: physical_offset = 0
		end

feature -- Access

	class_name: STRING
			-- Name of the class associated with `object'
		do
			Result := {ISE_RUNTIME}.generator_of_type (dynamic_type)
		end

	type_name: STRING
			-- Name of `object''s generating type (type of which `object'
			-- is a direct instance).
		do
			Result := {ISE_RUNTIME}.generating_type_of_type (dynamic_type)
		end

	dynamic_type: INTEGER
			-- Dynamic type of `object'

	generic_count: INTEGER
			-- Number of generic parameter in base type of `object'.
		do
			Result := {ISE_RUNTIME}.generic_parameter_count (dynamic_type)
		end

	generic_dynamic_type (i: INTEGER): INTEGER
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		require
			object_generic: generic_count > 0
			i_valid: i > 0 and i <= generic_count
		do
			Result := {ISE_RUNTIME}.eif_gen_param_id (dynamic_type, i)
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
			Result := {ISE_RUNTIME}.reference_field (i, $enclosing_object, physical_offset)
		end

	copy_semantics_field (i: INTEGER): REFLECTED_COPY_SEMANTICS_OBJECT
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			not_special: not is_special
			reference_field: field_type (i) = reference_type and is_copy_semantics_field (i)
		do
			create Result.make (Current, i)
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
		do
			create Result.make_for_expanded_field (Current, i)
		end

	field_name (i: INTEGER): STRING
			-- Name of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			not_special: not is_special
		do
			create Result.make_from_c ({ISE_RUNTIME}.field_name_of_type (i, dynamic_type))
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
			Result := {ISE_RUNTIME}.field_offset_of_type (i, dynamic_type)
		end

	field_type (i: INTEGER): INTEGER
			-- Abstract type of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		do
			Result := {ISE_RUNTIME}.field_type_of_type (i, dynamic_type)
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_static_type (i: INTEGER): INTEGER
			-- Static type of declared `i'-th field of dynamic type `dynamic_type'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
		do
			Result := {ISE_RUNTIME}.field_static_type_of_type (i, dynamic_type)
		ensure
			field_type_nonnegative: Result >= 0
		end

	character_8_field (i: INTEGER): CHARACTER_8
			-- CHARACTER_8 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			character_8_field: field_type (i) = Character_8_type
		do
			Result := {ISE_RUNTIME}.character_8_field (i, $enclosing_object, physical_offset)
		end

	character_32_field (i: INTEGER): CHARACTER_32
			-- CHARACTER_32 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			character_32_field: field_type (i) = Character_32_type
		do
			Result := {ISE_RUNTIME}.character_32_field (i, $enclosing_object, physical_offset)
		end

	boolean_field (i: INTEGER): BOOLEAN
			-- Boolean value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			boolean_field: field_type (i) = Boolean_type
		do
			Result := {ISE_RUNTIME}.boolean_field (i, $enclosing_object, physical_offset)
		end

	natural_8_field (i: INTEGER): NATURAL_8
			-- NATURAL_8 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_8_field: field_type (i) = natural_8_type
		do
			Result := {ISE_RUNTIME}.natural_8_field (i, $enclosing_object, physical_offset)
		end

	natural_16_field (i: INTEGER): NATURAL_16
			-- NATURAL_16 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_16_field: field_type (i) = natural_16_type
		do
			Result := {ISE_RUNTIME}.natural_16_field (i, $enclosing_object, physical_offset)
		end

	natural_32_field (i: INTEGER): NATURAL_32
			-- NATURAL_32 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_32_field: field_type (i) = natural_32_type
		do
			Result := {ISE_RUNTIME}.natural_32_field (i, $enclosing_object, physical_offset)
		end

	natural_64_field (i: INTEGER): NATURAL_64
			-- NATURAL_64 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_64_field: field_type (i) = natural_64_type
		do
			Result := {ISE_RUNTIME}.natural_64_field (i, $enclosing_object, physical_offset)
		end

	integer_8_field (i: INTEGER): INTEGER_8
			-- INTEGER_8 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_8_field: field_type (i) = Integer_8_type
		do
			Result := {ISE_RUNTIME}.integer_8_field (i, $enclosing_object, physical_offset)
		end

	integer_16_field (i: INTEGER): INTEGER_16
			-- INTEGER_16 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_16_field: field_type (i) = Integer_16_type
		do
			Result := {ISE_RUNTIME}.integer_16_field (i, $enclosing_object, physical_offset)
		end

	integer_32_field (i: INTEGER): INTEGER
			-- INTEGER_32 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_32_field: field_type (i) = Integer_32_type
		do
			Result := {ISE_RUNTIME}.integer_32_field (i, $enclosing_object, physical_offset)
		end

	integer_64_field (i: INTEGER): INTEGER_64
			-- INTEGER_64 value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_64_field: field_type (i) = Integer_64_type
		do
			Result := {ISE_RUNTIME}.integer_64_field (i, $enclosing_object, physical_offset)
		end

	real_32_field (i: INTEGER): REAL
			-- Real value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			real_32_field: field_type (i) = real_32_type
		do
			Result := {ISE_RUNTIME}.real_32_field (i, $enclosing_object, physical_offset)
		end

	pointer_field (i: INTEGER): POINTER
			-- Pointer value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			pointer_field: field_type (i) = Pointer_type
		do
			Result := {ISE_RUNTIME}.pointer_field (i, $enclosing_object, physical_offset)
		end

	real_64_field (i: INTEGER): REAL_64
			-- Double precision value of `i'-th field of `object'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			real_64_field: field_type (i) = real_64_type
		do
			Result := {ISE_RUNTIME}.real_64_field (i, $enclosing_object, physical_offset)
		end

feature -- Element change

	set_reference_field (i: INTEGER; value: detachable ANY)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			reference_field: field_type (i) = Reference_type
			valid_value: is_field_statically_attached (i) implies value /= Void
			value_conforms_to_field_static_type:
				value /= Void implies field_conforms_to (value.generating_type.type_id, field_static_type (i))
		do
			{ISE_RUNTIME}.set_reference_field (i, $enclosing_object, physical_offset, value)
		end

	set_real_64_field, set_double_field (i: INTEGER; value: REAL_64)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			real_64_field: field_type (i) = real_64_type
		do
			{ISE_RUNTIME}.set_real_64_field (i, $enclosing_object, physical_offset, value)
		end

	set_character_8_field, set_character_field (i: INTEGER; value: CHARACTER_8)
			-- Set character value of `i'-th field of `object' to `value'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			character_field: field_type (i) = Character_8_type
		do
			{ISE_RUNTIME}.set_character_8_field (i, $enclosing_object, physical_offset, value)
		end

	set_character_32_field (i: INTEGER; value: CHARACTER_32)
			-- Set character 32 value of `i'-th field of `object' to `value'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			character_field: field_type (i) = Character_32_type
		do
			{ISE_RUNTIME}.set_character_32_field (i, $enclosing_object, physical_offset, value)
		end

	set_boolean_field (i: INTEGER; value: BOOLEAN)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			boolean_field: field_type (i) = Boolean_type
		do
			{ISE_RUNTIME}.set_boolean_field (i, $enclosing_object, physical_offset, value)
		end

	set_natural_8_field (i: INTEGER; value: NATURAL_8)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_8_field: field_type (i) = natural_8_type
		do
			{ISE_RUNTIME}.set_natural_8_field (i, $enclosing_object, physical_offset, value)
		end

	set_natural_16_field (i: INTEGER; value: NATURAL_16)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_16_field: field_type (i) = natural_16_type
		do
			{ISE_RUNTIME}.set_natural_16_field (i, $enclosing_object, physical_offset, value)
		end

	set_natural_32_field (i: INTEGER; value: NATURAL_32)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_32_field: field_type (i) = natural_32_type
		do
			{ISE_RUNTIME}.set_natural_32_field (i, $enclosing_object, physical_offset, value)
		end

	set_natural_64_field (i: INTEGER; value: NATURAL_64)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			natural_64_field: field_type (i) = natural_64_type
		do
			{ISE_RUNTIME}.set_natural_64_field (i, $enclosing_object, physical_offset, value)
		end

	set_integer_8_field (i: INTEGER; value: INTEGER_8)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_8_field: field_type (i) = Integer_8_type
		do
			{ISE_RUNTIME}.set_integer_8_field (i, $enclosing_object, physical_offset, value)
		end

	set_integer_16_field (i: INTEGER; value: INTEGER_16)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_16_field: field_type (i) = Integer_16_type
		do
			{ISE_RUNTIME}.set_integer_16_field (i, $enclosing_object, physical_offset, value)
		end

	set_integer_field, set_integer_32_field (i: INTEGER; value: INTEGER)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_32_field: field_type (i) = Integer_32_type
		do
			{ISE_RUNTIME}.set_integer_32_field (i, $enclosing_object, physical_offset, value)
		end

	set_integer_64_field (i: INTEGER; value: INTEGER_64)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			integer_64_field: field_type (i) = Integer_64_type
		do
			{ISE_RUNTIME}.set_integer_64_field (i, $enclosing_object, physical_offset, value)
		end

	set_real_32_field, set_real_field (i: INTEGER; value: REAL)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			real_32_field: field_type (i) = real_32_type
		do
			{ISE_RUNTIME}.set_real_32_field (i, $enclosing_object, physical_offset, value)
		end

	set_pointer_field (i: INTEGER; value: POINTER)
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count
			pointer_field: field_type (i) = Pointer_type
		do
			{ISE_RUNTIME}.set_pointer_field (i, $enclosing_object, physical_offset, value)
		end

feature -- Measurement

	field_count: INTEGER
			-- Number of logical fields in `object'
		do
			Result := {ISE_RUNTIME}.field_count_of_type (dynamic_type)
		end

	persistent_field_count: INTEGER
			-- Number of logical fields in `object' that are not transient.
		do
			Result := {ISE_RUNTIME}.persistent_field_count_of_type (dynamic_type)
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
			Result := {ISE_RUNTIME}.object_size ($enclosing_object)
		end

	deep_physical_size_64: NATURAL_64
			-- Space occupied by `object' and its children in bytes
		local
			l_traverse: OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE
			l_obj: like {OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE}.visited_objects.item
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
					l_obj := l_objects.item
					Result := Result + {ISE_RUNTIME}.object_size ($l_obj)
					l_objects.forth
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
