note
	description: "Collects useful information about a specific runtime type"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TYPE_METADATA

inherit

	HASHABLE
		undefine
			is_equal
		end

	ANY
		redefine
			is_equal
		end

	REFACTORING_HELPER
		export
			{NONE} all
		undefine
			is_equal
		end


create {PS_METADATA_FACTORY}
	make

feature -- Access

	type: TYPE [detachable ANY]
			-- The actual dynamic type.

	name: IMMUTABLE_STRING_8
			-- The type name.
		do
			Result := type.name
		end

feature -- Status report

	is_none: BOOLEAN
			-- Is `Current' the special `NONE' type?


	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result:= hash_code = other.hash_code
		end

	is_basic_type: BOOLEAN
			-- Is `Current' of an ABEL basic type (STRING or expanded types)?
		do
			Result := type.is_expanded
				--or reflection.type_conforms_to (type.type_id, reflection.dynamic_type_from_string ("READABLE_STRING_GENERAL"))
				or type.type_id = ({detachable STRING_8}).type_id or type.type_id = ({detachable STRING_32}).type_id
				-- The attached syntax is used here because the {TYPE}.is_conforming_to will always generate a catcall.
				or attached {TYPE [detachable IMMUTABLE_STRING_GENERAL]} type
				--or type.is_conforming_to ({detachable IMMUTABLE_STRING_GENERAL})
		end

	is_generic_derivation: BOOLEAN
			-- Does `Current' type have one or more generic parameters?
		do
			Result := generic_parameter_count > 0
		end

	is_subtype_of (other: PS_TYPE_METADATA): BOOLEAN
			-- Does `Current' conform to `other'?
		do
			Result := conforms (type, other.type)
		end

	is_supertype_of (other: PS_TYPE_METADATA): BOOLEAN
			-- Does `other' conform to `Current'?
		do
			Result := conforms (other.type, type)
		end

	has_attribute (a_name: STRING): BOOLEAN
			-- Does `Current' have an attribute with name `name'?
		do
			Result := attributes.has (a_name)
		end

feature -- Genericity

	generic_parameter_count: INTEGER
			-- The number of generic parameters of `Current'.
		do
			if is_none then
				Result := 0
			else
				Result := reflection.generic_count_of_type (type.type_id)
			end
		ensure
			non_negative: Result >= 0
			positive_if_generic: is_generic_derivation implies Result > 0
		end

	actual_generic_parameter (index: INTEGER): PS_TYPE_METADATA
			-- The type metadata of the generic parameter at position `index'.
		require
			is_generic: is_generic_derivation
			valid_index: index <= generic_parameter_count and index > 0
		do
			Result := factory.create_metadata_from_type (reflection.type_of_type (reflection.detachable_type (reflection.generic_dynamic_type_of_type (type.type_id, index))))
		end

feature -- Conformance

	supertypes: LIST [PS_TYPE_METADATA]
			-- All types that `Current' conforms to.
		do
			create {LINKED_LIST [PS_TYPE_METADATA]} Result.make
			across
				supertypes_internal_wrapper (type) as type_cursor
			loop
				Result.extend (factory.create_metadata_from_type (type_cursor.item))
			end
		ensure
			across Result as cursor all Current.is_subtype_of (cursor.item) end
		end

	subtypes: LIST [PS_TYPE_METADATA]
			-- All types that conform to `Current'.
		do
			create {LINKED_LIST [PS_TYPE_METADATA]} Result.make
			across
				subtypes_internal_wrapper (type) as type_cursor
			loop
				Result.extend (factory.create_metadata_from_type (type_cursor.item))
			end
		ensure
			across Result as cursor all cursor.item.is_subtype_of (Current) end
		end

feature -- Attributes

	attribute_count: INTEGER
			-- The number of attributes in `Current'.
--		do
--			Result := attributes.count
--		ensure
--			correct: Result = reflection.field_count_of_type (type.type_id)
--		end

	attributes: ARRAYED_LIST [STRING]
			-- Names of all attributes in `Current' type.

	basic_attributes: LIST [STRING]
			-- Names of all attributes of a basic type.
		do
			create {LINKED_LIST [STRING]} Result.make
			across
				attributes as attr_cursor
			loop
				if attribute_type (attr_cursor.item).is_basic_type then
					Result.extend (attr_cursor.item)
				end
			end
		ensure
			exists: Result.for_all (agent has_attribute (?))
			only_basic: across Result as cursor all attribute_type (cursor.item).is_basic_type end
			complete: across attributes as cursor all attribute_type (cursor.item).is_basic_type implies Result.has (cursor.item) end
		end

	reference_attributes: LIST [STRING]
			-- Name of all attributes of a reference type.
		do
			create {LINKED_LIST [STRING]} Result.make
			across
				attributes as attr_cursor
			loop
				if not attribute_type (attr_cursor.item).is_basic_type then
					Result.extend (attr_cursor.item)
				end
			end
		ensure
			exists: Result.for_all (agent has_attribute (?))
			only_reference: across Result as cursor all not attribute_type (cursor.item).is_basic_type end
			complete: across attributes as cursor all not attribute_type (cursor.item).is_basic_type implies Result.has (cursor.item) end
		end

	field_index (attribute_name: STRING): INTEGER
			-- The field index of `attribute_name', to be used for INTERNAL.
		require
			attribute_present: has_attribute (attribute_name)
		do
			Result := attr_name_to_index_hash [attribute_name]
		ensure
			correct: reflection.field_name_of_type (Result, type.type_id).is_equal (attribute_name)
			within_bounds: 0 < Result and Result <= attribute_count
		end

	attribute_type (attribute_name: STRING): PS_TYPE_METADATA
			-- Metadata of the detachable type of attribute `attribute_name'.
		require
			has_attribute: attributes.has (attribute_name)
		do
			check attached attr_name_to_type_hash [attribute_name] as res then
				Result := res
			end
		end

	hash_code: INTEGER
			-- Hash code value.

	builtin_type: ARRAYED_LIST [INTEGER]
			-- The builtin types of the attributes.

