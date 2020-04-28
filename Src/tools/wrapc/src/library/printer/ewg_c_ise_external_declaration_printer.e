note

	description:

	"C declaration without declarator formatter.%
	%This implementation has workaround for the limitations of%
	%the C declaration list in ISE Eiffel C external clauses."

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_ISE_EXTERNAL_DECLARATION_PRINTER

inherit

	EWG_C_DECLARATION_PROCESSOR
		redefine
			process_function_type
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

feature -- Formatting

	print_declaration_from_type (a_type: EWG_C_AST_TYPE; a_declarator: STRING)
		local
			type: EWG_C_AST_TYPE
		do
			reset
			if
				a_type.skip_consts_and_aliases.is_struct_type or
					a_type.skip_consts_and_aliases.is_union_type
			then
				-- Structs and unions (without indirections) need to be
				-- treated as pointer to struct resp. unions.
				create {EWG_C_AST_POINTER_TYPE} type.make (a_type.header_file_name, a_type)
			elseif a_type.skip_consts_aliases_and_pointers.is_array_type then
				-- Arrays need to be treated as void pointers
				type := c_system.types.void_pointer_type
			else
				type := a_type
			end

			process (type)
		end

feature {EWG_C_AST_TYPE_PROCESSOR} -- Processing

	process_function_type (a_type: EWG_C_AST_FUNCTION_TYPE)
			-- Nested function declarations confuse the ISE external parser.
			-- Replacing the with a void pointer.
		do
			process (c_system.types.void_type)
		end

end
