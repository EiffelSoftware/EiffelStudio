note
	description: "[
		Objects implementing {TEST_SUITE_S}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SUITE

inherit
	TEST_SUITE_S

	TEST_PROCESSOR_REGISTRAR_I
		redefine
			is_valid_processor
		end

	DISPOSABLE_SAFE
		redefine
			is_interface_usable
		end

	TEST_PROJECT
		redefine
			is_interface_usable,
			remove_test
		end

create
	make

feature {NONE} -- Initialization

	make (a_project_helper: like eiffel_project_helper)
			-- Initialize `Current'.
		local
			l_project: E_PROJECT
			l_project_factory: SHARED_EIFFEL_PROJECT
		do
				-- Create registrar
			create internal_processors.make

				-- Create events
			create processor_launched_event
			create processor_proceeded_event
			create processor_finished_event
			create processor_stopped_event
			create processor_error_event

			create l_project_factory
			l_project := l_project_factory.eiffel_project
			check l_project /= Void end
			make_with_project (l_project, a_project_helper)

			register_locator (create {TEST_COMPILED_LOCATOR})
			register_locator (create {TEST_UNCOMPILED_LOCATOR}.make)

			synchronize
		end

feature -- Access

	processor_registrar: attached TEST_PROCESSOR_REGISTRAR_I
			-- <Precursor>
		do
			Result := Current
		end

	processor_instances (a_test_suite: attached TEST_SUITE_S): attached DS_LINEAR [attached TEST_PROCESSOR_I]
			-- <Precursor>
		do
			if a_test_suite = Current then
				Result := internal_processors
			else
				Result := empty_processor_list
			end
		end

feature {NONE} -- Access

	internal_processors: attached DS_LINKED_LIST [attached TEST_PROCESSOR_I]
			-- Internal storage for `processor_instances'

	empty_processor_list: attached DS_LINEAR [attached TEST_PROCESSOR_I]
			-- Empty list for `processor_instances'
		once
			create {attached DS_LINKED_LIST [attached TEST_PROCESSOR_I]} Result.make
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {DISPOSABLE_SAFE} and then Precursor {TEST_PROJECT}
		end

	is_registered (a_processor: attached TEST_PROCESSOR_I): BOOLEAN
			-- <Precursor>
		do
			Result := internal_processors.has (a_processor)
		end

	count_executed: NATURAL
			-- <Precursor>

	count_passing: NATURAL
			-- <Precursor>

	count_failing: NATURAL
			-- <Precursor>

feature -- Status setting

	synchronize_processors
			-- <Precursor>
		local
			l_proc: attached TEST_PROCESSOR_I
		do
			from
				internal_processors.start
			until
				internal_processors.after
			loop
				l_proc := internal_processors.item_for_iteration
				internal_processors.forth
				if l_proc.is_idle then
					if l_proc.is_finished then
						stop_task (l_proc)
					else
						proceed_task (l_proc)
					end
				end
			end
		end

	launch_processor (a_processor: attached TEST_PROCESSOR_I; a_arg: attached TEST_PROCESSOR_CONF_I; a_blocking: BOOLEAN)
			-- <Precursor>
		do
			a_processor.start (a_arg)
				-- Note: replace `as_attached' with Current when compiler treats Current as attached
			processor_launched_event.publish ([as_attached, a_processor.as_attached])

			if a_blocking then
				from until
					a_processor.is_finished
				loop
					proceed_task (a_processor)
				end
				stop_task (a_processor)
			end
		end

