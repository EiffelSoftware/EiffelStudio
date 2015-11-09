note
	description: "[
			RULE #17: Empty conditional instruction
	
			An empty conditional instruction is useless and should be removed.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EMPTY_IF_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_if_pre_action (agent process_if)
		end

feature -- Properties

	name: STRING = "empty_conditional"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.empty_if_title
		end

	id: STRING_32 = "CA017"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.empty_if_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.empty_if_violation_1)
		end

feature {NONE} -- Rule Checking

	process_if (a_if: IF_AS)
			-- Checks if `a_if' has an empty compound.
		local
			l_violation: CA_RULE_VIOLATION
		do
			if a_if.compound = Void then
				create l_violation.make_with_rule (Current)
				l_violation.set_location (a_if.start_location)
				violations.extend (l_violation)
			end
		end

end
