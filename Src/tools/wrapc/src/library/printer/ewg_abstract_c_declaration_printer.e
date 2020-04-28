note

	description:

		"Abstract C declaration printer"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class EWG_ABSTRACT_C_DECLARATION_PRINTER

inherit

	EWG_PRINTER

feature -- Status

	can_be_printed (a_declaration: EWG_C_AST_DECLARATION): BOOLEAN
		require
			a_declaration_not_void: a_declaration /= Void
		do
			if a_declaration.is_anonymous then
				Result := can_be_printed_from_type (a_declaration.type, "")
			else
				if attached a_declaration.declarator as l_declarator then
					Result := can_be_printed_from_type (a_declaration.type, l_declarator)
				end
			end
		end

	can_be_printed_from_type (a_type: EWG_C_AST_TYPE; a_declarator: STRING): BOOLEAN
		require
			a_type_not_void: a_type /= Void
			a_declarator_not_void: a_declarator /= Void
		do
			Result := a_type.is_named_recursive or a_type.based_type_recursive.is_function_type or a_type.based_type_recursive.is_eiffel_object_type or a_type.based_type_recursive.has_perfect_alias_type
		end

feature -- Declaring

	print_declaration (a_declaration: EWG_C_AST_DECLARATION)
			-- Print the declaration `a_declaration'.
		require
			a_declaration_not_void: a_declaration /= Void
			can_be_printed: can_be_printed (a_declaration)
		do
			if a_declaration.is_anonymous then
				print_declaration_from_type (a_declaration.type, "")
			else
				if attached  a_declaration.declarator as l_declarator then
					print_declaration_from_type (a_declaration.type, l_declarator)
				end
			end
		end

	print_declaration_from_type (a_type: EWG_C_AST_TYPE; a_declarator: STRING)
			-- Print a declaration declaring `a_declarator' to be of type `a_type'.
		require
			a_type_not_void: a_type /= Void
			can_be_printed: can_be_printed_from_type (a_type, a_declarator)
		deferred
		end

end
