note
	description: "[
			RULE #32: Very long routine implementation
	
			A routine implementation that contains
			many instructions should be shortened. It might contain
			copy-and-pasted code, or computations that are not part of what the
			feature should do, or computation that can be moved to separate routines.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_VERY_LONG_ROUTINE_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initialization for `Current'.
		do
			make_with_defaults
			default_severity_score := 70
			initialize_options (a_pref_manager)
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent pre_process_feature)
			a_checker.add_feature_post_action (agent post_process_feature)
			a_checker.add_do_pre_action (agent process_do)
			a_checker.add_once_pre_action (agent process_once)
			a_checker.add_if_pre_action (agent process_if)
			a_checker.add_loop_pre_action (agent process_loop)
			a_checker.add_inspect_pre_action (agent process_inspect)
		end

	initialize_options (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initializes the rule preferences.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			threshold := l_factory.new_integer_preference_value (a_pref_manager,
				preference_option_name_instruction_threshold, default_threshold)
			threshold.set_default_value (default_threshold.out)
			threshold.set_validation_agent (agent is_integer_string_within_bounds (?, 3, 1_000_000))
		end

	default_threshold: INTEGER = 70

feature -- Rule checking

	n_instructions: INTEGER
			-- # instructions in current routine.

	pre_process_feature (a_feature: FEATURE_AS)
			-- Resets the instruction counter.
		do
			n_instructions := 0
		end

	post_process_feature (a_feature: FEATURE_AS)
			-- Adds a rule violation if necessary.
		local
			l_threshold: INTEGER
			l_viol: CA_RULE_VIOLATION
		do
			l_threshold := threshold.value

			if n_instructions > l_threshold then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_feature.start_location)
				l_viol.long_description_info.extend (a_feature.feature_name.name_32)
				l_viol.long_description_info.extend (n_instructions)
				l_viol.long_description_info.extend (l_threshold)
				violations.extend (l_viol)
			end
		end

	process_do (a_do: DO_AS)
			-- Updates the # instructions.
		do
			if attached a_do.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
		end

	process_once (a_once: ONCE_AS)
			-- Updates the # instructions.
		do
			if attached a_once.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
		end

	process_if (a_if: IF_AS)
			-- Updates the # instructions.
		do
			if attached a_if.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
			if attached a_if.else_part as l_e then
				n_instructions := n_instructions + l_e.count
			end
		end

	process_elseif (a_elseif: ELSIF_AS)
			-- Updates the # instructions.
		do
			if attached a_elseif.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
		end

	process_loop (a_loop: LOOP_AS)
			-- Updates the # instructions.
		do
			if attached a_loop.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
		end

	process_inspect (a_inspect: INSPECT_AS)
			-- Updates the # instructions.
		do
			if attached a_inspect.else_part as l_e then
				n_instructions := n_instructions + l_e.count
			end
		end

	process_case (a_case: CASE_AS)
			-- Updates the # instructions.
		do
			if attached a_case.compound as l_c then
				n_instructions := n_instructions + l_c.count
			end
		end

feature -- Properties

	name: STRING = "long_feature"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.very_long_routine_title
		end

	id: STRING_32 = "CA032"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.very_long_routine_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		local
			l_info: LINKED_LIST [ANY]
		do
			l_info := a_violation.long_description_info
			a_formatter.add (ca_messages.very_long_routine_violation_1)
			if attached {READABLE_STRING_GENERAL} l_info.first as l_f then
				a_formatter.add_feature_name (l_f, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.very_long_routine_violation_2)
			if attached {INTEGER} l_info.at (2) as l_n then
				a_formatter.add_int (l_n)
			end
			a_formatter.add (ca_messages.very_long_routine_violation_3)
			if attached {INTEGER} l_info.at (3) as l_t then
				a_formatter.add_int (l_t)
			end
			a_formatter.add (ca_messages.very_long_routine_violation_4)
		end

feature {NONE} -- Preferences


	preference_option_name_instruction_threshold: STRING
			-- A name of an instruction count threshold option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_instruction_threshold)
		end

	option_name_instruction_threshold: STRING = "maximum_instruction_count"
			-- A name of a threshold option.

	threshold: INTEGER_PREFERENCE

end
