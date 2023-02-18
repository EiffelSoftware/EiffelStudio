note
	description: "Asynchronous task that checks a set of classes using a list of rules."
	author: "Stefan Zurfluh", "Eiffel Software", "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_RULE_CHECKING_TASK

inherit
	CA_SHARED_NAMES
	EXCEPTION_MANAGER_FACTORY
	ROTA_TIMED_TASK_I

create
	make

feature {NONE} -- Initialization

	make (a_rules_checker: CA_ALL_RULES_CHECKER; a_rules: LINKED_LIST [CA_RULE]; a_classes: LINKED_SET [CLASS_C]; a_completed_action: PROCEDURE [detachable ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]]])
			-- Initializes `Current'. `a_rules_checker' will be used for checking standard rules. All classes from `a_classes'
			-- will be analyzed by all rules from `a_rules'. `a_completed_action' will be called as soon as the analysis is done.
		do

			if a_classes.is_empty then
					-- Make sure `completed_action' is called even when no classes
					-- have been added.
				a_completed_action ([Void])
			else -- Initialization.
				rules_checker := a_rules_checker
				rules := a_rules
				classes := a_classes
				completed_action := a_completed_action
				classes.start
				has_next_step := True
				create type_recorder.make
				create exceptions.make
				create context
				across rules as l_rules loop
						-- Set the context already here. For any further
						-- class only update the info in the context.
					l_rules.set_current_context (context)
				end
			end
		end

feature -- Initialization

	set_output_actions (a_output_actions: attached ACTION_SEQUENCE [TUPLE [READABLE_STRING_GENERAL]])
			-- Sets the output acitons to `a_output_actions'.
		do
			output_actions := a_output_actions
		ensure
			output_actions = a_output_actions
		end

feature {NONE} -- Implementation

	rules_checker: CA_ALL_RULES_CHECKER
			-- The rule checker for standard rules.

	type_recorder: CA_AST_TYPE_RECORDER
			-- Type recorder for type information.

	rules: LINKED_LIST [CA_RULE]
			-- Rules that have been set for analysis.

	classes: LINKED_SET [CLASS_C]
			-- Classes that shall be analyzed.

	completed_action: PROCEDURE [ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]]]
			-- Shall be called when analysis has completed.

	output_actions: detachable ACTION_SEQUENCE [TUPLE [READABLE_STRING_GENERAL]]
			-- These procedures will be called whenever something should
			-- be output.

	exceptions: LINKED_SET [TUPLE [detachable EXCEPTION, CLASS_C]]

	context: CA_ANALYSIS_CONTEXT

feature -- From ROTA

	sleep_time: NATURAL = 10
			-- <Precursor>

	has_next_step: BOOLEAN
			-- <Precursor>

	step
			-- <Precursor>
		local
			is_retried: BOOLEAN
			c: CLASS_C
		do
			if not is_retried then
					-- Gather type information
				type_recorder.clear
				c := classes.item
				type_recorder.analyze_class (c)
				context.set_node_types (type_recorder.node_types)
				context.set_checking_class (c)

				across rules as l_rules loop
						-- If rule is non-standard then it will not be checked by l_rules_checker.
						-- We will have the rule check the current class here:
					if
						l_rules.is_enabled.value
						and then attached {CA_CFG_RULE} l_rules as l_cfg_rule
					then
						l_cfg_rule.check_class (c)
					end
				end

					-- Status output.
				if output_actions /= Void then
					output_actions.call ([ca_messages.analyzing_class (c.name)])
				end

				rules_checker.run_on_class (c)

				classes.forth
				has_next_step := not classes.after
				if not has_next_step then
					completed_action (exceptions)
				end
			end
		rescue
			if attached c then
					-- Instant error output.
				if output_actions /= Void then
					output_actions.call ([ca_messages.error_on_class (c.name)])
				end
				exceptions.extend ([exception_manager.last_exception, c])
			end
			if not classes.after then
					-- Jump to the next class.
				classes.forth
			end
			has_next_step := not classes.after
			if not has_next_step then
				completed_action (exceptions)
			end
			is_retried := True
			retry
		end

	cancel
			-- <Precursor>
		do
			has_next_step := False
		end

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

end
