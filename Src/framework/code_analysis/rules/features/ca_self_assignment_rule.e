note
	description: "[
			RULE #1: Self-assignment
			
			Assigning a variable to itself is a meaningless instruction
			due to a typing error. Most probably, one of the two
			variable names was misspelled. One example among many
			others: the programmer wanted to assign a local variable
			to a class attribute and used one of the variable names twice.
		]"
	author: "Stefan Zurfluh, Eiffel Software"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_SELF_ASSIGNMENT_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
			default_severity_score := 70
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_assign_pre_action (agent pre_assign)
		end

feature -- Properties

	name: STRING = "self_assignment"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.self_assignment_title
		end

	id: STRING_32 = "CA001"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.self_assignment_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.self_assignment_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_name then
				a_formatter.add_local (l_name)
			end
			a_formatter.add (ca_messages.self_assignment_violation_2)
		end

feature {NONE} -- Checking the rule

	pre_assign (a_assign_as: ASSIGN_AS)
			-- Checks `a_assign_as' for rule violations.
		local
			l_violation: CA_RULE_VIOLATION
		do
			if
				attached {EXPR_CALL_AS} a_assign_as.source as l_source
				and then attached {ACCESS_ID_AS} l_source.call as l_src_access_id
				and then attached {ACCESS_ID_AS} a_assign_as.target as l_tar
				and then l_tar.feature_name.is_equal (l_src_access_id.feature_name)
			then
				create l_violation.make_with_rule (Current)
				l_violation.set_location (a_assign_as.start_location)
				l_violation.long_description_info.extend (l_src_access_id.feature_name.name_32)
				violations.extend (l_violation)
			end
		end

end
