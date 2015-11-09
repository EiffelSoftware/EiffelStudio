note
	description: "[
			RULE #33: Very big class
	
			A class declaration that is very large
			(that is not including inherited features) may be problematic. The
			class might provide features it is not responsible for.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_VERY_BIG_CLASS_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initialization for `Current'.
		do
			make_with_defaults
			default_severity_score := 60
			initialize_options (a_pref_manager)
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_class_pre_action (agent pre_process_class)
			a_checker.add_class_post_action (agent post_process_class)
			a_checker.add_do_pre_action (agent process_do)
			a_checker.add_once_pre_action (agent process_once)
			a_checker.add_if_pre_action (agent process_if)
			a_checker.add_loop_pre_action (agent process_loop)
			a_checker.add_inspect_pre_action (agent process_inspect)
		end

	initialize_options (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initializes rule preferences.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory

			features_threshold := l_factory.new_integer_preference_value (a_pref_manager,
				full_preference_name (option_name_features_threshold), default_features_threshold)
			features_threshold.set_default_value (default_features_threshold.out)
			features_threshold.set_validation_agent (agent is_integer_string_within_bounds (?, 3, 1_000_000))

			instructions_threshold := l_factory.new_integer_preference_value (a_pref_manager,
				full_preference_name (option_name_instructions_threshold), default_instructions_threshold)
			instructions_threshold.set_default_value (default_instructions_threshold.out)
			instructions_threshold.set_validation_agent (agent is_integer_string_within_bounds (?, 3, 1_000_000))
		end

	default_features_threshold: INTEGER = 60

	default_instructions_threshold: INTEGER = 300

feature -- Rule checking

	n_features, n_instructions: INTEGER
			-- Counts the number of features and instructions.

	pre_process_class (a_class: CLASS_AS)
			-- Resets the counters.
		do
			n_features := 0
			n_instructions := 0
		end

	post_process_class (a_class: CLASS_AS)
			-- Adds violations if the class violates the rule.
		local
			l_features_threshold, l_instructions_threshold: INTEGER
			l_viol: CA_RULE_VIOLATION
		do
			l_features_threshold := features_threshold.value
			l_instructions_threshold := instructions_threshold.value

			if n_instructions > l_instructions_threshold or n_features > l_features_threshold then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_class.start_location)
				l_viol.long_description_info.extend (n_features)
				l_viol.long_description_info.extend (n_instructions)
				l_viol.long_description_info.extend (l_features_threshold)
				l_viol.long_description_info.extend (l_instructions_threshold)
				violations.extend (l_viol)
			end
		end

	process_do (a_do: DO_AS)
			-- Updates the number of features and the number of instructions.
		do
			n_features := n_features + 1

			if attached a_do.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
		end

	process_once (a_once: ONCE_AS)
			-- Updates the number of features and the number of instructions.
		do
			n_features := n_features + 1

			if attached a_once.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
		end

	process_if (a_if: IF_AS)
			-- Updates the number of instructions.
		do
			if attached a_if.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
			if attached a_if.else_part as l_e then
				n_instructions := n_instructions + l_e.count
			end
		end

	process_elseif (a_elseif: ELSIF_AS)
			-- Updates the number of instructions.
		do
			if attached a_elseif.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
		end

	process_loop (a_loop: LOOP_AS)
			-- Updates the number of instructions.
		do
			if attached a_loop.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
		end

	process_inspect (a_inspect: INSPECT_AS)
			-- Updates the number of instructions.
		do
			if attached a_inspect.else_part as l_e then
				n_instructions := n_instructions + l_e.count
			end
		end

	process_case (a_case: CASE_AS)
			-- Updates the number of instructions.
		do
			if attached a_case.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
		end

feature -- Properties

	name: STRING = "long_class"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.very_big_class_title
		end

	id: STRING_32 = "CA033"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.very_big_class_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		local
			l_info: LINKED_LIST [ANY]
		do
			l_info := a_violation.long_description_info

			a_formatter.add (ca_messages.very_big_class_violation_1)
			a_formatter.add_class (a_violation.affected_class.original_class)
			a_formatter.add (ca_messages.very_big_class_violation_2)
			if attached {INTEGER} l_info.first as l_n_features then
				a_formatter.add_int (l_n_features)
			end
			a_formatter.add (ca_messages.very_big_class_violation_3)
			if attached {INTEGER} l_info.at (2) as l_n_instructions then
				a_formatter.add_int (l_n_instructions)
			end
			a_formatter.add (ca_messages.very_big_class_violation_4)
			if attached {INTEGER} l_info.at (3) as l_features_threshold then
				a_formatter.add_int (l_features_threshold)
			end
			a_formatter.add (ca_messages.very_big_class_violation_5)
			if attached {INTEGER} l_info.at (4) as l_instructions_threshold then
				a_formatter.add_int (l_instructions_threshold)
			end
			a_formatter.add (ca_messages.very_big_class_violation_6)
		end

feature {NONE} -- Preferences

	option_name_features_threshold: STRING = "maximum_feature_count"
			-- A name of a features threshold option.

	option_name_instructions_threshold: STRING = "maximum_instruction_count"
			-- A name of an instructions threshold option.

feature {NONE} -- Options

	features_threshold, instructions_threshold: INTEGER_PREFERENCE
			-- Thresholds where the rule will start triggering.

end
