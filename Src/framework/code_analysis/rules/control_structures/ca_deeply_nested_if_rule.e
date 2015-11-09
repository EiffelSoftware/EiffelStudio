note
	description: "[
			RULE #43: Deeply nested if instructions.
	
			Deeply nested If instructions make the code
			less readable. They should be avoided; one can refactor the affected
			code by changing the decision logic or by introducing separate routines.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_DEEPLY_NESTED_IF_RULE

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
			initialize_preferences (a_pref_manager)
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_if_pre_action (agent pre_process_if)
			a_checker.add_if_post_action (agent post_process_if)
		end

	initialize_preferences (a_pref_manager: attached PREFERENCE_MANAGER)
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			depth_threshold := l_factory.new_integer_preference_value (a_pref_manager,
				preference_option_name_depth_threshold, default_depth_threshold)
			depth_threshold.set_default_value (default_depth_threshold.out)
			depth_threshold.set_validation_agent (agent is_integer_string_within_bounds (?, 2, 20))
		end

feature {NONE} -- Rule checking

	process_feature (a_feature: FEATURE_AS)
			-- Resets the if depth.
		do
			current_depth := 0
		end

	current_depth: INTEGER
			-- The current if depth.

	pre_process_if (a_if: IF_AS)
			-- Increase the if depth if the necessary conditions are satisfied.
		do
			if (a_if.else_part = Void) and (a_if.elsif_list = Void) then
					-- Only count pure if's.
				current_depth := current_depth + 1
			end
		end

	post_process_if (a_if: IF_AS)
			-- If the depth is high enough then create a rule violation.
		local
			l_viol: CA_RULE_VIOLATION
		do
			if (a_if.else_part = Void) and (a_if.elsif_list = Void) then
					-- Only look at pure if's.
				if current_depth > depth_threshold.value then
					create l_viol.make_with_rule (Current)
					l_viol.set_location (a_if.start_location)
					l_viol.long_description_info.extend (depth_threshold.value)
					violations.extend (l_viol)
				end
				current_depth := current_depth - 1
			end
		end

feature {NONE} -- Preferences

	preference_option_name_depth_threshold: STRING
			-- A name of a depth threshold option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_depth_threshold)
		end

	option_name_depth_threshold: STRING = "maximum_depth"
			-- A name of a threshold option.

	default_depth_threshold: INTEGER = 3
			-- The default depth necessary that will trigger a rule violation.

	depth_threshold: INTEGER_PREFERENCE
			-- The depth necessary that will trigger a rule violation.

feature -- Properties

	name: STRING = "deeply_nested_conditionals"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.deeply_nested_if_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.deeply_nested_if_description
		end

	id: STRING_32 = "CA043"
			-- <Precursor>

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Generates a formatted rule violation description for `a_formatter' based on `a_violation'.
		do
			a_formatter.add (ca_messages.deeply_nested_if_violation_1)

			if attached {INTEGER} a_violation.long_description_info.first as l_threshold then
				a_formatter.add_int (l_threshold - 1)
			end

			a_formatter.add (ca_messages.deeply_nested_if_violation_2)
		end

end
