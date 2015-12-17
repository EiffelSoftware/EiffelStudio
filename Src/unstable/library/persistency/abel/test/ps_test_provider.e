note
	description: "[
		The ancestor for provider classes of backend-neutral tests.
		Each test defined in a descendants of this class should provide the following:
			- The test does not take any arguments
			- The test shall leave an empty database after execution
			- The test can assume an empty database before execution
		Additionaly, the provider class should be instantiated using the make feature defined here.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_TEST_PROVIDER

inherit

	PS_ABEL_EXPORT
		undefine
			default_create
		end

	EQA_TEST_SET
		export
			{NONE} all
		end

feature {PS_TEST_PROVIDER}

	repository: PS_REPOSITORY
			-- The repository to operate on

--	executor: PS_EXECUTOR
			-- An executor for `repository'

	repo_access: PS_TRANSACTION

	test_data: PS_TEST_DATA
			-- Some useful test data

	make (a_repository: PS_REPOSITORY)
			-- Initialization for `Current'
		do
			default_create
			repository := a_repository
--			create executor.make (repository)
			repo_access := repository.new_transaction
--			create {PS_REPOSITORY_ACCESS_IMPL} repo_access.make (repository)
			create test_data.make
			initialize
		end

	initialize
			-- Initialize every other field
		do
		end


	test_read_write_cycle (object: ANY; update_operation: detachable PROCEDURE [ANY])
			-- Perform a write-read test on `object' with a possible `update_operation'.
		local
			context: PS_TRANSACTION
			query: PS_QUERY [ANY]
			first_count: INTEGER
			second_count: INTEGER
		do
			repository.wipe_out
			context := repository.new_transaction
			context.insert (object)

			create query.make
			query.set_type (object.generating_type)

			context.execute_query (query)
			assert ("Insert-Retrieve cycle failed!", across query as cursor some cursor.item.is_deep_equal (object) end)

			if attached update_operation then
				across
					query as cursor
				loop
					first_count := first_count + 1
				end

				update_operation.call ([object])

				query.reset
				context.execute_query (query)

				across
					query as cursor
				loop
					second_count := second_count + 1
				end

				assert ("Query count has changed.", first_count = 1 implies second_count = 1)
				assert ("Update-Retrieve cycle failed.", across query as cursor some cursor.item.is_deep_equal (object) end)
			end
			query.close
			context.commit
		end


	test_read_write_cycle_with_root (an_object: ANY; update_operation: detachable PROCEDURE [ANY])
			-- Perform a write-read test on `object' with a possible `update_operation'.
			-- Use root object status.
		local
			object: ANY
			context: PS_TRANSACTION
			query: PS_QUERY [ANY]
			cursor: ITERATION_CURSOR [ANY]
		do
			object := an_object

			repository.wipe_out
			context := repository.new_transaction
			context.insert (object)

			if not context.is_expanded (object.generating_type) then
				assert ("Object is not persistent", context.is_persistent (object))
				assert ("Object is not root", context.is_root (object))
			end

			create query.make
			query.set_type (object.generating_type)
			query.set_is_non_root_ignored (True)

			context.execute_query (query)
			cursor := query.new_cursor
			assert ("Query is empty", not cursor.after)
			assert ("Insert-Retrieve cycle failed!", cursor.item.is_deep_equal (object))

			if not context.is_expanded (object.generating_type) then

				assert ("Retrieved object is not root", context.is_root (cursor.item))
			end

			cursor.forth
			assert ("More than one result.", cursor.after)

			if not context.is_expanded (object.generating_type) then

				if attached update_operation then

					query.close

					update_operation.call ([object])
					context.update (object)

					create query.make
					query.set_type (object.generating_type)
					query.set_is_non_root_ignored (True)

					context.execute_query (query)
					cursor := query.new_cursor

					cursor := query.new_cursor
					assert ("Query is empty", not cursor.after)
					assert ("Update-Retrieve cycle failed!", cursor.item.is_deep_equal (object))

					cursor.forth
					assert ("More than one result.", cursor.after)
				end

				context.unmark_root (object)
				assert ("Object is still root", not context.is_root (object))

				query.close
				create query.make
				query.set_type (object.generating_type)
				query.set_is_non_root_ignored (True)

				context.execute_query (query)
				cursor := query.new_cursor

				assert ("Query is not empty", cursor.after)

				context.mark_root (object)
				assert ("Object not declared as root", context.is_root (object))

				query.close
				create query.make
				query.set_type (object.generating_type)
				query.set_is_non_root_ignored (True)

				context.execute_query (query)
				cursor := query.new_cursor

				assert ("Query is empty", not cursor.after)
				assert ("Object has changed!", cursor.item.is_deep_equal (object))

				cursor.forth
				assert ("More than one result.", cursor.after)

			end


			query.close
			context.commit
		end

end
