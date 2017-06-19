note
	description: "[
			RULE #15: Double negation
	
			A double negation appearing in an expression can be safely removed.
			It is also possible that the developer has intended to put a single
			negation and the instruction is erroneous.
		]"
	author: "Samuel Schmid"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_DOUBLE_NEGATION_RULE

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

	name: STRING = "double_negation"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.double_negation_title
		end

	id: STRING_32 = "CA015"

	description: STRING_32
		do
			Result := ca_names.double_negation_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.double_negation_violation)
		end

feature {NONE} -- Rule Checking

	process_un_not (a_un_not: UN_NOT_AS)
			-- Checks `a_un_not' for rule violations.
		do
			if is_un_not (a_un_not.expr) then
				create_violation(a_un_not)
			end
		end

	is_un_not (expression: attached EXPR_AS): BOOLEAN
			-- Is `expression' a unary not operation?
		do
			if attached {PARAN_AS} expression as l_paran then
				Result := is_un_not (l_paran.expr)
			else
				Result := attached {UN_NOT_AS} expression
			end
		end

	create_violation(a_un_not: UN_NOT_AS)
		local
			l_viol: CA_RULE_VIOLATION
			l_fix: CA_DOUBLE_NEGATION_FIX
		do
			create l_viol.make_with_rule (Current)
			l_viol.set_location (a_un_not.start_location)

			create l_fix.make_with_un_not (current_context.checking_class, a_un_not)
			l_viol.fixes.extend (l_fix)

			violations.extend (l_viol)
		end

end

