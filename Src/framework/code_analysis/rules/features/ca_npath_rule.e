note
	description: "[
			RULE #34: High NPath complexity
	
			NPath is the number of acyclic execution
			paths through a routine. A routine's NPath complexity should not be too
			high. In order to reduce the NPath complexity one can move some
			functionality to separate routines.
		]"
	author: "Stefan Zurfluh, Eiffel Software"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_NPATH_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initializes `Current' and its preferences (using
			-- `a_pref_manager'.
		do
			make_with_defaults
			default_severity_score := 60
			create {LINKED_STACK[INTEGER]} npath_stack.make
			initialize_options (a_pref_manager)
		end

	initialize_options (a_pref_manager: attached PREFERENCE_MANAGER)
			-- Initializes the options regarding this rule using
			-- `a_pref_manager'.
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			threshold := l_factory.new_integer_preference_value (a_pref_manager,
				preference_option_name_threshold, default_threshold)
			threshold.set_default_value (default_threshold.out)
			threshold.set_validation_agent (agent is_integer_string_within_bounds (?, 10, 1_000_000))
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
			-- Adds the AST visitor agents to `a_checker'.
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_feature_post_action (agent evaluate_feature)
			a_checker.add_if_pre_action (agent pre_process_if)
			a_checker.add_if_post_action (agent post_process_if)
			a_checker.add_loop_pre_action (agent pre_process_loop)
			a_checker.add_loop_post_action (agent post_process_loop)
			a_checker.add_inspect_pre_action (agent pre_process_inspect)
			a_checker.add_inspect_post_action (agent post_process_inspect)
		end


feature -- Properties

	name: STRING = "npath_complexity"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.npath_title
		end

	id: STRING_32 = "CA034"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result :=  ca_names.npath_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- <Precursor>
		local
			l_info: LINKED_LIST[ANY]
		do
			l_info := a_violation.long_description_info
			a_formatter.add (ca_messages.npath_violation_1)
			if attached {FEATURE_AS} l_info.first as l_feat then
				a_formatter.add_feature_name (l_feat.feature_name.name_32, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.npath_violation_2)
			if attached {INTEGER} l_info.at (2) as l_npath then
				a_formatter.add_int (l_npath)
			end
			a_formatter.add (ca_messages.npath_violation_3)
			if attached {INTEGER} l_info.at (3) as l_max then
				a_formatter.add_int (l_max)
			end
			a_formatter.add (".")
		end

feature {NONE} -- Preferences

	preference_option_name_threshold: STRING
			-- A name of a threshold option within the corresponding preference namespace.
		do
			Result := full_preference_name (option_name_threshold)
		end

	option_name_threshold: STRING = "threshold"
			-- A name of a threshold option.

	default_threshold: INTEGER = 200
			-- Default value for `threshold'.

	threshold: INTEGER_PREFERENCE
			-- Maximally allowed NPath measure for a routine.

feature {NONE} -- Rule Checking

	npath_stack: STACK [INTEGER]
			-- NPath measures of nested inner blocks, such as if...end.

	process_feature (a_feature_as: FEATURE_AS)
			-- Sets the currently processed feature to `a_feature_as'.
		do
			if a_feature_as.body /= Void and then a_feature_as.body.is_routine then
					-- Only look at routines.
				current_feature := a_feature_as
				prepare_routine
			else
				current_feature := Void
			end
		end

	evaluate_feature (a_feature_as: FEATURE_AS)
		do
			if current_feature /= Void then
					-- The feature has been prepared in `process_feature' and
					-- will therefore be evaluated now.
				evaluate_routine
			end
		end

	prepare_routine
			-- Initializes data structures.
		do
			npath_stack.wipe_out
			npath_stack.put (1)
		end

	evaluate_routine
			-- Creates a rule violation if NPath is high enough.
		local
			l_violation: CA_RULE_VIOLATION
			l_npath, l_threshold: INTEGER
		do
			check npath_stack.count = 1 end
			l_npath := npath_stack.item

			l_threshold := threshold.value

			if l_npath > l_threshold then
				create l_violation.make_with_rule (Current)
				check attached current_feature end
				l_violation.set_location (current_feature.start_location)
				l_violation.long_description_info.extend (current_feature)
				l_violation.long_description_info.extend (l_npath)
				l_violation.long_description_info.extend (l_threshold)
				violations.extend (l_violation)
			end
		end

	pre_process_if (a_if: IF_AS)
			-- Adds a new element to the NPath stack.
		do
			npath_stack.put (1)
		end

	post_process_if (a_if: IF_AS)
			-- Combines the inner NPath of `a_if' with the next-outer
			-- level.
		local
			inner_npath: INTEGER
		do
			inner_npath := npath_stack.item + 1
			npath_stack.remove
			npath_stack.replace (inner_npath * npath_stack.item)
		end

	pre_process_loop (a_loop: LOOP_AS)
			-- Adds a new element to the NPath stack.
		do
			npath_stack.put (1)
		end

	post_process_loop (a_loop: LOOP_AS)
			-- Combines the inner NPath of `a_loop' with the next-outer
			-- level.
		local
			inner_npath: INTEGER
		do
			inner_npath := npath_stack.item + 1
			npath_stack.remove
			npath_stack.replace (inner_npath * npath_stack.item)
		end

	pre_process_inspect (a_inspect: INSPECT_AS)
			-- Adds a new element to the NPath stack.
		do
			npath_stack.put (1)
		end

	post_process_inspect (a_inspect: INSPECT_AS)
			-- Combines the inner NPath of `a_inspect' with the next-outer
			-- level.
		local
			inner_npath: INTEGER
		do
			inner_npath := npath_stack.item + 1
			npath_stack.remove
			npath_stack.replace (inner_npath * npath_stack.item)
		end

	process_and_then (a_and_then: BIN_AND_THEN_AS)
			-- Do nothing. It would be possible to raise the NPath measure
			-- here, too.
		do

		end

	process_or_else (a_or_else: BIN_OR_ELSE_AS)
			-- Do nothing. It would be possible to raise the NPath measure
			-- here, too.
		do

		end

	current_feature: detachable FEATURE_AS
			-- Currently processed feature.

end
