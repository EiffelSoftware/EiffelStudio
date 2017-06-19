note
	description: "[
			RULE #42: Unneeded comparison of boolean variables or queries
	
			In expressions, boolean variables or
			queries need not be compared to True or False.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_BOOLEAN_COMPARISON_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
			default_severity_score := 30
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_bin_eq_pre_action (agent process_bin_eq)
		end

feature -- Properties

	name: STRING = "comparison_to_boolean_constant"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.boolean_comparison_title
		end

	id: STRING_32 = "CA042"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.boolean_comparison_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.boolean_comparison_violation)
		end

feature {NONE} -- Rule Checking

	process_bin_eq (a_bin_eq: BIN_EQ_AS)
			-- Checks if `a_bin_eq' compares a boolean constant.
		local
			l_viol: CA_RULE_VIOLATION
		do
			if attached {BOOL_AS} a_bin_eq.left or attached {BOOL_AS} a_bin_eq.right then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_bin_eq.start_location)
				violations.extend (l_viol)
			end
		end

end
