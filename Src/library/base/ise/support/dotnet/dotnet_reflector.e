note
	description: "[
			Access to internal object properties.
			This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_REFLECTOR

inherit
	REFLECTOR_HELPER

	REFLECTOR_CONSTANTS

	REFACTORING_HELPER

feature -- Conformance

	is_instance_of (object: ANY; type_id: INTEGER): BOOLEAN
			-- Is `object' an instance of type `type_id'?
		require
			object_not_void: object /= Void
			type_id_nonnegative: type_id >= 0
		do
			Result := type_conforms_to (dynamic_type (object), type_id)
		end

	type_conforms_to (type1, type2: INTEGER): BOOLEAN
			-- Does `type1' conform to `type2'?
		require
			type1_nonnegative: type1 >= 0
			type2_nonnegative: type2 >= 0
		local
			l_system_type1, l_system_type2: detachable SYSTEM_TYPE
		do
			if type1 = type2 then
				Result := True
			else
				fixme ("Take into account generics")
				if attached id_to_eiffel_type.item (type1) as l_rt_class_type then
					l_system_type1 := l_rt_class_type.dotnet_type
				end
				if attached id_to_eiffel_type.item (type2) as l_rt_class_type then
					l_system_type2 := l_rt_class_type.dotnet_type
				end
				if l_system_type1 /= Void and l_system_type2 /= Void then
					Result := l_system_type2.is_assignable_from (l_system_type1)
				end
			end
		ensure
			instance_free: class
		end

	field_conforms_to (a_source_type, a_field_type: INTEGER): BOOLEAN
			-- Does `a_source_type' conform to `a_field_type'?
			--| Different from `type_conforms_to' since possible attachment mark of `a_field_type'
			--| is discarded.
		require
			a_source_type_non_negative: a_source_type >= 0
			a_field_type_non_negative: a_field_type >= 0
		do
				-- Currently .NET does not support attachment, this is why we are simlpy
				-- calling `type_conforms_to'.
			fixme ("Take into account attachment marks")
			Result := type_conforms_to (a_source_type, a_field_type)
		end

feature -- Creation

	dynamic_type_from_string (class_type: READABLE_STRING_GENERAL): INTEGER
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
			elseif attached {RT_CLASS_TYPE} eiffel_type_from_string (class_type) as l_type then
				Result := dynamic_type_from_rt_class_type (l_type)
				l_table.put (Result, class_type)
			else
				Result := -1
			end
		ensure
			dynamic_type_from_string_valid: Result = -1 or Result = none_type or Result >= 0
		end

	new_instance_of (type_id: INTEGER): ANY
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
		require
			type_id_nonnegative: type_id >= 0
			not_special_type: not is_special_type (type_id)
		do
			check attached {ISE_RUNTIME}.create_type (pure_implementation_type (type_id)) as l_result then
				Result := l_result
			end
			if attached {TUPLE} Result as l_tuple and then attached tuple_native_array_field_info as l_info then
					-- Create `native_array' field from TUPLE, otherwise we would violate
					-- TUPLE invariant. Note that the `native_array' has one more element than
					-- the number of generic parameters (see TUPLE.default_create).
				l_info.set_value (l_tuple,
					create {NATIVE_ARRAY [detachable SYSTEM_OBJECT]}.make (generic_count (l_tuple) + 1))
			end
		ensure
			not_special_type: not is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
		end

	new_special_any_instance (type_id, count: INTEGER): SPECIAL [detachable ANY]
			-- New instance of dynamic `type_id' that represents
			-- a SPECIAL with `count' element. To create a SPECIAL of
			-- basic type, use `TO_SPECIAL'.
		require
			count_valid: count >= 0
			type_id_nonnegative: type_id >= 0
			special_type: is_special_any_type (type_id)
		local
			l_assert: BOOLEAN
		do
			l_assert := {ISE_RUNTIME}.check_assert (False)
			check attached {SPECIAL [detachable ANY]} {ISE_RUNTIME}.create_type (pure_implementation_type (type_id)) as l_result then
				Result := l_result
				Result.make_empty (count)
			end
			{ISE_RUNTIME}.check_assert (l_assert).do_nothing
		ensure
			special_type: is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
			count_set: Result.count = 0
			capacity_set: Result.capacity = count
		end

	type_of (object: detachable ANY): detachable TYPE [detachable ANY]
			-- Type object for `object'.
		do
			if object /= Void then
				Result := type_of_type (dynamic_type (object))
			else
				check
					expected_type:
						attached {TYPE [detachable ANY]} new_instance_of (dynamic_type_from_string ("TYPE [NONE]")) as t
				then
					Result := t
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	type_of_type (type_id: INTEGER): TYPE [detachable ANY]
			-- Return type for type id `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		local
			l_type_name: STRING
		do
			create l_type_name.make (30)
			l_type_name.append ("TYPE [")
			l_type_name.append (type_name_of_type (type_id))
			l_type_name.append_character (']')
			check attached {detachable like type_of_type} new_instance_of (dynamic_type_from_string (l_type_name)) as l_result then
				Result := l_result
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_special_any_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type.
		require
			type_id_nonnegative: type_id >= 0
		local
			l_dotnet_type: detachable SYSTEM_TYPE
		do
				-- Unlike `is_special_type' we need to take the interface type,
				-- as the ({SPECIAL [ANY]}).to_cil will yield the interface type, not
				-- the implementation type.
			if attached {RT_GENERIC_TYPE} id_to_eiffel_type.item (type_id) as l_gen_type and then l_gen_type.count = 1 then
				l_dotnet_type := l_gen_type.dotnet_type
				Result := l_dotnet_type /= Void and then l_dotnet_type.equals (({SPECIAL [ANY]}).to_cil)
			end
		end

	is_special_expanded_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a user defined expanded type.
		require
			type_id_nonnegative: type_id >= 0
			is_special_type: is_special_type (type_id)
		do
			if attached {RT_GENERIC_TYPE} pure_implementation_type (type_id) as l_gen_type then
				Result := attached l_gen_type.generics as l_generics and then
					attached {RT_CLASS_TYPE} l_generics.item (0) as l_type and then
					not l_type.is_basic and then
					attached l_type.dotnet_type as l_dotnet_type and then
					l_dotnet_type.is_value_type
			end
		end

	is_special_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type
			-- or a basic type.
		require
			type_id_nonnegative: type_id >= 0
		local
			l_class_name: detachable SYSTEM_STRING
		do
			fixme ("It might return True if another class is called SPECIAL")
			if attached {RT_GENERIC_TYPE} pure_implementation_type (type_id) as l_gen_type and then l_gen_type.count = 1 then
				l_class_name := l_gen_type.class_name
				Result := l_class_name /= Void and then l_class_name.equals (special_class_name)
			end
		end

	is_special (object: ANY): BOOLEAN
			-- Is `object' a special object?
			-- It only recognized a special object
			-- initialized within a TO_SPECIAL object.
		require
			object_not_void: object /= Void
		do
			Result := is_special_type (dynamic_type (object))
		end

	is_expanded_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent an expanded type?
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := attached  Id_to_eiffel_implementation_type.item (type_id) as l_type and then
				attached l_type.dotnet_type as l_dotnet_type and then l_dotnet_type.is_value_type
		end

	is_tuple_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent a TUPLE?
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := attached {RT_TUPLE_TYPE} pure_implementation_type (type_id) as l_tuple_type
		end

	is_tuple (object: ANY): BOOLEAN
			-- Is `object' a TUPLE object?
		require
			object_not_void: object /= Void
		do
			Result := attached {TUPLE} object as l_tuple
		end

	is_marked (obj: ANY): BOOLEAN
			-- Is `obj' marked?
		require
			object_not_void: obj /= Void
		do
			Result := {ISE_RUNTIME}.is_object_marked (obj)
		end

	is_attached_type (a_type_id: INTEGER): BOOLEAN
			-- Is `a_type_id' an attached type?
		require
			a_type_non_negative: a_type_id >= 0
		do
				-- Currently .NET does not support attachment.
			fixme ("Take into account attachment marks")
			Result := False
		end

	is_field_transient_of_type (i: INTEGER; a_type_id: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' a transient attribute?
			-- I.e. an attribute that does not need to be stored?
		require
			a_type_non_negative: a_type_id >= 0
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (a_type_id)
		local
			l_transients: ARRAYED_LIST [BOOLEAN]
			l_members: like get_members
			l_is_transient: BOOLEAN
			k, nb: INTEGER
			l_attributes: detachable NATIVE_ARRAY [detachable SYSTEM_OBJECT]
			l_field: FIELD_INFO
			l_provider: ICUSTOM_ATTRIBUTE_PROVIDER
		do
			if attached id_to_fields_transient.item (a_type_id) as l_result then
				Result := l_result.i_th (i)
			else
				from
					l_members := get_members (a_type_id)
					k := 1
					nb := l_members.count
					create l_transients.make (nb)
				until
					k > nb
				loop
					l_field := l_members.i_th (k)
					l_provider := l_field
					l_attributes := l_provider.get_custom_attributes ({NON_SERIALIZED_ATTRIBUTE}, False)
					if l_attributes /= Void and then l_attributes.count > 0 then
						check
							valid_number_of_custom_attributes: l_attributes.count = 1
						end
						l_is_transient := attached {NON_SERIALIZED_ATTRIBUTE} l_attributes.item (0)
					else
						l_is_transient := False
					end
					l_transients.extend (l_is_transient)
					k := k + 1
				end
				id_to_fields_transient.put (l_transients, a_type_id)
				Result := l_transients.i_th (i)
			end
		end

	is_field_expanded_of_type (i: INTEGER; a_type_id: INTEGER): BOOLEAN
			-- Is `i'-th field of type `a_type_id' a user-defined expanded attribute?
		require
			a_type_non_negative: a_type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (a_type_id)
		do
			Result := field_type_of_type (i, a_type_id) = expanded_type
		end

