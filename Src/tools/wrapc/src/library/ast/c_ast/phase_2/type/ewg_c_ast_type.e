note

	description:

		"C AST Phase 2 Element, representing an arbitrary type. %
		%Note that this is a deferred base class for the various %
		%more specific concrete c type classes. Also note that %
		%here C type is a bit more generalized than usual. For %
		%example a function has also a type. Indirections such %
		%as 'int*' are represented by an pointer type whos base %
		%is the primitive type 'int'"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class EWG_C_AST_TYPE

inherit

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	HASHABLE

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

feature {NONE}

	make (a_name: detachable STRING; a_header_file_name: STRING)
			-- Make a new c type with the name `a_name',
			-- that was found in header `a_header_file_name'.
			-- Name may be `Void' in which case the type is
			-- anonymoys. `a_header_file_name' may not be `Void'.
			-- TODO: Make seperate create routine `make_anonymous'
			-- TODO: Some types (primitive types e.g.) have no
			-- header they were defined in, what to do with them?
		require
			a_header_file_name_not_void: a_header_file_name /= Void
			a_name_not_void_implies_name_not_empty: a_name /= Void implies a_name.count > 0
		do
			name := a_name
			header_file_name := a_header_file_name
		end

feature {ANY} -- Basic Queries

	name: detachable STRING
			-- Name of this type;
			-- may be Void, in case type is anonymous

	header_file_name: STRING
			-- Name of header file this type has been found

	closest_alias_type: detachable EWG_C_AST_ALIAS_TYPE
			-- After a certain stage, this attribute contains a
			-- reference to the closest alias for `Current'.
			-- Close means low ammount of indirections.
			-- It can be `Void' if there are no aliases for `Current'
			-- at all.
			-- The number one use for this attribute is for example if
			-- `Current' is some anonymous struct type, and
			-- `closest_alias_type' is a simple
			-- typedef for the struct type. Without the
			-- `closest_alias_type' it would be imossible to
			-- determine the size of the struct for example.

	closest_alias_type_quality: INTEGER
			-- The number of pointer or array indirections between
			-- `closest_alias_type' and `Current'. It is "perfect"
			-- quality when `closest_alias_type_quality' is `0'.
			-- Needless to say, that `closest_alias_type_quality'
			-- only makes sense if `closest_alias_type /= Void'.

