note

	description:

		"Wraps members that are of type struct"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_STRUCT_MEMBER_WRAPPER

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
			a_struct_wrapper: EWG_STRUCT_WRAPPER)
		require
			a_mapped_eiffel_name_not_void: a_mapped_eiffel_name /= Void
			a_mapped_eiffel_name_not_empty: not a_mapped_eiffel_name.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
			a_c_declaration_not_void: a_c_declaration /= Void
			a_struct_wrapper_not_void: a_struct_wrapper /= Void
		do
			make_member_wrapper (a_mapped_eiffel_name, a_header_file_name)
			c_declaration := a_c_declaration
			struct_wrapper := a_struct_wrapper
		ensure
			mapped_eiffel_name_set: mapped_eiffel_name = a_mapped_eiffel_name
			header_file_name_set: header_file_name = a_header_file_name
			c_declaration_set: c_declaration = a_c_declaration
			struct_wrapper_set: struct_wrapper = a_struct_wrapper
		end

feature -- Access

	c_declaration: EWG_C_AST_DECLARATION
			-- C declaration to wrap

	struct_wrapper: EWG_STRUCT_WRAPPER
			-- struct wrapper that covers member

	eiffel_type: STRING
		do
			Result := struct_wrapper.mapped_eiffel_name
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
			getter_name.append_string ("_struct")

			create setter_name.make (mapped_eiffel_name.count + 11)
			setter_name.append_string ("set_")
			setter_name.append_string (mapped_eiffel_name)
			setter_name.append_string ("_struct")

			create list.make
			list.put_last (getter_name)
			list.put_last (setter_name)
			Result := list
		end

invariant

	struct_wrapper_not_void: struct_wrapper /= Void

	c_declaration_not_void: c_declaration /= Void

	struct_wrapper_wrapps_c_declaration_type: c_declaration.type.based_type_recursive = struct_wrapper.c_struct_type

end
