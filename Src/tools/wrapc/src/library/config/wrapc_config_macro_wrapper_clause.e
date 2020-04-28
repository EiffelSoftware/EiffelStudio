note
	description: "Represents a wrapper clause that will generate macro wrappers"
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPC_CONFIG_MACRO_WRAPPER_CLAUSE

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

	class_name: detachable STRING


feature {ANY} -- Setting

	set_class_name (a_class_name: STRING)
		require
			a_class_name_not_void: a_class_name /= Void
			a_class_name_not_empty: a_class_name.count > 0
		do
			class_name := a_class_name
		ensure
			class_name_set: class_name = a_class_name
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



