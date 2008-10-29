indexing

	description:

		"Objects that instruct interpreter to call features using random input"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_RANDOM_FEATURE_CALLER

inherit

	AUT_TASK

	AUT_SHARED_RANDOM
		export {NONE} all end

	AUT_SHARED_CONSTANTS
		export {NONE} all end

	ERL_G_TYPE_ROUTINES

create

	make

feature {NONE} -- Initialization

	make (a_system: like system; an_interpreter: like interpreter; a_queue: like queue; a_error_handler: like error_handler; a_feature_table: like feature_table) is
			-- Create new feature caller.
		require
			a_system_not_void: a_system /= Void
			a_interpreter_not_void: an_interpreter /= Void
			a_queue_not_void: a_queue /= Void
			a_error_handler_not_void: a_error_handler /= Void
		do
			system := a_system
			interpreter := an_interpreter
			queue := a_queue
			error_handler := a_error_handler
			steps_completed := True
			feature_table := a_feature_table
		ensure
			system_set: system = a_system
			interpreter_set: interpreter = an_interpreter
			queue_set: queue = a_queue
			error_handler_set: error_handler = a_error_handler
			steps_completed: steps_completed
			feature_table_set: feature_table = a_feature_table
		end

feature -- Status

	has_next_step: BOOLEAN is
			-- Is there a next step to execute?
			-- True when either the feature has been successfully called `steps_completed'
			-- or the invocation or a prepatorial step for the invocation messed up the
			-- interpreter.
		do
			Result := interpreter.is_running and interpreter.is_ready and not steps_completed
		end

feature -- Access

	feature_to_call: FEATURE_I
			-- Feature to call; If `Void' a random feature
			-- will be selected.

	type: TYPE_A
			-- Type of feature; If `Void' a random type
			-- will be selected.

	target: ITP_VARIABLE
			-- Target of feature call

	receiver: ITP_VARIABLE
			-- Variable to receive the value of the feature call if that feature is a query

	input_creator: AUT_RANDOM_INPUT_CREATOR
			-- Input creator used to create arguments for feature call

	feature_caller: AUT_RANDOM_FEATURE_CALLER
			-- Feature call for diversification of object pool

	system: SYSTEM_I
			-- system

	interpreter: AUT_INTERPRETER_PROXY
			-- Proxy to the interpreter used to execute call

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

feature -- Change

	set_feature_and_type (a_feature: like feature_to_call; a_type: like type) is
				-- Set `feature_to_call' to `a_feature' and
				-- `type' to `a_type'.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
			class_has_feature: has_feature (a_type.associated_class, a_feature)
		do
			feature_to_call := a_feature
			type := a_type
		ensure
			feature_set: feature_to_call = a_feature
			type_set: type = a_type
		end

feature -- Execution

	start is
		do
			steps_completed := False
			input_creator := Void
			feature_caller := Void
			target := Void
			receiver := Void
		ensure then
			input_creator_void: input_creator = Void
			feature_caller_void: feature_caller = Void
			target_void: target = Void
			receiver_void: receiver = Void
		end

	step is
		do
			if type = Void then
				-- 1st step in diversify mode
				create_input_creator_diversify
			elseif input_creator = Void then
				-- 1st step in non-diversify mode
				create_input_creator
-- the following two lines are commented out in order to disable diversification (uncomment them to re-enable it)
--				create feature_caller.make (system, interpreter, queue, error_handler, feature_table)
--				feature_caller.start
			elseif input_creator.has_next_step then
				input_creator.step
			elseif feature_caller /= Void and then feature_caller.has_next_step then
				feature_caller.step
			else
				if not input_creator.has_error then
					invoke
				end
				steps_completed := True
			end
		end

	cancel is
		do
			steps_completed := True
		end

feature {NONE} -- Implementation

	steps_completed: BOOLEAN
			-- Should there be no more steps for reasons other than a bad interpeter?

	queue: AUT_DYNAMIC_PRIORITY_QUEUE
			-- Queue

