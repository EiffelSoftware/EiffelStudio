note
	description: "A rule that will be used by the Code Analyzer."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_RULE

inherit
	HASHABLE

	CA_SHARED_NAMES

	SHARED_SERVER

feature {NONE} -- Initialization

	make_with_defaults
		do
			is_enabled_by_default := True
			is_system_wide := False
			checks_library_classes := True
			checks_nonlibrary_classes := True
			default_severity_score := 50
			create {CA_WARNING} severity
			create violations.make
		end

feature -- Basic properties, usually fix

	name: STRING
			-- A locale-independent name used to store the rule settings.
		deferred
		ensure
			attached_result: attached Result
		end

	title: STRING_32
			-- A short title.
		deferred
		ensure
			valid_result: Result /= Void
		end

	id: STRING_32
			-- A preferrably unique identifier for the rule. It should start with "CA".
		deferred
		ensure
			valid_result: Result /= Void
		end

	description: STRING_32
			-- A description of what this rule checks.
		deferred
		ensure
			valid_result: Result /= Void
		end

	is_system_wide: BOOLEAN
			-- Is the rule only checked when a system wide analysis is performed?

	checks_library_classes: BOOLEAN
			-- Does this rule check library classes?

	checks_nonlibrary_classes: BOOLEAN
			-- Does this rule check non-library classes?

	is_enabled_by_default: BOOLEAN
			-- Is this rule enabled by default?

	default_severity_score: INTEGER
			-- The default severity score.

feature {CA_RULE_VIOLATION} -- formatted rule checking output

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Formats a description of a violation of this rule, `a_violation', using `a_formatter'.
		require
			violation_added: violations.has (a_violation)
			violation_correct: a_violation.rule = Current
		deferred
		end

feature -- Properties the user can change

	is_enabled: BOOLEAN_PREFERENCE
			-- Is the rule enabled?

	severity: CA_RULE_SEVERITY
			-- The severity of violations of this rule.

	severity_score: INTEGER_PREFERENCE
			-- The severity score.

	set_severity (a_severity: attached CA_RULE_SEVERITY)
			-- Sets the severity to `a_severity'.
		do
			severity := a_severity
		end

	set_is_enabled_preference (a_pref: attached BOOLEAN_PREFERENCE)
			-- Sets the "enabled" preference to `a_pref'.
		do
			is_enabled := a_pref
		end

	set_severity_score_preference (a_pref: attached INTEGER_PREFERENCE)
			-- Sets the "severity score" preference to `a_pref'.
		do
			severity_score := a_pref
		end

feature -- Rule checking

	set_current_context (a_context: attached CA_ANALYSIS_CONTEXT)
			-- Sets the current rule checking context to `a_context'.
		do
			current_context := a_context
		ensure
			current_context = a_context
		end

feature {CA_RULE_VIOLATION} -- Rule checking

	current_context: detachable CA_ANALYSIS_CONTEXT
			-- The current rule checking context.

feature -- Results

	frozen clear_violations
			-- Clears all stored rule violations.
		do
			violations.wipe_out
		end

	violations: LINKED_LIST [CA_RULE_VIOLATION]
			-- The violations this rule has found.

feature -- Hash Code

	hash_code: INTEGER
		do
				-- Delegate it.
			Result := id.hash_code
		end

feature {CA_CODE_ANALYZER} -- Preferences

	full_preference_name (a_preference_name: STRING): STRING
		do
			Result := preference_namespace + a_preference_name
		end

feature -- Preferences

	option_name_enable: STRING = "enable"
			-- A name of an enable option.

	preference_option_name_enable: STRING
			-- A name of an enable option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_enable)
		end

	preference_option_name_severity: STRING
			-- A name of a severity option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_severity)
		end

feature {NONE} -- Preferences

	frozen preference_namespace: STRING
			-- Every rule has a separate sub namespace so that in the preferences dialog,
			-- the rule will have its own folder.
		do
			Result := "rule." + name + "."
		end

	option_name_severity: STRING = "severity"
			-- A name of a severity option.

	frozen is_integer_string_within_bounds (a_value: attached READABLE_STRING_GENERAL; a_lower, a_upper: INTEGER): BOOLEAN
			-- Is the integer string `a_value' within the interval [`a_lower', `a_upper']?
		require
			is_integer: a_value.is_integer
		local
			int: INTEGER
		do
			int := a_value.to_integer
			if int >= a_lower and int <= a_upper then
				Result := True
			end
		end

invariant
	checks_some_classes: checks_library_classes or checks_nonlibrary_classes
	valid_severity_score: severity_score.value >= 0 and severity_score.value <= 100
end
