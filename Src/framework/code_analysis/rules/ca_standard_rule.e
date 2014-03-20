note
	description: "A rule that looks at some AST nodes. The rule will be checked using {CA_ALL_RULES_CHECKER}."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_STANDARD_RULE

inherit
	CA_RULE

feature -- Activation

	frozen prepare_checking (a_checker: attached CA_ALL_RULES_CHECKER)
			-- Prepares this rule for being checked using `a_checker'.
		do
			violations.wipe_out
			register_actions (a_checker)
		end

feature {NONE} -- Implementation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
			-- Registers the agents that will be called during the AST visit with
			-- `a_checker'.
		deferred
		end

invariant
	title_set: title.count > 3
end
