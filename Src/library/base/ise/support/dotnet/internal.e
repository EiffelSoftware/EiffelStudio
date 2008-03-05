indexing
	description: "[
			Access to internal object properties.
			This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INTERNAL

inherit
	INTERNAL_HELPER

	REFACTORING_HELPER

feature -- Conformance

	is_instance_of (object: ANY; type_id: INTEGER): BOOLEAN is
			-- Is `object' an instance of type `type_id'?
		require
			object_not_void: object /= Void
			type_id_nonnegative: type_id >= 0
		do
			Result := type_conforms_to (dynamic_type (object), type_id)
		end

	type_conforms_to (type1, type2: INTEGER): BOOLEAN is
			-- Does `type1' conform to `type2'?
		require
			type1_nonnegative: type1 >= 0
			type2_nonnegative: type2 >= 0
		do
			if type1 = type2 then
				Result := True
			else
				fixme ("Take into account generics")
				Result :=
					id_to_eiffel_type.item (type2).dotnet_type.is_assignable_from (
						id_to_eiffel_type.item (type1).dotnet_type)
			end
		end

feature -- Creation

	dynamic_type_from_string (class_type: STRING): INTEGER is
			-- Dynamic type corresponding to `class_type'.
			-- If no dynamic type available, returns -1.
		require
			class_type_not_void: class_type /= Void
			class_type_not_empty: not class_type.is_empty
			is_valid_type_string: is_valid_type_string (class_type)
		local
			l_table: like internal_dynamic_type_string_table
		do
			l_table := internal_dynamic_type_string_table
			l_table.search (class_type)
			if l_table.found then
				Result := l_table.found_item
			else
				Result := dynamic_type_from_rt_class_type (eiffel_type_from_string (class_type))
				l_table.put (Result, class_type)
			end
		ensure
			dynamic_type_from_string_valid: Result = -1 or Result = none_type or Result >= 0
		end

	new_instance_of (type_id: INTEGER): ANY is
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
		require
			type_id_nonnegative: type_id >= 0
			not_special_type: not is_special_type (type_id)
		local
			l_tuple: TUPLE
		do
			Result := {ISE_RUNTIME}.create_type (pure_implementation_type (type_id))
			l_tuple ?= Result
			if l_tuple /= Void then
					-- Create `native_array' field from TUPLE, otherwise we would violate
					-- TUPLE invariant. Note that the `native_array' has one more element than
					-- the number of generic parameters (see TUPLE.default_create).
				tuple_native_array_field_info.set_value (l_tuple,
					create {NATIVE_ARRAY [SYSTEM_OBJECT]}.make (generic_count (l_tuple) + 1))
			end
		ensure
			not_special_type: not is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
		end

	new_special_any_instance (type_id, count: INTEGER): SPECIAL [ANY] is
			-- New instance of dynamic `type_id' that represents
			-- a SPECIAL with `count' element. To create a SPECIAL of
			-- basic type, use `TO_SPECIAL'.
		require
			count_valid: count >= 0
			type_id_nonnegative: type_id >= 0
			special_type: is_special_any_type (type_id)
		do
			Result ?= {ISE_RUNTIME}.create_type (pure_implementation_type (type_id))
			Result.make (count)
		ensure
			special_type: is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
			count_set: Result.count = count
		end

	type_of (object: ANY): TYPE [ANY]
			-- Type object for `object'.
		do
			if object /= Void then
				Result := type_of_type (dynamic_type (object))
			else
				Result ?= new_instance_of (dynamic_type_from_string ("TYPE [NONE]"))
			end
		ensure
			result_not_void: Result /= Void
		end

	type_of_type (type_id: INTEGER): TYPE [ANY]
			-- Return type for type id `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result ?= new_instance_of (dynamic_type_from_string ("TYPE [" + type_name_of_type (type_id) + "]"))
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_special_any_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type.
		require
			type_id_nonnegative: type_id >= 0
		local
			l_gen_type: RT_GENERIC_TYPE
		do
				-- Unlike `is_special_type' we need to take the interface type,
				-- as the {SPECIAL [ANY]}.to_cil will yield the interface type, not
				-- the implementation type.
			l_gen_type ?= id_to_eiffel_type.item (type_id)
			if l_gen_type /= Void and then l_gen_type.count = 1 then
				Result := l_gen_type.dotnet_type.equals (({SPECIAL [ANY]}).to_cil)
			end
		end

	is_special_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type
			-- or a basic type.
		require
			type_id_nonnegative: type_id >= 0
		local
			l_gen_type: RT_GENERIC_TYPE
		do
			fixme ("It might return True if another class is called SPECIAL")
			l_gen_type ?= pure_implementation_type (type_id)
			if l_gen_type /= Void and then l_gen_type.count = 1 then
				Result := l_gen_type.class_name.equals (("SPECIAL").to_cil)
			end
		end

	is_special (object: ANY): BOOLEAN is
			-- Is `object' a special object?
			-- It only recognized a special object
			-- initialized within a TO_SPECIAL object.
		require
			object_not_void: object /= Void
		do
			Result := is_special_type (dynamic_type (object))
		end

	is_tuple_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent a TUPLE?
		require
			type_id_nonnegative: type_id >= 0
		local
			l_tuple_type: RT_TUPLE_TYPE
		do
			l_tuple_type ?= pure_implementation_type (type_id)
			Result := l_tuple_type /= Void
		end

	is_tuple (object: ANY): BOOLEAN is
			-- Is `object' a TUPLE object?
		require
			object_not_void: object /= Void
		local
			l_tuple: TUPLE
		do
			l_tuple ?= object
			Result := l_tuple /= Void
		end

	is_marked (obj: ANY): BOOLEAN is
			-- Is `obj' marked?
		require
			object_not_void: obj /= Void
		do
			Result := marked_objects.contains (obj)
		end

