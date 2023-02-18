note
	description: "[
			RULE #44: Many instructions in an Inspect case
	
			A case of an inspect construct
			containing many instructions decreases code readability. The number
			of instructions should be lowered, for example by moving functionality
			to separate features.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_INSPECT_INSTRUCTIONS_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initialization using preference manager `a_pref_manager'.
		do
			make_with_defaults
			severity := severity_hint
			initialize_options (a_pref_manager)
		end

	initialize_options (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initializes the options for this rule.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			max_instructions := l_factory.new_integer_preference_value (a_pref_manager,
				preference_option_name_instruction_threshold, default_max)
			max_instructions.set_default_value (default_max.out)
			max_instructions.set_validation_agent (agent is_integer_string_within_bounds (?, 1, 1_000_000))
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_inspect_pre_action (agent process_inspect)
		end

feature {NONE} -- Rule Checking

	process_inspect (a_inspect: INSPECT_AS)
			-- Checks `a_inspect' for rule violations.
		local
			l_count, l_max: INTEGER
			l_viol: CA_RULE_VIOLATION
		do
			if a_inspect.case_list /= Void then
				across a_inspect.case_list as l_cases loop
					if attached l_cases.compound as l_comp then
						l_count := l_comp.count
						l_max := max_instructions.value
						if l_count > l_max then
							create l_viol.make_with_rule (Current)
							l_viol.set_location (l_cases.start_location)
							l_viol.long_description_info.extend (l_count)
							l_viol.long_description_info.extend (l_max)
							violations.extend (l_viol)
						end
					end
				end
			end
		end

feature {NONE} -- Preferences

	preference_option_name_instruction_threshold: STRING
			-- A name of an instruction count threshold option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_instruction_threshold)
		end

	option_name_instruction_threshold: STRING = "maximum_instruction_count"
			-- A name of an instruction threshold option.

	max_instructions: INTEGER_PREFERENCE

	default_max: INTEGER = 8

feature -- Properties

	name: STRING = "long_multi_branch"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.inspect_instructions_title
		end

	id: STRING_32 = "CA044"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.inspect_instructions_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.inspect_instructions_violation_1)
			if attached {INTEGER} a_violation.long_description_info.first as l_count then
				a_formatter.add_int (l_count)
			end
			a_formatter.add (ca_messages.inspect_instructions_violation_2)
			if attached {INTEGER} a_violation.long_description_info.at (2) as l_max then
				a_formatter.add_int (l_max)
			end
			a_formatter.add (".")
		end

end