feature {ANY} -- Basic Commands

	set_name (a_name: STRING)
			-- Make `a_name' the new `name' of `Current'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
			non_anonymous: not is_anonymous
		end

	set_anonymous
			-- Make type anonymous.
		do
			name := Void
		ensure
			anonymous: is_anonymous
		end

	set_header_file_name (a_header_file_name: STRING)
			-- Set 'header_file_name' to be `a_header_file_name'.
		require
			a_header_file_name_not_void: a_header_file_name /= Void
		do
			header_file_name := a_header_file_name
		end


	set_closest_alias_type (a_closest_alias_type: EWG_C_AST_ALIAS_TYPE)
		require
			a_closest_alias_type_better: closest_alias_type = Void or else
				 closest_alias_type_quality > a_closest_alias_type.number_of_pointer_or_arrays_between_current_and_type (Current)
			a_closest_alias_has_current_as_base: closest_alias_type /= Void
																implies a_closest_alias_type.has_type_as_base_indirect (Current)
		do
			closest_alias_type := a_closest_alias_type
			closest_alias_type_quality := a_closest_alias_type.number_of_pointer_or_arrays_between_current_and_type (Current)
		ensure
			closest_alias_type_set: closest_alias_type = a_closest_alias_type
		end

feature {ANY} -- Declaration Queries


	skip_wrapper_irrelevant_types: EWG_C_AST_TYPE
			-- Skip types that are not relevant for wrapping such as
			-- "consts" "aliases", but sometimes also "arrays" and
			-- "pointers"
		do
			Result := skip_consts_and_aliases
			if not Result.is_callback then
				Result := Result.based_type_recursive
			end
		end

	can_be_wrapped: BOOLEAN
			-- Can `Current' type be wrapped by EWG?  Note that primitive
			-- types (such as 'int') cannot be wrapped, but they can be
			-- mapped nativly onto Eiffel types anyway.
		do
			Result := ((is_enum_type or is_struct_type or is_union_type) and
						  (not is_anonymous or (has_closest_alias_type and then
														closest_alias_type_quality <= 1))) or
				is_callback
		end

	has_built_in_wrapper: BOOLEAN
			-- Does `Current' have a built in wrapper?
			-- This is for example the case for the type 'int' which
			-- maps nativly to INTEGER.
		do
			-- TODO: what about arrays ?
			Result := not based_type_recursive.is_composite_data_type
		end

	has_closest_alias_type: BOOLEAN
			-- Does `Current' have a closest alias type?
		do
			Result := closest_alias_type /= Void
		ensure
			definition: Result = (closest_alias_type /= Void)
		end

	has_perfect_alias_type: BOOLEAN
			-- Is `closest_alias_type' not `Void' and then
			-- is also an alias with no pointer
			-- or array indirections ?
		do
			Result := closest_alias_type /= Void and then
								closest_alias_type_quality = 0
		ensure
			valid: Result implies ( attached closest_alias_type as l_closest_alias_type and then
								  l_closest_alias_type.has_type_as_base_with_no_pointer_or_array_types_inbetween_indirect (Current))
		end

	is_anonymous: BOOLEAN
			-- Is this an anonymous type?
			-- It is anonymous if it does not have a name.
			-- Otherwise it is considered to be "named".
			-- For example the type 'int' is considered to be named.
			-- The type "int*" not. Of course there can be a (named)
			-- alias of the form "typedef int* pointer_to_int".
			-- Note that even in this case only "pointer_to_int" is considered named
			-- "int*" will always be anonymous.
		do
			Result := name = Void
		end

	is_named_recursive: BOOLEAN
			-- Is this type named, or any of it's base types ?
		do
			if not is_anonymous then
				Result := True
			end
		end

feature

	skip_consts_and_aliases: EWG_C_AST_TYPE
			-- If `Current' is of type EWG_C_AST_CONST_TYPE or EWG_C_AST_ALIAS_TYPE,
			-- return the first non alias and non const base, otherwise `Current'
			-- TODO: rename to `skip_const_and_alias_types'
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
		end

	skip_aliases: EWG_C_AST_TYPE
			-- If `Current' is of type EWG_C_AST_ALIAS_TYPE,
			-- return the first non alias base, otherwise `Current'
			-- TODO: rename to `skip_alias_types'
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
		end

	skip_consts: EWG_C_AST_TYPE
			-- If `Current' is of type EWG_C_AST_CONST_TYPE,
			-- return the first non const base, otherwise `Current'
			-- TODO: rename to `skip_const_types'
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
		end


	skip_consts_and_pointers: EWG_C_AST_TYPE
			-- If `Current' is of type EWG_C_AST_CONST_TYPE or EWG_C_AST_POINTER_TYPE,
			-- return the first non const and non pointer base, otherwise `Current'
			-- TODO: rename to `skip_const_and_pointer_types'
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
		end

	skip_const_pointer_and_array_types: EWG_C_AST_TYPE
			-- If `Current' is of type EWG_C_AST_CONST_TYPE,
			-- EWG_C_AST_POINTER_TYPE, or EWG_C_AST_ARRAY_TYPE, return
			-- the first non const, non pointer, and non array type,
			-- otherwise `Current'.
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
		end

	skip_consts_aliases_and_arrays: EWG_C_AST_TYPE
			-- If `Current' is of type EWG_C_AST_CONST_TYPE, EWG_C_AST_ALIAS_TYPE or
			-- EWG_C_AST_ARRAY_TYPE return the first non const, non alias, non array
			-- base, otherwise `Current'
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
		end

	skip_consts_aliases_and_pointers: EWG_C_AST_TYPE
			-- If `Current' is of type EWG_C_AST_CONST_TYPE, EWG_C_AST_ALIAS_TYPE or
			-- EWG_C_AST_POINTER_TYPE return the first non const, non alias, non array
			-- base, otherwise `Current'
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
		end

	based_type_recursive: EWG_C_AST_TYPE
			-- If `Current' is not a based type return `Current'.
			-- if `Current' is a based type return `base.based_type_recursive'.
			-- I.e. return the type that stands at the end of the chain.
			-- TODO: rename to `skip_based_types'
		do
			Result := Current
		ensure
			result_not_void: Result /= Void
			not_based_result_is_current: not is_based_type implies Result = Current
			based_implies_result_is_end_of_chain: -- TODO
		end

	corresponding_eiffel_type: STRING
			-- Returns a string that contains the Eiffel
			-- type name which corresponds with this C type.
			-- TODO: make feature deferred
			-- TODO: add `append_corresponding_eiffel_type_to_string' and use that one.
		do
			Result := "POINTER"
		end

	corresponding_eiffel_type_api: STRING
			-- Returns a string that contains the Eiffel
			-- type name which corresponds with this C type.
			-- to be used when we generate high level APIs
		do
			Result := "POINTER"
		end

	directly_nested_types: DS_LINKED_LIST [EWG_C_AST_TYPE]
			-- List of all types directly nested by `Current'.
			-- A nested type can be for example: function parameter type
			-- function return type, struct/union member or alias base.
		deferred
		ensure
			result_not_void: Result /= Void
			--result_has_no_void: not Result.has (Void)
		end

	total_pointer_and_array_indirections: INTEGER
			-- Number of total pointer and array indirections
		do
			Result := 0
		ensure
			result_greater_equal_zero: Result >= 0
		end

	total_pointer_indirections: INTEGER
			-- Number of total pointer indirections
		do
			Result := 0
		ensure
			result_greater_equal_zero: Result >= 0
		end

	conforms_to_void_pointer_type: BOOLEAN
			-- Does `Current' conform to "void*" (`c_system.types.void_pointer_type')?
			-- I.e. can it be cast to one?
		do
			if
				skip_consts_and_aliases.is_pointer_type or
					skip_consts_and_aliases.is_array_type
			then
				Result := True
			end
		end

