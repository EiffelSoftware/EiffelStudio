note
	description: "Several small tests for exception handling in SCOOP"
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	original_source: "http://se.inf.ethz.ch/student_projects/florian_besser/code.zip"
	original_test: "SCOOP testsuite/Small Tests/, %
				%SCOOP testsuite/Large Tests/Worker Aggregator"


class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run all small tests from the original test suite.
		do
			test_build_house
			io.put_new_line

			test_call_api
			io.put_new_line

			test_chain_purge
			io.put_new_line

			test_read_file
			io.put_new_line

			test_worker_aggregator
			io.put_new_line
		end

feature -- Original test: Build-A-House

	test_build_house
			-- Test that an exception is thrown upon synchronization.
		local
			house: separate HOUSE
			success: BOOLEAN
		do
			create house
			success := build_house (house)

			if success then
				print ("ERROR: House successfully built.%N")
			else
				print ("OK: Failed to build house.%N")
			end
		end

	build_house (h: separate HOUSE): BOOLEAN
			-- Build with several commands and a query.
		local
			retried: BOOLEAN
		do
			if not retried then

				h.build_foundation

					-- This causes an exception.
				h.build_walls

				h.build_roof

					-- Make sure we didn't get the exception so far.
				print ("OK: Exception not yet propagated.%N")

				Result := h.is_finished

				print ("ERROR: Exception still not propagated.%N")
			end
		rescue
			retried := True
			retry
		end

feature -- Original test: Call API

	test_call_api
			-- Test exceptions on a wrong API call.
		local
			worker: separate WORKER
			retried: BOOLEAN
		do
			if not retried then
				create worker
				worker_invalid_call (worker)
			end
		rescue
			print ("OK: test_call_api has failed as it should.%N")
			retried := True
			retry
		end

	worker_invalid_call (worker: separate WORKER)
			-- SCOOP helper feature.
		local
			sync: INTEGER
		do
			worker.do_invalid_call
			sync := worker.counter
		end

feature -- Original test: Chain Purge

	maximum_calls: INTEGER = 1000

	test_chain_purge
			-- Test that no calls are lost for objects that suffered and recovered from an exception.
		local
			w: separate WORKER
			retried: BOOLEAN
		do
			if not retried then
				create w
				add_work(w)		--And now RELEASE Lock, so no exception will happen
				query_work(w)	--here!
			end
		rescue
			print ("ERROR: test_chain_purge has failed.%N")
			retried := True
			retry
		end

	add_work (worker: separate WORKER)
			-- Add `maximum_calls' calls to the request queue of `worker'.
		do
			across 
				1 |..| maximum_calls as i
			loop
					-- The call fails, but `worker' will recover locally.
				worker.work
			end
		rescue
			print ("ERROR: add_work has failed.%N")
		end

	query_work (worker: separate WORKER)
			-- Check if the number of executed calls match.
		local
			executed_calls: INTEGER
		do
			executed_calls := worker.counter

			if executed_calls = maximum_calls then
				print ("OK: No calls were thrown away.%N")
			else
				print ("ERROR: Some calls were thrown away.%N")
			end
		rescue
			print ("ERROR: query_work has failed.%N")
		end

feature -- Original test: Read File

	test_read_file
			-- Test if exceptions from reading non-existing files are correctly propagated.
		local
			worker: separate WORKER
			retried: BOOLEAN
		do
			if not retried then
				create worker
				worker_read_file (worker)
				print ("ERROR: No exception propagated.%N")
			end
		rescue
			print ("OK: Exception successfully propagated.%N")
			retried := True
			retry
		end

	worker_read_file (worker: separate WORKER)
			-- SCOOP helper feature.
		local
			sync: INTEGER
		do
			worker.read_file
			sync := worker.counter -- Synchronize to get exception.
		end

feature -- Original test: Worker Aggregator

	test_worker_aggregator
			-- Test that an exception is truly lost when passing a dirty 
			-- separate object to another processor.
		local
			aggregator: separate AGGREGATOR
			worker: separate WORKER
			retried: BOOLEAN
		do
			if not retried then 
				create aggregator

				across 
					1 |..| 5 as i
				loop
					create worker
					worker_fail_work (worker)	--Exception should be lost after this call.
					aggregator_receive_worker (aggregator, worker)
				end
				print ("OK: test_worker_aggregator successfully terminated.%N")
			end
		rescue
			print ("ERROR: Exception propagated in test_worker_aggregator.%N")
			retried := True
			retry
		end

	worker_fail_work (worker: separate WORKER)
			-- SCOOP helper feature.
		do
			worker.fail_work
		end

	aggregator_receive_worker (aggregator: separate AGGREGATOR; worker: separate WORKER)
			-- SCOOP helper feature.
		do
			aggregator.receive_worker (worker)
		end

end
