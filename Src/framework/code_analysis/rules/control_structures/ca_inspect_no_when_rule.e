note
	description: "[
					RULE #60: Inspect instruction has no 'when' branch.
		
					An Inspect instruction that has no 'when' branch must be avoided.
					If there is an 'else' branch then these instructions will always be executed:
					thus the Multi-branch instruction is not needed.
					If there is no branch at all then an exception is always raised, 
					for there is no matching branch for any value of the inspected variable.
	]"
	author: "Paolo Antonucci"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_INSPECT_NO_WHEN_RULE

inherit

	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
		end

feature {NONE} -- Activation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_inspect_pre_action (agent process_inspect)
		end

feature {NONE} -- Rule checking

	process_inspect (a_inspect_as: INSPECT_AS)
		local
			l_viol: CA_RULE_VIOLATION
		do
				-- Sample violations:
				--
				--	inspect my_int
				--	end
				--
				--	inspect my_int
				--  else
				--		io.put_string ("Do something")
				--	end
				--

			if a_inspect_as.case_list = Void or else a_inspect_as.case_list.is_empty then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_inspect_as.start_location)
				l_viol.long_description_info.extend (attached a_inspect_as.else_keyword (current_context.matchlist))
				violations.extend (l_viol)
			end
		end

feature -- Properties

	name: STRING = "no_when_part"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.inspect_no_when_title
		end

	id: STRING_32 = "CA060"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.inspect_no_when_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			check
				attached {BOOLEAN} a_violation.long_description_info.first
			end
			if attached {BOOLEAN} a_violation.long_description_info.first as l_has_else then
				if l_has_else then
					a_formatter.add (ca_messages.inspect_no_when_with_else_violation)
				else
					a_formatter.add (ca_messages.inspect_no_when_no_else_violation)
				end
			end
		end

end
