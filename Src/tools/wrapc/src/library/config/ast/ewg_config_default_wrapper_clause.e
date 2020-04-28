note

	description:

		"Represents a wrapper clause that will not generate default wrappers"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_CONFIG_DEFAULT_WRAPPER_CLAUSE

inherit

	EWG_CONFIG_WRAPPER_CLAUSE
		rename
			make as make_config_wrapper_clause
		end

create

	make

feature {NONE} -- Initialization

	make
		do
			make_config_wrapper_clause
			create struct_wrapper_clause.make
			create enum_wrapper_clause.make
			create union_wrapper_clause.make
			create callback_wrapper_clause.make
			create function_wrapper_clause.make
		end

feature {ANY} -- Access

	accepts_type (a_type: EWG_C_AST_TYPE): BOOLEAN
		local
			skipped_type: EWG_C_AST_TYPE
		do
			skipped_type := a_type.skip_wrapper_irrelevant_types
			if skipped_type.is_struct_type then
				Result := struct_wrapper_clause.accepts_type (a_type)
			elseif skipped_type.is_enum_type then
				Result := enum_wrapper_clause.accepts_type (a_type)
			elseif skipped_type.is_union_type then
				Result := union_wrapper_clause.accepts_type (a_type)
			elseif skipped_type.is_callback then
				Result := callback_wrapper_clause.accepts_type (a_type)
			else
					check
						dead_end: False
					end
			end
		end

	accepts_declaration (a_declaration: EWG_C_AST_DECLARATION): BOOLEAN
		do
			Result := function_wrapper_clause.accepts_declaration (a_declaration)
		end

feature {ANY} -- Basic Routines

	shallow_wrap_type (a_type: EWG_C_AST_TYPE;
							 a_include_header_file_name: STRING;
							 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			skipped_type: EWG_C_AST_TYPE
		do
			skipped_type := a_type.skip_wrapper_irrelevant_types
			if skipped_type.is_struct_type then
				struct_wrapper_clause.shallow_wrap_type (a_type,
																	  a_include_header_file_name,
																	  a_eiffel_wrapper_set)
			elseif skipped_type.is_enum_type then
				enum_wrapper_clause.shallow_wrap_type (a_type,
																	a_include_header_file_name,
																	a_eiffel_wrapper_set)
			elseif skipped_type.is_union_type then
				union_wrapper_clause.shallow_wrap_type (a_type,
																	 a_include_header_file_name,
																	 a_eiffel_wrapper_set)
			elseif skipped_type.is_callback then
				callback_wrapper_clause.shallow_wrap_type (a_type,
																		 a_include_header_file_name,
																		 a_eiffel_wrapper_set)
			else
					check
						dead_end: False
					end
			end
		end

	shallow_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
									  a_include_header_file_name: STRING;
									  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		do
			function_wrapper_clause.shallow_wrap_declaration (a_declaration,
																			  a_include_header_file_name,
																			  a_eiffel_wrapper_set)
		end

	deep_wrap_type (a_type: EWG_C_AST_TYPE;
						 a_include_header_file_name: STRING;
						 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
						 a_config_system: EWG_CONFIG_SYSTEM)
		local
			skipped_type: EWG_C_AST_TYPE
		do
			skipped_type := a_type.skip_wrapper_irrelevant_types
			if skipped_type.is_struct_type then
				struct_wrapper_clause.deep_wrap_type (a_type,
																  a_include_header_file_name,
																  a_eiffel_wrapper_set,
																  a_config_system)
			elseif skipped_type.is_enum_type then
				enum_wrapper_clause.deep_wrap_type (a_type,
																a_include_header_file_name,
																a_eiffel_wrapper_set,
																a_config_system)
			elseif skipped_type.is_union_type then
				union_wrapper_clause.deep_wrap_type (a_type,
																 a_include_header_file_name,
																 a_eiffel_wrapper_set,
																 a_config_system)
			elseif skipped_type.is_callback then
				callback_wrapper_clause.deep_wrap_type (a_type,
																	 a_include_header_file_name,
																	 a_eiffel_wrapper_set,
																	 a_config_system)
			else
					check
						dead_end: False
					end
			end
		end

	deep_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
								  a_include_header_file_name: STRING;
								  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
								  a_config_system: EWG_CONFIG_SYSTEM)
		do
			function_wrapper_clause.deep_wrap_declaration (a_declaration,
																		  a_include_header_file_name,
																		  a_eiffel_wrapper_set,
																		  a_config_system)
		end

feature {NONE}

	default_eiffel_identifier_for_type (a_type: EWG_C_AST_TYPE): STRING
		do

			check
				dead_end: False
			end
			create Result.make_empty
		end

	default_eiffel_identifier_for_declaration (a_declaration: EWG_C_AST_DECLARATION): STRING
		do
			check
				dead_end: False
			end
			create Result.make_empty
		end

	struct_wrapper_clause: EWG_CONFIG_STRUCT_WRAPPER_CLAUSE

	enum_wrapper_clause: EWG_CONFIG_ENUM_WRAPPER_CLAUSE

	union_wrapper_clause: EWG_CONFIG_UNION_WRAPPER_CLAUSE

	callback_wrapper_clause: EWG_CONFIG_CALLBACK_WRAPPER_CLAUSE

	function_wrapper_clause: EWG_CONFIG_FUNCTION_WRAPPER_CLAUSE


invariant

	struct_wrapper_clause_not_void: struct_wrapper_clause /= Void
	enum_wrapper_clause_not_void: enum_wrapper_clause /= Void
	union_wrapper_clause_not_void: union_wrapper_clause /= Void
	callback_wrapper_clause_not_void: callback_wrapper_clause /= Void
	function_wrapper_clause_not_void: function_wrapper_clause /= Void

end
