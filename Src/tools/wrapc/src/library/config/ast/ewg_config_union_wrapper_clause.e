note

	description:

		"Represents a wrapper clause that will generate enum wrappers"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_CONFIG_UNION_WRAPPER_CLAUSE

inherit

	EWG_CONFIG_COMPOSITE_DATA_TYPE_WRAPPER_CLAUSE

create

	make

feature {ANY} -- Access

	accepts_type (a_type: EWG_C_AST_TYPE): BOOLEAN
		local
			skipped_type: EWG_C_AST_TYPE
		do
			skipped_type := a_type.skip_wrapper_irrelevant_types
			Result := skipped_type.is_union_type and skipped_type.can_be_wrapped
		end

feature {ANY} -- Basic Routines

	shallow_wrap_type (a_type: EWG_C_AST_TYPE;
							 a_include_header_file_name: STRING;
							 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			union_wrapper: EWG_UNION_WRAPPER
			member_list: DS_ARRAYED_LIST [EWG_MEMBER_WRAPPER]
		do
			if attached {EWG_C_AST_UNION_TYPE} a_type.skip_wrapper_irrelevant_types as union_type then

				create member_list.make_default
				create union_wrapper.make (eiffel_identifier_for_type (union_type),
												a_include_header_file_name,
												union_type,
												member_list)
				a_eiffel_wrapper_set.add_wrapper (union_wrapper)
			end
		end

end



