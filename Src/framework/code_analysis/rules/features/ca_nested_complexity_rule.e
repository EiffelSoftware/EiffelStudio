note
	description: "[
			RULE #10: High complexity of nested branches and loops
	
			With the number of nested braches or loops
			increasing the code get less readable. If the branch and loop complexity
			is too high then the code should be refactored in such a way as to reduce
			its complexity.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_NESTED_COMPLEXITY_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initialization.
		do
			make_with_defaults
			default_severity_score := 60
			initialize_options (a_pref_manager)
		end

	initialize_options (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initializes the rule preferences.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			threshold := l_factory.new_integer_preference_value (a_pref_manager,
				preference_option_name_threshold, 5)
			threshold.set_default_value ("5")
			threshold.set_validation_agent (agent is_integer_string_within_bounds (?, 2, 100))
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent pre_process_feature)
			a_checker.add_feature_post_action (agent post_process_feature)
			a_checker.add_if_pre_action (agent pre_process_if)
			a_checker.add_if_post_action (agent post_process_if)
			a_checker.add_loop_pre_action (agent pre_process_loop)
			a_checker.add_loop_post_action (agent post_process_loop)
		end

feature -- Properties

	name: STRING = "nested_complexity"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.nested_complexity_title
		end

	id: STRING_32 = "CA010"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.nested_complexity_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		local
			l_info: LINKED_LIST[ANY]
		do
			l_info := a_violation.long_description_info
			a_formatter.add (ca_messages.nested_complexity_violation_1)
			if attached {READABLE_STRING_GENERAL} l_info.first as l_feature_name then
				a_formatter.add_feature_name (l_feature_name, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.nested_complexity_violation_2)
			if attached {INTEGER} l_info.at (2) as l_max then
				a_formatter.add_int (l_max)
			end
			a_formatter.add (ca_messages.nested_complexity_violation_3)
			if attached {INTEGER} l_info.at (3) as l_option then
				a_formatter.add_int (l_option)
			end
			a_formatter.add (".")
		end

feature {NONE} -- Options

	preference_option_name_threshold: STRING
			-- A name of a threshold option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_threshold)
		end

	option_name_threshold: STRING = "threshold"
			-- A name of a threshold option.

	threshold: INTEGER_PREFERENCE
			-- Minimum nested branches and loops threshold.

feature {NONE} -- AST Visits

	current_feature: detachable FEATURE_AS
			-- Currently checked feature.

	current_depth, maximum_depth: INTEGER
			-- Depths in current feature.

	current_violation_exists: BOOLEAN
			-- Is there a rule violation in the current feature?

	pre_process_feature (a_feature: FEATURE_AS)
			-- Resetting variables.
		do
			current_feature := a_feature
			current_depth := 0
			maximum_depth := 0
			current_violation_exists := False
		end

	post_process_feature (a_feature: FEATURE_AS)
			-- Add rule violation if it exists for `a_feature'.
		local
			l_violation: CA_RULE_VIOLATION
		do
			if current_violation_exists then
				create l_violation.make_with_rule (Current)
				l_violation.set_location (current_feature.start_location)
				l_violation.long_description_info.extend (current_feature.feature_name.name_32)
				l_violation.long_description_info.extend (maximum_depth)
				l_violation.long_description_info.extend (threshold.value)
				violations.extend (l_violation)
			end
		end

	pre_process_if (a_if: IF_AS)
			-- Increment depth.
		do
			current_depth := current_depth + 1
			evaluate_depth
		end

	post_process_if (a_if: IF_AS)
			-- Decrement depth.
		do
			current_depth := current_depth - 1
		end

	pre_process_loop (a_loop: LOOP_AS)
			-- Increment depth.
		do
			current_depth := current_depth + 1
			evaluate_depth
		end

	post_process_loop (a_loop: LOOP_AS)
			-- Decrement depth.
		do
			current_depth := current_depth - 1
		end

	evaluate_depth
			-- Checks if current depth is too high.
		do
			if current_depth > maximum_depth then
				maximum_depth := current_depth
			end

			if not current_violation_exists and then current_depth > threshold.value then
				current_violation_exists := True
			end
		end

end
