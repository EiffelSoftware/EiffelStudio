note
	description: "Summary description for {EWG_EIFFEL_API_SHARED}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EWG_EIFFEL_API_SHARED

inherit

	EWG_ABSTRACT_GENERATOR


feature -- Status Report.

	is_char_pointer_type (a_declarator: EWG_C_AST_DECLARATION): BOOLEAN
		do
			if a_declarator.type.is_char_pointer_type then
				Result := True
			elseif attached {EWG_C_AST_ALIAS_TYPE} a_declarator.type as l_type then
				if attached {EWG_C_AST_POINTER_TYPE} l_type.base as l_pointer_type then
					if attached {EWG_C_AST_PRIMITIVE_TYPE} l_pointer_type.skip_wrapper_irrelevant_types as l_primitive_type then
						Result := l_primitive_type.is_char_type
					end
				end
			end
		end

	is_unicode_char_pointer_type (a_declarator: EWG_C_AST_DECLARATION): BOOLEAN
		do
			if a_declarator.type.is_unicode_char_pointer_type then
				Result := True
			elseif attached {EWG_C_AST_ALIAS_TYPE} a_declarator.type as l_type then
				if attached {EWG_C_AST_POINTER_TYPE} l_type.base as l_pointer_type then
					-- To be checked.
				end
			end
		end

	has_struct_wrapper_by_name (a_name: STRING): BOOLEAN
		local
			cs: DS_BILINEAR_CURSOR [EWG_STRUCT_WRAPPER]
			l_name: STRING
			found: BOOLEAN
		do
			from
				cs := directory_structure.config_system.eiffel_wrapper_set.new_struct_wrapper_cursor
				cs.start
			until
				cs.off or found
			loop
				l_name := cs.item.mapped_eiffel_name
				if l_name.is_case_insensitive_equal_general (a_name) then
					found := True
				end
				cs.forth
			end
			Result := found
		end


	has_union_wrapper_by_name ( a_name: STRING): BOOLEAN
		local
			cs: DS_BILINEAR_CURSOR [EWG_UNION_WRAPPER]
			l_name: STRING
			found: BOOLEAN
		do
			from
				cs := directory_structure.config_system.eiffel_wrapper_set.new_union_wrapper_cursor
				cs.start
			until
				cs.off or found
			loop
				l_name := cs.item.mapped_eiffel_name
				if l_name.is_case_insensitive_equal_general (a_name) then
					found := True
				end
				cs.forth
			end
			Result := found
		end


end
