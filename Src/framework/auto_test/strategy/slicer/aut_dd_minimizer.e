indexing

	description:

		"Strategy that seeks to minimize test cases by program dd-minimizing (algorithm by Andreas Zeller)"

	copyright: "Copyright (c) 2007, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_DD_MINIMIZER

inherit

	KL_SHARED_STREAMS
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_system: like system; a_player: like player; a_error_handler: like error_handler) is
			-- Create new minimizer.
		require
			a_system_not_void: a_system /= Void
			a_player_not_void: a_player /= Void
			a_error_handler_not_void: a_error_handler /= Void
		do
			system := a_system
			player := a_player
			error_handler := a_error_handler
			step_output_stream := null_output_stream
			create test_cache.make
		ensure
			system_set: system = a_system
			player_set: player = a_player
			error_handler_set: error_handler = a_error_handler
		end

feature -- Access

	system: SYSTEM_I
			-- System

	player: AUT_REQUEST_PLAYER
			-- Player to verify if minimization was successful

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

	last_result: AUT_WITNESS
			-- Last minimized test case

	step_output_stream: KI_TEXT_OUTPUT_STREAM
			-- Outputstream where individual steps of ddmin are logged to

	execution_count: INTEGER
			-- How many executions were needed for last minimization

	total_time: DT_DATE_TIME_DURATION
			-- Total time used for last minimization

	execution_time: DT_DATE_TIME_DURATION
			-- Time used just for execution for last_minimization

feature -- Slicing

	minimize (a_witness: AUT_WITNESS; a_step_output_stream: like step_output_stream) is
			-- Minimize `a_witness' and make result available via `last_result'.
		require
			a_witness_not_void: a_witness /= Void
			a_witness_not_empty: a_witness.count > 0
			a_witness_fails: a_witness.is_fail
			a_step_output_stream_valid: a_step_output_stream /= Void and then a_step_output_stream.is_open_write
		local
			total_timer: AUT_TIMER
			slice: AUT_DD_SLICE
		do
			step_output_stream := a_step_output_stream
			execution_count := 0
			create total_timer.make
			create execution_time.make_precise (0, 0, 0, 0, 0, 0, 0)
			total_timer.start
			create test_cache.make
			create slice.make_from_witness (a_witness)
			slice.include_all
			if slice.count > 1 then
				minimize_recursive (slice, 2)
				create last_result.make_default (last_slice.list)
			else
				last_result := a_witness
			end
			total_timer.calculate_duration
			total_time := total_timer.last_duration
			a_step_output_stream.flush
			step_output_stream := null_output_stream
		ensure
			last_result_not_void: last_result /= Void
			last_result_minimized: last_result.count <= a_witness.count
			failure_is_reproduced: last_result.is_fail and then last_result.is_same_bug (a_witness)
		end

feature {NONE} -- Implementation

	test_cache: ERL_G_TRIE [BOOLEAN, INTEGER]
			-- Cache for test results;
			-- (Every request sequence that has been tested already has an entry in this tree.
			-- If the test failed the entry is `False', if the test passed the entry is `True')

	last_slice: AUT_DD_SLICE
			-- Last slice computed

	minimize_recursive (a_slice: AUT_DD_SLICE; n: INTEGER) is
			-- Minimize `a_witness' by dividing it into `n' subsets.
		require
			a_slice_not_void: a_slice /= Void
			a_slice_not_empty: a_slice.count > 0
			a_slice_fails: a_slice.witness.is_fail
			n_big_enough: n >= 1
			n_small_enough: n <= a_slice.count
		local
			slice_list: DS_LINEAR [AUT_DD_SLICE]
		do
			step_output_stream.put_string ("minimize_recursive start (tc size, n): ")
			step_output_stream.put_integer (a_slice.count)
			step_output_stream.put_string (", ")
			step_output_stream.put_integer (n)
			step_output_stream.put_new_line
			last_slice := Void
			slice_list := a_slice.deltas (n)
			test_slices (slice_list)
			if last_slice /= Void then
				if last_slice.count >= 2 then
					minimize_recursive (last_slice, 2)
				end
			else
				if n > 2 then
					slice_list := a_slice.delta_complements (n)
					test_slices (slice_list)
				else
					-- In the case where `n = 2' `minimize_to_subset' and `minimize_to_complement' amount to the same.
					-- No need to test again.
				end
				if last_slice /= Void then
					if last_slice.count >= 2 then
						minimize_recursive (last_slice, (n - 1).max (2))
					end
				else
					if n < a_slice.count then
						minimize_recursive (a_slice, a_slice.count.min (2*n))
					end
					if last_slice = Void then
						last_slice := a_slice
					end
				end
			end
			step_output_stream.put_string ("minimize_recursive end (min size): ")
			step_output_stream.put_integer (last_slice.count)
			step_output_stream.put_new_line
		ensure
			last_slice_not_void: last_slice /= Void
			last_slice_minimized: last_slice.count <= a_slice.count
		end

	test_slices (a_list: DS_LINEAR [AUT_DD_SLICE]) is
			-- Test all items in `a_list' and see if there is one that fails in the same
			-- way as its witness. If there is one, make it available via `last_slice' otherwise
			-- set `last_slice' to `Void'.
		require
			a_list_not_void: a_list /= Void
			a_list_does_not_have_void: not a_list.has (Void)
		local
			cs: DS_LINEAR_CURSOR [AUT_DD_SLICE]
			i: INTEGER
			candidate_list: DS_LIST [AUT_REQUEST]
			candidate_witness: AUT_WITNESS
		do
			step_output_stream.put_line ("test slices: ")
			last_slice := Void
			from
				cs := a_list.new_cursor
				cs.start
				i := 1
			until
				cs.off or last_slice /= Void
			loop
				cs.item.append_debugging_info (step_output_stream)
				test_cache.search (cs.item.index_list)
				if test_cache.last_found then
						-- We have tested this slice already
					if not test_cache.last_item then
						step_output_stream.put_line (" (cached) found same bug")
						-- The test failed then
						last_slice := cs.item
					else
						step_output_stream.put_line (" (cached)")
						cs.forth
						i := i + 1
					end
				else
					candidate_list := cs.item.fresh_list
					player.set_request_list (candidate_list)
					execute_task (player)
					create candidate_witness.make_default (candidate_list)
					if candidate_witness.is_fail and then cs.item.witness.is_same_bug (candidate_witness) then
						step_output_stream.put_line (" found same bug")
						last_slice := cs.item
						test_cache.put (False, cs.item.index_list)
					else
						test_cache.put (True, cs.item.index_list)
						step_output_stream.put_new_line
						cs.forth
						i := i + 1
					end

				end
			end
			cs.go_after
			if last_slice = Void then
				step_output_stream.put_line ("no success")
			else
				step_output_stream.put_string ("new minimum: " )
				step_output_stream.put_integer (i)
				step_output_stream.put_new_line
			end
		end

	execute_task (a_task: AUT_TASK) is
			-- Execute task `a_task'.
		require
			a_task_not_void: a_task /= Void
		local
			timer: AUT_TIMER
		do
			execution_count := execution_count + 1
			create timer.make
			timer.start
			from
				a_task.start
			until
				not a_task.has_next_step
			loop
				a_task.step
			end
			timer.calculate_duration
			execution_time := execution_time + timer.last_duration
		end

invariant

	error_handler_not_void: error_handler /= Void
	system_attached: system /= Void
	player_not_void: player /= Void
	step_output_stream_valid: step_output_stream /= Void and then step_output_stream.is_open_write
	test_cache_not_void: test_cache /= Void

end