feature {NONE} -- Steps

	create_input_creator_diversify is
			-- Create `input_creator' for use in diversify mode.
		do
			target := interpreter.variable_table.random_variable
			if target /= Void  then
				type := interpreter.variable_table.variable_type (target)
				if not type.is_none and then not type.is_expanded then
					choose_feature
					if feature_to_call /= Void then
						create input_creator.make (system, interpreter, feature_table)
						add_feature_argument_type_in_input_creator (feature_to_call, type, input_creator)
						input_creator.start
					else
						type := Void
					end
				else
					cancel
				end
			else
				cancel
			end
		ensure
			feature_and_type_set: has_next_step = ((type /= Void) and (feature_to_call /= Void))
		end

	create_input_creator is
			-- Create `input_creator' for use in non-diversify mode.
		require
			type_not_void: type /= Void
			feature_not_void: feature_to_call /= Void
		do
			create input_creator.make (system,interpreter, feature_table)
			input_creator.add_type (type)
			add_feature_argument_type_in_input_creator (feature_to_call, type, input_creator)
			input_creator.start
		end

	invoke is
			-- Invoke feature to call.
		require
			type_not_void: type /= Void
			type_not_expanded: not type.is_expanded
			feature_not_void: feature_to_call /= Void
			input_creator_not_void: input_creator /= Void
			input_creator_done: feature_to_call.arguments /= Void and target /= Void implies input_creator.receivers.count = feature_to_call.arguments.count
			input_creator_done: feature_to_call.arguments /= Void and target = Void implies input_creator.receivers.count = feature_to_call.arguments.count + 1
		local
			list: DS_LIST [ITP_EXPRESSION]
			normal_response: AUT_NORMAL_RESPONSE
			l_target_type: TYPE_A
		do
			list := input_creator.receivers
			if target = Void then
				target ?= list.first
					-- If `list.first' represents `Void' (ITP_REFERENCE), target will be `Void'.
				list.remove_first
			end
			if target /= Void then
				l_target_type := interpreter.variable_table.variable_type (target)
				if not l_target_type.is_none then
					if feature_to_call.type /= void_type then
						receiver := interpreter.variable_table.new_variable
						interpreter.invoke_and_assign_feature (receiver, type, feature_to_call, target, input_creator.receivers)
					else
						interpreter.invoke_feature (type, feature_to_call, target, input_creator.receivers)
					end
					queue.mark (create {AUT_FEATURE_OF_TYPE}.make (feature_to_call, interpreter.variable_table.variable_type (target)))
					if not interpreter.last_response.is_bad and not interpreter.last_response.is_error then
						normal_response ?= interpreter.last_response
						if normal_response /= Void then
							if normal_response.exception /= Void then
								if not (normal_response.exception.name.is_case_insensitive_equal ("Precondition") and
									normal_response.exception.trace_depth = 1)
								then
									interpreter.log_line (exception_thrown_message + error_handler.duration_to_now.second_count.out)
								end
							end
						else
							check
								dead_end: False
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	choose_feature is
			-- Chose `feature_to_call' from `type'.
		require
			type_not_void: type /= Void
		local
			count: INTEGER
			class_: CLASS_C
			i: INTEGER
			l_feature_table: like feature_table
		do
			class_ := type.associated_class
			random.forth
			l_feature_table := feature_table
			update_feature_table (l_feature_table, class_)
			count := l_feature_table.item (class_).count
			if count > 0 then
				i := (random.item  \\ count) + 1
				feature_to_call := l_feature_table.item (class_).item (i)
			else
				steps_completed := True
			end
		ensure
			end_or_feature_not_void: not has_next_step xor (feature_to_call /= Void)
		end

	feature_table: HASH_TABLE [ARRAY [FEATURE_I], CLASS_C]
			-- Table used to store features in a class

	update_feature_table (a_table: HASH_TABLE [ARRAY [FEATURE_I], CLASS_C]; a_class: CLASS_C) is
			-- If feature information for `a_class' is not stored in `a_table',
			-- store it in `a_table', otherwise do nothing.
		require
			a_table_attached: a_table /= Void
			a_class_attached: a_class /= Void
		local
			l_feature_table: FEATURE_TABLE
			l_feats: ARRAY [FEATURE_I]
			l_feature: FEATURE_I
			i: INTEGER
			l_any_class: CLASS_C
		do
			if not a_table.has (a_class) then
				create l_feats.make (1, a_class.feature_table.count)
				l_any_class := system.any_class.compiled_representation
				from
					i := 1
					l_feature_table := a_class.feature_table
					l_feature_table.start
				until
					l_feature_table.after
				loop
					l_feature := l_feature_table.item_for_iteration
					if
						l_feature.is_exported_for (l_any_class) and then
						not l_feature.is_prefix and then
						not l_feature.is_infix
					then
						l_feats.put (l_feature_table.item_for_iteration, i)
						i := i + 1
					end
					l_feature_table.forth
				end
			end
		ensure
			a_class_in_table: a_table.has (a_class)
		end

invariant

	system_not_void: system /= Void
	interpreter_not_void: interpreter /= Void
	type_and_feature_valid: (type /= Void) = (feature_to_call /= Void)
	queue_not_void: queue /= Void
	class_has_feature: (type /= Void) implies has_feature (type.associated_class, feature_to_call)
	error_handler_not_void: error_handler /= Void

end
