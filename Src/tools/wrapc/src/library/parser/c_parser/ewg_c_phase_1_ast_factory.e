note

	description:

		"Phase 1 C AST factory"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_PHASE_1_AST_FACTORY

feature -- C declarations

	new_enum_declaration (a_name: STRING; a_header_file_name: STRING): EWG_C_PHASE_1_DECLARATION
			-- New enum named `a_name' (without any members)
		require
			a_name_not_void: a_name /= Void
			a_header_file_name_not_void: a_header_file_name /= Void
		local
			type_specifier: EWG_C_PHASE_1_TYPE_SPECIFIER
			declarator: EWG_C_PHASE_1_DECLARATOR
			direct_declarator: EWG_C_PHASE_1_DIRECT_DECLARATOR
			type_list: DS_LINKED_LIST [ANY]
			decl_list: DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATOR]
		do
			create type_specifier.make ("int")
			create direct_declarator.make (a_name)
			create declarator.make (direct_declarator, a_header_file_name)
			create type_list.make
			type_list.put_last (type_specifier)
			create decl_list.make
			decl_list.put_last (declarator)
			create Result.make (type_list, decl_list, a_header_file_name)
		ensure
			enum_declaration_not_void: Result /= Void
		end

	new_declarator_list: DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATOR]
			-- New (empty) declarator list
		do
			create Result.make
		ensure
			declarator_list_not_void: Result /= Void
		end

	new_empty_elipsis_parameter_type_list: EWG_C_PHASE_1_PARAMETER_TYPE_LIST
		do
			create Result.make_empty_with_ellipsis
		ensure
			list_not_void: Result /= Void
			list_has_no_parameter: Result.parameter_list.count = 0
			list_has_ellipsis_parameter: Result.has_ellipsis_parameter
		end

	new_direct_abstract_declarator: EWG_C_PHASE_1_DIRECT_DECLARATOR
			-- New direct abstract declarator
		do
			create Result.make_abstract
		ensure
			result_not_void: Result /= Void
			result_is_abstract: Result.is_abstract
		end

	new_abstract_declarator (a_header_file_name: STRING): EWG_C_PHASE_1_DECLARATOR
			-- New abstract declarator
		require
			a_header_file_name_not_void: a_header_file_name /= Void
		do
			create Result.make (new_direct_abstract_declarator,
									  a_header_file_name)
		ensure
			result_not_void: Result /= Void
			result_is_abstract: Result.is_abstract
		end

feature -- C types

	new_pointer: EWG_C_PHASE_1_POINTER
			-- New pointer
		do
			create Result.make
		ensure
			pointer_not_void: Result /= Void
		end

	new_pointer_with_type_qualifier_list (a_type_qualifier_list: DS_LINKED_LIST [EWG_C_PHASE_1_TYPE_QUALIFIER]): EWG_C_PHASE_1_POINTER
			-- New pointer with type qualifiers taken from `a_type_qualifier_list'
		do
			create Result.make_with_type_qualifier_list (a_type_qualifier_list)
		ensure
			pointer_not_void: Result /= Void
		end

	new_array: EWG_C_PHASE_1_ARRAY
			-- New array
		do
			create Result.make
		ensure
			array_not_void: Result /= Void
		end

	new_array_with_size (a_size: STRING): EWG_C_PHASE_1_ARRAY 
			-- New array with the size `a_size'
		require
			a_size_not_void: a_size /= Void
			a_size_not_emptu: a_size.count > 0
		do
			create Result.make_with_size (a_size)
		ensure
			array_not_void: Result /= Void
		end

end
