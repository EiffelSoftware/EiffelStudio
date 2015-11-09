note
	description: "[
			RULE #23: Unneeded parentheses
	
			Parentheses that are not needed should be
			removed. This helps enforcing a consistent coding style.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNNEEDED_PARENTHESES_RULE

inherit
	CA_STANDARD_RULE

	AST_ITERATOR
		redefine
			process_bin_div_as,
			process_bin_minus_as,
			process_bin_mod_as,
			process_bin_plus_as,
			process_bin_power_as,
			process_bin_slash_as,
			process_bin_star_as,
			process_bin_and_as,
			process_bin_and_then_as,
			process_bin_eq_as,
			process_bin_ne_as,
			process_bin_not_tilde_as,
			process_bin_tilde_as,
			process_bin_free_as,
			process_bin_implies_as,
			process_bin_or_as,
			process_bin_or_else_as,
			process_bin_xor_as,
			process_bin_ge_as,
			process_bin_gt_as,
			process_bin_le_as,
			process_bin_lt_as,
			process_object_test_as,
			process_paran_as,
			process_un_free_as,
			process_un_minus_as,
			process_un_not_as,
			process_un_old_as,
			process_un_plus_as,
			process_un_strip_as
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			default_severity_score := 30
			create {CA_SUGGESTION} severity
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_routine_pre_action (agent check_routine)
		end

feature -- Properties

	name: STRING = "redundant_parentheses"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.unneeded_parentheses_title
		end

	id: STRING_32 = "CA023"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.unneeded_parentheses_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.unneeded_parentheses_violation_1)
		end

feature {NONE} -- Implementation

	check_routine (a_routine: ROUTINE_AS)
			-- Processes a routine. All possible violations of this rule
			-- will occur within a routine. `check_routine' is called by
			-- the global rule checker. This rule then separately traverses
			-- the AST tree from here on because it needs to look at many
			-- different types of AST nodes.
		do
			is_within_binary := False

			process_routine_as (a_routine)

			is_within_binary := False
		end

	is_within_binary: BOOLEAN

	is_not_nested (a_expr: attached EXPR_AS): BOOLEAN
			-- Is `a_expr' not one of unary, binary, or object test expressions?
		do
			Result := (not attached {UNARY_AS} a_expr)
				and (not attached {BINARY_AS} a_expr)
				and (not attached {OBJECT_TEST_AS} a_expr)
		end

feature {NONE} -- AST Visitor

	process_paran_as (a_paran: PARAN_AS)
		local
			l_violation: CA_RULE_VIOLATION
		do
			if not is_within_binary or is_not_nested (a_paran.expr) then
				create l_violation.make_with_rule (Current)
				l_violation.set_location (a_paran.start_location)
				violations.extend (l_violation)
			end
		end

	process_bin_div_as (a_bin: BIN_DIV_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_minus_as (a_bin: BIN_MINUS_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_mod_as (a_bin: BIN_MOD_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_plus_as (a_bin: BIN_PLUS_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_power_as (a_bin: BIN_POWER_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_slash_as (a_bin: BIN_SLASH_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_star_as (a_bin: BIN_STAR_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_and_as (a_bin: BIN_AND_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_and_then_as (a_bin: BIN_AND_THEN_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_eq_as (a_bin: BIN_EQ_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_ne_as (a_bin: BIN_NE_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_not_tilde_as (a_bin: BIN_NOT_TILDE_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_tilde_as (a_bin: BIN_TILDE_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_free_as (a_bin: BIN_FREE_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_implies_as (a_bin: BIN_IMPLIES_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_or_as (a_bin: BIN_OR_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_or_else_as (a_bin: BIN_OR_ELSE_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_xor_as (a_bin: BIN_XOR_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_ge_as (a_bin: BIN_GE_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_gt_as (a_bin: BIN_GT_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_le_as (a_bin: BIN_LE_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_bin_lt_as (a_bin: BIN_LT_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_bin)
			is_within_binary := l_old
		end

	process_object_test_as (a_ot: OBJECT_TEST_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_ot)
			is_within_binary := l_old
		end

	process_un_free_as (a_un: UN_FREE_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_un)
			is_within_binary := l_old
		end

	process_un_minus_as (a_un: UN_MINUS_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_un)
			is_within_binary := l_old
		end

	process_un_not_as (a_un: UN_NOT_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_un)
			is_within_binary := l_old
		end

	process_un_old_as (a_un: UN_OLD_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_un)
			is_within_binary := l_old
		end

	process_un_plus_as (a_un: UN_PLUS_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_un)
			is_within_binary := l_old
		end

	process_un_strip_as (a_un: UN_STRIP_AS)
		local
			l_old: BOOLEAN
		do
			l_old := is_within_binary
			is_within_binary := True
			Precursor (a_un)
			is_within_binary := l_old
		end

end
