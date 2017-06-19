note
	description: "[
			RULE #28: Two if instructions can be combined using short-circuit operator
	
			Two nested if instructions, where the
			inner one does not have an else clause, should be combined into a single
			if instruction using the short circuit 'and then' operator.
		]"
	author: "Stefan Zurfluh, Eiffel Software"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_SHORT_CIRCUIT_IF_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			default_severity_score := 40
			severity := severity_hint
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_if_pre_action (agent process_if)
		end

feature {NONE} -- Rule checking

	process_if (a_if: IF_AS)
			-- Checks `a_if' for rule violations.
		local
			l_viol: CA_RULE_VIOLATION
		do
			if
				attached a_if.compound as l_c
				and then l_c.count = 1
				and then attached {IF_AS} l_c.first as l_inner_if
				and then a_if.else_part = Void
				and then a_if.elsif_list = Void
				and then l_inner_if.else_part = Void
				and then l_inner_if.elsif_list = Void
			then
					-- The Compound of the (outer) if only contains an (inner) if instruction,
					-- which is exactly what will trigger this rule.
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_if.start_location)
				violations.extend (l_viol)
			end
		end

feature -- Properties

	name: STRING = "combinable_nested_conditionals"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.short_circuit_if_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.short_circuit_if_description
		end

	id: STRING_32 = "CA028"
			-- <Precursor>

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Generates a formatted rule violation description for `a_formatter' based on `a_violation'.
		do
			a_formatter.add (ca_messages.short_circuit_if_violation)
		end

end
