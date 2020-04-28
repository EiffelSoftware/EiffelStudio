note

	description:

		"Wraps members that are of type struct"

	library: "Eiffel Wrapper Generator Library"
	date: "$Date$"
	revision: "$Revision$"

class
	EWG_UNION_MEMBER_WRAPPER

inherit

	EWG_MEMBER_WRAPPER
		rename
			make as make_member_wrapper
		end

create

	make

feature {NONE} -- Initialization

	make (a_mapped_eiffel_name: STRING; a_header_file_name: STRING;
			a_c_declaration: EWG_C_AST_DECLARATION;
			a_union_wrapper: EWG_UNION_WRAPPER)
		require
			a_mapped_eiffel_name_not_void: a_mapped_eiffel_name /= Void
			a_mapped_eiffel_name_not_empty: not a_mapped_eiffel_name.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
			a_c_declaration_not_void: a_c_declaration /= Void
			a_struct_wrapper_not_void: a_union_wrapper /= Void
		do
			make_member_wrapper (a_mapped_eiffel_name, a_header_file_name)
			c_declaration := a_c_declaration
			union_wrapper := a_union_wrapper
		ensure
			mapped_eiffel_name_set: mapped_eiffel_name = a_mapped_eiffel_name
			header_file_name_set: header_file_name = a_header_file_name
			c_declaration_set: c_declaration = a_c_declaration
			union_wrapper_set: union_wrapper = a_union_wrapper
		end

feature -- Access

	c_declaration: EWG_C_AST_DECLARATION
			-- C declaration to wrap

	union_wrapper: EWG_UNION_WRAPPER
			-- Union wrapper that covers member

	eiffel_type: STRING
		do
			Result := union_wrapper.mapped_eiffel_name
		ensure
			result_not_void: Result /= Void
		end

	proposed_feature_name_list: DS_LINEAR [STRING]
		local
			getter_name: STRING
			setter_name: STRING
			list: DS_LINKED_LIST [STRING]
		do
			create getter_name.make (mapped_eiffel_name.count + 7)
			getter_name.append_string (mapped_eiffel_name)
			getter_name.append_string ("_union")

			create setter_name.make (mapped_eiffel_name.count + 11)
			setter_name.append_string ("set_")
			setter_name.append_string (mapped_eiffel_name)
			setter_name.append_string ("_union")

			create list.make
			list.put_last (getter_name)
			list.put_last (setter_name)
			Result := list
		end

invariant

	union_wrapper_not_void: union_wrapper /= Void

	c_declaration_not_void: c_declaration /= Void

	union_wrapper_wrapps_c_declaration_type: c_declaration.type.based_type_recursive = union_wrapper.c_union_type

end
