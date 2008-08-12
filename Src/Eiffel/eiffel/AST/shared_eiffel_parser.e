indexing
	description: "Shared Eiffel parser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	Heavy_eiffel_parser: EIFFEL_PARSER is
			-- Heavy eiffel parser
		do
			if il_parsing then
				Result := heavy_il_roundtrip_parser
			else
				Result := heavy_roundtrip_parser
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

	entity_feature_parser: EIFFEL_PARSER is
			-- Entity declaration parser.
		once
			create Result.make_with_factory (create {AST_COMPILER_FACTORY})
			Result.set_feature_parser
		end

feature -- Setting

	set_il_parsing (v: BOOLEAN) is
			-- Assign `v' to `il_parsing' if project is not already compiled.
		do
			if not (create {SHARED_WORKBENCH}).Workbench.has_compilation_started then
				il_parsing_cell.put (v)
			else
				il_parsing_cell.put ((create {SHARED_WORKBENCH}).System.il_generation)
			end
		ensure
			il_parsing_set:
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else il_parsing = v
		end

feature {NONE} -- Usage

	il_parsing_cell: CELL [BOOLEAN] is
			-- Keep state of which parser will be used in
			-- `Eiffel_parser'.
		once
			create Result.put (False)
		ensure
			il_parsing_not_void: Result /= Void
		end

feature {NONE} -- Internal parsers

	pure_eiffel_parser: EIFFEL_PARSER is
			-- Pure Eiffel parser
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_COMPILER_LIGHT_FACTORY})
		ensure
			eiffel_parser_not_void: Result /= Void
			pure_parser: not Result.il_parser
		end

	il_eiffel_parser: EIFFEL_PARSER is
			-- IL Eiffel parser.
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_COMPILER_LIGHT_FACTORY})
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

	Matchlist_scanner: EIFFEL_ROUNDTRIP_SCANNER is
			-- Scanner for generating a matchlist.
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_SCANNER_FACTORY})
		ensure
			Result_not_void: Result /= Void
		end

	Heavy_roundtrip_parser: EIFFEL_PARSER is
			-- Heavy pure eiffel parser.
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_COMPILER_FACTORY})
		ensure
			eiffel_parser_not_void: Result /= Void
			pure_parser: not Result.il_parser
		end

	Heavy_il_roundtrip_parser: EIFFEL_PARSER is
			-- Heavy IL Eiffel parser.
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_COMPILER_FACTORY})
			Result.set_il_parser
		ensure
			il_eiffel_parser_not_void: Result /= Void
			il_parser: Result.il_parser
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

