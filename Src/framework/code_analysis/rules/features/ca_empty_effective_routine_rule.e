note
	description: "[
			RULE #53: Empty routine in deferred class.
	
			A routine with an empty body in a deferred
			class should be considered to be declared as deferred. That way it will
			not be forgotten to implement the routine in the descendant classes and
			errors can be avoided.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EMPTY_EFFECTIVE_ROUTINE_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			is_enabled_by_default := False
			severity := severity_hint
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_do_pre_action (agent process_do)
		end

feature {NONE} -- Rule checking

	process_feature (a_feature: FEATURE_AS)
			-- Sets the currently processed feature.
		do
			current_feature := a_feature
		end

	current_feature: FEATURE_AS
			-- The currently processed feature.

	process_do (a_do: DO_AS)
			-- Checks if body of `a_do' is empty.
		local
			l_viol: CA_RULE_VIOLATION
		do
				-- Check that the feature is not a function. For a function, keeping the default
				-- value for the Result is some sort of implementation, too.
			if (current_context.checking_class.is_deferred and not current_feature.is_function) and then a_do.compound = Void then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (current_feature.start_location)
				l_viol.long_description_info.extend (current_feature.feature_name.name_32)
				violations.extend (l_viol)
			end
		end

feature -- Properties

	name: STRING = "empty_feature_in_deferred class"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.empty_effective_routine_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.empty_effective_routine_description
		end

	id: STRING_32 = "CA053"
			-- <Precursor>

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Generates a formatted rule violation description for `a_formatter' based on `a_violation'.
		do
			a_formatter.add (ca_messages.empty_effective_routine_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature then
				a_formatter.add_feature_name (l_feature, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.empty_effective_routine_violation_2)
		end

end
