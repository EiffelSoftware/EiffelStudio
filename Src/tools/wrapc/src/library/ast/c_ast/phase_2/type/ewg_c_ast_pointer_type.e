note

	description:

		"C pointer types"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_AST_POINTER_TYPE

inherit

	EWG_C_AST_BASED_TYPE
		rename
			make as make_based_type
		redefine
			is_same_type,
			total_pointer_and_array_indirections,
			total_pointer_indirections,
			is_char_pointer_type,
			is_unicode_char_pointer_type,
			corresponding_eiffel_type,
			corresponding_eiffel_type_api,
			skip_consts_and_pointers,
			skip_consts_aliases_and_pointers,
			skip_const_pointer_and_array_types,
			has_type_as_base_with_no_pointer_or_array_types_inbetween_indirect,
			number_of_pointer_or_array_types_between_current_and_type_recursive,
			is_pointer_type
		end

	EWG_C_CALLING_CONVENTION_CONSTANTS
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make

feature {NONE} -- Creation

	make (a_header_file_name: STRING; a_base: EWG_C_AST_TYPE)
		require
			a_header_file_name_not_void: a_header_file_name /= Void
			a_base_not_void: a_base /= Void
		do
			make_based_type (Void, a_header_file_name, a_base)
		ensure
			base_set: base = a_base
			header_file_name_set: header_file_name = a_header_file_name
		end

feature -- Access

	is_same_type (other: EWG_C_AST_TYPE): BOOLEAN
		do
			if attached {EWG_C_AST_POINTER_TYPE} other as other_pointer then
				Result := Current = other_pointer or else is_same_based_type (other_pointer)
			end
		end

	append_anonymous_hash_string_to_string (a_string: STRING)
		do
			a_string.append_string ("pointer_")
			base.append_hash_string_to_string (a_string)
		end

	total_pointer_and_array_indirections: INTEGER
			-- Number of total pointer and array indirections
		do
			Result := 1 + base.skip_consts_and_aliases.total_pointer_and_array_indirections
		end

	total_pointer_indirections: INTEGER
			-- Number of total pointer indirections
		do
			Result := 1 + base.skip_consts_and_aliases.total_pointer_indirections
		end

	is_pointer_type: BOOLEAN
		do
			Result := True
		end

	corresponding_eiffel_type: STRING
		do
			Result := "POINTER"
		end

	corresponding_eiffel_type_api: STRING
		do
			if is_char_pointer_type then
				Result := "STRING_8"
			elseif is_unicode_char_pointer_type then
				Result := "STRING_32"
			else
				Result := "POINTER"
			end
		end

	skip_consts_and_pointers: EWG_C_AST_TYPE
		do
			Result := base.skip_consts_and_pointers
		end

	skip_consts_aliases_and_pointers: EWG_C_AST_TYPE
		do
			Result := base.skip_consts_aliases_and_pointers
		end

	skip_const_pointer_and_array_types: EWG_C_AST_TYPE
		do
			Result := base.skip_const_pointer_and_array_types
		end

	has_type_as_base_with_no_pointer_or_array_types_inbetween_indirect (a_type: EWG_C_AST_TYPE): BOOLEAN
		do
			Result := False
		end

	is_char_pointer_type: BOOLEAN
			-- Is the current type a pointer to char ?
			-- (Note aliases and consts are ignored)
		do
			if
				base.skip_consts_and_aliases.is_primitive_type
			then
				if attached {EWG_C_AST_PRIMITIVE_TYPE} base.skip_consts_and_aliases as  primitive_type then
					Result := primitive_type.is_char_type
				end
			end
		end

	is_unicode_char_pointer_type: BOOLEAN
			-- Is the current type a pointer to unicode char ?
			-- (Note consts are ignored)
		do
			if
				base.skip_consts.is_based_type
			then
				if attached {EWG_C_AST_ALIAS_TYPE}  base.skip_consts as l_base then
					Result := l_base.is_unicode_char_pointer_type
				end
			end
		end

	function_type: EWG_C_AST_FUNCTION_TYPE
			-- If `Current' is a callback, return the corresponding function type
		require
			is_callback: is_callback
		do
			check attached {EWG_C_AST_FUNCTION_TYPE} based_type_recursive as l_based_type_recursive  then
				Result := l_based_type_recursive
			end
		ensure
			function_type_not_void: Result /= Void
		end

	get_eiffel_type (a_header_file_name: STRING_8 ): STRING
		do
			Result := "Not Implemented"
			-- TODO double check
		end

feature -- Visitor Pattern

	process (a_processor: EWG_C_AST_TYPE_PROCESSOR)
			-- Process `Current' using `a_processor'.
		do
			a_processor.process_pointer_type (Current)
		end

feature {EWG_C_AST_BASED_TYPE}

	number_of_pointer_or_array_types_between_current_and_type_recursive (a_type: EWG_C_AST_TYPE; a_indirections: INTEGER): INTEGER
		do
			if base = a_type then
				Result := a_indirections + 1
			else
				if attached {EWG_C_AST_BASED_TYPE} base as base_based_type then
					Result := base_based_type.number_of_pointer_or_array_types_between_current_and_type_recursive (a_type, a_indirections + 1)
				end
			end
		end

invariant

	is_anonymous: is_anonymous

end
