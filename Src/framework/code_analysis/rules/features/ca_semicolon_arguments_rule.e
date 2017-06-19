note
	description: "[
			RULE #25: Semicolon to separate arguments
	
			Routine arguments should be separated with
			semicolons. Although this is optional, it is bad style not to put semicolons.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_SEMICOLON_ARGUMENTS_RULE

inherit
	CA_STANDARD_RULE

	SHARED_SERVER

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

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_body_pre_action (agent process_body)
		end

feature -- Properties

	name: STRING = "missing_argument_semicolon"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.semicolon_arguments_title
		end

	id: STRING_32 = "CA025"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.semicolon_arguments_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.semicolon_arguments_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feat then
				a_formatter.add_feature_name (l_feat, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.semicolon_arguments_violation_2)
		end

feature {NONE} -- Checking the rule

	current_feature_name: STRING_32
			-- Name of currently checked feature.

	process_feature (a_feature: FEATURE_AS)
			-- Sets current feature name.
		do
			current_feature_name := a_feature.feature_name.name_32
		end

	process_body (a_body: BODY_AS)
			-- Checks `a_body' for rule violations.
		local
			l_n_semis: INTEGER
			l_viol: CA_RULE_VIOLATION
		do
			if current_context.matchlist /= Void and then attached a_body.arguments as l_a then
				l_n_semis := l_a.text_32 (current_context.matchlist).occurrences (';')
				if l_n_semis < l_a.count - 1 then
						-- At least one argument must have no semicolon separator.
					create l_viol.make_with_rule (Current)
					l_viol.set_location (l_a.start_location)
					l_viol.long_description_info.extend (current_feature_name)
					violations.extend (l_viol)
				end
			end
		end

end
