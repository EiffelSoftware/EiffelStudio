note
	description: "[
			RULE #11: Many feature arguments
	
			A feature that has many arguments should be
			avoided since it makes the class interface complicated and it is not
			easy to use. The feature arguments may include options, which should be
			considered to be moved to separate features. Interfaces of features with
			a large number of arguments are complicated, in the sense for example
			that they are hard to remember for the programmer. Often many arguments
			are of the same type (such as INTEGER). So, in a call, the passed
			arguments are likely to get mixed up, too, without the compiler detecting
			it. Arguments where in most of the cases the same value is passed--the
			default value--are called options. As opposed to operands, which are
			necessary in each feature call, each option should be moved to a separate
			feature. The features for options can then be called before the operational
			feature call in order to set (or unset) certain options. If a feature for
			an option is not called then the class assumes the default value for this option.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_MANY_ARGUMENTS_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initialization for `Current'.
		do
			make_with_defaults
			initialize_options (a_pref_manager)
		end

	initialize_options (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initializes rule preferences.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			n_arguments_threshold := l_factory.new_integer_preference_value (a_pref_manager,
				preference_option_name_argument_threshold, 4)
			n_arguments_threshold.set_default_value ("4")
			n_arguments_threshold.set_validation_agent (agent is_integer_string_within_bounds (?, 2, 20))
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent process_feature)
		end

feature -- Properties

	name: STRING = "many_arguments"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.many_arguments_title
		end

	id: STRING_32 = "CA011"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.many_arguments_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		local
			l_infos: LINKED_LIST [ANY]
		do
			l_infos := a_violation.long_description_info

			a_formatter.add (ca_messages.many_arguments_violation_1)
			if attached {READABLE_STRING_GENERAL} l_infos.first as l_feature_name then
				a_formatter.add_feature_name (l_feature_name, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.many_arguments_violation_2)
			if attached {INTEGER} l_infos.at (2) as l_n then
				a_formatter.add_int (l_n)
			end
			a_formatter.add (ca_messages.many_arguments_violation_3)
			if attached {INTEGER} l_infos.at (3) as l_t then
				a_formatter.add_int (l_t)
			end
			a_formatter.add (".")
		end

feature {NONE} -- Preferences

	preference_option_name_argument_threshold: STRING
			-- A name of an argument threshold option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_argument_threshold)
		end

	option_name_argument_threshold: STRING = "maximum_argument_count"
			-- A name of a threshold option.

	n_arguments_threshold : INTEGER_PREFERENCE
			-- The minimum number of arguments a feature body must have in order to
			-- trigger a rule violation.

feature -- Visitor

	process_feature (a_feature: FEATURE_AS)
			-- Checks `a_feature' for rule violations.
		local
			n: INTEGER
			l_viol: CA_RULE_VIOLATION
		do
			if attached a_feature.body.arguments as l_args_1 then
				n := 0
				across l_args_1 as l_args_2 loop
					n := n + l_args_2.id_list.count
				end

				if n > n_arguments_threshold.value then
					create l_viol.make_with_rule (Current)
					l_viol.set_location (a_feature.start_location)
					l_viol.long_description_info.extend (a_feature.feature_name.name_32)
					l_viol.long_description_info.extend (n)
					l_viol.long_description_info.extend (n_arguments_threshold.value)
					violations.extend (l_viol)
				end
			end
		end

end
