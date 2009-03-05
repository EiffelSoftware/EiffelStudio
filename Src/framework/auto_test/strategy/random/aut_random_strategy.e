note

	description:

		"Testing strategy for automated random testing"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_RANDOM_STRATEGY

inherit

	AUT_STRATEGY
		rename
			make as make_strategy
		redefine
			start,
			cancel
		end

create

	make

feature {NONE} -- Initialization

	make (a_system: like system; an_interpreter: like interpreter; an_error_handler: like error_handler)
			-- Create new strategy.
		require
			a_system_not_void: a_system /= Void
			an_interpreter_not_void: an_interpreter /= Void
			an_interpreter_not_in_replay_mode: not an_interpreter.is_in_replay_mode
			an_error_handler_not_void: an_error_handler /= Void
		do
			make_strategy (a_system, an_interpreter)
			create queue.make (system)
			error_handler := an_error_handler
		ensure
			system_set: system = a_system
			interpreter_set: interpreter = an_interpreter
			error_handler_set: error_handler = an_error_handler
		end

feature -- Status

	has_next_step: BOOLEAN
		do
			Result := sub_task /= Void and then sub_task.has_next_step
		end

feature -- Access

	queue: AUT_DYNAMIC_PRIORITY_QUEUE
			-- Feature queue

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

	selected_feature: AUT_FEATURE_OF_TYPE
			-- Currently selected feature;
			-- `Void' if none is selected.

feature -- Execution

	start
		do
			Precursor
			assign_void
			if queue.highest_dynamic_priority > 0 then
				select_new_sub_task
			end
		end

	cancel
		do
			sub_task := Void
		end

	step
		do
			if interpreter.is_running and interpreter.is_ready then
				sub_task.step
			end
			if interpreter.is_running and not interpreter.is_ready then
				interpreter.stop
			end
			if not interpreter.is_running then
				if sub_task /= Void then
					sub_task.cancel
				end
				interpreter.start
				assign_void
			end
			if not sub_task.has_next_step then
				if queue.highest_dynamic_priority > 0 then
					select_new_sub_task
				else
					sub_task := Void
				end
			end
		end

feature {NONE} -- Implementation

	select_new_sub_task
			-- Select new task and make it available via `sub_task'.
		require
			positive_priority: queue.highest_dynamic_priority > 0
		local
			caller: AUT_RANDOM_FEATURE_CALLER
			creator: AUT_RANDOM_OBJECT_CREATOR
			l_selected_type: TYPE_A
			l_selected_feature: FEATURE_I
		do
			queue.select_next

			selected_feature := queue.last_feature
			l_selected_feature := selected_feature.feature_
			l_selected_type := selected_feature.type

			if selected_feature.is_creator then
				create creator.make (system, interpreter, l_selected_type, feature_table)
				creator.set_creation_procedure (l_selected_feature)
				sub_task := creator
			else
				create caller.make (system, interpreter, queue, error_handler, feature_table)
				caller.set_feature_and_type (l_selected_feature, l_selected_type)
				sub_task := caller
			end

				-- Start sub task.
			sub_task.start
			error_handler.decrease_counter
			error_handler.report_feature_selection (l_selected_type, l_selected_feature)
		end

	sub_task: AUT_TASK
			-- Current sub task

	feature_table: HASH_TABLE [ARRAY [FEATURE_I], CLASS_C]
			-- Table to store features in a class (Used for cache)
			-- [List of a feature in a class, class]
		do
			if feature_table_internal = Void then
				create feature_table_internal.make (10)
			end
			Result := feature_table_internal
		ensure
			result_attached: Result /= Void
		end

	feature_table_internal: like feature_table
			-- Implementation of `feature_table'

invariant

	queue_not_void: queue /= Void
	error_handler_not_void: error_handler /= Void
	interpreter_not_in_replay_mode: not interpreter.is_in_replay_mode

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