feature {ANY} -- Comparsion

	is_same_type (other: EWG_C_AST_TYPE): BOOLEAN
			-- Is `Current' the same type as `other'?
			-- Comparsion is based on the premise that
			-- nested types can be compared via its
			-- object identity.
		require
			other_not_void: other /= Void
		do
			Result := string_equality_tester.test (name, other.name)
		ensure
			symmetric: Result implies other.is_same_type (Current)
		end

	eiffel_compatible_type: EWG_C_AST_TYPE
			-- Returns either `Current' or if `Current' is a problematic type
			-- to wrap in Eiffel (such as anonymous callbacks), return a compatible
			-- type (such as "void*"). Compatible means that `Current' is assignable
			-- to `Result' without a cast.
		do
			-- TODO: arrays are also problematic, but not yet taken care of
			if
				skip_consts_aliases_and_arrays.is_pointer_type and
					based_type_recursive.is_function_type
			then
				-- TODO: what should we do with consts?
				Result := c_system.types.void_pointer_type
			else
				Result := Current
			end
		end

feature {ANY} -- Assertion helpers

	is_array_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_ARRAY_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_const_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_CONST_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_pointer_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_POINTER_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_alias_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_ALIAS_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_function_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_FUNCTION_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_struct_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_STRUCT_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_enum_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_ENUM_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_union_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_UNION_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_composite_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_COMPOSITE_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_composite_data_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_COMPOSITE_DATA_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_simple_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_SIMPLE_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_primitive_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_PRIMITIVE_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_eiffel_object_type: BOOLEAN
		do
			Result := False
		end

	is_based_type: BOOLEAN
			-- Is `Current' of type EWG_C_AST_BASED_TYPE?
			-- Note: This is just a shortcut, which I think
			-- is justified since this C AST is _very_ static
			-- and also very important to EWG
		do
			Result := False
		end

	is_callback: BOOLEAN
			-- Is `Current' a pointer to a function?
			-- This routine should be polymorph, but
			-- due to a SE (v1.1) bug, it's not ):
		local
			b: BOOLEAN
		do
			-- This assigment seems to prevent
			-- the triggering of a bug in SE (v1.1)
			b := is_pointer_type
			if b then
				if attached {EWG_C_AST_POINTER_TYPE} Current as pointer_type then
					Result := pointer_type.base.skip_consts_and_aliases.is_function_type
				end
			end
		end

	is_char_pointer_type: BOOLEAN
			-- Is the current type a pointer to char ?
			-- (Note aliases and consts are ignored)
		do
			Result := False
		end


	is_unicode_char_pointer_type: BOOLEAN
			-- Is the current type a pointer to unicode char ?
			-- (Note aliases and consts are ignored)
		do
			Result := False
		end

