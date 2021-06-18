note
	description: "[
		Access to internal object properties.
		This class may be used as ancestor by classes needing its facilities.
	]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	REFLECTOR

inherit
	REFLECTOR_HELPER

	REFLECTOR_CONSTANTS

feature -- Conformance

	type_conforms_to (type1, type2: INTEGER): BOOLEAN
			-- Does `type1' conform to `type2'?
		require
			type1_nonnegative: type1 >= 0
			type2_nonnegative: type2 >= 0
		do
			Result := helper.type_conforms_to (type1, type2)
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
			Result := helper.field_conforms_to (a_source_type, a_field_type)
		ensure
			instance_free: class
		end

feature -- Creation

	dynamic_type_from_string (class_type: READABLE_STRING_GENERAL): INTEGER
			-- Dynamic type corresponding to `class_type'.
			-- If no dynamic type available, returns -1.
		require
			class_type_not_void: class_type /= Void
			class_type_not_empty: not class_type.is_empty
			is_valid_type_string: is_valid_type_string (class_type)
		do
			Result := helper.dynamic_type_from_string (class_type)
		ensure
			dynamic_type_from_string_valid: Result = -1 or Result = none_type or Result >= 0
		end

	new_instance_of (type_id: INTEGER): ANY
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
			-- `type_id' cannot represent a SPECIAL type, use
			-- `new_special_any_instance' instead.
		require
			type_id_nonnegative: type_id >= 0
			not_special_type: not is_special_type (type_id)
		do
			Result := helper.new_instance_of (type_id)
		ensure
			not_special_type: not attached {SPECIAL [detachable ANY]} Result
			dynamic_type_set: Result.generating_type.type_id = type_id
		end

	new_special_any_instance (type_id, count: INTEGER): SPECIAL [detachable ANY]
			-- New instance of dynamic `type_id' that represents
			-- a SPECIAL with `count' element. To create a SPECIAL of
			-- basic type, use `SPECIAL'.
		require
			count_valid: count >= 0
			type_id_nonnegative: type_id >= 0
			special_type: is_special_any_type (type_id)
		do
			Result := helper.new_special_any_instance (type_id, count)
		ensure
			dynamic_type_set: Result.generating_type.type_id = type_id
			count_set: Result.count = 0
			capacity_set: Result.capacity = count
		end

	new_tuple_from_special (type_id: INTEGER; values: SPECIAL [detachable separate ANY]): detachable TUPLE
			-- New instance of a tuple of type `type_id' filled with `values' if all types of items are suitable.
			-- `Void' if some items from `values' are inappropriate for a tuple of type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
			is_tuple_type: is_tuple_type (type_id)
			-- sufficient_values_count: values.count >= tuple_type_count (type_id)
			-- valid_value_types: across 1 |..| tuple_type_count (type_id) as i all valid_object_for_tuple_index (values [i - 1], i)
		local
			i: INTEGER
			v: detachable separate ANY
		do
			if attached {TUPLE} new_instance_of (type_id) as l_tuple then
				i := l_tuple.count
				if i <= values.count then
					from
						Result := l_tuple
					until
						i <= 0 or else not attached Result
					loop
						v := values [i - 1]
						if Result.valid_type_for_index (v, i) then
								-- Value `v' is compatible with tuple item at index `i'.
							Result [i] := v
						else
								-- Value `v' is not compatible with tuple item at index `i'.
							Result := Void
						end
						i := i - 1
					end
				end
			end
		ensure
			dynamic_type_set: attached Result implies Result.generating_type.type_id = type_id
			values_set: attached Result implies ∀ k: 1 |..| Result.count ¦ Result.item (k) = values [k - 1]
		end

	new_tuple_from_tuple (type_id: INTEGER; source: separate TUPLE): detachable TUPLE
			-- New instance of a tuple of type `type_id' filled with values fom `source' if all value types are suitable.
			-- `Void' if some values from `source' are inappropriate for a tuple of type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
			is_tuple_type: is_tuple_type (type_id)
			-- sufficient_values_count: source.count >= tuple_type_count (type_id)
			-- valid_value_types: across 1 |..| tuple_type_count (type_id) as i all valid_object_for_tuple_index (values [i - 1], i)
		local
			i: INTEGER
			v: detachable separate ANY
		do
			if attached {TUPLE} new_instance_of (type_id) as l_tuple then
				i := l_tuple.count
				if i <= source.count then
					Result := l_tuple
					if source.object_comparison then
						Result.compare_objects
					end
					from
					until
						i <= 0 or else not attached Result
					loop
						v := source [i]
						if Result.valid_type_for_index (v, i) then
								-- Value `v' is compatible with tuple item at index `i'.
							Result [i] := v
						else
								-- Value `v' is not compatible with tuple item at index `i'.
							Result := Void
						end
						i := i - 1
					end
				else
						-- Insufficient number of values.
					Result := Void
				end
			end
		ensure
			dynamic_type_set: attached Result implies Result.generating_type.type_id = type_id
			object_comparison_set: attached Result implies Result.object_comparison = source.object_comparison
			values_set: attached Result implies ∀ k: 1 |..| Result.count ¦ Result.item (k) = source [k]
		end

	type_of_type (type_id: INTEGER): TYPE [detachable ANY]
			-- Associated TYPE instance for an object of type id `type_id'
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.type_of_type (type_id)
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_special_any_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.is_special_any_type (type_id)
		end

	is_special_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type
			-- or a basic type.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.is_special_type (type_id)
		ensure
			instance_free: class
		end

	is_tuple_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent a TUPLE?
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.is_tuple_type (type_id)
		end

	is_attached_type (a_type_id: INTEGER): BOOLEAN
			-- Is `a_type_id' an attached type?
		require
			a_type_non_negative: a_type_id >= 0
		do
			Result := helper.is_attached_type (a_type_id)
		ensure
			instance_free: class
		end

	is_field_transient_of_type (i: INTEGER; a_type_id: INTEGER): BOOLEAN
			-- Is `i'-th field of `object' a transient attribute?
			-- I.e. an attribute that does not need to be stored?
		require
			a_type_non_negative: a_type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (a_type_id)
		do
			Result := helper.is_field_transient_of_type (i, a_type_id)
		ensure
			instance_free: class
		end

	is_field_expanded_of_type (i: INTEGER; a_type_id: INTEGER): BOOLEAN
			-- Is `i'-th field of type `a_type_id' a user-defined expanded attribute?
		require
			a_type_non_negative: a_type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (a_type_id)
		do
			Result := helper.is_field_expanded_of_type (i, a_type_id)
		ensure
			instance_free: class
		end

