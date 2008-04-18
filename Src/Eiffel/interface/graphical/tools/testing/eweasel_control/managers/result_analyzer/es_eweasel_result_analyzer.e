indexing
	description: "[
					eWeasel Result Analyzer.
					Convert eWeasel string output to {ES_EWEASEL_TEST_RESULT_ITEM}
																				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_RESULT_ANALYZER

inherit
	ES_EWEASEL_SUB_MANAGER

create
	make

feature -- Command

	reset is
			-- Clear all last test run caches
		local
			l_test_result_tool: ES_TESTING_RESULT_TOOL_PANEL
		do
			all_output_string.wipe_out
			buffer_string.wipe_out
			all_results.wipe_out -- Maybe we need record results here?
			manager.testing_tool.reset

			l_test_result_tool := manager.testing_result_tool
			if l_test_result_tool /= Void and then l_test_result_tool.is_initialized then
				l_test_result_tool.test_run_result_grid_manager.reset
			end

			clear_buffer_string_moving
		ensure
			cleared: all_output_string.is_empty
			cleared: buffer_string.is_empty
			cleared: all_results.is_empty
		end

	on_eweasel_output (a_string: STRING) is
			-- Handle eWeasel output from process library
			-- Note, this is called in another thread but not Eiffel Studio UI thread
		do
			mutex.lock
			output_buffer.append (a_string)
			mutex.unlock
		end

	on_eweasel_exit is
			-- Handle eWeasel output string just after eWeasel exited.
		do
			prcess_output ("", True)
		end

	start_buffer_string_moving is
			-- Call `move_process_library_output_to_testing_tool' in idle actions
		require
			cleared: is_idle_agent_cleared
		local
			l_env: EV_ENVIRONMENT
		do
			buffer_string_moving_agent := agent move_process_library_output_to_testing_tool
			create l_env
			l_env.application.add_idle_action (buffer_string_moving_agent)
		ensure
			created: buffer_string_moving_agent /= Void
		end

	clear_buffer_string_moving is
			-- Clear `buffer_string_moving_agent' if possible
		local
			l_env: EV_ENVIRONMENT
		do
			if buffer_string_moving_agent /= Void then
				create l_env
				l_env.application.remove_idle_action (buffer_string_moving_agent)
				buffer_string_moving_agent := Void
			end
		ensure
			cleared: is_idle_agent_cleared
		end

	prcess_output (a_string: STRING; a_on_exit: BOOLEAN) is
			-- Call handlers to analyze output string.
		require
			not_void: a_string /= Void
		local
			l_handler: like all_hanlders
			l_item: ES_EWEASEL_TEST_RESULT_ITEM
			l_need_iteration: BOOLEAN
		do
			if not a_string.is_empty then
				buffer_string.append (a_string)
			end

			from
				l_need_iteration := is_need_iteration (buffer_string) or a_on_exit
			until
				not l_need_iteration
			loop
				from
					l_handler := all_hanlders
					l_handler.start
				until
					l_handler.after or l_item /= Void
				loop
					if a_on_exit then
						l_item := l_handler.item.handle_output_on_exit (buffer_string)
					else
						l_item := l_handler.item.handle_output (buffer_string)
					end

					l_handler.forth
				end

				check on_exit_must_handled: a_on_exit implies l_item /= Void end

				if l_item /= Void then
					process_result (l_item)
				end
				check handled: lines_cell.item = Void and one_block_cell.item = Void end

				-- We start to check if still need interation
				l_item := Void
				l_need_iteration := is_need_iteration (buffer_string)
			end
		ensure
			cleared:
		end

	process_result (a_item: ES_EWEASEL_TEST_RESULT_ITEM) is
			-- Process analyzed result.
		require
			not_void: a_item /= Void
			valid: a_item.is_valid
		local
			l_consumer: SERVICE_CONSUMER [EVENT_LIST_S]
			l_result_item: EVENT_LIST_TESTING_RESULT_ITEM
			l_contexts: ES_TESTING_EVENT_LIST_CONTEXTS
		do
			all_results.extend (a_item)
			create l_consumer

			if l_consumer.is_service_available then
				-- FIXIT:	The second parameter priority is?
				--			For the moment, we don't use it.
				create l_result_item.make ({ENVIRONMENT_CATEGORIES}.testing, 0, a_item)
				a_item.set_test_case_result_index (all_results.count)
				a_item.set_total_test_cases_count (all_test_cases_count)
				create l_contexts
				l_consumer.service.put_event_item (l_contexts.eweasel_result_analyzer, l_result_item)
			end
		ensure
			added: all_results.has (a_item)
		end

	set_all_test_cases_count (a_count: INTEGER) is
			-- Set `all_test_cases_count' with `a_count'
		require
			valie: a_count >= 0
		do
			all_test_cases_count := a_count
		ensure
			set: all_test_cases_count = a_count
		end

