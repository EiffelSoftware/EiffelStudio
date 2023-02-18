note
	description: "Manages the settings for Code Analysis."
	author: "Stefan Zurfluh, Eiffel Software", "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_SETTINGS

inherit
	CA_SHARED_NAMES

	EIFFEL_LAYOUT

	PREFERENCES_VERSIONS

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
			create preferences.make_with_defaults_and_location_and_version (
				<<preference_path.name>>, eiffel_layout.eiffel_preferences, version_2_0)
			l_manager := preferences.new_manager (code_analysis_namespace)

			is_error_enabled := l_factory.new_boolean_preference_value (l_manager, preference_name_error_enabled, True)
			is_warning_enabled := l_factory.new_boolean_preference_value (l_manager, preference_name_warning_enabled, True)
			is_hint_enabled := l_factory.new_boolean_preference_value (l_manager, preference_name_hint_enabled, True)
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
					l_rules.preference_option_name_enable,
					l_rules.is_enabled_by_default)
				l_enabled.set_default_value (l_rules.is_enabled_by_default.out)
				l_enabled.set_description (l_rules.description)
				l_rules.set_is_enabled_preference (l_enabled)

				l_score := l_factory.new_integer_preference_value (l_manager,
					l_rules.preference_option_name_severity,
					l_rules.default_severity_score)
				l_score.set_default_value (l_rules.default_severity_score.out)
				l_score.set_validation_agent (agent validate_severity_score)
				l_score.set_description (ca_messages.severity_score_description)
				l_rules.set_severity_score_preference (l_score)
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

	is_error_enabled,
	is_warning_enabled,
	is_hint_enabled: BOOLEAN_PREFERENCE
			-- Are certain rule categories enabled?

feature -- Preferences

	code_analysis_namespace: STRING = "tools.code_analysis"
			-- The namespace for the Code Analysis preferences.

feature {NONE} -- Implementation

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

feature {NONE} -- Preferences

	preference_name_prefix_general: STRING = "general."
			-- A prefix for preference names on a general category.

	preference_name_error_enabled: STRING
			-- Name of a preference that tells if errors are enabled.
		do
			Result := preference_name_prefix_general + "enable_errors"
		end

	preference_name_warning_enabled: STRING
			-- Name of a preference that tells if warnings are enabled.
		do
			Result := preference_name_prefix_general + "enable_warnings"
		end

	preference_name_hint_enabled: STRING
			-- Name of a preference that tells if hints are enabled.
		do
			Result := preference_name_prefix_general + "enable_hints"
		end

feature {NONE} -- Storage

	preference_path: PATH
			-- A path of the preferences.
		require
			is_valid_environment: eiffel_layout.is_valid_environment
		once
			Result := eiffel_layout.eifinit_path.extended ("code_analysis.xml")
			if attached eiffel_layout.user_priority_file_name (Result, True) as f then
				Result := f
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

end
