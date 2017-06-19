note
	description: "[
			RULE #57: Simplifiable boolean expression
	
			Some negated boolean expressions can be
			simplified using the inverse comparison operator.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_SIMPLIFIABLE_BOOLEAN_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_un_not_pre_action (agent process_un_not)
		end

feature -- Properties

	name: STRING = "negated_comparison"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.simplifiable_boolean_title
		end

	id: STRING_32 = "CA057"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.simplifiable_boolean_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.simplifiable_boolean_violation)
		end

feature {NONE} -- Rule Checking

	process_un_not (a_un_not: UN_NOT_AS)
			-- Checks `a_un_not' for rule violations.
		local
			l_viol: CA_RULE_VIOLATION
		do
			if is_comparison (a_un_not.expr) then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_un_not.start_location)
				violations.extend (l_viol)
			end
		end

	is_comparison (expression: attached EXPR_AS): BOOLEAN
			-- Is `expression' a comparison expression?
		do
			if attached {PARAN_AS} expression as l_paran then
				Result := is_comparison (l_paran.expr)
			else
				Result := (attached {BIN_EQ_AS} expression) or (attached {COMPARISON_AS} expression)
			end
		end

end
