note
	description: "Manages the settings for Code Analysis."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_SETTINGS

inherit
	CA_SHARED_NAMES

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the settings manager.
		do
			initialize_preferences
		end

	initialize_preferences
			-- Initialize preference values.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
			l_manager: PREFERENCE_MANAGER
		do
			create l_factory
			create preferences.make
			l_manager := preferences.new_manager (code_analysis_namespace)

			are_errors_enabled := l_factory.new_boolean_preference_value (l_manager,
				ca_names.general_category + "." + ca_names.are_errors_enabled, True)
			are_errors_enabled.set_default_value ("True")
			are_warnings_enabled := l_factory.new_boolean_preference_value (l_manager,
				ca_names.general_category + "." + ca_names.are_warnings_enabled, True)
			are_warnings_enabled.set_default_value ("True")
			are_suggestions_enabled := l_factory.new_boolean_preference_value (l_manager,
				ca_names.general_category + "." + ca_names.are_suggestions_enabled, True)
			are_suggestions_enabled.set_default_value ("True")
			are_hints_enabled := l_factory.new_boolean_preference_value (l_manager,
				ca_names.general_category + "." + ca_names.are_hints_enabled, True)
			are_hints_enabled.set_default_value ("True")
		end

feature {CA_CODE_ANALYZER} -- Initialization

	initialize_rule_settings (a_rules: attached ITERABLE [attached CA_RULE])
			-- Initializes the preferences for all rules in `a_rules' including
			-- "enabled" and "severity".
		local
			l_factory: BASIC_PREFERENCE_FACTORY
			l_manager: PREFERENCE_MANAGER
			l_enabled: BOOLEAN_PREFERENCE
			l_score: INTEGER_PREFERENCE
		do
			create l_factory
			l_manager := preferences.manager (code_analysis_namespace)

			across a_rules as l_rules loop
				l_enabled := l_factory.new_boolean_preference_value (l_manager,
					ca_names.rules_category + "." + l_rules.item.title + "." + ca_names.enable_rule,
					l_rules.item.is_enabled_by_default)
				l_enabled.set_default_value (l_rules.item.is_enabled_by_default.out)
				l_enabled.set_description (l_rules.item.description)
				l_rules.item.set_is_enabled_preference (l_enabled)

				l_score := l_factory.new_integer_preference_value (l_manager,
					ca_names.rules_category + "." + l_rules.item.title + "." + ca_names.severity_score,
					l_rules.item.default_severity_score)
				l_score.set_default_value (l_rules.item.default_severity_score.out)
				l_score.set_validation_agent (agent validate_severity_score)
				l_score.set_description (ca_messages.severity_score_description)
				l_rules.item.set_severity_score_preference (l_score)
			end
		end

feature -- Settings

	preferences: PREFERENCES
			-- The preferences specific to Code Analysis.

	preference_manager: detachable PREFERENCE_MANAGER
			-- The preference manager.
		do
			Result := preferences.manager (code_analysis_namespace)
		end

	are_errors_enabled,
	are_warnings_enabled,
	are_suggestions_enabled,
	are_hints_enabled: BOOLEAN_PREFERENCE
			-- Are certain rule categories enabled?

feature {NONE} -- Implementation

	code_analysis_namespace: STRING = "tools.code_analysis"
			-- The namespace for the Code Analysis preferences.

	validate_severity_score (a_value: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_value' a valid severity score?
		local
			int: INTEGER
		do
			int := a_value.to_integer
			if int >= 0 and int <= 100 then
				Result := True
			end
		end

end
