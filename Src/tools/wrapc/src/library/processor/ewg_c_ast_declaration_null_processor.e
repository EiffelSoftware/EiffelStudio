note

	description:

		"Dummy processor for the 'Visitor Pattern' on phase 2 C declarations"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_AST_DECLARATION_NULL_PROCESSOR

inherit

	EWG_C_AST_DECLARATION_PROCESSOR

create

	make

feature {NONE} -- Initialization

	make
		do
		end

feature

	process_typedef_declaration (a_base_type: EWG_C_AST_TYPE; a_alias: STRING)
		do
		end

	process_function_declaration (a_function_type: EWG_C_AST_FUNCTION_TYPE; a_name: STRING)
		do
		end

	process_variable_declaration (a_type: EWG_C_AST_TYPE; a_name: STRING)
		do
		end

	process_type_declaration (a_type: EWG_C_AST_TYPE) 
		do
		end

end
