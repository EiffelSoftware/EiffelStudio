note

	description:

		"Abstract base class for all types that are based on other types"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class EWG_C_AST_BASED_TYPE

inherit

	EWG_C_AST_SIMPLE_TYPE
		rename
			make as make_simple_type
		redefine
			total_pointer_and_array_indirections,
			total_pointer_indirections,
			directly_nested_types,
			is_based_type,
			based_type_recursive,
			is_named_recursive
		end

feature {NONE} -- Creation

	make (a_name: detachable STRING; a_header_file_name: STRING; a_base: EWG_C_AST_TYPE)
		require
			a_header_file_name_not_void: a_header_file_name /= Void
			a_base_not_void: a_base /= Void
		do
			make_simple_type (a_name, a_header_file_name)
			base := a_base
		ensure
			name_set: name = a_name
			base_set: base = a_base
			header_file_name_set: header_file_name = a_header_file_name
		end

feature {ANY}

	base: EWG_C_AST_TYPE
			-- The base of the current type

	is_named_recursive: BOOLEAN
		do
			Result := Precursor
			if not Result then
				Result := base.is_named_recursive
			end
		end


feature {ANY}

	total_pointer_and_array_indirections: INTEGER
		do
			Result := base.total_pointer_and_array_indirections
		end

	total_pointer_indirections: INTEGER
		do
			Result := base.total_pointer_indirections
		end

	is_same_based_type (other_based: EWG_C_AST_BASED_TYPE): BOOLEAN
		require
			other_based_not_void: other_based /= Void
		do
			Result := string_equality_tester.test (name, other_based.name) and
				base = other_based.base
		end

	directly_nested_types: DS_LINKED_LIST [EWG_C_AST_TYPE]
		do
			create Result.make
			Result.put_last (base)
		end

	is_based_type: BOOLEAN
		do
			Result := True
		end

	based_type_recursive: EWG_C_AST_TYPE
		do
			Result := base.based_type_recursive
		end

	has_type_as_base_indirect (a_type: EWG_C_AST_TYPE): BOOLEAN
			-- Returns `True' iff `a_type' is a direct or
			-- indirect base of `Current'.
		require
			a_type_not_void: a_type /= Void
		do
			if base = a_type then
				Result := True
			else
				if attached {EWG_C_AST_BASED_TYPE} base as base_based_type then
					Result := base_based_type.has_type_as_base_indirect (a_type)
				end
			end
		ensure
			a_type_is_base_implies_true: base = a_type implies Result
		end

	has_type_as_base_with_no_pointer_or_array_types_inbetween_indirect (a_type: EWG_C_AST_TYPE): BOOLEAN
			-- Returns `True' iff `a_type' is a direct or
			-- indirect base of `Current' and there are no
			-- array or pointer types "in between".
		require
			a_type_not_void: a_type /= Void
		do
			if base = a_type then
				Result := True
			else
				if attached {EWG_C_AST_BASED_TYPE} base as base_based_type then
					Result := base_based_type.has_type_as_base_indirect (a_type)
				end
			end
		ensure
			a_type_is_base_implies_true: base = a_type implies Result
		end

	number_of_pointer_or_arrays_between_current_and_type (a_type: EWG_C_AST_TYPE): INTEGER
			-- Returns the number of array or pointer indirections between `Current'
			-- and `a_type'
		require
			a_type_not_void: a_type /= Void
			a_type_has_current_as_base_indirect: has_type_as_base_indirect (a_type)
		do
			if base = a_type then
				Result := 0
			else
				if attached {EWG_C_AST_BASED_TYPE} base as base_based_type then
					Result := number_of_pointer_or_array_types_between_current_and_type_recursive (a_type, 0)
				end
			end
		ensure
			a_type_is_base_implies_zero: base = a_type implies Result = 0
		end

feature {EWG_C_AST_BASED_TYPE} -- Implementation

	number_of_pointer_or_array_types_between_current_and_type_recursive (a_type: EWG_C_AST_TYPE; a_indirections: INTEGER): INTEGER
		require
			a_type_not_void: a_type /= Void
			a_type_has_current_as_base_indirect: has_type_as_base_indirect (a_type)
			a_indirections_greater_equal_zero: a_indirections >= 0
		do
			if base = a_type then
				Result := a_indirections
			else
				if attached {EWG_C_AST_BASED_TYPE} base as base_based_type then
					Result := base_based_type.number_of_pointer_or_array_types_between_current_and_type_recursive (a_type, a_indirections)
				end
			end
		end

invariant

	base_not_void: base /= Void
	end_of_chain_is_not_based: not based_type_recursive.is_based_type

end
