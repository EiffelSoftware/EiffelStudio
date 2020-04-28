note

	description:

		"Represents a wrapper clause that will not generate wrappers"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_CONFIG_NONE_WRAPPER_CLAUSE

inherit

	EWG_CONFIG_WRAPPER_CLAUSE

create

	make

feature {ANY} -- Access

	accepts_type (a_type: EWG_C_AST_TYPE): BOOLEAN
		do
			Result := True
		end

	accepts_declaration (a_declaration: EWG_C_AST_DECLARATION): BOOLEAN
		do
			Result := True
		end

feature {ANY} -- Basic Routines

	shallow_wrap_type (a_type: EWG_C_AST_TYPE;
							 a_include_header_file_name: STRING;
							 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		do
			-- Do nothing
		end

	shallow_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
									  a_include_header_file_name: STRING;
									  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		do
			-- Do nothing
		end

	deep_wrap_type (a_type: EWG_C_AST_TYPE;
						 a_include_header_file_name: STRING;
						 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
						 a_config_system: EWG_CONFIG_SYSTEM)
		do
			-- Do nothing
		end

	deep_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
								  a_include_header_file_name: STRING;
								  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
								  a_config_system: EWG_CONFIG_SYSTEM)
		do
			-- Do nothing
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

end



