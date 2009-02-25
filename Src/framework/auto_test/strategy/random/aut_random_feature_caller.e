note

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

	make (a_system: like system; an_interpreter: like interpreter; a_queue: like queue; a_error_handler: like error_handler; a_feature_table: like feature_table)
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

	has_next_step: BOOLEAN
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
			-- Type of the target on which the feature will be called; If `Void' a random type
			-- will be selected.

	target: ITP_VARIABLE
			-- Target of feature call

	receiver: ITP_VARIABLE
			-- Variable to receive the value of the feature call if that feature is a query

	target_creator: AUT_RANDOM_INPUT_CREATOR
			-- Creator to prepare (either select or create) target object for current feature call

	argument_creator: AUT_RANDOM_INPUT_CREATOR
			-- Creator to prepare (either select or create) arguments for current feature call

	feature_caller: AUT_RANDOM_FEATURE_CALLER
			-- Feature call for diversification of object pool

	system: SYSTEM_I
			-- system

	interpreter: AUT_INTERPRETER_PROXY
			-- Proxy to the interpreter used to execute call

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

feature -- Change

	set_feature_and_type (a_feature: like feature_to_call; a_type: like type)
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

	start
		do
			steps_completed := False
			target_creator := Void
			feature_caller := Void
			target := Void
			receiver := Void
			is_feature_and_type_rechecked := False
		ensure then
			input_creator_void: target_creator = Void
			feature_caller_void: feature_caller = Void
			target_void: target = Void
			receiver_void: receiver = Void
			is_feature_argument_check_set: not is_feature_and_type_rechecked
		end

	step
		do
			if type = Void then
				-- 1st step in diversify mode
				create_input_creator_diversify
			elseif target_creator = Void then
				-- 1st step in non-diversify mode
				create_target_creator
-- the following two lines are commented out in order to disable diversification (uncomment them to re-enable it)
--				create feature_caller.make (system, interpreter, queue, error_handler, feature_table)
--				feature_caller.start
			elseif target_creator.has_next_step then
				target_creator.step
			elseif not is_feature_and_type_rechecked then
				is_feature_and_type_rechecked := True
					-- Recheck `type' and `feature'.
				recheck_type_and_feature

					-- Create or select objects as arguments of the feature call.
				if not steps_completed and then feature_to_call.argument_count > 0 then
					create_argument_creator
				end
			elseif argument_creator /= Void and then argument_creator.has_next_step then
				argument_creator.step
			elseif feature_caller /= Void and then feature_caller.has_next_step then
				feature_caller.step
			else
				if not target_creator.has_error then
					invoke
				end
				steps_completed := True
			end
		end

	cancel
		do
			steps_completed := True
		end

feature {NONE} -- Implementation

	steps_completed: BOOLEAN
			-- Should there be no more steps for reasons other than a bad interpeter?

	queue: AUT_DYNAMIC_PRIORITY_QUEUE
			-- Queue

feature {NONE} -- Steps

	create_input_creator_diversify
			-- Create `target_creator' for use in diversify mode.
		do
			fixme ("Does not work for the moment. Jason 25.02.2009")
			target := interpreter.variable_table.random_variable
			if target /= Void  then
				type := interpreter.variable_table.variable_type (target)
				if not type.is_none and then not type.is_expanded then
					choose_feature
					if feature_to_call /= Void then
						create target_creator.make (system, interpreter, feature_table)
						add_feature_argument_type_in_input_creator (feature_to_call, type, target_creator)
						target_creator.start
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

	create_target_creator
			-- Create `target_creator' for use in non-diversify mode.
		require
			type_not_void: type /= Void
			feature_not_void: feature_to_call /= Void
		do
			create target_creator.make (system,interpreter, feature_table)
			target_creator.add_type (type)
			target_creator.start
		end

	create_argument_creator is
			-- Create `argument_creator'.
		require
			feature_need_argument: feature_to_call /= Void and then feature_to_call.argument_count > 0
		do
			create argument_creator.make (system, interpreter, feature_table)
			add_feature_argument_type_in_input_creator (feature_to_call, type, argument_creator)
			argument_creator.start
		ensure
			argument_creator_created: argument_creator /= Void
		end

	invoke
			-- Invoke feature to call.
		require
			type_not_void: type /= Void
			type_not_expanded: not type.is_expanded
			feature_not_void: feature_to_call /= Void
			input_creator_not_void: target_creator /= Void
			input_creator_done: feature_to_call.arguments /= Void and target /= Void implies target_creator.receivers.count = feature_to_call.arguments.count
			input_creator_done: feature_to_call.arguments /= Void and target = Void implies target_creator.receivers.count = feature_to_call.arguments.count + 1
		local
			list: DS_LIST [ITP_EXPRESSION]
			normal_response: AUT_NORMAL_RESPONSE
		do
			if argument_creator /= Void and then not argument_creator.receivers.is_empty then
				list := argument_creator.receivers
			else
				create {DS_LINKED_LIST [ITP_EXPRESSION]} list.make
			end

			if target /= Void then
				if feature_to_call.type /= void_type then
					receiver := interpreter.variable_table.new_variable
					interpreter.invoke_and_assign_feature (receiver, type, feature_to_call, target, list)
				else
					interpreter.invoke_feature (type, feature_to_call, target, list)
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

feature {NONE} -- Implementation

	choose_feature
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

	update_feature_table (a_table: HASH_TABLE [ARRAY [FEATURE_I], CLASS_C]; a_class: CLASS_C)
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
				l_any_class := system.any_class.compiled_class
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

	is_feature_and_type_rechecked: BOOLEAN
			-- Is feature argument creation checked after the target object
			-- of the feature call has been selected?
			-- See `recheck_type_and_feature' for the reason of the rechecking

	recheck_type_and_feature is
			-- Recheck `type' and `feature' after the target object of the feature has been selected.
			-- This is necessary because depending on the dynamic type of the target object, the feature name
			-- maybe different (because of feature renaming),
			-- and the type of the arguments (if any) maybe different too (because of covariant redefinition).
		require
			target_creator_attached: target_creator /= Void
		local
			l_target_type: TYPE_A
		do
			if not target_creator.receivers.is_empty and then {l_target: ITP_VARIABLE} target_creator.receivers.first then
				l_target_type := interpreter.variable_table.variable_type (l_target)
				if l_target_type.is_none then
					cancel
				else
					target := l_target
					set_feature_and_type (l_target_type.associated_class.feature_with_rout_id (feature_to_call.rout_id_set.first).associated_feature_i, l_target_type)
				end
			else
				cancel
			end
		end

invariant

	system_not_void: system /= Void
	interpreter_not_void: interpreter /= Void
	type_and_feature_valid: (type /= Void) = (feature_to_call /= Void)
	queue_not_void: queue /= Void
	class_has_feature: (type /= Void) implies has_feature (type.associated_class, feature_to_call)
	error_handler_not_void: error_handler /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
