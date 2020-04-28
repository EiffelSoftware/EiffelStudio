note

	description:

		"Phase 2 AST element, which represents a declaration"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_AST_DECLARATION

inherit

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

	HASHABLE

create

	make

feature {NONE} -- Initialisation

	make (a_declarator: detachable STRING; a_type: like type; a_header_file_name: STRING)
			-- Create a new declaration with the
			-- declarator `a_declarator' and the type resp. signature
			-- `a_type'.
		require
			a_declarator_not_void_implies_not_empty: a_declarator /= Void implies not a_declarator.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: a_header_file_name.count > 0
			a_type_not_void: a_type /= Void
		do
			declarator := a_declarator
			type := a_type
			header_file_name := a_header_file_name
		ensure
			declarator_set: declarator = a_declarator
			type_set: type = a_type
			header_file_name_set: header_file_name = a_header_file_name
		end

feature {ANY} -- Access

	declarator: detachable STRING
			-- Declarator

	type: EWG_C_AST_TYPE
			-- Type

	header_file_name: STRING
			-- Name of header file the declaration comes from


	hash_code: INTEGER
			-- Hash code for current type.
		do
			Result := type.hash_code
		end

feature {ANY} -- Setting

	set_type (a_type: like type)
			-- Make `a_type' the new `type'.
		require
			a_type_not_void: a_type /= Void
		do
			type := a_type
		ensure
			type_set: type = a_type
		end


	set_declarator (a_declarator: STRING)
			-- Rename a delcarator `declarator` with `a_declarator`.
		do
			declarator := a_declarator
		ensure
			declarator_set: declarator = a_declarator
		end

feature {ANY}

	is_anonymous: BOOLEAN
			-- Is this declaration anonymous?
			-- I.e. Does it not have a declarator?
		do
			Result := declarator = Void
		ensure
			declarator_void_equals_anonymous: (declarator = Void) = Result
		end

	is_function_declaration: BOOLEAN
			-- Is this a function declaration ?
		do
			Result := False
		end

feature {ANY} -- Comparsion

	is_same_declaration  (other: EWG_C_AST_DECLARATION): BOOLEAN
			-- Two declarations are considered equal if their name is
			-- equal.
		local
			names_are_equal: BOOLEAN
		do
			if other /= Void then
				if is_anonymous then
					names_are_equal := other.is_anonymous
				elseif other.is_anonymous then
					names_are_equal := False
				else
					names_are_equal := string_equality_tester.test (declarator, other.declarator)
				end
				Result := names_are_equal and type = other.type
			end
		end

invariant

	declarator_not_void_implies_not_empty: attached declarator as l_declarator implies not l_declarator.is_empty
	header_file_name_not_void: header_file_name /= Void
	header_file_name_not_empty: header_file_name.count > 0
	declarator_valid_c_identifier: True -- TODO:
	type_not_void: type /= Void

end