feature -- Access

	none_type: INTEGER is -2
			-- Type ID representation for NONE.

	Pointer_type: INTEGER is 0

	Reference_type: INTEGER is 1

	character_8_type, character_type: INTEGER is 2

	Boolean_type: INTEGER is 3

	Integer_type, integer_32_type: INTEGER is 4

	Real_type, real_32_type: INTEGER is 5

	Double_type, real_64_type: INTEGER is 6

	Expanded_type: INTEGER is 7

	Bit_type: INTEGER is 8

	Integer_8_type: INTEGER is 9

	Integer_16_type: INTEGER is 10

	Integer_64_type: INTEGER is 11

	character_32_type, wide_character_type: INTEGER is 12

	natural_8_type: INTEGER is 13

	natural_16_type: INTEGER is 14

	natural_32_type: INTEGER is 15

	natural_64_type: INTEGER is 16

	min_predefined_type: INTEGER is -2
	max_predefined_type: INTEGER is 17
			-- See non-exported definition of `object_type' below.

	class_name (object: ANY): STRING is
			-- Name of the class associated with `object'
		require
			object_not_void: object /= Void
		do
			Result := object.generator
		end

	class_name_of_type (type_id: INTEGER): STRING is
			-- Name of class associated with dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := id_to_eiffel_type.item (type_id).class_name
		end

	type_name (object: ANY): STRING is
			-- Name of `object''s generating type (type of which `object'
			-- is a direct instance).
		require
			object_not_void: object /= Void
		do
			Result := object.generating_type
		end

	type_name_of_type (type_id: INTEGER): STRING is
			-- Name of `type_id''s generating type (type of which `type_id'
			-- is a direct instance).
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := pure_implementation_type (type_id).type_name
		end

	dynamic_type (object: ANY): INTEGER is
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		local
			l_gen_type: RT_GENERIC_TYPE
			l_class_type: RT_CLASS_TYPE
			l_object: SYSTEM_OBJECT
		do
			l_gen_type := {ISE_RUNTIME}.generic_type (object)
			if l_gen_type = Void then
					-- Case of a non-generic Eiffel class or of a .NET class
					-- Let's retrieve the associated type and its interface type if any.
				create l_class_type.make
				l_object := object
				l_class_type.set_type (interface_type (l_object.get_type).type_handle)
			else
					-- Convert `l_gen_type' so that all referenced types are using the associated
					-- interface type if any. As run-time generates data for implementation not for
					-- interfaces.
				l_class_type := internal_pure_interface_type (l_gen_type)
				check
					l_class_type_not_void: l_class_type /= Void
				end
			end
			Result := dynamic_type_from_rt_class_type (l_class_type)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	generic_count (obj: ANY): INTEGER is
			-- Number of generic parameter in `obj'.
		require
			obj_not_void: obj /= Void
		do
			Result := {ISE_RUNTIME}.generic_parameter_count (obj)
		end

	generic_count_of_type (type_id: INTEGER): INTEGER is
			-- Number of generic parameter in `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		local
			l_gen_type: RT_GENERIC_TYPE
		do
			l_gen_type ?= id_to_eiffel_type.item (type_id)
			if l_gen_type /= Void then
				Result := l_gen_type.count
			end
		end

	generic_dynamic_type (object: ANY; i: INTEGER): INTEGER is
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		require
			object_not_void: object /= Void
			object_generic: generic_count (object) > 0
			i_valid: i > 0 and i <= generic_count (object)
		local
			l_class_type: RT_CLASS_TYPE
		do
			l_class_type := internal_pure_interface_type (
				{ISE_RUNTIME}.type_of_generic (object, i))
			Result := dynamic_type_from_rt_class_type (l_class_type)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	generic_dynamic_type_of_type (type_id, i: INTEGER): INTEGER is
			-- Dynamic type of generic parameter of `type_id' at position `i'.
		require
			type_id_nonnegative: type_id >= 0
			type_id_generic: generic_count_of_type (type_id) > 0
			i_valid: i > 0 and i <= generic_count_of_type (type_id)
		local
			l_gen_type: RT_GENERIC_TYPE
			l_class_type: RT_CLASS_TYPE
		do
			l_gen_type ?= id_to_eiffel_type.item (type_id)
			l_class_type ?= l_gen_type.generics.item (i - 1)
			check
					-- It should be a fully instantiated type.
				l_class_type_not_void: l_class_type /= Void
			end
			Result := dynamic_type_from_rt_class_type (l_class_type)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	field (i: INTEGER; object: ANY): ANY is
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		local
			l_obj: SYSTEM_OBJECT
			l_nat8: NATURAL_8
			l_nat16: NATURAL_16
			l_nat32: NATURAL_32
			l_nat64: NATURAL_64
			l_int8: INTEGER_8
			l_int16: INTEGER_16
			l_int32: INTEGER
			l_int64: INTEGER_64
			l_char: CHARACTER_8
			l_wchar: CHARACTER_32
			l_boolean: BOOLEAN
			l_real: REAL
			l_double: DOUBLE
			l_pointer: POINTER
			l_dtype: INTEGER
		do
			l_dtype := dynamic_type (object)
			l_obj := internal_field (i, object, l_dtype)
			inspect
				field_type_of_type (i, l_dtype)
			when Pointer_type then
				l_pointer ?= l_obj
				Result := l_pointer

			when character_8_type then
				l_char ?= l_obj
				Result := l_char

			when character_32_type then
				l_wchar ?= l_obj
				Result := l_wchar

			when Boolean_type then
				l_boolean ?= l_obj
				Result := l_boolean

			when natural_8_type then
				l_nat8 ?= l_obj
				Result := l_nat8

			when natural_16_type then
				l_nat16 ?= l_obj
				Result := l_nat16

			when natural_32_type then
				l_nat32 ?= l_obj
				Result := l_nat32

			when natural_64_type then
				l_nat64 ?= l_obj
				Result := l_nat64

			when Integer_8_type then
				l_int8 ?= l_obj
				Result := l_int8

			when Integer_16_type then
				l_int16 ?= l_obj
				Result := l_int16

			when Integer_32_type then
				l_int32 ?= l_obj
				Result := l_int32

			when Integer_64_type then
				l_int64 ?= l_obj
				Result := l_int64

			when real_32_type then
				l_real ?= l_obj
				Result := l_real

			when real_64_type then
				l_double ?= l_obj
				Result := l_double

			else
					-- A reference, so nothing to be done
				Result := l_obj
			end
		end

	field_name (i: INTEGER; object: ANY): STRING is
			-- Name of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := field_name_of_type (i, dynamic_type (object))
		ensure
			Result_exists: Result /= Void
		end

	field_name_of_type (i: INTEGER; type_id: INTEGER): STRING is
			-- Name of `i'-th field of dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (type_id)
		local
			l_native_array: NATIVE_ARRAY [STRING]
			l_members: NATIVE_ARRAY [FIELD_INFO]
			l_name: STRING
			l_eiffel_name: EIFFEL_NAME_ATTRIBUTE
			k, nb: INTEGER
			l_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]
			l_field: FIELD_INFO
			l_provider: ICUSTOM_ATTRIBUTE_PROVIDER
		do
			l_native_array := id_to_fields_name.item (type_id)
			if l_native_array = Void then
				from
					l_members := get_members (type_id)
					k := 1
					nb := l_members.count
					create l_native_array.make (nb)
				until
					k = nb
				loop
					l_field := l_members.item (k)
					l_provider := l_field
					l_attributes := l_provider.get_custom_attributes_type ({EIFFEL_NAME_ATTRIBUTE}, False)
					if l_attributes.count > 0 then
						check
							valid_number_of_custom_attributes: l_attributes.count = 1
						end
						l_eiffel_name ?= l_attributes.item (0)
						l_name := l_eiffel_name.name
					else
						l_name := l_field.name
					end
					l_native_array.put (k, l_name)
					k := k + 1
				end
				id_to_fields_name.put (l_native_array, type_id)
			end
			Result := l_native_array.item (i)
		ensure
			field_name_of_type_not_void: Result /= Void
		end

	field_offset (i: INTEGER; object: ANY): INTEGER is
			-- Offset of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := 4 * i
		end

	field_type (i: INTEGER; object: ANY): INTEGER is
			-- Abstract type of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
		do
			Result := field_type_of_type (i, dynamic_type (object))
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Abstract type of `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		local
			l_type: SYSTEM_TYPE
			l_native_array: NATIVE_ARRAY [INTEGER]
			l_members: NATIVE_ARRAY [FIELD_INFO]
			l_abstract_type: INTEGER
			k, nb: INTEGER
		do
			l_native_array := id_to_fields_abstract_type.item (type_id)
			if l_native_array = Void then
				from
					l_members := get_members (type_id)
					k := 1
					nb := l_members.count
					create l_native_array.make (nb)
				until
					k = nb
				loop
					l_type := l_members.item (k).field_type
					if not l_type.is_value_type and not l_type.is_enum then
						l_abstract_type := Reference_type
					else
						if abstract_types.contains (l_type) then
							l_abstract_type ?= abstract_types.item (l_type)
						else
							l_abstract_type := Expanded_type
						end
					end
					l_native_array.put (k, l_abstract_type)
					k := k + 1
				end
				id_to_fields_abstract_type.put (l_native_array, type_id)
			end
			Result := l_native_array.item (i)
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_static_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Static type of declared `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		local
			l_rt_type: RT_TYPE
			l_class_type, l_current_rt_type: RT_CLASS_TYPE
			l_current_rt_gen_type: RT_GENERIC_TYPE
			l_type, l_current_type: SYSTEM_TYPE
			l_dtypes: NATIVE_ARRAY [INTEGER]
			l_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]
			k, nb, l_dtype: INTEGER
			l_type_feature_name: TYPE_FEATURE_ATTRIBUTE
			l_name: SYSTEM_STRING
			l_members: NATIVE_ARRAY [FIELD_INFO]
			l_field: FIELD_INFO
			l_meth: METHOD_INFO
			l_type_attr: RT_INTERFACE_TYPE_ATTRIBUTE
			l_provider: ICUSTOM_ATTRIBUTE_PROVIDER
			l_object: SYSTEM_OBJECT
		do
			l_dtypes := id_to_fields_static_type.item (type_id)
			if l_dtypes = Void then
				from
					l_members := get_members (type_id)
					k := 1
					nb := l_members.count
					create l_dtypes.make (nb)
				until
					k = nb
				loop
					l_field := l_members.item (k)
					l_provider := l_field
					l_attributes := l_provider.get_custom_attributes_type ({TYPE_FEATURE_ATTRIBUTE}, False)
					if l_attributes.count > 0 then
						check
							valid_number_of_custom_attributes: l_attributes.count = 1
						end
						l_type_feature_name ?= l_attributes.item (0)
						check
							l_type_feature_name_not_void: l_type_feature_name /= Void
						end
						l_name := l_type_feature_name.feature_name
						if l_current_type = Void then
							l_current_rt_type := pure_implementation_type (type_id)
							l_object := {ISE_RUNTIME}.create_type (l_current_rt_type)
							l_current_type := {SYSTEM_TYPE}.get_type_from_handle (l_current_rt_type.type)
								-- Get RT_GENERIC_TYPE from `l_current_rt_type' if it
								-- is an instance of `RT_GENERIC_TYPE', otherwise we get
								-- Void which is ok to, it simply means the call to `evaluated_type'
								-- below will not require a generic type as it should include
								-- no formals.
							l_current_rt_gen_type ?= l_current_rt_type
						end
						l_meth := l_current_type.get_method (l_name)
						check
							has_method: l_meth /= Void
						end
							-- Invoke method that is going to give us a RT_TYPE instance representing the
							-- static type of the field for the base class of `type_id'.
						l_rt_type ?= l_meth.invoke_object_object_array (l_object, Void)
						check
							l_rt_type_not_void: l_rt_type /= Void
						end
							-- Evaluate given type into context of `l_current_rt_gen_type' to resolve
							-- formals to actual generic parameters. Of course if `l_current_rt_gen_type'
							-- is Void, it means that `l_rt_type' does not contain any formals.
						l_class_type ?= l_rt_type.evaluated_type (l_current_rt_gen_type)
						check
							l_class_type_not_void: l_class_type /= Void
						end
							-- Get the associated dynamic type.
						l_class_type := internal_pure_interface_type (l_class_type)
						l_dtype := dynamic_type_from_rt_class_type (l_class_type)
					else
							-- Case of a non-generic attribute or non-formal one.
						l_type := interface_type (l_field.field_type)
						if l_type.is_value_type then
								-- Case of an expanded type.
							l_dtype :=
								dynamic_type_from_rt_class_type (associated_runtime_type (l_type))
						else
								-- Normal case, we handle a non-generic class type.
							create l_class_type.make
							l_attributes := l_field.get_custom_attributes_type ({RT_INTERFACE_TYPE_ATTRIBUTE}, False)
							if l_attributes.count > 0 then
								l_type_attr ?= l_attributes.item (0)
								check
									l_type_attr_not_void: l_type_attr /= Void
								end
								l_class_type.set_type (l_type_attr.class_type.type_handle)
							else
								l_class_type.set_type (l_type.type_handle)
							end
							l_dtype := dynamic_type_from_rt_class_type (l_class_type)
						end
					end
					l_dtypes.put (k, l_dtype)
					k := k + 1
				end
				id_to_fields_static_type.put (l_dtypes, type_id)
			end
			Result := l_dtypes.item (i)
		ensure
			field_type_nonnegative: Result >= 0
		end

	expanded_field_type (i: INTEGER; object: ANY): STRING is
			-- Class name associated with the `i'-th
			-- expanded field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			is_expanded: field_type (i, object) = Expanded_type
		do
			Result := class_name_of_type (field_static_type_of_type (i, dynamic_type (object)))
		ensure
			Result_exists: Result /= Void
		end

	character_8_field, character_field (i: INTEGER; object: ANY): CHARACTER_8 is
			-- Character value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_8_field: field_type (i, object) = character_8_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	character_32_field (i: INTEGER; object: ANY): CHARACTER_32 is
			-- Character value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_32_field: field_type (i, object) = character_32_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	boolean_field (i: INTEGER; object: ANY): BOOLEAN is
			-- Boolean value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	natural_8_field (i: INTEGER; object: ANY): NATURAL_8 is
			-- NATURAL_8 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_8_field: field_type (i, object) = natural_8_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	natural_16_field (i: INTEGER; object: ANY): NATURAL_16 is
			-- NATURAL_16 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_16_field: field_type (i, object) = natural_16_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	natural_32_field (i: INTEGER; object: ANY): NATURAL_32 is
			-- NATURAL_32 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_field: field_type (i, object) = natural_32_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	natural_64_field (i: INTEGER; object: ANY): NATURAL_64 is
			-- NATURAL_64 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_64_field: field_type (i, object) = natural_64_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	integer_8_field (i: INTEGER; object: ANY): INTEGER_8 is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	integer_16_field (i: INTEGER; object: ANY): INTEGER_16 is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	integer_field, integer_32_field (i: INTEGER; object: ANY): INTEGER is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_32_field: field_type (i, object) = Integer_32_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	integer_64_field (i: INTEGER; object: ANY): INTEGER_64 is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	real_32_field, real_field (i: INTEGER; object: ANY): REAL is
			-- Real value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_32_field: field_type (i, object) = real_32_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	pointer_field (i: INTEGER; object: ANY): POINTER is
			-- Pointer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

	real_64_field, double_field (i: INTEGER; object: ANY): DOUBLE is
			-- Double precision value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_64_field: field_type (i, object) = real_64_type
		do
			Result ?= internal_field (i, object, dynamic_type (object))
		end

feature -- Version

	compiler_version: INTEGER is
		do
			-- Built-in.
		end

feature -- Element change

	set_reference_field (i: INTEGER; object: ANY; value: ANY) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			reference_field: field_type (i, object) = Reference_type
			value_conforms_to_field_static_type:
				value /= Void implies
					type_conforms_to (dynamic_type (value),
						field_static_type_of_type (i, dynamic_type (object)))
		do
			internal_set_reference_field (i, object, value)
		end

	set_real_64_field, set_double_field (i: INTEGER; object: ANY; value: DOUBLE) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_64_field: field_type (i, object) = real_64_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_character_8_field, set_character_field (i: INTEGER; object: ANY; value: CHARACTER_8) is
			-- Set character value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_8_field: field_type (i, object) = character_8_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_character_32_field (i: INTEGER; object: ANY; value: CHARACTER_32) is
			-- Set character value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_32_field: field_type (i, object) = character_32_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_natural_8_field (i: INTEGER; object: ANY; value: NATURAL_8) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_8_field: field_type (i, object) = natural_8_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_natural_16_field (i: INTEGER; object: ANY; value: NATURAL_16) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_16_field: field_type (i, object) = natural_16_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_natural_32_field (i: INTEGER; object: ANY; value: NATURAL_32) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_32_field: field_type (i, object) = natural_32_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_natural_64_field (i: INTEGER; object: ANY; value: NATURAL_64) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_64_field: field_type (i, object) = natural_64_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_8_field (i: INTEGER; object: ANY; value: INTEGER_8) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_16_field (i: INTEGER; object: ANY; value: INTEGER_16) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_field, set_integer_32_field (i: INTEGER; object: ANY; value: INTEGER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_32_field: field_type (i, object) = Integer_32_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_64_field (i: INTEGER; object: ANY; value: INTEGER_64) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_real_32_field, set_real_field (i: INTEGER; object: ANY; value: REAL) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_32_field: field_type (i, object) = real_32_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_pointer_field (i: INTEGER; object: ANY; value: POINTER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			internal_set_reference_field (i, object, value)
		end

feature -- Measurement

	field_count (object: ANY): INTEGER is
			-- Number of logical fields in `object'
		require
			object_not_void: object /= Void
		do
			Result := get_members (dynamic_type (object)).count - 1
		end

	field_count_of_type (type_id: INTEGER): INTEGER is
			-- Number of logical fields in dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := get_members (type_id).count - 1
		end

	bit_size (i: INTEGER; object: ANY): INTEGER is
			-- Size (in bit) of the `i'-th bit field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			is_bit: field_type (i, object) = Bit_type
		do
			Result := 4
		ensure
			positive_result: Result > 0
		end

	physical_size (object: ANY): INTEGER is
			-- Space occupied by `object' in bytes
			--| In .NET, it is an approximation since .NET has not facility that returns the size
			--| of an object. For example, we do not take into account layout/packing nor the
			--| presence of an object header.
		require
			object_not_void: object /= Void
		local
			i, nb: INTEGER
			l_type_id: INTEGER
		do
			l_type_id := dynamic_type (object)
			from
				i := 1
				nb := field_count_of_type (l_type_id)
			until
				i > nb
			loop
				inspect
					field_type_of_type (i, l_type_id)
				when pointer_type then Result := Result + {PLATFORM}.pointer_bytes
				when character_8_type then Result := Result + {PLATFORM}.character_8_bytes
				when character_32_type then Result := Result + {PLATFORM}.character_32_bytes
				when boolean_type then Result := Result + {PLATFORM}.boolean_bytes
				when real_32_type then Result := Result + {PLATFORM}.real_32_bytes
				when real_64_type then Result := Result + {PLATFORM}.real_64_bytes
				when natural_8_type then Result := Result + {PLATFORM}.natural_8_bytes
				when natural_16_type then Result := Result + {PLATFORM}.natural_16_bytes
				when natural_32_type then Result := Result + {PLATFORM}.natural_32_bytes
				when natural_64_type then Result := Result + {PLATFORM}.natural_64_bytes
				when integer_8_type then Result := Result + {PLATFORM}.integer_8_bytes
				when integer_16_type then Result := Result + {PLATFORM}.integer_16_bytes
				when integer_32_type then Result := Result + {PLATFORM}.integer_32_bytes
				when integer_64_type then Result := Result + {PLATFORM}.integer_64_bytes
				else
						-- It is a reference, which we assume to be the same as a pointer
					Result := Result + {PLATFORM}.pointer_bytes
				end
				i := i + 1
			end
		end

	deep_physical_size (object: ANY): INTEGER is
			-- Space occupied by `object' and its children in bytes
		require
			object_not_void: object /= Void
		local
			l_traverse: OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE
			l_objects: ARRAYED_LIST [ANY]
		do
			create l_traverse
			l_traverse.set_root_object (object)
			l_traverse.traverse
			l_objects := l_traverse.visited_objects
			from
				l_objects.start
			until
				l_objects.after
			loop
				Result := Result + physical_size (l_objects.item)
				l_objects.forth
			end
		end

feature -- Marking

	mark (obj: ANY) is
			-- Mark object `obj'.
			-- To be thread safe, make sure to call this feature when you
			-- have the marking lock that you acquire using `lock_marking'.
		require
			object_not_void: obj /= Void
			object_not_marked: not is_marked (obj)
		do
			marked_objects.add (obj, obj)
		ensure
			marked: is_marked (obj)
		end

	unmark (obj: ANY) is
			-- Unmark object `obj'.
			-- To be thread safe, make sure to call this feature when you
			-- have the marking lock that you acquire using `lock_marking'.
		require
			object_not_void: obj /= Void
			object_marked: is_marked (obj)
		do
			marked_objects.remove (obj)
		ensure
			not_marked: not is_marked (obj)
		end

	lock_marking is
			-- Get a lock on `mark' and `unmark' routine so that 2 threads cannot `mark' and
			-- `unmark' at the same time.
		do
			-- Nothing to be done, because `marked_objects' is per thread.
		end

	unlock_marking is
			-- Release a lock on `mark' and `unmark', so that another thread can
			-- use `mark' and `unmark'.
		do
			-- Nothing to be done, because `marked_objects' is per thread.
		end

feature {NONE} -- Cached data

	internal_dynamic_type_string_table: HASH_TABLE [INTEGER, STRING] is
			-- Table of dynamic type indexed by type name
		once
			create Result.make (100)
		ensure
			internal_dynamic_type_string_table_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	object_type: INTEGER is 17
			-- System.Object type ID

	private_type_field_name: SYSTEM_STRING is "$$____type"
			-- .NET name for fields that stores generic types if any.

	next_dynamic_type_id: CELL [INTEGER] is
			-- ID for dynamic type (each generic derivation get a new ID)
		once
			create Result.put (max_predefined_type + 1)
		ensure
			next_dynamic_type_id_not_void: Result /= Void
		end

	pure_implementation_type (type_id: INTEGER): RT_CLASS_TYPE is
			-- Given `type_id' which might include some reference to interface type,
			-- returns the corresponding implementation type.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := id_to_eiffel_implementation_type.item (type_id)
			if Result = Void then
				Result := internal_pure_implementation_type (id_to_eiffel_type.item (type_id))
				id_to_eiffel_implementation_type.put (Result, type_id)
			end
		end

	internal_pure_implementation_type (a_class_type: RT_CLASS_TYPE): RT_CLASS_TYPE is
			-- Given `a_class_type' which might include some reference to interface type,
			-- returns the corresponding implementation type.
		require
			a_class_type_not_void: a_class_type /= Void
		local
			l_class_type: RT_CLASS_TYPE
			l_basic_type: RT_BASIC_TYPE
			l_none_type: RT_NONE_TYPE
			l_gen_type, l_new_gen_type: RT_GENERIC_TYPE
			i, nb: INTEGER
			l_generics: NATIVE_ARRAY [RT_TYPE]
			l_stop: BOOLEAN
		do
			l_gen_type ?= a_class_type
			if l_gen_type /= Void then
				from
					i := 0
					nb := l_gen_type.generics.count
					create l_generics.make (nb)
				until
					i = nb or l_stop
				loop
					l_class_type ?= l_gen_type.generics.item (i)
					if l_class_type /= Void then
						l_class_type := internal_pure_implementation_type (l_class_type)
						if l_class_type /= Void then
							l_generics.put (i, l_class_type)
						else
							l_stop := True
						end
					else
						l_stop := True
					end
					i := i + 1
				end
				if not l_stop then
					if l_gen_type.is_tuple then
						create {RT_TUPLE_TYPE} l_new_gen_type.make
					else
						create l_new_gen_type.make
					end
					l_new_gen_type.set_type (implementation_type (l_gen_type.dotnet_type).type_handle)
					l_new_gen_type.set_generics (l_generics)
					Result := l_new_gen_type
				end
			else
				l_basic_type ?= a_class_type
				if l_basic_type /= Void then
					create {RT_BASIC_TYPE} Result.make
				else
					l_none_type ?= a_class_type
					if l_none_type /= Void then
						create {RT_NONE_TYPE} Result.make
					else
						create Result.make
					end
				end
				if l_none_type = Void then
					Result.set_type (implementation_type (a_class_type.dotnet_type).type_handle)
				end
			end
		end

	internal_pure_interface_type (a_class_type: RT_CLASS_TYPE): RT_CLASS_TYPE is
			-- Given `a_class_type' which might include some reference to implementation type,
			-- returns the corresponding interface type.
		require
			a_class_type_not_void: a_class_type /= Void
		local
			l_gen_type, l_new_gen_type: RT_GENERIC_TYPE
			l_basic_type: RT_BASIC_TYPE
			l_none_type: RT_NONE_TYPE
			i, nb: INTEGER
			l_generics: NATIVE_ARRAY [RT_TYPE]
			l_class_type: RT_CLASS_TYPE
			l_stop: BOOLEAN
		do
			l_gen_type ?= a_class_type
			if l_gen_type /= Void then
				from
					i := 0
					nb := l_gen_type.generics.count
					create l_generics.make (nb)
				until
					i = nb or l_stop
				loop
					l_class_type ?= l_gen_type.generics.item (i)
					if l_class_type /= Void then
						l_class_type := internal_pure_interface_type (l_class_type)
						if l_class_type /= Void then
							l_generics.put (i, l_class_type)
						else
							l_stop := True
						end
					else
						l_stop := True
					end
					i := i + 1
				end
				if not l_stop then
					if l_gen_type.is_tuple then
						create {RT_TUPLE_TYPE} l_new_gen_type.make
					else
						create l_new_gen_type.make
					end
					l_new_gen_type.set_type (interface_type (l_gen_type.dotnet_type).type_handle)
					l_new_gen_type.set_generics (l_generics)
					Result := l_new_gen_type
				end
			else
				l_basic_type ?= a_class_type
				if l_basic_type /= Void then
					create {RT_BASIC_TYPE} Result.make
				else
					l_none_type ?= a_class_type
					if l_none_type /= Void then
						create {RT_NONE_TYPE} Result.make
					else
						create Result.make
					end
				end
				if l_none_type = Void then
					Result.set_type (interface_type (a_class_type.dotnet_type).type_handle)
				end
			end
		end

	interface_type (a_type: SYSTEM_TYPE): SYSTEM_TYPE is
			-- Interface type of Eiffel type `a_type' if it exists, otherwise `a_type'.
		require
			a_type_not_void: a_type /= Void
		do
			Result ?= implementation_to_interface.item (a_type)
			if Result = Void then
				Result := {ISE_RUNTIME}.interface_type (a_type)
				implementation_to_interface.set_item (a_type, Result)
			end
		ensure
			interface_type_not_void: Result /= Void
		end

	implementation_type (a_type: SYSTEM_TYPE): SYSTEM_TYPE is
			-- Implementation type of Eiffel type `a_type' if it exists, otherwise `a_type'.
		require
			a_type_not_void: a_type /= Void
		do
			load_assemblies
			Result ?= interface_to_implementation.item (a_type)
			if Result = Void then
					-- No associated implementation, it must be itself
				Result := a_type
			end
		ensure
			interface_type_not_void: Result /= Void
		end

	dynamic_type_from_rt_class_type (a_class_type: RT_CLASS_TYPE): INTEGER is
			-- Dynamic type of `a_class_type'.
		local
			l_obj: SYSTEM_OBJECT
		do
			if a_class_type = Void then
				Result := -1
			else
				l_obj := eiffel_type_to_id.item (a_class_type)
				if l_obj /= Void then
					Result ?= l_obj
				else
					if a_class_type.is_none then
						Result := none_type
					else
						Result := next_dynamic_type_id.item
						next_dynamic_type_id.put (Result + 1)
					end
					eiffel_type_to_id.set_item (a_class_type, Result)
					resize_arrays (Result)
					id_to_eiffel_type.put (a_class_type, Result)
				end
			end
		ensure
			dynamic_type_from_rt_class_type: Result = -1 or Result = none_type or Result >= 0
		end

	internal_field (i: INTEGER; object: ANY; type_id: INTEGER): SYSTEM_OBJECT is
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
			type_id_nonnegative: type_id >= 0
			valid_type: dynamic_type (object) = type_id
		do
			Result := get_members (type_id).item (i).get_value (object)
		end

	eiffel_type_from_string (class_type: STRING): RT_CLASS_TYPE is
			-- Eiffel .NET type corresponding to `class_type'.
			-- If no dynamic type available, returns Void.
		require
			class_type_not_void: class_type /= Void
		local
			l_type: RT_CLASS_TYPE
			l_parameters: ARRAYED_LIST [STRING]
			l_list: ARRAYED_LIST [RT_CLASS_TYPE]
			l_type_name: STRING
			l_start_pos, l_end_pos, i: INTEGER
			l_types: NATIVE_ARRAY [RT_TYPE]
			l_found: BOOLEAN
			l_class_type_name: STRING
			l_gen_type: RT_GENERIC_TYPE
		do
				-- Load data from all assemblies in case it is not yet done.
			load_assemblies

				-- Clean `class_type'.
			l_class_type_name := class_type.twin
			l_class_type_name.left_adjust
			l_class_type_name.right_adjust

				-- Search for a non generic class type.
			eiffel_meta_type_mapping.search (mapped_type (l_class_type_name))
			if eiffel_meta_type_mapping.found then
					-- It is a non-generic Eiffel type which was recorded in `load_assemblies'.
				check
					only_one_element: eiffel_meta_type_mapping.found_item.count = 1
				end
				Result := eiffel_meta_type_mapping.found_item.first
			else
					-- Let's see if it is a partially well-formed Eiffel generic class:
					-- 1 - it must have at least one `[' preceded by some characters (l_start_pos > 1)
					-- 2 - last character should be ']' (l_end_pos = l_class_type_name.count)
					-- 2 - it cannot be "[]" (l_start_pos < l_end_pos)
					-- 3 - Number of `[' is equal to number of ']'
				l_start_pos := l_class_type_name.index_of ('[', 1)
				l_end_pos := l_class_type_name.count
				if l_class_type_name.item (l_end_pos) /= ']' then
					l_end_pos := 0
				end
				if
					l_start_pos > 1 and l_end_pos = l_class_type_name.count and l_start_pos < l_end_pos and
					l_class_type_name.occurrences ('[') = l_class_type_name.occurrences (']')
				then
						-- It seems to be a generic class, let's try to find its base type.
					l_type_name := l_class_type_name.substring (1, l_start_pos - 1)
					l_type_name.left_adjust
					l_type_name.right_adjust
					eiffel_meta_type_mapping.search (mapped_type (l_type_name))
					if eiffel_meta_type_mapping.found then
							-- Extract generic parameters and ensures that it matches the number of generic
							-- parameter expected by the type `l_type_name'.
						l_parameters := parameters_decomposition (l_class_type_name.substring (l_start_pos + 1, l_end_pos - 1))
						l_list := eiffel_meta_type_mapping.found_item
						l_gen_type ?= l_list.first
						if l_gen_type /= Void then
							check
								valid_count: not l_gen_type.is_tuple implies l_parameters.count = l_gen_type.count
							end
							create l_types.make (l_parameters.count)
							from
								l_parameters.start
								l_found := True
							until
								l_parameters.after or not l_found
							loop
								l_type := eiffel_type_from_string (l_parameters.item)
								if l_type /= Void then
									l_types.put (i, l_type)
								else
									l_found := False
								end
								i := i + 1
								l_parameters.forth
							end
							if l_found then
								if l_gen_type.is_tuple then
									l_type := l_gen_type
									create {RT_TUPLE_TYPE} l_gen_type.make
									l_gen_type.set_type (l_type.type)
									l_gen_type.set_generics (l_types)
									Result := l_gen_type
								else
									from
										l_found := False
										l_list.start
									until
										l_list.after or else l_found
									loop
										l_type := l_list.item
										l_found := same_generics (l_type, l_types)
										l_list.forth
									end
									if l_found then
										create l_gen_type.make
										l_gen_type.set_type (l_type.type)
										l_gen_type.set_generics (l_types)
										Result := l_gen_type
									end
								end
							end
						end
					end
				end
			end
		end

	same_generics (a_type: RT_TYPE; a_types: NATIVE_ARRAY [RT_TYPE]): BOOLEAN is
			-- Is `a_types' compatible with `a_type'?
		require
			a_type_not_void: a_type /= Void
			a_types_not_void: a_types /= Void
		local
			l_gen_type: RT_GENERIC_TYPE
			l_generics: NATIVE_ARRAY [RT_TYPE]
			i, nb: INTEGER
			l_class_type: RT_CLASS_TYPE
			l_type: SYSTEM_TYPE
			l_formal: RT_FORMAL_TYPE
		do
			l_gen_type ?= a_type
			if l_gen_type /= Void then
				l_generics := l_gen_type.generics
				nb := l_generics.count
				if nb = a_types.count then
					from
						Result := True
					until
						i = nb or else not Result
					loop
						l_class_type ?= a_types.item (i)
						if l_class_type /= Void then
							l_type := l_class_type.dotnet_type
							if l_type.is_value_type then
								Result := l_generics.item (i).equals (associated_runtime_type (l_type))
							else
									-- It should be a formal
								l_formal ?= l_generics.item (i)
								Result := l_formal /= Void
							end
						else
							Result := False
						end
						i := i + 1
					end
				end
			end
		end

	load_assemblies is
			-- Analyzes current loaded assembly in current AppDomain. Assemblies
			-- loaded after are loaded by hooking `load_eiffel_types_from_assembly'
			-- to the `add_assembly_load' event.
		local
			l_assemblies: NATIVE_ARRAY [ASSEMBLY]
			i, nb: INTEGER
			l_handler: ASSEMBLY_LOAD_EVENT_HANDLER
		once
			l_assemblies := {APP_DOMAIN}.current_domain.get_assemblies
			create l_handler.make (Current, $assembly_load_event)
			{APP_DOMAIN}.current_domain.add_assembly_load (l_handler)
			from
				nb := l_assemblies.count
			until
				i = nb
			loop
				load_eiffel_types_from_assembly (l_assemblies.item (i))
				i := i + 1
			end
		end

	assembly_load_event (sender: SYSTEM_OBJECT; args: ASSEMBLY_LOAD_EVENT_ARGS) is
			-- Action executed when a new assembly is loaded.
		do
			if args /= Void then
				check
					has_loaded_assembly: args.loaded_assembly /= Void
				end
				load_eiffel_types_from_assembly (args.loaded_assembly)
			end
		end

	assembly_names: HASHTABLE is
			-- Prevent same assembly to be loaded more than once by `load_eiffel_types_from_assembly'
		once
			create Result.make (10)
		ensure
			assembly_names_not_void: Result /= Void
		end

	load_eiffel_types_from_assembly (an_assembly: ASSEMBLY) is
			-- Load all Eiffel types from `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		local
			l_types: NATIVE_ARRAY [SYSTEM_TYPE]
			l_name: EIFFEL_NAME_ATTRIBUTE
			l_cas: NATIVE_ARRAY [SYSTEM_OBJECT]
			i, j, nb, l_count: INTEGER
			retried: BOOLEAN
			l_class_type: RT_CLASS_TYPE
			l_gen_type: RT_GENERIC_TYPE
			l_array: NATIVE_ARRAY [SYSTEM_TYPE]
			l_rt_array: NATIVE_ARRAY [RT_TYPE]
			l_type, l_param_type, l_any_type, l_interface_type: SYSTEM_TYPE
			l_formal_type: RT_FORMAL_TYPE
			l_list: ARRAYED_LIST [RT_CLASS_TYPE]
			l_assembly_name: ASSEMBLY_NAME
			l_provider: ICUSTOM_ATTRIBUTE_PROVIDER
		do
			if not retried then
				l_assembly_name := an_assembly.get_name
				if not assembly_names.contains (l_assembly_name) then
					l_types := an_assembly.get_types
						-- Add only when types have been extracted. On some assemblies
						-- types cannot be extracted.
					assembly_names.add (l_assembly_name, l_assembly_name)
					from
						nb := l_types.count
					until
						i = nb
					loop
						l_type := l_types.item (i)
						l_provider := l_type
						l_cas := l_provider.get_custom_attributes_type ({EIFFEL_NAME_ATTRIBUTE}, False)
						if l_cas /= Void and then l_cas.count > 0 then
							l_name ?= l_cas.item (0)
							check
								l_name_not_void: l_name /= Void
							end
							if l_name.is_generic then
								check
									has_generics: l_name.generics /= Void
								end
								l_array := l_name.generics
								l_count := l_array.count
								create l_rt_array.make (l_count)
								from
									l_any_type := {ANY}
									j := 0
								until
									j = l_count
								loop
									l_param_type := l_array.item (j)
										-- Special case here. If we load another Eiffel assembly which
										-- contains its own version of ANY, then the comparison will fail.
										-- Since the code was generated so that it is either ANY or a value type,
										-- then if it is not a value type, then we need to do as if it was our ANY.
									if l_param_type.equals (l_any_type) or else not l_param_type.is_value_type then
											-- It is a formal
										create l_formal_type.make
										l_formal_type.set_position (j)
										l_rt_array.put (j, l_formal_type)
									else
											-- It is an expanded type
										check
											l_param_type_is_value_type: l_param_type.is_value_type
										end
										l_rt_array.put (j,
											associated_runtime_type (interface_type (l_param_type)))
									end
									j := j + 1
								end
								if l_count = 0 then
										-- It should be a TUPLE type.
									check
										tuple_name: l_name.name.is_equal ("TUPLE")
									end
									create {RT_TUPLE_TYPE} l_gen_type.make
								else
									create l_gen_type.make
								end
								l_interface_type := interface_type (l_type)
								l_gen_type.set_type (l_interface_type.type_handle)
								l_gen_type.set_generics (l_rt_array)
								l_class_type := l_gen_type
							else
								create l_class_type.make
								l_interface_type := interface_type (l_type)
								l_class_type.set_type (l_interface_type.type_handle)
							end

								-- Update `interface_to_implementation'
							interface_to_implementation.add (l_interface_type, l_type)

								-- Update `eiffel_meta_type_mapping'
							eiffel_meta_type_mapping.search (mapped_type (l_name.name))
							if eiffel_meta_type_mapping.found then
								eiffel_meta_type_mapping.found_item.extend (l_class_type)
							else
								create l_list.make (1)
								l_list.extend (l_class_type)
								eiffel_meta_type_mapping.force (l_list, l_name.name)
							end
						end
						i := i + 1
					end
				end
			end
		rescue
				-- It could fail in `an_assembly.get_types' and we don't want to
				-- prevent the assembly to load by failing here.
			retried := True
			retry
		end

	associated_runtime_type (a_type: SYSTEM_TYPE): RT_CLASS_TYPE is
			-- Associated Eiffel runtime type for an expanded `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_type_is_expanded: a_type.is_value_type
		do
			if abstract_types.contains (a_type) then
				create {RT_BASIC_TYPE} Result.make
			elseif a_type.equals_type ({RT_NONE_TYPE}) then
				create {RT_NONE_TYPE} Result.make
			else
				create Result.make
			end
			Result.set_type (a_type.type_handle)
		ensure
			associated_runtime_type_not_void: Result /= Void
		end

	eiffel_type_to_id: HASHTABLE is
			-- Mapping between live Eiffel types and their dynamic type id.
			-- Key: RT_CLASS_TYPE
			-- Value: dynamic type
		once
			create Result.make (chunk_size)
		ensure
			eiffel_type_to_id_not_void: Result /= Void
		end

	eiffel_meta_type_mapping: HASH_TABLE [ARRAYED_LIST [RT_CLASS_TYPE], STRING] is
			-- Mapping between Eiffel class names and .NET pseudo-types.
			-- It only contains the pseudo derivation, that is to say for
			-- a generic class A [G], where the following generic derivation
			-- exists in the system A [INTEGER_16], A [STRING], A [ANY], it only
			-- contains A [INTEGER_16] and A [REFERENCE_TYPE].
		local
			l_basic_type: RT_BASIC_TYPE
			l_list: ARRAYED_LIST [RT_CLASS_TYPE]
		once
			create Result.make (chunk_size)
				-- Add basic type
			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({NATURAL_8}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "NATURAL_8")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({NATURAL_16}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "NATURAL_16")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({NATURAL_32}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "NATURAL_32")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({NATURAL_64}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "NATURAL_64")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({INTEGER_8}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "INTEGER_8")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({INTEGER_16}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "INTEGER_16")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({INTEGER}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "INTEGER_32")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({INTEGER_64}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "INTEGER_64")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({POINTER}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "POINTER")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({CHARACTER_8}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "CHARACTER_8")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({REAL}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "REAL_32")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({DOUBLE}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "REAL_64")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({BOOLEAN}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "BOOLEAN")

			create l_list.make (1)
			l_list.extend (create {RT_NONE_TYPE}.make)
			Result.put (l_list, "NONE")
		ensure
			eiffel_meta_type_mapping_not_void: Result /= Void
		end

	interface_to_implementation: HASHTABLE is
			-- Mapping from interface to associated implementation.
		once
			create Result.make (chunk_size)
		ensure
			interface_to_implementation_not_void: Result /= Void
		end

	implementation_to_interface: HASHTABLE is
			-- Mapping from implementation to associated interface.
		once
			create Result.make (chunk_size)
		ensure
			implementation_to_interface_not_void: Result /= Void
		end

	abstract_types: HASHTABLE is
			-- List of all known basic types.
			-- Key: type
			-- Value: ID
		once
			create Result.make_from_capacity (10)
			Result.set_item (({POINTER}).to_cil, Pointer_type)
			Result.set_item (({CHARACTER_8}).to_cil, character_8_type)
			Result.set_item (({BOOLEAN}).to_cil, Boolean_type)
			Result.set_item (({REAL}).to_cil, real_32_type)
			Result.set_item (({DOUBLE}).to_cil, real_64_type)
			Result.set_item (({NATURAL_8}).to_cil, natural_8_type)
			Result.set_item (({NATURAL_16}).to_cil, natural_16_type)
			Result.set_item (({NATURAL_32}).to_cil, natural_32_type)
			Result.set_item (({NATURAL_64}).to_cil, natural_64_type)
			Result.set_item (({INTEGER_8}).to_cil, Integer_8_type)
			Result.set_item (({INTEGER_16}).to_cil, Integer_16_type)
			Result.set_item (({INTEGER}).to_cil, Integer_32_type)
			Result.set_item (({INTEGER_64}).to_cil, Integer_64_type)
		ensure
			abstract_types_not_void: Result /= Void
		end

	get_members (type_id: INTEGER): NATIVE_ARRAY [FIELD_INFO] is
			-- Retrieve all members of type `type_id'.
			-- We need permission to retrieve non-public members.
			-- Only fields are returned.
		require
			type_id_non_negative: type_id >= 0
		local
			l_field_info: FIELD_INFO
			allm: NATIVE_ARRAY [MEMBER_INFO]
			i, nb: INTEGER
			l_cv_f_name: STRING
			l_type: SYSTEM_TYPE
			l_fields: ARRAYED_LIST [FIELD_INFO]
		do
			Result := id_to_fields.item (type_id)
			if Result = Void then
				if is_tuple_type (type_id) or is_special_type (type_id) then
						-- To match classic behavior, SPECIAL and TUPLE are seen as if they
						-- had no attributes.
					create Result.make (1)
				else
					l_type := implementation_type (id_to_eiffel_type.item (type_id).dotnet_type)
					allm := l_type.get_members_binding_flags ({BINDING_FLAGS}.instance |
						{BINDING_FLAGS}.public | {BINDING_FLAGS}.non_public)
					from
						nb := allm.count
						create l_fields.make (nb)
					until
						i = nb
					loop
						l_field_info ?= allm.item (i)
						if l_field_info /= Void then
							l_cv_f_name := l_field_info.name
							if not l_cv_f_name.is_equal (private_type_field_name) then
								l_fields.extend (l_field_info)
							end
						end
						i := i + 1
					end
					from
						l_fields.start
						i := 1
						create Result.make (l_fields.count + 1)
					until
						l_fields.after
					loop
						Result.put (i, l_fields.item)
						l_fields.forth
						i := i + 1
					end
				end
				id_to_fields.put (Result, type_id)
			end
		end

	internal_set_reference_field (i: INTEGER; object: ANY; value: SYSTEM_OBJECT) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
		do
			get_members (dynamic_type (object)).item (i).set_value (object, value)
		end

	resize_arrays (max_type_id: INTEGER) is
			-- Resize all arrays indexed by type_id so that they can accomodate
			-- `max_type_id'.
		local
			l_new_count: INTEGER
		do
			l_new_count := array_upper_cell.item
			if max_type_id > l_new_count then
				l_new_count := (max_type_id).max (l_new_count * 2)
				array_upper_cell.put (l_new_count)
				id_to_eiffel_type.conservative_resize (0, l_new_count)
				id_to_eiffel_implementation_type.conservative_resize (0, l_new_count)
				id_to_fields.conservative_resize (0, l_new_count)
				id_to_fields_static_type.conservative_resize (0, l_new_count)
				id_to_fields_abstract_type.conservative_resize (0, l_new_count)
				id_to_fields_name.conservative_resize (0, l_new_count)
			end
		end

	id_to_eiffel_type: ARRAY [RT_CLASS_TYPE] is
			-- Mapping between dynamic type id and Eiffel types.
		once
			create Result.make (min_predefined_type, array_upper_cell.item)
		ensure
			id_to_eiffel_type_not_void: Result /= Void
		end

	id_to_eiffel_implementation_type: ARRAY [RT_CLASS_TYPE] is
			-- Mapping between dynamic type id and Eiffel implementation types.
		once
			create Result.make (min_predefined_type, array_upper_cell.item)
		ensure
			id_to_eiffel_type_not_void: Result /= Void
		end

	id_to_fields: ARRAY [NATIVE_ARRAY [FIELD_INFO]] is
			-- Buffer for `get_members' lookups index by type_id.
		once
			create Result.make (min_predefined_type, array_upper_cell.item)
		ensure
			id_to_fields_not_void: Result /= Void
		end

	id_to_fields_abstract_type: ARRAY [NATIVE_ARRAY [INTEGER]] is
			-- Buffer for `field_type_of_type' lookups index by type_id.
		once
			create Result.make (min_predefined_type, array_upper_cell.item)
		ensure
			id_to_fields_abstract_type_not_void: Result /= Void
		end

	id_to_fields_static_type: ARRAY [NATIVE_ARRAY [INTEGER]] is
			-- Buffer for `field_static_type_of_type' lookups index by type_id.
		once
			create Result.make (min_predefined_type, array_upper_cell.item)
		ensure
			id_to_fields_static_type_not_void: Result /= Void
		end

	id_to_fields_name: ARRAY [NATIVE_ARRAY [STRING]] is
			-- Buffer for `field_name_of_type' lookups index by type_id.
		once
			create Result.make (min_predefined_type, array_upper_cell.item)
		ensure
			id_to_fields_name_not_void: Result /= Void
		end

	marked_objects: HASHTABLE is
			-- Contains all objects marked.
		once
			create Result.make (chunk_size, Void, create {RT_REFERENCE_COMPARER}.make)
		end

	chunk_size: INTEGER is 50;
			-- Default initial size for tables.

	array_upper_cell: CELL [INTEGER] is
			-- Store upper index for all arrays indexed by type id.
		once
			create Result.put (chunk_size)
		ensure
			array_upper_cell: Result /= Void
		end

	tuple_native_array_field_info: FIELD_INFO is
			-- Info about `native_array' of TUPLE.
		local
			l_tuple: TUPLE
			l_tuple_type_id: INTEGER
			allm: NATIVE_ARRAY [MEMBER_INFO]
			i, nb: INTEGER
			l_cv_f_name: STRING
			l_type: SYSTEM_TYPE
		once
			create l_tuple
			l_tuple_type_id := dynamic_type (l_tuple)
			l_type := implementation_type (id_to_eiffel_type.item (l_tuple_type_id).dotnet_type)
			allm := l_type.get_members_binding_flags ({BINDING_FLAGS}.instance |
				{BINDING_FLAGS}.public | {BINDING_FLAGS}.non_public)
			from
				nb := allm.count
			until
				i = nb
			loop
				Result ?= allm.item (i)
				if Result /= Void then
					l_cv_f_name := Result.name
					if l_cv_f_name.is_equal (private_type_field_name) then
						Result := Void
					else
						i := nb - 1 -- Jump out of loop
					end
				end
				i := i + 1
			end
		ensure
			tuple_native_array_field_info_not_void: Result /= Void
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



end -- class INTERNAL