feature -- Query

	all_test_cases_count: INTEGER
			-- How many test cases expected to run

	all_results: ARRAYED_LIST [ES_EWEASEL_TEST_RESULT_ITEM] is
			-- All result items analyzed from eWeasel output.
		do
			if internal_all_results = Void then
				create internal_all_results.make (100)
			end
			Result := internal_all_results
		ensure
			not_void: Result /= Void
		end

	all_hanlders: ARRAYED_LIST [ES_EWEASEL_RESULT_HANDLER] is
			-- All result handlers
		once
			create Result.make (5)

			-- Begin handler to first
			Result.extend (create {ES_EWEASEL_BEGIN_RESULT_HANDLER})

			Result.extend (create {ES_EWEASEL_FAILED_RESULT_HANDLER})
			Result.extend (create {ES_EWEASEL_PASSED_RESULT_HANDLER})
			Result.extend (create {ES_EWEASEL_RESULT_ERROR_INIT_CONTROL_FILE_HANDLER})

			-- Put default handler to last
			Result.extend (create {ES_EWEASEL_RESULT_DEFAULT_HANDLER})

		ensure
			not_void: Result /= Void
		end

	is_idle_agent_cleared: BOOLEAN is
			-- If `buffer_string_moving_agent' clear ?
		do
			Result := buffer_string_moving_agent = Void
		end

feature {ES_EWEASEL_RESULT_HANDLER} -- Shared cache

	one_block_cell: CELL [TUPLE [content: STRING_GENERAL; end_index: INTEGER]]
			-- One eWeasel output block of a test case run
			-- This feature is used by all {EWEASEL_RESULT_HANDLER} during a execution of `prcess_output'
		indexing
			once_status: global
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	lines_cell: CELL [LIST [STRING_8]]
			-- Singleton cell used by `lines'
		indexing
			once_status: global
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	reset_cache is
			-- Clear cache
		do
			one_block_cell.put (Void)
			lines_cell.put (Void)
		ensure
			cleared: one_block_cell.item = Void
			cleared: lines_cell.item = Void
		end

	one_block: TUPLE [content: STRING_GENERAL; end_index: INTEGER] is
			-- Item in `one_block_cell'
		do
			Result := one_block_cell.item
		end

feature {NONE} -- Implementation

	buffer_string: STRING
			-- Buffer eWeasel string waiting for parse.
		do
			if internal_buffer_string = Void then
				create internal_buffer_string.make_empty
			end
			Result := internal_buffer_string
		ensure
			not_void: Result /= Void
		end

	all_output_string: STRING is
			-- All eWeasel output string.
		do
			if internal_all_output_string = Void then
				create internal_all_output_string.make_empty
			end
			Result := internal_all_output_string
		ensure
			not_void: Result /= Void
		end

	output_buffer: STRING is
			-- Thread library output buffer
			-- This is the ONLY multi-thread critical section of testing tool
		indexing
			once_status: global
		once
			create Result.make_empty
		ensure
			not_void: Result /= Void
		end

	is_need_iteration (a_buffer_string: STRING): BOOLEAN is
			-- If `a_buffer_string' contain a eweasel block which need analyze
		local
			l_finder: ES_EWEASEL_OUTPUT_REGULAR_EXPRESSION_FINDER
		do
			create l_finder
			Result := l_finder.one_result_block (a_buffer_string) /= Void
		end
		
feature {NONE} -- Multi-thread implementation

	mutex: MUTEX is
			-- Mutex used by
		indexing
			once_status: global
		once
			create Result.make
		end

	buffer_string_moving_agent: PROCEDURE [ES_EWEASEL_RESULT_ANALYZER, TUPLE]
			-- Agent instance which created by `start_buffer_string_moving'

	move_process_library_output_to_testing_tool is
			-- Move process library output to Eiffel Studio UI thread in idle actions
		do
			mutex.lock
			if not output_buffer.is_empty then
				on_eweasel_output_testing_tool (output_buffer)
				output_buffer.wipe_out
			end
			mutex.unlock
		end

	on_eweasel_output_testing_tool (a_string: STRING) is
			-- Handle eWeasel output string in Eiffel Studio UI thread
		require
			not_void: a_string /= Void and then not a_string.is_empty
		do
			all_output_string.append (a_string)
			prcess_output (a_string, False)
		ensure
			added: all_output_string.has_substring (a_string)
		end

feature {NONE} -- Cache

	internal_buffer_string: STRING
			-- Instance holder of `buffer_string'

	internal_all_output_string: STRING
			-- Instance holder of `all_output_string'.

	internal_all_results: like all_results;
			-- Instance holder of `all_result'.

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
