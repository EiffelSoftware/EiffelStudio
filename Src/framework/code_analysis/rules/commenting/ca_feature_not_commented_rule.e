note
	description: "[
			RULE #36: Feature not commented
	
			A feature should have a comment. Feature
			comments are particularly helpful for writing clients of this class. To
			the programmer, feature comments will appear as tooltip documentation.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_FEATURE_NOT_COMMENTED_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			is_enabled_by_default := False
			default_severity_score := 20
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent process_feature)
		end

feature {NONE} -- Rule checking

	process_feature (a_feature: FEATURE_AS)
			-- Checks if `a_feature' has a feature comment or not.
		local
			l_viol: CA_RULE_VIOLATION
		do
			if current_context.matchlist /= Void and then a_feature.comment (current_context.matchlist).count = 0 then
					-- The comments list is empty.
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_feature.start_location)
				l_viol.long_description_info.extend (a_feature.feature_name.name_32)
				violations.extend (l_viol)
			end
		end

feature -- Properties

	name: STRING = "missing_feature_comment"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.feature_not_commented_title
		end

	id: STRING_32 = "CA036"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.feature_not_commented_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.feature_not_commented_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature_name then
				a_formatter.add_feature_name (l_feature_name, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.feature_not_commented_violation_2)
		end

end
