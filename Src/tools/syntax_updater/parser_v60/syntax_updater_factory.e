note
	description: "Fast parser that only recognizes the old constructs"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_UPDATER_FACTORY

inherit
	AST_NULL_FACTORY
		redefine
			new_bang_creation_as,
			new_bang_creation_expr_as,
			new_old_routine_creation_as,
			new_static_access_as,
			new_keyword_as,
			new_creation_keyword_as
		end

feature -- Access

	has_obsolete_constructs: BOOLEAN
			-- Does current class has some obsolete constructs?

feature -- Status setting

	reset
		do
			has_obsolete_constructs := False
		ensure
			no_obsolete_constructs: not has_obsolete_constructs
		end

feature -- Processing

	new_creation_keyword_as (a_scn: EIFFEL_SCANNER): KEYWORD_AS
		do
			has_obsolete_constructs := True
		end

	new_keyword_as (a_code: INTEGER_32; a_scn: EIFFEL_SCANNER): KEYWORD_AS
			-- New KEYWORD_AS only for `feature' and `creation'.
		do
			if a_code = {EIFFEL_TOKENS}.te_feature then
				create Result.make (a_code, a_scn.text, a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
			end
		end

	new_static_access_as (c: TYPE_AS; f: ID_AS; p: PARAMETER_LIST_AS; f_as: KEYWORD_AS; d_as: SYMBOL_AS): STATIC_ACCESS_AS
		do
			has_obsolete_constructs := has_obsolete_constructs or else f_as /= Void
		end

	new_bang_creation_as (tp: TYPE_AS; tg: ACCESS_AS; c: ACCESS_INV_AS; l_as, r_as: SYMBOL_AS): BANG_CREATION_AS
		do
			has_obsolete_constructs := True
		end

	new_bang_creation_expr_as (t: TYPE_AS; c: ACCESS_INV_AS; l_as, r_as: SYMBOL_AS): BANG_CREATION_EXPR_AS
		do
			has_obsolete_constructs := True
		end

	new_old_routine_creation_as (l: AST_EIFFEL; t: OPERAND_AS; f: ID_AS; o: DELAYED_ACTUAL_LIST_AS; is_qualified: BOOLEAN; a_as: SYMBOL_AS): PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		do
			has_obsolete_constructs := True
		end

end
