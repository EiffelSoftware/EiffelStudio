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
		do
			check_failure (
				agent (q1, q2: PS_QUERY [TEST_PERSON]; tx1, tx2: PS_TRANSACTION)
						-- Simulate a lost update situation.
					local
						l_cursor1, l_cursor2: ITERATION_CURSOR [TEST_PERSON]
					do
							-- T1 reads
							-- T2 reads, updates and commits
							-- T1 updates and commits
							--> At least one transaction has to fail.

						tx1.execute_query (q1)
						l_cursor1 := q1.new_cursor


							-- The next step may abort in lock-based systems
						tx2.execute_query (q2)
						l_cursor2 := q2.new_cursor

						l_cursor2.item.add_item
						tx2.update (l_cursor2.item)
						q2.close
						tx2.commit


						l_cursor1.item.add_item
						tx1.update (l_cursor1.item)
						q1.close
						tx1.commit

							-- By now at least one transaction has to fail.
						assert ("The transaction should be aborted", False)
					end
			)
		end

	test_no_dirty_read
			-- Test if a dirty read can happen.
		do
			check_failure (
				agent (q1, q2: PS_QUERY [TEST_PERSON]; tx1, tx2: PS_TRANSACTION)
						-- Simulate a dirty read situation.
					local
						l_cursor: ITERATION_CURSOR [TEST_PERSON]
					do
							-- T1 reads and updates
							-- T2 reads
							-- T1 does a rollback
							--> T2 either reads an old value, or fails.

						tx1.execute_query (q1)
						l_cursor := q1.new_cursor
						l_cursor.item.add_item
						tx1.update (l_cursor.item)
						q1.close

							-- The next step may abort in lock-based systems
						tx2.execute_query (q2)
						l_cursor := q2.new_cursor

							-- In Snapshot Isolation, T2 has to read an old value.
						assert ("A dirty read has happened", l_cursor.item.items_owned = 0)

						tx1.rollback
						q2.close
						tx2.commit
					end
			)
		end

	test_repeatable_read
		-- Test if a non-repeatable read can happen
		do
			check_failure (
				agent (q1, q2: PS_QUERY [TEST_PERSON]; tx1, tx2: PS_TRANSACTION)
						-- Simulate a non-repeatable read situation.
					local
						l_cursor: ITERATION_CURSOR [TEST_PERSON]
					do
							-- T1 reads
							-- T2 reads, updates and commits
							-- T1 reads again
							--> T1 has to read the same value twice. T2 may fail.

						tx1.execute_query (q1)
						assert ("The items_owned attribute is not zero on first read", q1.new_cursor.item.items_owned = 0)

							-- The next step may abort in lock-based systems
						tx2.execute_query (q2)
						l_cursor := q2.new_cursor

						l_cursor.item.add_item
						tx2.update (l_cursor.item)
						q2.close
						tx2.commit

						q1.reset
						tx1.execute_query (q1)
						assert ("The items_owned attribute is not zero on second read", q1.new_cursor.item.items_owned = 0)

						q1.close
						tx1.commit
					end
			)
		end

	test_correct_insert_rollback
			-- Test if an object inserted within an aborted transaction gets removed correctly
		local
			some_person: TEST_PERSON
			retrieved_person: TEST_PERSON
			q1, q2: PS_QUERY [TEST_PERSON]

			transaction: PS_TRANSACTION
			l_cursor1, l_cursor2: ITERATION_CURSOR [TEST_PERSON]
		do
			create some_person.make ("first_name", "last_name", 0)

			transaction := repository.new_transaction
			create q1.make
			create q2.make

			transaction.insert (some_person)
			transaction.execute_query (q1)
			l_cursor1 := q1.new_cursor

			assert ("Person not inserted", not l_cursor1.after)
			retrieved_person := l_cursor1.item

			q1.close
			transaction.rollback

			repository.execute_query (q2)
			l_cursor2 := q2.new_cursor
			assert ("Result not empty", l_cursor2.after)

			transaction.prepare
			assert ("Person not properly removed", not transaction.is_persistent (some_person) and not transaction.is_persistent (retrieved_person))
			transaction.commit

			q2.close

			repository.wipe_out
		end


	test_correct_update_rollback
			-- Test if an object updated within an aborted transaction gets rolled back correctly
		local
			some_person: TEST_PERSON
			q1, q2: PS_QUERY [TEST_PERSON]

			transaction: PS_TRANSACTION
			l_cursor1, l_cursor2: ITERATION_CURSOR [TEST_PERSON]
		do
			create some_person.make ("first_name", "last_name", 0)
			transaction := repository.new_transaction

			transaction.insert (some_person)
			transaction.commit
			transaction.prepare

			create q1.make
			create q2.make

			transaction.execute_query (q1)
			l_cursor1 := q1.new_cursor

			l_cursor1.item.add_item
			transaction.update (l_cursor1.item)

			transaction.execute_query (q2)
			l_cursor2 := q2.new_cursor

			assert ("Not updated correctly", l_cursor2.item.is_deep_equal (l_cursor1.item))

			q1.close
			q2.reset
			transaction.rollback

			repository.execute_query (q2)
			l_cursor2 := q2.new_cursor
			assert ("Update not rolled back", l_cursor2.item.is_deep_equal (some_person))
			q2.close
			repository.wipe_out
		end



	test_correct_delete_rollback
			-- Test if an object deleted within an aborted transaction gets inserted again
		local
--			some_person: TEST_PERSON
--			t1: PS_INTERNAL_TRANSACTION
--			q1, q2: PS_OBJECT_QUERY [TEST_PERSON]
		do
--			create some_person.make ("first_name", "last_name", 0)
--			executor.execute_insert (some_person)
--			t1:= executor.new_transaction
--			create q1.make
--			create q2.make

--			executor.execute_delete_within_transaction (some_person, t1)
--			executor.execute_query_within_transaction (q1, t1)
--			assert ("Not deleted correctly", q1.stable_cursor.after)

--			t1.rollback

--			executor.execute_query (q2)
--			assert ("Item not present in database", not q2.stable_cursor.after)
--			assert ("Object not known any more", executor.is_persistent_within_transaction (some_person, executor.new_transaction))
--			repository.clean_db_for_testing
		end


feature {NONE} -- Support

	check_failure (action: PROCEDURE [
			PS_QUERY [TEST_PERSON],
			PS_QUERY [TEST_PERSON],
			PS_TRANSACTION,
			PS_TRANSACTION])
			-- Call `action' and check if it triggers a transaction conflict.
		local
			q1, q2: detachable PS_QUERY [TEST_PERSON]
			tx1, tx2: detachable PS_TRANSACTION
			init: PS_TRANSACTION

			some_person: TEST_PERSON
			retried: BOOLEAN
		do

			if not retried then

				create some_person.make ("first_name", "last_name", 0)

				init := repository.new_transaction
				init.insert (some_person)
				init.commit


				tx1 := repository.new_transaction
				tx2 := repository.new_transaction

				create q1.make
				create q2.make

				action.call ([q1, q2, tx1, tx2])

			end

			if attached q1 then
				q1.close
			end

			if attached q2 then
				q2.close
			end

			if attached tx1 and then tx1.is_active then
				tx1.rollback
			end

			if attached tx2 and then tx2.is_active then
				tx2.rollback
			end

			repository.wipe_out

		rescue
			if
				(attached tx1 and then attached {PS_TRANSACTION_ABORTED_ERROR} tx1.last_error)
				or (attached tx2 and then attached {PS_TRANSACTION_ABORTED_ERROR} tx2.last_error)
			then
				retried := True
				retry
			end
		end
end