feature -- Access

	class_name_of_type (type_id: INTEGER): STRING
			-- Name of class associated with dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.class_name_of_type (type_id)
		ensure
			instance_free: class
		end

	type_name_of_type (type_id: INTEGER): STRING
			-- Name of `type_id''s generating type (type of which `type_id'
			-- is a direct instance).
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.type_name_of_type (type_id)
		end

	type_name_8_of_type (type_id: INTEGER): STRING_8
			-- Name of `type_id''s generating type (type of which `type_id'
			-- is a direct instance).
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.type_name_8_of_type (type_id)
		end

	attached_type (type_id: INTEGER): INTEGER
			-- Attached version of `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.attached_type (type_id)
		ensure
			unchanged_if_attached: is_attached_type (type_id) implies type_id = Result
		end

	detachable_type (type_id: INTEGER): INTEGER
			-- Detachable version of `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.detachable_type (type_id)
		ensure
			unchanged_if_detachable: not is_attached_type (type_id) implies type_id = Result
		end

	generic_count_of_type (type_id: INTEGER): INTEGER
			-- Number of generic parameter in `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.generic_count_of_type (type_id)
		end

	generic_dynamic_type_of_type (type_id: INTEGER; i: INTEGER): INTEGER
			-- Dynamic type of generic parameter of `type_id' at position `i'.
		require
			type_id_nonnegative: type_id >= 0
			type_id_generic: generic_count_of_type (type_id) > 0
			i_valid: i > 0 and i <= generic_count_of_type (type_id)
		do
			Result := helper.generic_dynamic_type_of_type (type_id, i)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	storable_version_of_type (a_type_id: INTEGER): detachable IMMUTABLE_STRING_8
			-- Storable version if any specified.
		require
			a_type_id_nonnegative: a_type_id >= 0
		do
			Result := helper.storable_version_of_type (a_type_id)
		end

	field_name_of_type (i: INTEGER; type_id: INTEGER): STRING
			-- Name of `i'-th field of dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (type_id)
		do
			Result := helper.field_name_of_type (i, type_id)
		ensure
			instance_free: class
		end

	field_name_8_of_type (i: INTEGER; type_id: INTEGER): STRING_8
			-- Name of `i'-th field of dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (type_id)
		do
			Result := helper.field_name_8_of_type (i, type_id)
		ensure
			instance_free: class
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER
			-- Abstract type of `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		do
			Result := helper.field_type_of_type (i, type_id)
		ensure
			field_type_nonnegative: Result >= 0
			instance_free: class
		end

	field_static_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER
			-- Static type of declared `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		do
			Result := helper.field_static_type_of_type (i, type_id)
		ensure
			field_type_nonnegative: Result >= 0
			instance_free: class
		end

feature -- Version

	compiler_version: INTEGER
		do
			Result := 0
		end

feature -- Measurement

	field_count_of_type (type_id: INTEGER): INTEGER
			-- Number of logical fields in dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := helper.field_count_of_type (type_id)
		ensure
			instance_free: class
		end

	persistent_field_count_of_type (a_type_id: INTEGER): INTEGER
			-- Number of logical fields in dynamic type `type_id' that are not transient.
		require
			a_type_non_negative: a_type_id >= 0
		do
			Result := helper.persistent_field_count_of_type (a_type_id)
		ensure
			instance_free: class
		end

feature {NONE} -- Implementation

	helper: DOTNET_REFLECTOR
			-- Helper that tell us all about types in a .NET system.
		once
			create Result
		ensure
			instance_free: class
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
