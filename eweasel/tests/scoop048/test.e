note
	description: "Try many different combinations of queries and calls on two possibly failed separate objects."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	original_source: "http://se.inf.ethz.ch/student_projects/florian_besser/code.zip"
	original_tests: "SCOOP testsuite/Internal Test Suite/"

class
	TEST

create
	make

feature -- Test control constants

	is_random_testing: BOOLEAN = True

	test_run_count: INTEGER = 2

	call_count: INTEGER = 1000

	job_count: INTEGER = 14

	debug_on: BOOLEAN = False

feature -- Access

	is_p_dirty: BOOLEAN
			-- Is processor P dirty?

	is_q_dirty: BOOLEAN
			-- Is processor Q dirty?

	is_test_failed: BOOLEAN
			-- Is there a failure within the test?
			-- A failure happens when an unexpected exception happens, or an expected exception does not occur.

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			i, max: INTEGER
			last_percentage, now_percentage: REAL_64
			stop: BOOLEAN
		do
			from
				i := 1
			until
				i > test_run_count
			loop
				prepare_and_run_test
				i := i + 1
			end
		end

feature -- Test execution

	prepare_and_run_test
			-- Initialize state and workers and run the test.
		local
			p, q: separate WORKER
			retried: BOOLEAN
		do
			if not retried then
				create p
				create q
				is_p_dirty := False
				is_q_dirty := False
				is_test_failed := False
				run_test (p, q)
			end
		rescue
			print ("ERROR: Probably reached maximum SCOOP Processors.%N")
			retried := True
			retry
		end

	run_test (p, q: separate WORKER)
			-- Run different combinations of calls.
		local
			saved_is_p_dirty, saved_is_q_dirty: BOOLEAN
			i, next_job: INTEGER
			random: RANDOM
			sync: POINTER
		do
			from
				i := 1
				random := new_random_generator
					-- Make sure these objects are locked!
				sync := p.default_pointer
				sync := q.default_pointer

			until
				i > call_count or is_test_failed
			loop
				saved_is_p_dirty := is_p_dirty
				saved_is_q_dirty := is_q_dirty
				if is_random_testing then
					random.forth
					next_job := random.item \\ job_count
				else
					next_job := i \\ job_count
				end
					-- Jobs start at 1.
				next_job := next_job + 1
				execute_job (next_job, p, q)
				if is_test_failed then
					print ("ERROR: A test failed. Job number: " + next_job.out + " / is_p_dirty: " + saved_is_p_dirty.out + " / is_q_dirty: " + saved_is_q_dirty.out + "%N")
				end
				i := i + 1
			end
		end

	execute_job (job: INTEGER; p, q: separate WORKER)
			-- Execute one of the features in {WORKER} and update state accordingly.
			-- Return False if an unexpected exception happens.
		local
			is_error_expected: BOOLEAN
			sync: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				inspect job
				when 1 then

						-- Predict exception.
					is_error_expected := is_p_dirty

						-- Update state: Exception in P (if any) has propagated now.
					is_p_dirty := False

						-- Perform call
					print_debug ("Debug: Executing job 1: Send async call p -> q%N")
					sync := p.send_async_call (q)
				when 2 then

						-- Predict exception.
					is_error_expected := is_p_dirty

						-- Update state.
						--If P is already failed, no call to Q will be logged.
					if not is_error_expected then
						is_q_dirty := True
					end
						-- Update state: Exception in P (if any) has propagated now.
					is_p_dirty := False

					if not is_p_dirty then
						print_debug ("Debug: Executing job 2: Send async call p -> q and FAIL. Setting Q dirty.%N")
					else
						print_debug ("Debug: Executing job 2: Send async call p -> q and FAIL. Setting Q NOT dirty since P is dirty.%N")
					end

						-- Perform call
					sync := p.send_async_call_fail (q)
				when 3 then

						-- Predict exception.
					is_error_expected := is_p_dirty or is_q_dirty

						-- Update state
					if not is_p_dirty then
							-- When P was dirty, exception already happend in P.
							-- Q didn't have a chance to get rid of its own dirtyness.
						is_q_dirty := False
					end
					is_p_dirty := False
					print_debug ("Debug: Executing job 3: Send sync call p -> q%N")
					sync := p.send_sync_call (q)
				when 4 then

						-- Predict exception.
					is_error_expected := True

						-- Update state
					if not is_p_dirty then
							-- When P was dirty, exception already happend in P.
							-- Q didn't have a chance to get rid of its own dirtyness.
						is_q_dirty := False
					end
					is_p_dirty := False
					print_debug ("Debug: Executing job 4: Send sync call p -> q and FAIL%N")
					sync := p.send_sync_call_fail (q)
						--Do not set a flag, sine exception should be immediately returned

				when 5 then

						-- Predict exception.
					is_error_expected := is_p_dirty

						-- Update state.
					is_p_dirty := False

						-- Perform call.
					print_debug ("Debug: Executing job 5: Send self call p -> p%N")
					sync := p.send_self_call
				when 6 then
						-- Predict exception.
					is_error_expected := True

						-- Update state.
					is_p_dirty := False

						-- Perform call.
					print_debug ("Debug: Executing job 6: Send self call p -> p and FAIL%N")
					sync := p.send_self_call_fail
				when 7 then
						-- Predict exception.
					is_error_expected := is_q_dirty

						-- Update state.
					is_q_dirty := False

						-- Perform call.
					print_debug ("Debug: Executing job 7: Send async call q -> p%N")
					sync := q.send_async_call (p)
				when 8 then
						-- Predict exception.
					is_error_expected := is_q_dirty

						-- Update state.
						--If Q is already failed, no call to P will be logged.
					if not is_error_expected then
						is_p_dirty := True
					end
					is_q_dirty := False

						-- Perform call.
					if not is_q_dirty then
						print_debug ("Debug: Executing job 8: Send async call q -> p and FAIL. Setting P dirty.%N")
					else
						print_debug ("Debug: Executing job 8: Send async call q -> p and FAIL. Setting P NOT dirty since Q is dirty.%N")
					end
					sync := q.send_async_call_fail (p)
				when 9 then
						-- Predict exception.
					is_error_expected := is_p_dirty or is_q_dirty

						-- Update state.
					if not is_q_dirty then
							-- When Q was dirty, exception already happend in Q.
							-- P didn't have a chance to get rid of its own dirtyness.
						is_p_dirty := False
					end
					is_q_dirty := False

						-- Perform call.
					print_debug ("Debug: Executing job 9: Send sync call q -> p%N")
					sync := q.send_sync_call (p)
				when 10 then
						-- Predict exception.
					is_error_expected := True

						-- Update state.
					if not is_q_dirty then
							-- When Q was dirty, exception already happend in Q.
							-- P didn't have a chance to get rid of its own dirtyness (if any).
						is_p_dirty := False
					end
					is_q_dirty := False

						-- Perform call.
					print_debug ("Debug: Executing job 10: Send sync call q -> p and FAIL%N")
					sync := q.send_sync_call_fail (p)
				when 11 then
						-- Predict exception.
					is_error_expected := is_q_dirty

						-- Update state.
					is_q_dirty := False

						-- Perform call.
					print_debug ("Debug: Executing job 11: Send self call q -> q%N")
					sync := q.send_self_call
				when 12 then
						-- Predict exception.
					is_error_expected := True

						-- Update state.
					is_q_dirty := False

						-- Perform call.
					print_debug ("Debug: Executing job 12: Send self call q -> q and FAIL%N")
					sync := q.send_self_call_fail
				when 13 then
						-- Set P as dirty.
					is_error_expected := False
					is_p_dirty := True
					p.receive_async_call_fail
				when 14 then
						-- Set Q as dirty.
					is_error_expected := False
					is_q_dirty := True
					q.receive_async_call_fail
				else
					print ("ERROR: Unknown job number.%N")
				end
				if is_error_expected then
					print ("ERROR: We excpected an exception that has not happened!%N")
					is_test_failed := True
				end
			end
		rescue
			if not is_error_expected then
				print ("ERROR: An exception has happened that we did not expect!%N")
				is_test_failed := True
			end
			retried := True
			retry
		end

feature {NONE} -- Utilities

	new_random_generator: RANDOM
			-- Create a random generator with the current time as seed.
		local
			time: C_DATE -- Using C_DATE to avoid compiling many classes.
			seed: INTEGER
		do
			create time.make_utc
			seed := time.hour_now
			seed := seed * 60 + time.minute_now
			seed := seed * 60 + time.second_now
			seed := seed * 1000 + time.millisecond_now
			create Result.set_seed (seed)
		end

	print_debug (s: STRING)
			-- Print statement to hide debugging output.
		do
			if debug_on then
				print (s)
			end
		end

end
