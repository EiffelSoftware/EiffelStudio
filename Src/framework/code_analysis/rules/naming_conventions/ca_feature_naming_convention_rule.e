note
	description: "[
		RULE #64: Feature naming convention violated
		
		Feature names should respect the Eiffel naming convention for features
		(all lowercase, no trailing or two consecutive underscores).
	]"
	author: "Paolo Antonucci"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_FEATURE_NAMING_CONVENTION_RULE

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
			a_checker.add_feature_pre_action (agent process_feature)
		end

feature {NONE} -- Rule checking

	process_feature (a_feature_as: FEATURE_AS)
			-- Process `a_feature_as'.
		local
			l_name: READABLE_STRING_32
			l_viol: CA_RULE_VIOLATION
		do
			l_name := a_feature_as.feature_name.text_32 (current_context.matchlist)
			if not is_valid_feature_name (l_name) then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_feature_as.start_location)
				l_viol.long_description_info.extend (l_name)
				violations.extend (l_viol)
			end
		end

	is_valid_feature_name (a_name: READABLE_STRING_32): BOOLEAN
			-- Does `a_name' respect the naming conventions for features?
		do
				-- Sample violations:
				-- my_feature_, my__feature, _my_feature, MY_FEATURE, my_FEATURE
			Result := not a_name.ends_with ("_") and not a_name.has_substring ("__") and (a_name.as_lower ~ a_name)
		end

feature -- Properties

	name: STRING = "feature_name"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.feature_naming_convention_title
		end

	id: STRING_32 = "CA064"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.feature_naming_convention_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (ca_messages.feature_naming_convention_violation_1)
			check
				attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first
			end
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature_name then
				a_formatter.add (l_feature_name)
			end
			a_formatter.add (ca_messages.feature_naming_convention_violation_2)
		end

end
