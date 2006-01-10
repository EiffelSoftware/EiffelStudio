indexing
	description: "Shared Eiffel parser"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_EIFFEL_PARSER

feature -- Access

	Eiffel_parser: EIFFEL_PARSER is
			-- Eiffel parser
		do
			if il_parsing then
				Result := il_eiffel_parser
			else
				Result := pure_eiffel_parser
			end
		end

	Eiffel_validating_parser: EIFFEL_PARSER is
		do
			if il_parsing then
				Result := il_eiffel_validating_parser
			else
				Result := pure_eiffel_validating_parser
			end
		end

	il_parsing: BOOLEAN is
			-- Do we need to perform a IL parsing?
		do
			Result := il_parsing_cell.item
		end

	entity_declaration_parser: EIFFEL_PARSER is
			-- Entity declaration parser.
		once
			create Result.make_with_factory (create {AST_COMPILER_FACTORY})
			Result.set_entity_declaration_parser
		end

	Type_parser: EIFFEL_PARSER is
			-- Type parser.
		once
			create Result.make_with_factory (create {AST_COMPILER_FACTORY})
			Result.set_type_parser
		end

	Expression_parser: EIFFEL_PARSER is
			-- Type parser.
		once
			create Result.make_with_factory (create {AST_COMPILER_FACTORY})
			Result.set_expression_parser
		end

feature -- Setting

	set_il_parsing (v: BOOLEAN) is
			-- Assign `v' to `il_parsing' if project is not already compiled.
		do
			if not (create {SHARED_WORKBENCH}).Workbench.has_compilation_started then
				il_parsing_cell.set_item (v)
			else
				il_parsing_cell.set_item ((create {SHARED_WORKBENCH}).System.il_generation)
			end
		ensure
			il_parsing_set:
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else il_parsing = v
		end

feature {NONE} -- Usage

	il_parsing_cell: BOOLEAN_REF is
			-- Keep state of which parser will be used in
			-- `Eiffel_parser'.
		once
			create Result
		ensure
			il_parsing_not_void: Result /= Void
		end

feature {NONE} -- Internal parsers

	pure_eiffel_parser: EIFFEL_PARSER is
			-- Pure Eiffel parser
		once
			create Result.make_with_factory (create {AST_COMPILER_FACTORY})
		ensure
			eiffel_parser_not_void: Result /= Void
			pure_parser: not Result.il_parser
		end

	il_eiffel_parser: EIFFEL_PARSER is
			-- IL Eiffel parser.
		once
			create Result.make_with_factory (create {AST_COMPILER_FACTORY})
			Result.set_il_parser
		ensure
			il_eiffel_parser_not_void: Result /= Void
			il_parser: Result.il_parser
		end

	pure_eiffel_validating_parser: EIFFEL_PARSER is
			-- Pure Eiffel validating parser
		once
			create Result.make_with_factory (create {AST_NULL_FACTORY})
		ensure
			eiffel_parser_not_void: Result /= Void
			pure_parser: not Result.il_parser
		end

	il_eiffel_validating_parser: EIFFEL_PARSER is
			-- IL Eiffel validating parser.
		once
			create Result.make_with_factory (create {AST_NULL_FACTORY})
			Result.set_il_parser
		ensure
			il_eiffel_parser_not_void: Result /= Void
			il_parser: Result.il_parser
		end

	External_parser: EXTERNAL_PARSER is
			-- Parser for external clauses
		once
			create Result.make
		ensure
			external_parser_not_void: Result /= Void
		end

end

--|----------------------------------------------------------------
--| Copyright (C) 1999-2000, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