feature -- Access

	class_name (object: ANY): STRING
			-- Name of the class associated with `object'
		require
			object_not_void: object /= Void
		do
			Result := object.generator
		end

	class_name_of_type (type_id: INTEGER): STRING
			-- Name of class associated with dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			if
				attached id_to_eiffel_type.item (type_id) as l_rt_class_type and then
				attached l_rt_class_type.class_name as l_name
			then
				Result := l_name
			else
				Result := "Unknown base class"
			end
		end

	type_name (object: ANY): STRING
			-- Name of `object''s generating type (type of which `object'
			-- is a direct instance).
			-- Consider using `type_name_32`.
		require
			object_not_void: object /= Void
		do
			Result := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (object.generating_type.name_32)
		end

	type_name_32 (object: ANY): STRING_32
			-- Name of `object''s generating type (type of which `object'
			-- is a direct instance).
		require
			object_not_void: object /= Void
		do
			Result := object.generating_type.name_32
		end

	type_name_of_type (type_id: INTEGER): STRING
			-- Name of `type_id''s generating type (type of which `type_id'
			-- is a direct instance).
		require
			type_id_nonnegative: type_id >= 0
		do
			if
				attached pure_implementation_type (type_id) as l_rt_class_type and then
				attached l_rt_class_type.type_name as l_name
			then
				Result := l_name
			else
				Result := "Unknown Type"
			end
		end

	type_name_8_of_type (type_id: INTEGER): STRING_8
			-- Name of `type_id''s generating type (type of which `type_id'
			-- is a direct instance).
		require
			type_id_nonnegative: type_id >= 0
		do
			if
				attached pure_implementation_type (type_id) as l_rt_class_type and then
				attached l_rt_class_type.type_name as l_name
			then
				Result := l_name
			else
				Result := "Unknown Type"
			end
		end

	type_name_32_of_type (type_id: INTEGER): STRING_32
			-- Name of `type_id''s generating type (type of which `type_id'
			-- is a direct instance).
		require
			type_id_nonnegative: type_id >= 0
		do
			if
				attached pure_implementation_type (type_id) as l_rt_class_type and then
				attached l_rt_class_type.type_name as l_name
			then
				Result := l_name
			else
				Result := {STRING_32} "Unknown Type"
			end
		end

	dynamic_type (object: ANY): INTEGER
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		local
			l_class_type: detachable RT_CLASS_TYPE
			l_object: SYSTEM_OBJECT
			l_type: detachable SYSTEM_TYPE
		do
			if attached {RT_GENERIC_TYPE} {ISE_RUNTIME}.generic_type (object) as l_gen_type then
					-- Convert `l_gen_type' so that all referenced types are using the associated
					-- interface type if any. As run-time generates data for implementation not for
					-- interfaces.
				l_class_type := internal_pure_interface_type (l_gen_type)
				check
					l_class_type_not_void: l_class_type /= Void
				end
			else
					-- Case of a non-generic Eiffel class or of a .NET class
					-- Let's retrieve the associated type and its interface type if any.
				create l_class_type.make
				l_object := object
				l_type := l_object.get_type
				check l_type /= Void then
					l_class_type.set_type (interface_type (l_type).type_handle)
				end
			end
			Result := dynamic_type_from_rt_class_type (l_class_type)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	attached_type (type_id: INTEGER): INTEGER
			-- Attached version of `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
				-- Currently .NET does not support attachment.
			fixme ("Take into account attachment marks")
			Result := type_id
		ensure
			unchanged_if_attached: is_attached_type (type_id) implies type_id = Result
		end

	detachable_type (type_id: INTEGER): INTEGER
			-- Detachable version of `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
				-- Currently .NET does not support attachment.
			fixme ("Take into account attachment marks")
			Result := type_id
		ensure
			unchanged_if_detachable: not is_attached_type (type_id) implies type_id = Result
		end

	generic_count (obj: ANY): INTEGER
			-- Number of generic parameter in `obj'.
		require
			obj_not_void: obj /= Void
		do
			Result := {ISE_RUNTIME}.generic_parameter_count (obj)
		end

	generic_count_of_type (type_id: INTEGER): INTEGER
			-- Number of generic parameter in `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			if attached {RT_GENERIC_TYPE} id_to_eiffel_type.item (type_id) as l_gen_type then
				Result := l_gen_type.count
			end
		end

	generic_dynamic_type (object: ANY; i: INTEGER): INTEGER
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		require
			object_not_void: object /= Void
			object_generic: generic_count (object) > 0
			i_valid: i > 0 and i <= generic_count (object)
		local
			l_class_type: detachable RT_CLASS_TYPE
		do
			Result := -1
			l_class_type := {ISE_RUNTIME}.type_of_generic (object, i)
			if l_class_type /= Void then
				l_class_type := internal_pure_interface_type (l_class_type)
				if l_class_type /= Void then
					Result := dynamic_type_from_rt_class_type (l_class_type)
				end
			end
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	generic_dynamic_type_of_type (type_id, i: INTEGER): INTEGER
			-- Dynamic type of generic parameter of `type_id' at position `i'.
		require
			type_id_nonnegative: type_id >= 0
			type_id_generic: generic_count_of_type (type_id) > 0
			i_valid: i > 0 and i <= generic_count_of_type (type_id)
		do
			if
				attached {RT_GENERIC_TYPE} id_to_eiffel_type.item (type_id) as l_gen_type and then
				attached l_gen_type.generics as l_generics and then
				attached {RT_CLASS_TYPE} l_generics.item (i - 1) as l_class_type
			then
				Result := dynamic_type_from_rt_class_type (l_class_type)
			else
				Result := -1
			end
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	storable_version_of_type (a_type_id: INTEGER): detachable IMMUTABLE_STRING_8
			-- Storable version if any specified.
		require
			a_type_id_nonnegative: a_type_id >= 0
		local
			l_cas: detachable NATIVE_ARRAY [detachable SYSTEM_OBJECT]
			l_result: detachable IMMUTABLE_STRING_8
		do
			if attached id_to_storable_version.item (a_type_id) as l_version_string then
				if l_version_string.is_empty then
					Result := Void
				else
					Result := l_version_string
				end
			else
				if
					attached pure_implementation_type (a_type_id) as l_rt_class_type and then
					attached {SYSTEM_TYPE}.get_type_from_handle (l_rt_class_type.type) as l_current_type
				then
							-- Get storable version.
					l_cas := l_current_type.get_custom_attributes ({EIFFEL_VERSION_ATTRIBUTE}, False)
					if
						l_cas /= Void and then l_cas.count > 0 and then
						attached {EIFFEL_VERSION_ATTRIBUTE} l_cas.item (0) as l_version and then
						attached l_version.version as l_version_string
					then
						l_result := l_version_string
						Result := l_result
					else
						l_result := internal_empty_string
					end
				else
					l_result := internal_empty_string
				end
					-- We do not store `Voids' in `id_to_storable_version' to have an efficient caching.
				id_to_storable_version.put (l_result, a_type_id)
			end
		end

	field_count_of_type (type_id: INTEGER): INTEGER
			-- Number of logical fields in dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := get_members (type_id).count
		end

	persistent_field_count_of_type (a_type_id: INTEGER): INTEGER
			-- Number of logical fields in dynamic type `type_id' that are not transient.
		require
			a_type_non_negative: a_type_id >= 0
		local
			i, nb: INTEGER
		do
			Result := persistent_field_counts.item (a_type_id)
			if Result = -1 then
				from
					i := 1
					nb := field_count_of_type (a_type_id)
					Result := 0
				until
					i > nb
				loop
					if not is_field_transient_of_type (i, a_type_id) then
						Result := Result + 1
					end
					i := i + 1
				end
				persistent_field_counts.put (Result, a_type_id)
			end
		ensure
			count_positive: Result >= 0
		end

	field_name_of_type (i: INTEGER; type_id: INTEGER): STRING
			-- Name of `i'-th field of dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (type_id)
		local
			l_names: ARRAYED_LIST [STRING]
			l_members: like get_members
			l_name: detachable SYSTEM_STRING
			k, nb: INTEGER
			l_attributes: detachable NATIVE_ARRAY [detachable SYSTEM_OBJECT]
			l_field: FIELD_INFO
			l_provider: ICUSTOM_ATTRIBUTE_PROVIDER
		do
			if attached id_to_fields_name.item (type_id) as l_result then
				Result := l_result.i_th (i)
			else
				from
					l_members := get_members (type_id)
					k := 1
					nb := l_members.count
					create l_names.make (nb)
				until
					k > nb
				loop
					l_field := l_members.i_th (k)
					l_provider := l_field
					l_attributes := l_provider.get_custom_attributes ({EIFFEL_NAME_ATTRIBUTE}, False)
					if l_attributes /= Void and then l_attributes.count > 0 then
						check
							valid_number_of_custom_attributes: l_attributes.count = 1
						end
						if attached {EIFFEL_NAME_ATTRIBUTE} l_attributes.item (0) as l_eiffel_name then
							l_name := l_eiffel_name.name
						else
							l_name := l_field.name
						end
					else
						l_name := l_field.name
					end
					if l_name /= Void then
						l_names.extend (l_name)
					else
						l_names.extend ("Invalid field name")
					end
					k := k + 1
				end
				id_to_fields_name.put (l_names, type_id)
				Result := l_names.i_th (i)
			end
		ensure
			field_name_of_type_not_void: Result /= Void
		end

	field_name_8_of_type (i: INTEGER; type_id: INTEGER): STRING_8
			-- Name of `i'-th field of dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (type_id)
		local
			l_names: ARRAYED_LIST [STRING_8]
			l_members: like get_members
			l_name: detachable SYSTEM_STRING
			k, nb: INTEGER
			l_attributes: detachable NATIVE_ARRAY [detachable SYSTEM_OBJECT]
			l_field: FIELD_INFO
			l_provider: ICUSTOM_ATTRIBUTE_PROVIDER
		do
			if attached id_to_fields_name.item (type_id) as l_result then
				Result := l_result.i_th (i)
			else
				from
					l_members := get_members (type_id)
					k := 1
					nb := l_members.count
					create l_names.make (nb)
				until
					k > nb
				loop
					l_field := l_members.i_th (k)
					l_provider := l_field
					l_attributes := l_provider.get_custom_attributes ({EIFFEL_NAME_ATTRIBUTE}, False)
					if l_attributes /= Void and then l_attributes.count > 0 then
						check
							valid_number_of_custom_attributes: l_attributes.count = 1
						end
						if attached {EIFFEL_NAME_ATTRIBUTE} l_attributes.item (0) as l_eiffel_name then
							l_name := l_eiffel_name.name
						else
							l_name := l_field.name
						end
					else
						l_name := l_field.name
					end
					if l_name /= Void then
						l_names.extend (l_name)
					else
						l_names.extend ("Invalid field name")
					end
					k := k + 1
				end
				id_to_fields_name.put (l_names, type_id)
				Result := l_names.i_th (i)
			end
		ensure
			field_name_of_type_not_void: Result /= Void
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER
			-- Abstract type of `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		local
			l_type: detachable SYSTEM_TYPE
			l_native_array: detachable NATIVE_ARRAY [INTEGER]
			l_members: like get_members
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
					k > nb
				loop
					l_type := l_members.i_th (k).field_type
					if l_type /= Void then
						if not l_type.is_value_type and not l_type.is_enum then
							l_abstract_type := Reference_type
						else
							if abstract_types.contains (l_type) then
								check
									expected_type: attached {INTEGER} abstract_types.item (l_type) as t
								then
									l_abstract_type := t
								end
							else
								l_abstract_type := Expanded_type
							end
						end
					else
							-- It should not happen, so we put a value that would
							-- cause some failure.
						l_abstract_type := -1
					end
					l_native_array.put (k - 1, l_abstract_type)
					k := k + 1
				end
				id_to_fields_abstract_type.put (l_native_array, type_id)
			end
			Result := l_native_array.item (i - 1)
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_static_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER
			-- Static type of declared `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		local
			l_class_type: detachable RT_CLASS_TYPE
			l_current_rt_gen_type: detachable RT_GENERIC_TYPE
			l_type: detachable SYSTEM_TYPE
			l_dtypes: detachable NATIVE_ARRAY [INTEGER]
			l_attributes: detachable NATIVE_ARRAY [detachable SYSTEM_OBJECT]
			k, nb, l_dtype: INTEGER
			l_members: like get_members
			l_field: FIELD_INFO
			l_provider: ICUSTOM_ATTRIBUTE_PROVIDER
		do
			l_dtypes := id_to_fields_static_type.item (type_id)
			if l_dtypes = Void then
				check
					attached pure_implementation_type (type_id) as l_current_rt_type and then
					attached {ISE_RUNTIME}.create_type (l_current_rt_type) as l_object and then
					attached {SYSTEM_TYPE}.get_type_from_handle (l_current_rt_type.type) as l_current_type
				then
						-- Get RT_GENERIC_TYPE from `l_current_rt_type' if it
						-- is an instance of `RT_GENERIC_TYPE', otherwise we get
						-- Void which is ok to, it simply means the call to `evaluated_type'
						-- below will not require a generic type as it should include
						-- no formals.
					if attached {RT_GENERIC_TYPE} l_current_rt_type as t then
						l_current_rt_gen_type := t
					end
					from
						l_members := get_members (type_id)
						k := 1
						nb := l_members.count
						create l_dtypes.make (nb)
					until
						k > nb
					loop
							-- Default initialization to -1
						l_dtype := -1
						l_field := l_members.i_th (k)
						l_provider := l_field
						l_attributes := l_provider.get_custom_attributes ({TYPE_FEATURE_ATTRIBUTE}, False)
						if
							l_attributes /= Void and then l_attributes.count = 1 and then
							attached {TYPE_FEATURE_ATTRIBUTE} l_attributes.item (0) as l_type_feature_name
						then
							if attached l_current_type.get_method (l_type_feature_name.feature_name) as l_meth then
									-- Invoke method that is going to give us a RT_TYPE instance representing the
									-- static type of the field for the base class of `type_id'.
								if attached {RT_TYPE} l_meth.invoke_object_object_array (l_object, Void) as l_rt_type then
										-- Evaluate given type into context of `l_current_rt_gen_type' to resolve
										-- formals to actual generic parameters. Of course if `l_current_rt_gen_type'
										-- is Void, it means that `l_rt_type' does not contain any formals.
									if attached {RT_CLASS_TYPE} l_rt_type.evaluated_type (l_current_rt_gen_type) as t then
											-- Get the associated dynamic type.
										l_class_type := internal_pure_interface_type (t)
										if l_class_type /= Void then
											l_dtype := dynamic_type_from_rt_class_type (l_class_type)
										end
									end
								end
							end
						else
								-- Case of a non-generic attribute or non-formal one.
							l_type := l_field.field_type
							if l_type /= Void then
								l_type := interface_type (l_type)
								if l_type.is_value_type then
										-- Case of an expanded type.
									l_dtype :=
										dynamic_type_from_rt_class_type (associated_runtime_type (l_type))
								else
										-- Normal case, we handle a non-generic class type.
									create l_class_type.make
									l_attributes := l_field.get_custom_attributes ({RT_INTERFACE_TYPE_ATTRIBUTE}, False)
									if
										l_attributes /= Void and then l_attributes.count > 0 and then
										attached {RT_INTERFACE_TYPE_ATTRIBUTE} l_attributes.item (0) as l_type_attr
									then
										l_type := l_type_attr.class_type
									end
									if l_type /= Void then
										l_class_type.set_type (l_type.type_handle)
										l_dtype := dynamic_type_from_rt_class_type (l_class_type)
									end
								end
							end
						end
						l_dtypes.put (k - 1, l_dtype)
						k := k + 1
					end
				end
				id_to_fields_static_type.put (l_dtypes, type_id)
			end
			Result := l_dtypes.item (i - 1)
		ensure
			field_type_nonnegative: Result >= 0
		end

feature {NONE} -- Cached data

	internal_dynamic_type_string_table: STRING_TABLE [INTEGER]
			-- Table of dynamic type indexed by type name
		once
			create Result.make (100)
		ensure
			internal_dynamic_type_string_table_not_void: Result /= Void
		end

feature {TYPE, REFLECTOR, REFLECTED_OBJECT} -- Implementation

	private_type_field_name: SYSTEM_STRING = "$$____type"
			-- .NET name for fields that stores generic types if any.

	invalid_type_name_ending: SYSTEM_STRING = "\&"
			-- Invalid type name ending

	special_class_name: SYSTEM_STRING = "SPECIAL"
			-- SPECIAL class name

	next_dynamic_type_id: CELL [INTEGER]
			-- ID for dynamic type (each generic derivation get a new ID)
		once
			create Result.put (max_predefined_type + 1)
		ensure
			next_dynamic_type_id_not_void: Result /= Void
		end

	pure_implementation_type (type_id: INTEGER): detachable RT_CLASS_TYPE
			-- Given `type_id' which might include some reference to interface type,
			-- returns the corresponding implementation type.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := id_to_eiffel_implementation_type.item (type_id)
			if not attached Result then
				Result := id_to_eiffel_type.item (type_id)
				Result := internal_pure_implementation_type (Result)
				if attached Result then
					id_to_eiffel_implementation_type.put (Result, type_id)
				end
			end
		end

	internal_pure_implementation_type (a_class_type: detachable RT_CLASS_TYPE): detachable RT_CLASS_TYPE
			-- Given `a_class_type' which might include some reference to interface type,
			-- returns the corresponding implementation type.
		local
			i, nb: INTEGER
			l_generics: detachable NATIVE_ARRAY [detachable RT_TYPE]
			l_stop, l_has_none: BOOLEAN
			l_type: detachable SYSTEM_TYPE
		do
			if a_class_type = Void then
					-- No specified type, return Void.
			elseif attached {RT_GENERIC_TYPE} a_class_type as l_gen_type then
				check attached l_gen_type.generics as l_other_generics then
					from
						i := 0
						nb := l_other_generics.count
						create l_generics.make (nb)
					until
						i = nb or l_stop
					loop
						if
							attached {RT_CLASS_TYPE} l_other_generics.item (i) as l_class_type and then
							attached {RT_CLASS_TYPE} internal_pure_implementation_type (l_class_type) as l_int_class_type
						then
							l_generics.put (i, l_int_class_type)
						else
							l_stop := True
						end
						i := i + 1
					end
					if not l_stop then
						l_type := l_gen_type.dotnet_type
						if l_type /= Void then
							if l_gen_type.is_tuple then
								create {RT_TUPLE_TYPE} Result.make (
									implementation_type (l_type).type_handle, l_generics)
							else
								create {RT_GENERIC_TYPE} Result.make (
									implementation_type (l_type).type_handle, l_generics)
							end
						end
					end
				end
			else
				if attached {RT_BASIC_TYPE} a_class_type as l_basic_type then
					create {RT_BASIC_TYPE} Result.make
				elseif attached {RT_NONE_TYPE} a_class_type as l_none_type then
					create {RT_NONE_TYPE} Result.make
					l_has_none := False
				else
					create Result.make
				end
				if not l_has_none then
					l_type := a_class_type.dotnet_type
					if l_type /= Void then
						Result.set_type (implementation_type (l_type).type_handle)
					end
				end
			end
		end

	internal_pure_interface_type (a_class_type: RT_CLASS_TYPE): detachable RT_CLASS_TYPE
			-- Given `a_class_type' which might include some reference to implementation type,
			-- returns the corresponding interface type.
		require
			a_class_type_not_void: a_class_type /= Void
		local
			i, nb: INTEGER
			l_generics: detachable NATIVE_ARRAY [detachable RT_TYPE]
			l_stop, l_has_none: BOOLEAN
			l_type: detachable SYSTEM_TYPE
		do
			if attached {RT_GENERIC_TYPE} a_class_type as l_gen_type then
				check attached l_gen_type.generics as l_other_generics then
					from
						i := 0
						nb := l_other_generics.count
						create l_generics.make (nb)
					until
						i = nb or l_stop
					loop
						if
							attached {RT_CLASS_TYPE} l_other_generics.item (i) as l_class_type and then
							attached {RT_CLASS_TYPE} internal_pure_interface_type (l_class_type) as l_int_class_type
						then
							l_generics.put (i, l_int_class_type)
						else
							l_stop := True
						end
						i := i + 1
					end
					if not l_stop then
						l_type := l_gen_type.dotnet_type
						if l_type /= Void then
							if l_gen_type.is_tuple then
								create {RT_TUPLE_TYPE} Result.make (
									interface_type (l_type).type_handle, l_generics)
							else
								create {RT_GENERIC_TYPE} Result.make (
									interface_type (l_type).type_handle, l_generics)
							end
						end
					end
				end
			else
				if attached {RT_BASIC_TYPE} a_class_type as l_basic_type then
					create {RT_BASIC_TYPE} Result.make
				elseif attached {RT_NONE_TYPE} a_class_type as l_none_type then
					create {RT_NONE_TYPE} Result.make
					l_has_none := True
				else
					create Result.make
				end
				if not l_has_none then
					l_type := a_class_type.dotnet_type
					if l_type /= Void then
						Result.set_type (interface_type (l_type).type_handle)
					end
				end
			end
		end

	interface_type (a_type: SYSTEM_TYPE): SYSTEM_TYPE
			-- Interface type of Eiffel type `a_type' if it exists, otherwise `a_type'.
		require
			a_type_not_void: a_type /= Void
		do
			if attached {SYSTEM_TYPE} implementation_to_interface.item (a_type) as l_result then
				Result := l_result
			else
				check attached {ISE_RUNTIME}.interface_type (a_type) as l_type then
					implementation_to_interface.set_item (a_type, l_type)
					Result := l_type
				end
			end
		ensure
			interface_type_not_void: Result /= Void
		end

	implementation_type (a_type: SYSTEM_TYPE): SYSTEM_TYPE
			-- Implementation type of Eiffel type `a_type' if it exists, otherwise `a_type'.
		require
			a_type_not_void: a_type /= Void
		do
			load_assemblies
			if attached {SYSTEM_TYPE} interface_to_implementation.item (a_type) as t then
				Result := t
			else
					-- No associated implementation, it must be itself
				Result := a_type
			end
		ensure
			interface_type_not_void: Result /= Void
		end

	dynamic_type_from_rt_class_type (a_class_type: detachable RT_CLASS_TYPE): INTEGER
			-- Dynamic type of `a_class_type'.
		local
			l_obj: detachable SYSTEM_OBJECT
		do
			if a_class_type = Void then
				Result := -1
			else
				l_obj := eiffel_type_to_id.item (a_class_type)
				if l_obj /= Void then
					if attached {INTEGER} l_obj as i then
						Result := i
					end
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

	eiffel_type_from_string (class_type: READABLE_STRING_GENERAL): detachable RT_CLASS_TYPE
			-- Eiffel .NET type corresponding to `class_type'.
			-- If no dynamic type available, returns Void.
		require
			class_type_not_void: class_type /= Void
		local
			l_type: detachable RT_CLASS_TYPE
			l_parameters: like parameters_decomposition
			l_type_name: STRING_32
			l_start_pos, l_end_pos, i: INTEGER
			l_types: NATIVE_ARRAY [detachable RT_TYPE]
			l_found: BOOLEAN
			l_class_type_name: STRING_32
			nb: INTEGER
			l_mark: CHARACTER_32
			l_is_expanded, l_is_reference: BOOLEAN
		do
				-- Load data from all assemblies in case it is not yet done.
			load_assemblies

				-- Clean `class_type'.
			create l_class_type_name.make_from_string_general (class_type)
			l_class_type_name.left_adjust
			l_class_type_name.right_adjust

				-- Search for a non generic class type.
				-- We only check the mark if there is at least 3 characters.
			fixme ("We currently ignore attachment marks when retrieving")
			nb := l_class_type_name.count
			if nb > 1 then
				l_mark := l_class_type_name.item (1)
				if l_mark = '!' or l_mark = '?' then
					l_class_type_name.remove_head (1)
					l_class_type_name.left_adjust
				elseif nb >= 10 and l_class_type_name.substring_index ("attached", 1) = 1 then
						-- Remove `attached' and the white character after it.
					l_class_type_name.remove_head (9)
					l_class_type_name.left_adjust
				elseif nb >= 12 and l_class_type_name.substring_index ("detachable", 1) = 1 then
						-- Remove `attached' and the white character after it.					
					l_class_type_name.remove_head (11)
					l_class_type_name.left_adjust
				elseif nb >= 10 and l_class_type_name.substring_index ("expanded", 1) = 1 then
						-- Remove `expanded' and the white character after it.					
					l_class_type_name.remove_head (9)
					l_class_type_name.left_adjust
					l_is_expanded := True
				elseif nb >= 11 and l_class_type_name.substring_index ("reference", 1) = 1 then
						-- Remove `expanded' and the white character after it.					
					l_class_type_name.remove_head (10)
					l_class_type_name.left_adjust
					l_is_reference := True
				end
			end
			eiffel_meta_type_mapping.search (mapped_type (l_class_type_name))
			if eiffel_meta_type_mapping.found and then attached {ARRAYED_LIST [RT_CLASS_TYPE]} eiffel_meta_type_mapping.found_item as l_found_list then
					-- It is a non-generic Eiffel type which was recorded in `load_assemblies'
					-- Or possibly a basic type with its various associated referenced types.
					-- Nevertheless the check fails for CHARACTER_32 because it is mapped to a NATURAL_32, this
					-- is why it is commented out for the meantime.
				if l_found_list.count > 1 and then not attached {RT_BASIC_TYPE} l_found_list.first then
						-- If a list contains more than one item, we chose the item with the same expanded status.
						-- Unfortunately, this only works for type such as `expanded X' where X is not declared expanded,
						-- or `reference X' where X is declared expanded.
						-- If `X' has no qualification, we have to pick the type whose implementation has no mark (either
						-- expanded or reference).
					if l_is_expanded then
						from
							l_found_list.start
						until
							l_found_list.after or else Result /= Void
						loop
							if attached l_found_list.item.dotnet_type as l_dotnet_type and then l_dotnet_type.is_value_type then
								Result := l_found_list.item
							end
							l_found_list.forth
						end
					elseif l_is_reference then
						from
							l_found_list.start
						until
							l_found_list.after or else Result /= Void
						loop
							if attached l_found_list.item.dotnet_type as l_dotnet_type and then not l_dotnet_type.is_value_type then
								Result := l_found_list.item
							end
							l_found_list.forth
						end
					end
					if Result = Void then
							-- Case where we just got X without without knowing if the class
							-- was originally declared expanded or not.
						from
							l_found_list.start
						until
							l_found_list.after or else Result /= Void
						loop
							l_type := internal_pure_implementation_type (l_found_list.item)
							if l_type /= Void and then not l_type.has_expanded_mark and then not l_type.has_reference_mark then
									-- We found our type.
								Result := l_found_list.item
							end
							l_found_list.forth
						end
					end
				else
					Result := l_found_list.first
				end
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
						if
							l_parameters /= Void and then attached eiffel_meta_type_mapping.found_item as l_list and then
							attached {RT_GENERIC_TYPE} l_list.first as l_gen_type
						then
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
									create {RT_TUPLE_TYPE} Result.make (l_gen_type.type, l_types)
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
									if l_found and then l_type /= Void then
										create {RT_GENERIC_TYPE} Result.make (l_type.type, l_types)
									end
								end
							end
						end
					end
				end
			end
		end

	same_generics (a_type: RT_TYPE; a_types: NATIVE_ARRAY [detachable RT_TYPE]): BOOLEAN
			-- Is `a_types' compatible with `a_type'?
		require
			a_type_not_void: a_type /= Void
			a_types_not_void: a_types /= Void
		local
			i, nb: INTEGER
			l_type: detachable SYSTEM_TYPE
		do
			if attached {RT_GENERIC_TYPE} a_type as l_gen_type and then attached l_gen_type.generics as l_generics then
				nb := l_generics.count
				if nb = a_types.count then
					from
						Result := True
					until
						i = nb or else not Result
					loop
						if attached {RT_CLASS_TYPE} a_types.item (i) as l_class_type then
							l_type := l_class_type.dotnet_type
							if l_type /= Void and then l_type.is_value_type then
								Result := attached {RT_TYPE} l_generics.item (i) as l_other_type and then
									l_other_type.equals (associated_runtime_type (l_type))
							else
									-- It should be a formal
								Result := attached {RT_FORMAL_TYPE} l_generics.item (i) as l_formal
							end
						else
							Result := False
						end
						i := i + 1
					end
				end
			end
		end

	load_assemblies
			-- Analyzes current loaded assembly in current AppDomain. Assemblies
			-- loaded after are loaded by hooking `load_eiffel_types_from_assembly'
			-- to the `add_assembly_load' event.
		local
			i, nb: INTEGER
		once
			if attached {APP_DOMAIN}.current_domain as l_domain then
				l_domain.add_assembly_load (create {ASSEMBLY_LOAD_EVENT_HANDLER}.make (Current, $assembly_load_event))
				if attached l_domain.get_assemblies as l_assemblies then
					from
						nb := l_assemblies.count
					until
						i = nb
					loop
						load_eiffel_types_from_assembly (l_assemblies.item (i))
						i := i + 1
					end
				end
			end
		end

	assembly_load_event (sender: SYSTEM_OBJECT; args: ASSEMBLY_LOAD_EVENT_ARGS)
			-- Action executed when a new assembly is loaded.
		do
			if args /= Void then
				check
					has_loaded_assembly: args.loaded_assembly /= Void
				end
				load_eiffel_types_from_assembly (args.loaded_assembly)
			end
		end

	assembly_names: HASHTABLE
			-- Prevent same assembly to be loaded more than once by `load_eiffel_types_from_assembly'
		once
			create Result.make (10)
		ensure
			assembly_names_not_void: Result /= Void
		end

	load_eiffel_types_from_assembly (an_assembly: detachable ASSEMBLY)
			-- Load all Eiffel types from `an_assembly'.
		local
			l_types: detachable NATIVE_ARRAY [detachable SYSTEM_TYPE]
			i, nb: INTEGER
			retried: BOOLEAN
			l_assembly_name: detachable ASSEMBLY_NAME
		do
			if not retried and then an_assembly /= Void then
				l_assembly_name := an_assembly.get_name
				if l_assembly_name /= Void and then not assembly_names.contains (l_assembly_name) then
					l_types := an_assembly.get_types
						-- Add only when types have been extracted. On some assemblies
						-- types cannot be extracted.
					assembly_names.add (l_assembly_name, l_assembly_name)
					if l_types /= Void then
						from
							nb := l_types.count
						until
							i = nb
						loop
							if attached l_types.item (i) as l_type then
								load_eiffel_type_from_assembly (l_type)
							end
							i := i + 1
						end
					end
				end
			end
		rescue
				-- It could fail in `an_assembly.get_types' and we don't want to
				-- prevent the assembly to load by failing here.
			retried := True
			retry
		end

	load_eiffel_type_from_assembly (a_type: SYSTEM_TYPE)
			-- Load `a_type' if possible.
		require
			a_type_not_void: a_type /= Void
		local
			l_cas: detachable NATIVE_ARRAY [detachable SYSTEM_OBJECT]
			j, l_count: INTEGER
			retried: BOOLEAN
			l_class_type: detachable RT_CLASS_TYPE
			l_gen_type: RT_GENERIC_TYPE
			l_rt_array: NATIVE_ARRAY [detachable RT_TYPE]
			l_any_type, l_interface_type: detachable SYSTEM_TYPE
			l_formal_type: RT_FORMAL_TYPE
			l_list: ARRAYED_LIST [RT_CLASS_TYPE]
			l_provider: ICUSTOM_ATTRIBUTE_PROVIDER
			l_attribute_type_name: STRING_32
			l_attr_name: detachable SYSTEM_STRING
			l_eiffel_type_info: SYSTEM_TYPE
		do
			if not retried then
				l_provider := a_type
					-- To avoid exceptions, we do not load types that have a & in them.
				if attached a_type.name as l_type_name and then not l_type_name.ends_with (invalid_type_name_ending) then
					l_cas := l_provider.get_custom_attributes ({EIFFEL_NAME_ATTRIBUTE}, False)
				end
				l_eiffel_type_info := {EIFFEL_TYPE_INFO}
				if
					l_cas /= Void and then l_cas.count > 0 and then
					attached {EIFFEL_NAME_ATTRIBUTE} l_cas.item (0) as l_name_attr
				then
					if l_name_attr.is_generic and attached l_name_attr.generics as l_array then
						l_count := l_array.count
						create l_rt_array.make (l_count)
						from
							l_any_type := {ANY}
							j := 0
						until
							j = l_count
						loop
							check attached l_array.item (j) as l_param_type then
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
							end
							j := j + 1
						end
						if l_count = 0 then
								-- It should be a TUPLE type.
							check
								tuple_name: l_name_attr.name ~ ("TUPLE").to_cil
							end
							create {RT_TUPLE_TYPE} l_gen_type.make
						else
							create l_gen_type.make
						end
						l_interface_type := interface_type (a_type)
						l_gen_type.set_type (l_interface_type.type_handle)
						l_gen_type.set_generics (l_rt_array)
						l_class_type := l_gen_type
					else
						create l_class_type.make
						l_interface_type := interface_type (a_type)
						l_class_type.set_type (l_interface_type.type_handle)
					end
					l_attr_name := l_name_attr.name
				else
						-- Only add .NET types to the pictures.
					if not l_eiffel_type_info.is_assignable_from (a_type) then
						create l_class_type.make
						l_interface_type := interface_type (a_type)
						l_class_type.set_type (l_interface_type.type_handle)
						l_attr_name := a_type.full_name;
					end
				end

				if l_interface_type /= Void and l_class_type /= Void then
						-- Update `interface_to_implementation'
					interface_to_implementation.add (l_interface_type, a_type)
						-- Update `eiffel_meta_type_mapping' if we can get the name
					if l_attr_name /= Void then
						create l_attribute_type_name.make_from_cil (l_attr_name)
						eiffel_meta_type_mapping.search (mapped_type (l_attribute_type_name))
						if eiffel_meta_type_mapping.found and then attached {ARRAYED_LIST [RT_CLASS_TYPE]} eiffel_meta_type_mapping.found_item as l_found_item then
							l_found_item.extend (l_class_type)
						else
							create l_list.make (1)
							l_list.extend (l_class_type)
							eiffel_meta_type_mapping.force (l_list, l_attribute_type_name)
						end
					end
				end
			end
		rescue
				-- It could fail in for many reasons if the TYPE is invalid, but we still want to continue
				-- processing of other types, so we silently ignore the problem'
			retried := True
			retry
		end

	associated_runtime_type (a_type: SYSTEM_TYPE): RT_CLASS_TYPE
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

	eiffel_type_to_id: HASHTABLE
			-- Mapping between live Eiffel types and their dynamic type id.
			-- Key: RT_CLASS_TYPE
			-- Value: dynamic type
		once
			create Result.make (internal_chunk_size)
		ensure
			eiffel_type_to_id_not_void: Result /= Void
		end

	eiffel_meta_type_mapping: STRING_TABLE [ARRAYED_LIST [RT_CLASS_TYPE]]
			-- Mapping between Eiffel class names and .NET pseudo-types.
			-- It only contains the pseudo derivation, that is to say for
			-- a generic class A [G], where the following generic derivation
			-- exists in the system A [INTEGER_16], A [STRING], A [ANY], it only
			-- contains A [INTEGER_16] and A [REFERENCE_TYPE].
		local
			l_basic_type: RT_BASIC_TYPE
			l_list: ARRAYED_LIST [RT_CLASS_TYPE]
		once
			create Result.make (internal_chunk_size)
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
			l_basic_type.set_type (({CHARACTER_32}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "CHARACTER_32")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({REAL_32}).to_cil.type_handle)
			l_list.extend (l_basic_type)
			Result.put (l_list, "REAL_32")

			create l_list.make (1)
			create l_basic_type.make
			l_basic_type.set_type (({REAL_64}).to_cil.type_handle)
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

	interface_to_implementation: HASHTABLE
			-- Mapping from interface to associated implementation.
		once
			create Result.make (internal_chunk_size)
		ensure
			interface_to_implementation_not_void: Result /= Void
		end

	implementation_to_interface: HASHTABLE
			-- Mapping from implementation to associated interface.
		once
			create Result.make (internal_chunk_size)
		ensure
			implementation_to_interface_not_void: Result /= Void
		end

	abstract_types: HASHTABLE
			-- List of all known basic types.
			-- Key: type
			-- Value: ID
		once
			create Result.make_from_capacity (10)
			Result.set_item (({POINTER}).to_cil, Pointer_type)
			Result.set_item (({CHARACTER_8}).to_cil, character_8_type)
			Result.set_item (({BOOLEAN}).to_cil, Boolean_type)
			Result.set_item (({REAL_32}).to_cil, real_32_type)
			Result.set_item (({REAL_64}).to_cil, real_64_type)
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

	get_members (type_id: INTEGER): ARRAYED_LIST [FIELD_INFO]
			-- Retrieve all members of type `type_id'.
			-- We need permission to retrieve non-public members.
			-- Only fields are returned.
		require
			type_id_non_negative: type_id >= 0
		local
			allm: detachable NATIVE_ARRAY [detachable MEMBER_INFO]
			i, j, nb: INTEGER
			l_cv_f_name: detachable SYSTEM_STRING
			l_type: detachable SYSTEM_TYPE
		do
			if attached id_to_fields.item (type_id) as l_result then
				Result := l_result
			else
				if is_tuple_type (type_id) or is_special_type (type_id) then
						-- To match classic behavior, SPECIAL and TUPLE are seen as if they
						-- had no attributes.
					create Result.make (0)
				else
					if attached id_to_eiffel_type.item (type_id) as l_rt_class_type then
						l_type := l_rt_class_type.dotnet_type
						if l_type /= Void then
							l_type := implementation_type (l_type)
							allm := l_type.get_members_binding_flags ({BINDING_FLAGS}.instance |
								{BINDING_FLAGS}.public | {BINDING_FLAGS}.non_public)
							if allm /= Void then
									-- Let count the number of attributes to minimize the memory footprint.
									-- We include the `private_type_field_name'.
								from
									nb := 0
									j := allm.count
									create Result.make (nb)
								until
									i = j
								loop
									if attached {FIELD_INFO} allm.item (i) as l_field_info then
										nb := nb + 1
									end
									i := i + 1
								end
									-- Fill `Result' with attributes.
								from
									create Result.make (nb)
									i := 0
									j := allm.count
								until
									i = j
								loop
									if attached {FIELD_INFO} allm.item (i) as l_field_info then
										l_cv_f_name := l_field_info.name
										if l_cv_f_name /= Void and then not l_cv_f_name.is_equal (private_type_field_name) then
											Result.extend (l_field_info)
										end
									end
									i := i + 1
								end
							else
								create Result.make (0)
							end
						else
							create Result.make (0)
						end
					else
						create Result.make (0)
					end
				end
				id_to_fields.put (Result, type_id)
			end
		end

	resize_arrays (max_type_id: INTEGER)
			-- Resize all arrays indexed by type_id so that they can accommodate
			-- `max_type_id'.
		local
			l_new_count: INTEGER
		do
			l_new_count := array_upper_cell.item
			if max_type_id > l_new_count then
				l_new_count := (max_type_id).max (l_new_count * 2)
				array_upper_cell.put (l_new_count)
				id_to_eiffel_type.conservative_resize_with_default (Void, 0, l_new_count)
				id_to_eiffel_implementation_type.conservative_resize_with_default (Void, 0, l_new_count)
				id_to_storable_version.conservative_resize_with_default (Void, 0, l_new_count)
				id_to_fields.conservative_resize_with_default (Void, 0, l_new_count)
				id_to_fields_static_type.conservative_resize_with_default (Void, 0, l_new_count)
				id_to_fields_abstract_type.conservative_resize_with_default (Void, 0, l_new_count)
				id_to_fields_name.conservative_resize_with_default (Void, 0, l_new_count)
				id_to_fields_transient.conservative_resize_with_default (Void, 0, l_new_count)
				persistent_field_counts.conservative_resize_with_default (-1, 0, l_new_count)
			end
		end

	id_to_eiffel_type: ARRAY [detachable RT_CLASS_TYPE]
			-- Mapping between dynamic type id and Eiffel types.
		once
			create Result.make_filled (Void, min_predefined_type, array_upper_cell.item)
		ensure
			id_to_eiffel_type_not_void: Result /= Void
			instance_free: class
		end

	id_to_eiffel_implementation_type: ARRAY [detachable RT_CLASS_TYPE]
			-- Mapping between dynamic type id and Eiffel implementation types.
		once
			create Result.make_filled (Void, min_predefined_type, array_upper_cell.item)
		ensure
			id_to_eiffel_type_not_void: Result /= Void
		end

	id_to_storable_version: ARRAY [detachable IMMUTABLE_STRING_8]
			-- Buffer for `storable_version_of_type' lookups index by type_id.
		once
			create Result.make_filled (Void, min_predefined_type, array_upper_cell.item)
		ensure
			id_to_storable_version_not_void: Result /= Void
		end

	id_to_fields: ARRAY [detachable ARRAYED_LIST [FIELD_INFO]]
			-- Buffer for `get_members' lookups index by type_id.
		once
			create Result.make_filled (Void, min_predefined_type, array_upper_cell.item)
		ensure
			id_to_fields_not_void: Result /= Void
		end

	id_to_fields_abstract_type: ARRAY [detachable NATIVE_ARRAY [INTEGER]]
			-- Buffer for `field_type_of_type' lookups index by type_id.
		once
			create Result.make_filled (Void, min_predefined_type, array_upper_cell.item)
		ensure
			id_to_fields_abstract_type_not_void: Result /= Void
		end

	id_to_fields_static_type: ARRAY [detachable NATIVE_ARRAY [INTEGER]]
			-- Buffer for `field_static_type_of_type' lookups index by type_id.
		once
			create Result.make_filled (Void, min_predefined_type, array_upper_cell.item)
		ensure
			id_to_fields_static_type_not_void: Result /= Void
		end

	id_to_fields_name: ARRAY [detachable ARRAYED_LIST [STRING]]
			-- Buffer for `field_name_of_type' lookups index by type_id.
		once
			create Result.make_filled (Void, min_predefined_type, array_upper_cell.item)
		ensure
			id_to_fields_name_not_void: Result /= Void
		end

	id_to_fields_transient: ARRAY [detachable ARRAYED_LIST [BOOLEAN]]
			-- Buffer for `is_field_transient_of_type' lookups index by type_id.
		once
			create Result.make_filled (Void, min_predefined_type, array_upper_cell.item)
		ensure
			id_to_fields_name_not_void: Result /= Void
		end

	persistent_field_counts: ARRAY [INTEGER]
			-- Buffer for persistent count
		once
			create Result.make_filled (-1, min_predefined_type, array_upper_cell.item)
		ensure
			persistent_field_counts_not_void: Result /= Void
		end

	marked_objects: HASHTABLE
			-- Contains all objects marked.
		once
			create Result.make (internal_chunk_size, create {RT_REFERENCE_COMPARER}.make)
		end

	internal_chunk_size: INTEGER = 50;
			-- Default initial size for tables.

	array_upper_cell: CELL [INTEGER]
			-- Store upper index for all arrays indexed by type id.
		once
			create Result.put (internal_chunk_size)
		ensure
			array_upper_cell: Result /= Void
			instance_free: class
		end

	internal_empty_string: IMMUTABLE_STRING_8
			-- Constant to represent an empty string
		once
			create Result.make (0)
		ensure
			internal_empty_string_not_void: Result /= Void
			internal_empty_string_empty: Result.is_empty
		end

	tuple_native_array_field_info: detachable FIELD_INFO
			-- Info about `native_array' of TUPLE.
		local
			allm: detachable NATIVE_ARRAY [detachable MEMBER_INFO]
			i, nb: INTEGER
			l_cv_f_name: detachable SYSTEM_STRING
			l_type: detachable SYSTEM_TYPE
		once
			if attached id_to_eiffel_type.item (dynamic_type (create {TUPLE})) as l_rt_type then
				l_type := l_rt_type.dotnet_type
				if l_type /= Void then
					l_type := implementation_type (l_type)
					allm := l_type.get_members_binding_flags ({BINDING_FLAGS}.instance |
						{BINDING_FLAGS}.public | {BINDING_FLAGS}.non_public)
					if allm /= Void then
						from
							nb := allm.count
						until
							i = nb
						loop
							if attached {FIELD_INFO} allm.item (i) as r then
								Result := r
								l_cv_f_name := Result.name
								if l_cv_f_name /= Void and then not l_cv_f_name.is_equal (private_type_field_name) then
									i := nb - 1 -- Jump out of loop
								end
							end
							i := i + 1
						end
					end
				end
			end
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