feature -- Visitor Pattern

	process (a_processor: EWG_C_AST_TYPE_PROCESSOR)
			-- Process `Current' using `a_processor'.
		require
			a_processor_not_void: a_processor /= Void
		deferred
		end

feature
--feature {EWG_EWG_C_AST_TYPE_SET, C_AST_TYPE, DS_SPARSE_CONTAINER, DS_HASH_SET} -- Hashing features
		-- TODO: For some reason se 1.0 on windows requires DS_HASH_SET here,
		-- even though DS_SPARSE_CONTAINER should be sufficient

	hash_code: INTEGER
			-- Hash code for current type.
			-- Implemented via the `hash_code' of `hash_string'.
		local
			buffer: STRING
		do
			if not has_hash_code_cached then
				create buffer.make (Default_hash_string_cache_size)
				append_hash_string_to_string (buffer)
				hash_code_cache := buffer.hash_code
				has_hash_code_cached := True
			end
			Result := hash_code_cache
		ensure then
			hash_string_code_equals_hash_code_cache: hash_string.hash_code = hash_code_cache
			hash_hash_code_cached: has_hash_code_cached
		end

	hash_string: STRING
		do
			create Result.make (20)
			append_hash_string_to_string (Result)
		end

	append_hash_string_to_string (a_string: STRING)
			-- Append string that serves as source for the hash code of the current type.
		require
			a_string_not_void: a_string /= Void
		do

			a_string.append_string (generator)
			a_string.append_character ('?')
			if is_anonymous then
				a_string.append_string ("False")
			else
				a_string.append_string ("True")
			end
			a_string.append_character ('?')
			if is_anonymous then
				append_anonymous_hash_string_to_string (a_string)
			else
				append_non_anonymous_hash_string_to_string (a_string)
			end
		end

	append_anonymous_hash_string_to_string (a_string: STRING)
			-- Append string that serves as source for the hash code of the current type,
			-- if the current type is anonymous. This feature has to be implemented
			-- in an adequate way by descendants.
		require
			is_anonymous: is_anonymous
			a_string_not_void: a_string /= Void
		deferred
		end

	append_non_anonymous_hash_string_to_string (a_string: STRING)
			-- Append string that serves as source for the hash code of the current type,
			-- if the current type is named
		require
			is_not_anonymous: not is_anonymous
			a_string_not_void: a_string /= Void
		do
			a_string.append_string (name)
		end

feature {NONE} -- Implementation

	hash_code_cache: INTEGER
			-- Cached hash code for `Current'

	has_hash_code_cached: BOOLEAN
			-- Has `Current' already a precached hash code ?

feature {NONE} -- Implementation Constants

	Default_declaration_without_declarator_size: INTEGER = 12
			-- Default STRING size for `declaration_without_declarator'

	Default_declaration_size: INTEGER = 17
			-- Default STRING size for `declaration'

	Default_cast_size: INTEGER = 12
			-- Default STRING size for `cast'

	Default_hash_string_cache_size: INTEGER = 30
			-- Default STRING size for `hash_string'

invariant

	header_file_name_not_void: header_file_name /= Void
	name_not_void_implies_name_not_empty: attached name as l_name implies l_name.count > 0
	closest_alias_type_not_void_implies: attached closest_alias_type as l_closest_alias_type
													 implies l_closest_alias_type.has_type_as_base_indirect (Current)

end