feature -- Utilities

	reflection: INTERNAL
			-- An instance of INTERNAL.

feature {PS_METADATA_FACTORY} -- Initialization

	make (a_type: TYPE [detachable ANY]; a_manager: PS_METADATA_FACTORY)
			-- Initialize `Current'.
--		local
--			count: INTEGER
		do
			type := a_type
			factory := a_manager
			hash_code := type.hash_code
			create reflection

			if a_type.type_id = ({NONE}).type_id or a_type.type_id = ({detachable NONE}).type_id then
				is_none := True
				attribute_count := 0
			else
				is_none := False
				attribute_count := reflection.field_count_of_type (type.type_id)
			end

			create attr_name_to_type_hash.make (attribute_count)
			create attr_name_to_index_hash.make (attribute_count)
			create {ARRAYED_LIST [STRING]} attributes.make (attribute_count)
			create builtin_type.make (attribute_count)
			attributes.compare_objects
		end

	initialize
			-- Initialie all attributes.
		local
			i: INTEGER
			attr_type: TYPE [detachable ANY]
			attr_type_metadata: PS_TYPE_METADATA
			attr_name: STRING
		do
				-- Initialize the attributes
			from
				i := 1
			until
				i > attribute_count
			loop
				attr_name := reflection.field_name_of_type (i, type.type_id)
					-- Get the attribute type.
					-- Note that it's required to always use the detachable type.
				attr_type := reflection.type_of_type (reflection.detachable_type (reflection.field_static_type_of_type (i, type.type_id)))
				attr_type_metadata := factory.create_metadata_from_type (attr_type)
					-- Insert the values to the data structures
				attr_name_to_index_hash.extend (i, attr_name)
				attr_name_to_type_hash.extend (attr_type_metadata, attr_name)
				attributes.extend (attr_name)

				builtin_type.extend (reflection.field_type_of_type (i, type.type_id))
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	factory: PS_METADATA_FACTORY
			-- The factory that created `Current'.

	attr_name_to_type_hash: HASH_TABLE [PS_TYPE_METADATA, STRING]
			-- A hash table to map attribute names to types.

	attr_name_to_index_hash: HASH_TABLE [INTEGER, STRING]
			-- A hash table to map attribute names to their index, as used by INTERNAL.

	subtypes_internal_wrapper (a_type: TYPE [detachable ANY]): LIST [TYPE [detachable ANY]]
			-- A wrapper for a not-yet-implemented INTERNAL feature.
		do
			to_implement ("As soon as INTERNAL has the appropriate features, implement this function")
			check
				not_implemented: False
			end
			create {LINKED_LIST [TYPE [detachable ANY]]} Result.make
		ensure
			definition: Result.for_all (agent conforms (?, a_type))
		end

	supertypes_internal_wrapper (a_type: TYPE [detachable ANY]): LIST [TYPE [detachable ANY]]
			-- A wrapper for a not-yet-implemented INTERNAL feature.
		do
			to_implement ("As soon as INTERNAL has the appropriate features, implement this function")
			check
				not_implemented: False
			end
			create {LINKED_LIST [TYPE [detachable ANY]]} Result.make
		ensure
			definition: Result.for_all (agent conforms (a_type, ?))
		end

	conforms (subtype, supertype: TYPE [detachable ANY]): BOOLEAN
			-- A small helper utility to check conformance between two types.
		do
			Result := reflection.type_conforms_to (subtype.type_id, supertype.type_id)
		end

invariant
	non_negative_generic_count: generic_parameter_count >= 0
	correct_genericity: (generic_parameter_count = 0) = not is_generic_derivation
	attributes_splitted_correctly: basic_attributes.count + reference_attributes.count = attributes.count

	hash_correct: hash_code = type.type_id
end
