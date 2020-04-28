note

	description:

		"C declaration printer"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_DECLARATION_PRINTER

inherit

	EWG_C_DECLARATION_PROCESSOR
		select
			make_internal
		end

	EWG_ABSTRACT_C_DECLARATION_PRINTER
		rename
			make_internal as make_internal_dp
		end
create

	make,
	make_string

feature -- Declaring

	print_declaration_from_type (a_type: EWG_C_AST_TYPE; a_declarator: STRING)
		do
			reset
			declarator := a_declarator
			process (a_type)
		end

end