feature {TEST_PROCESSOR_I} -- Status setting

	propagate_error (a_error: attached STRING; a_token_values: attached TUPLE; a_processor: attached TEST_PROCESSOR_I)
			-- <Precursor>
		do
				-- Note: replace `as_attached' with Current when compiler treats Current as attached
			processor_error_event.publish ([as_attached, a_processor.as_attached, a_error.as_attached, a_token_values.as_attached])
		end

feature {TEST_EXECUTOR_I} -- Status setting

	set_test_queued (a_test: attached TEST_I; a_executor: attached TEST_EXECUTOR_I)
			-- <Precursor>
		do
			a_test.set_queued (a_executor)
				-- Note: replace `as_attached' with Current when compiler treats Current as attached
			test_changed_event.publish ([as_attached, a_test.as_attached])
			a_test.clear_changes
		end

	set_test_running (a_test: attached TEST_I)
			-- <Precursor>
		do
			a_test.set_running
				-- Note: replace `as_attached' with Current when compiler treats Current as attached
			test_changed_event.publish ([as_attached, a_test.as_attached])
			a_test.clear_changes
		end

	add_outcome_to_test (a_test: attached TEST_I; a_outcome: attached EQA_TEST_RESULT)
			-- <Precursor>
		local
			l_old, l_new: NATURAL_8
		do
			if a_test.is_outcome_available then
				l_old := a_test.last_outcome.status
			else
				count_executed := count_executed + 1
			end
			l_new := a_outcome.status
			if l_old /= l_new then
				if l_new = {EQA_TEST_RESULT_STATUS_TYPES}.failed then
					count_failing := count_failing + 1
				elseif l_new = {EQA_TEST_RESULT_STATUS_TYPES}.passed then
					count_passing := count_passing + 1
				end
				if l_old = {EQA_TEST_RESULT_STATUS_TYPES}.failed then
					count_failing := count_failing - 1
				elseif l_old = {EQA_TEST_RESULT_STATUS_TYPES}.passed then
					count_passing := count_passing - 1
				end
			end
			a_test.add_outcome (a_outcome)
				-- Note: replace `as_attached' with Current when compiler treats Current as attached
			test_changed_event.publish ([as_attached, a_test.as_attached])
			a_test.clear_changes
		end

	set_test_aborted (a_test: attached TEST_I)
			-- <Precursor>
		do
			a_test.abort
				-- Note: replace `as_attached' with Current when compiler treats Current as attached
			test_changed_event.publish ([as_attached, a_test.as_attached])
			a_test.clear_changes
		end

feature -- Query

	is_valid_type (a_type: attached TYPE [TEST_PROCESSOR_I]; a_test_suite: attached TEST_SUITE_S): BOOLEAN
			-- <Precursor>
		local
			l_start: BOOLEAN
		do
			from
			until
				Result or (l_start and internal_processors.after)
			loop
				if not internal_processors.off then
					Result := a_type.attempt (internal_processors.item_for_iteration) /= Void
				end
				if not Result then
					if l_start then
						internal_processors.forth
					else
						internal_processors.start
						l_start := True
					end
				end
			end
		end

	is_valid_processor (a_processor: attached TEST_PROCESSOR_I): BOOLEAN
			-- <Precursor>
		do
			Result := a_processor.test_suite = Current
		end

	processor (a_type: attached TYPE [TEST_PROCESSOR_I]; a_test_suite: attached TEST_SUITE_S): attached TEST_PROCESSOR_I
			-- <Precursor>
		local
			l_start: BOOLEAN
			l_result: detachable like processor
		do
			from
			until
				l_result /= Void or (l_start and internal_processors.after)
			loop
				if not internal_processors.off then
					l_result := a_type.attempt (internal_processors.item_for_iteration)
				end
				if l_result = Void then
					if l_start then
						internal_processors.forth
					else
						internal_processors.start
						l_start := True
					end
				end
			end
			check l_result /= Void end
			Result := l_result
		end

feature -- Element change

	register (a_processor: attached TEST_PROCESSOR_I)
			-- <Precursor>
		do
			internal_processors.force_last (a_processor)
		end

	unregister (a_processor: attached TEST_PROCESSOR_I)
			-- <Precursor>
		do
			internal_processors.start
			internal_processors.search_forth (a_processor)
			if not internal_processors.off then
				internal_processors.remove_at
			end
		end

feature {NONE} -- Element change

	remove_test (a_id: attached STRING)
			-- <Precursor>
		local
			l_test: TEST_I
		do
			l_test := test_routine_map.item (a_id)
			if l_test.is_outcome_available then
				count_executed := count_executed - 1
				if l_test.passed then
					count_passing := count_passing - 1
				elseif l_test.failed then
					count_failing := count_failing - 1
				end
			end
			Precursor (a_id)
		end

feature {NONE} -- Basic operations

	proceed_task (a_processor: attached TEST_PROCESSOR_I)
			-- Make `a_processor' proceed with its task. Notify observers of events.
		require
			a_processor_usable: a_processor.is_interface_usable
			a_processor_running: a_processor.is_running
			a_processor_idle: a_processor.is_idle
			not_a_processor_fininshed: not a_processor.is_finished
			a_processor_launched_by_current: a_processor.test_suite = Current
		do
			a_processor.proceed
			if a_processor.is_finished then
					-- Note: replace `as_attached' with Current when compiler treats Current as attached
				processor_finished_event.publish ([as_attached, a_processor.as_attached])
			else
					-- Note: replace `as_attached' with Current when compiler treats Current as attached
				processor_proceeded_event.publish ([as_attached, a_processor.as_attached])
			end
		end

	stop_task (a_processor: attached TEST_PROCESSOR_I)
			-- Stop `a_processor' and notify observers as long as processor is not running.
		require
			a_processor_usable: a_processor.is_interface_usable
			a_processor_running: a_processor.is_running
			a_processor_idle: a_processor.is_idle
			a_processor_fininshed: a_processor.is_finished
			a_processor_launched_by_current: a_processor.test_suite = Current
		do
			a_processor.stop
				-- Note: replace `as_attached' with Current when compiler treats Current as attached
			processor_stopped_event.publish_if ([as_attached, a_processor.as_attached],
				agent (ts: attached like Current; p: attached TEST_PROCESSOR_I): BOOLEAN
					do
						Result := not p.is_running
					end)
		end

feature -- Events

	processor_launched_event: attached EVENT_TYPE [TUPLE [test_suite: attached TEST_SUITE_S; processor: attached TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_proceeded_event: attached EVENT_TYPE [TUPLE [test_suite: attached TEST_SUITE_S; processor: attached TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_finished_event: attached EVENT_TYPE [TUPLE [test_suite: attached TEST_SUITE_S; processor: attached TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_stopped_event: attached EVENT_TYPE [TUPLE [test_suite: attached TEST_SUITE_S; processor: attached TEST_PROCESSOR_I]]
			-- <Precursor>

	processor_error_event: attached EVENT_TYPE [TUPLE [test_suite: attached TEST_SUITE_S; processor: attached TEST_PROCESSOR_I; error: attached STRING; token_values: TUPLE]]
			-- <Precursor>

invariant
	internal_processors_usable: internal_processors.for_all (agent {attached TEST_PROCESSOR_I}.is_interface_usable)

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
