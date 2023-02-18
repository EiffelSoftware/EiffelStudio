note
	description: "[
			RULE #62: Very long identifier
	
			A name of a feature, an argument, or a
			local variable that is very long is bad for code readability.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_VERY_LONG_IDENTIFIER_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initialization for `Current'.
		do
			make_with_defaults
			is_enabled_by_default := False
			default_severity_score := 40
			severity := severity_hint
			initialize_options (a_pref_manager)
		end

	initialize_options (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initializes rule preferences.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory

			max_feature_name_length := l_factory.new_integer_preference_value (a_pref_manager,
				full_preference_name (option_name_feature_name_threshold), default_max_feature_name_length)
			max_feature_name_length.set_default_value (default_max_feature_name_length.out)
			max_feature_name_length.set_validation_agent (agent is_integer_string_within_bounds (?, 9, 1_000_000))

			max_argument_name_length := l_factory.new_integer_preference_value (a_pref_manager,
				full_preference_name (option_name_argument_name_threshold), default_max_argument_name_length)
			max_argument_name_length.set_default_value (default_max_argument_name_length.out)
			max_argument_name_length.set_validation_agent (agent is_integer_string_within_bounds (?, 9, 1_000_000))

			max_local_name_length := l_factory.new_integer_preference_value (a_pref_manager,
				full_preference_name (option_name_local_name_threshold), default_max_local_name_length)
			max_local_name_length.set_default_value (default_max_local_name_length.out)
			max_local_name_length.set_validation_agent (agent is_integer_string_within_bounds (?, 9, 1_000_000))
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_routine_pre_action (agent process_routine)
			a_checker.add_body_pre_action (agent process_body)
			a_checker.add_feature_pre_action (agent process_feature)
		end

feature {NONE} -- Rule checking

	process_routine (a_routine: ROUTINE_AS)
			-- Checks if locals of `a_routine' violate this rule.
		local
			j, l_max, l_count: INTEGER
			l_name: STRING
			l_viol: CA_RULE_VIOLATION
		do
			if a_routine.locals /= Void then
				l_max := max_local_name_length.value

				across a_routine.locals as ic loop
					from
						j := 1
					until
						j > ic.id_list.count
					loop
						l_name := ic.item_name (j)
						l_count := l_name.count
						if l_count > l_max and then is_no_counter (l_name) then
							create l_viol.make_with_rule (Current)
							l_viol.set_location (ic.start_location)
							l_viol.long_description_info.extend (l_name)
							l_viol.long_description_info.extend (l_max)
							violations.extend (l_viol)
						end
						j := j + 1
					end
				end
			end
		end

	process_body (a_body: BODY_AS)
			-- Checks if arguments of `a_body' violate this rule.
		local
			j, l_max, l_count: INTEGER
			l_name: STRING
			l_viol: CA_RULE_VIOLATION
		do
			if a_body.arguments /= Void then
				l_max := max_argument_name_length.value

				across a_body.arguments as ic loop
					from
						j := 1
					until
						j > ic.id_list.count
					loop
						l_name := ic.item_name (j)
						l_count := l_name.count
						if l_count > l_max and then is_no_counter (l_name) then
							create l_viol.make_with_rule (Current)
							l_viol.set_location (ic.start_location)
							l_viol.long_description_info.extend (l_name)
							l_viol.long_description_info.extend (l_max)
							violations.extend (l_viol)
						end
						j := j + 1
					end
				end
			end
		end

	process_feature (a_feature: FEATURE_AS)
			-- Checks if `a_feature' violates this rule.
		local
			l_max: INTEGER
			l_name: STRING
			l_viol: CA_RULE_VIOLATION
		do
			l_max := max_feature_name_length.value
			l_name := a_feature.feature_name.name_8

			if l_name.count > l_max then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_feature.start_location)
				l_viol.long_description_info.extend (l_name)
				l_viol.long_description_info.extend (l_max)
				violations.extend (l_viol)
			end
		end

	is_no_counter (a_id: attached STRING): BOOLEAN
			-- Is `a_id' not a commonly used counter variable?
		do
			Result := not (a_id.count = 1 and then a_id.is_equal ("i") or a_id.is_equal ("j") or a_id.is_equal ("k") or a_id.is_equal ("n"))
		end

feature -- Options

	max_feature_name_length,
	max_argument_name_length,
	max_local_name_length: INTEGER_PREFERENCE

	default_max_feature_name_length: INTEGER = 30
	default_max_argument_name_length: INTEGER = 20
	default_max_local_name_length: INTEGER = 20

feature {NONE} -- Preferences

	option_name_feature_name_threshold: STRING = "maximum_feature_name_length"
			-- A name of a feature name length threshold option.

	option_name_argument_name_threshold: STRING = "maximum_argument_name_length"
			-- A name of an argument name length threshold option.

	option_name_local_name_threshold: STRING = "maximum_local_name_length"
			-- A name of a local name length threshold option.

feature -- Properties

	name: STRING = "long_identifier"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.very_long_identifier_title
		end

	id: STRING_32 = "CA062"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.very_long_identifier_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
		do
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_name then
				a_formatter.add (ca_messages.very_long_identifier_violation_1)
				a_formatter.add_local (l_name)
				a_formatter.add (ca_messages.very_long_identifier_violation_2)
				a_formatter.add_int (l_name.count)
			end
			a_formatter.add (ca_messages.very_long_identifier_violation_3)
			if attached {INTEGER} a_violation.long_description_info.at (2) as l_max then
				a_formatter.add_int (l_max)
			end
			a_formatter.add (".")
		end

end
