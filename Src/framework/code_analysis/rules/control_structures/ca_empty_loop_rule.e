note
	description: "[
			RULE #16: Empty Loop
	
			A loop with an empty body should be removed. In most of the cases the loop never exits.
		]"
	author: "Samuel Schmid"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EMPTY_LOOP_RULE

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
			a_checker.add_loop_pre_action (agent process_loop)
		end

feature -- Properties

	name: STRING = "empty_loop"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.empty_loop_title
		end

	id: STRING_32 = "CA016"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.empty_loop_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.empty_loop_violation)
		end

feature {NONE} -- Rule Checking

	process_loop (a_loop: LOOP_AS)
			-- Checks if `a_loop' has an empty compound.
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_EMPTY_LOOP_FIX
		do
			if not attached a_loop.compound then
				create l_violation.make_with_rule (Current)
				l_violation.set_location (a_loop.start_location)

				create l_fix.make_with_loop (current_context.checking_class, a_loop)
				l_violation.fixes.extend (l_fix)

				violations.extend (l_violation)
			end
		end

end
