note
	description: "Tests ABELs transaction capabilities"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TRANSACTION_TESTS

inherit
	PS_TEST_PROVIDER

create make

feature {PS_REPOSITORY_TESTS}

	test_no_lost_update
		-- Test if a lost update can happen.
		local
			some_person: PERSON
			t1, t2: PS_TRANSACTION
			q1, q2: PS_OBJECT_QUERY[PERSON]
		do
			create some_person.make ("first_name", "last_name", 0)
			executor.execute_insert (some_person)

			t1:= executor.new_transaction
			t2:= executor.new_transaction
			create q1.make
			create q2.make

			-- Simulate a race condition between two transactions that want to update some_person
			-- t1 reads some_person
			executor.execute_query_within_transaction (q1, t1)

			-- t2 reads, updates and commits
			executor.execute_query_within_transaction (q2, t2) -- This step can abort already in lock-based systems

			if q2.result_cursor.after then -- Transaction has been aborted
				-- A commit has to fail now
				t2.commit
				assert ("The transaction should be aborted", t2.has_error)
			else  -- Transaction has not been aborted (which is the case in multiversion concurrency control)
				-- Let T2 finish its update
				q2.result_cursor.item.add_item
				executor.execute_update_within_transaction (q2.result_cursor.item, t2)
				t2.commit

				-- t1 now updates, but it has to fail at commit time
				q1.result_cursor.item.add_item
				executor.execute_update_within_transaction (q1.result_cursor.item, t1)
				t1.commit

				assert ("The transaction should be aborted", t1.has_error and then attached{PS_TRANSACTION_CONFLICT} t1.error)
			end
			repository.clean_db_for_testing
		end


	test_no_dirty_reads
		-- Test if a dirty read can happen.
		local
			some_person: PERSON
			t1, t2: PS_TRANSACTION
			q1, q2, q3: PS_OBJECT_QUERY[PERSON]
		do
			create some_person.make ("first_name", "last_name", 0)
			executor.execute_insert (some_person)

			t1:= executor.new_transaction
			t2:= executor.new_transaction
			create q1.make
			create q2.make

			-- Simulate a dirty read
			-- t1 reads and updates some_person
			executor.execute_query_within_transaction (q1, t1)
			q1.result_cursor.item.add_item
			executor.execute_update_within_transaction (q1.result_cursor.item, t1)

			-- t2 reads, updates and commits
			executor.execute_query_within_transaction (q2, t2) -- This can block and abort in lock-based systems

			if q2.result_cursor.after then -- Query has been aborted, which is great
				-- A commit at this time has to fail
				t2.commit
				assert ("Transaction should have an error", t2.has_error)
			else -- If we have multi-version concurrency control
				q2.result_cursor.item.add_item
				executor.execute_update_within_transaction (q2.result_cursor.item, t2)
				t2.commit
			end


			-- t1 now does a rollback
			t1.rollback

			create q3.make
			executor.execute_query (q3)
			-- Now ensure that t2 has not read the dirty value
			assert ("The items_owned attribute is equal to two, which implies that t2 has read a dirty value", q3.result_cursor.item.items_owned < 2)
			repository.clean_db_for_testing

		end


	test_repeatable_read
		-- Test if a non-repeatable read can happen
		local
			some_person: PERSON
			t1, t2: PS_TRANSACTION
			q1, q2, q3: PS_OBJECT_QUERY[PERSON]
		do
			create some_person.make ("first_name", "last_name", 0)
			executor.execute_insert (some_person)

			t1:= executor.new_transaction
			t2:= executor.new_transaction
			create q1.make
			create q2.make
			create q3.make

			-- Simulate a non-repeatable read
			-- t1 reads some_person
			executor.execute_query_within_transaction (q1, t1)

			-- t2 updates some_person and commits
			executor.execute_query_within_transaction (q2, t2)
			if q2.result_cursor.after then -- T2 has been aborted, which is good in lock-based systems
				t2.commit
				assert ("The transaction should have an error", t2.has_error)
			else
				q2.result_cursor.item.add_item
				executor.execute_update_within_transaction (q2.result_cursor.item, t2)
				t2.commit
			end


			-- t1 reads again some_person
			executor.execute_query_within_transaction (q3, t1)

			-- Now ensure that t1 has read the same value twice
			assert ("T1 has suffered a non-repeadable read", q1.result_cursor.item.items_owned = q3.result_cursor.item.items_owned)
			repository.clean_db_for_testing

		end


	test_correct_insert_rollback
		-- Test if an object inserted within an aborted transaction gets removed correctly
		local
			some_person: PERSON
			t1: PS_TRANSACTION
			q1, q2: PS_OBJECT_QUERY[PERSON]
		do
			create some_person.make ("first_name", "last_name", 0)
			t1:= executor.new_transaction
			create q1.make
			create q2.make

			executor.execute_insert_within_transaction (some_person, t1)
			executor.execute_query_within_transaction (q1, t1)
			assert ("Person not inserted", not q1.result_cursor.after)

			t1.rollback

			executor.execute_query (q2)
			assert ("Result not empty", q2.result_cursor.after)
			assert ("Person not properly removed", not executor.is_persistent_within_transaction (some_person, executor.new_transaction) and not executor.is_persistent_within_transaction (q1.result_cursor.item, executor.new_transaction))

			repository.clean_db_for_testing
		end


	test_correct_update_rollback
		-- Test if an object updated within an aborted transaction gets rolled back correctly
		local
			some_person: PERSON
			t1: PS_TRANSACTION
			q1, q2: PS_OBJECT_QUERY[PERSON]
		do
			create some_person.make ("first_name", "last_name", 0)
			executor.execute_insert (some_person)
			t1:= executor.new_transaction
			create q1.make
			create q2.make

			executor.execute_query_within_transaction (q1, t1)
			q1.result_cursor.item.add_item
			executor.execute_update_within_transaction (q1.result_cursor.item, t1)

			executor.execute_query_within_transaction (q2, t1)
			assert ("Not updated correctly", q2.result_cursor.item.is_deep_equal (q1.result_cursor.item))

			t1.rollback

			q2.reset
			executor.execute_query (q2)
			assert ("Update not rolled back", q2.result_cursor.item.is_deep_equal (some_person))
			repository.clean_db_for_testing
		end



	test_correct_delete_rollback
		-- Test if an object deleted within an aborted transaction gets inserted again
		local
			some_person: PERSON
			t1: PS_TRANSACTION
			q1, q2: PS_OBJECT_QUERY[PERSON]
		do
			create some_person.make ("first_name", "last_name", 0)
			executor.execute_insert (some_person)
			t1:= executor.new_transaction
			create q1.make
			create q2.make

			executor.execute_delete_within_transaction (some_person, t1)
			executor.execute_query_within_transaction (q1, t1)
			assert ("Not deleted correctly", q1.result_cursor.after)

			t1.rollback

			executor.execute_query (q2)
			assert ("Item not present in database", not q2.result_cursor.after)
			assert ("Object not known any more", executor.is_persistent_within_transaction (some_person, executor.new_transaction))
			repository.clean_db_for_testing
		end


end
