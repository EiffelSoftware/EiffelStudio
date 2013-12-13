note
	description: "The main TUTORIAL class."
	author: "Roman Schmocker, Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

-- This class shows the use of the old, obsolete public API.
-- The interface is still used in the test suite, but it is no longer exported to {ANY}.

class TUTORIAL

--inherit
--	ARGUMENTS

--	PS_EIFFELSTORE_EXPORT

--create
--	make

--feature 	-- Tutorial exploration features

--	explore
--			-- Tutorial code.
--		local
--			p1, p2, p3: PERSON
--			c1, c2, c3: CHILD
--			in_memory_repo, mysql_repo: PS_DEFAULT_REPOSITORY
--		do
--			print ("---o--- ABEL Tutorial ---o---")
--			io.new_line
----			mysql_repo := repo_factory.create_mysql_repository_with_default_host_port ("tutorial","tutorial","tutorial")
----			create executor.make (mysql_repo)
--			in_memory_repo := repo_factory.create_in_memory_repository
--			create executor.make (in_memory_repo)
--			print ("Insert 3 new persons in the database")
--			io.new_line
--			create p1.make ("Albo", "Bitossi")
--			p1.celebrate_birthday
--			executor.execute_insert (p1)
--			create p2.make ("Berno", "Citrini")
--			p2.celebrate_birthday
--			p2.celebrate_birthday
--			p2.celebrate_birthday
--			executor.execute_insert (p2)
--			create p3.make ("Dumbo", "Ermini")
--			executor.execute_insert (p3)
--			print ("Query the database for persons and print result")
--			print_result (simple_query)
--			print ("Update an existing person in the database and print result")
--			p2.celebrate_birthday
--			executor.execute_update (p2)
--			print_result (simple_query)
--			print ("Delete Dumbo Ermini from the database and print result")
--			executor.execute_delete (p3)
--			print_result (simple_query)
----			-- Uncomment the following 2 lines to have a failing update of an object not known to ABEL
----			--print ("A failing update...")
----			--failing_update
----			-- Uncomment the following 2 lines to have a failing delete of an object not known to ABEL
----			--print ("A failing delete...")			
----			--failing_delete
--			print ("Combined criterion example: search for an Albo Bitossi who is not 20")
--			print_result (query_with_composite_criterion)
--			print ("Delete Albo Bitossi using a deletion query")
----			delete_person_with_deletion_query ("Bitossi")
----			print_result (simple_query)
--			print ("Insert 3 children in the database")
--			create c1.make ("Baby", "Doe")
--			create c2.make ("John", "Doe")
--			create c3.make ("Grandpa", "Doe")
--			c1.set_father (c2)
--			c2.set_father (c3)
--			executor.execute_insert (c1)
--			io.new_line
--			print ("Query the database for children and print result")
--			print_children_result (query_for_children)
--			print ("Inserting John Doe has no effect")
--			executor.execute_insert (c2)
--			print_children_result (query_for_children)
--			print ("Updating John Doe has no effect")
--			if attached {CHILD} c1.father as dad then
--				dad.celebrate_birthday
--			end
--			executor.execute_update (c1)
--			print_children_result (query_for_children)
--			print ("Celebrating the birthday for all PERSON objects in the repository")
--			update_ages
--			print_result (simple_query)
--		end

--feature {NONE} -- Initialization

--	make
--		-- Tutorial initialization.
--		do
--			create factory
--			create repo_factory
--			create my_visitor
--			explore
--		end

--feature -- Access

--	executor: PS_EXECUTOR
--		-- The executor of database operations used throughout the tutorial.

--	factory: PS_CRITERION_FACTORY
--		-- Criterion factory.

--	repo_factory: PS_REPOSITORY_FACTORY
--		-- Repository factory.

--	my_visitor: MY_PRIVATE_VISITOR
--		-- User-defined visitor to react to an error.

--feature -- CRUD operations

--	simple_query: LINKED_LIST [PERSON]
--		-- Query all persons from repository.
--		local
--			query:PS_OBJECT_QUERY [PERSON]
--		do
--			create Result.make
--			create query.make
--			executor.execute_query (query)

--			across query as	query_result
--			loop
--				Result.extend (query_result.item)
--			end
--		end

--	query_with_composite_criterion: LINKED_LIST [PERSON]
--		-- Query using a composite criterion.
--		local
--			query: PS_OBJECT_QUERY [PERSON]
--		do
--			create Result.make
--			create query.make
--			query.set_criterion (composite_search_criterion)
--			executor.execute_query (query)

--			across query as	query_result
--			loop
--				Result.extend (query_result.item)
--			end
--		end

--	query_for_children: LINKED_LIST [CHILD]
--		-- Query all children from repository.
--		local
--			query:PS_OBJECT_QUERY [CHILD]
--		do
--			create Result.make
--			create query.make
--			executor.execute_query (query)

--			across query as	query_result
--			loop
--				Result.extend (query_result.item)
--			end
--		end

--feature -- Failing write operations

--	failing_update
--		-- Try and fail to update a new person object.
--		local
--			a_person: PERSON
--		do
--			create a_person.make ("Bob", "Barath")
--			executor.execute_update (a_person)
--				-- Results in a precondition violation.
--		end

--	failing_delete
--		-- Try and fail to delete a new person object.
--		local
--			a_person: PERSON
--		do
--			create a_person.make ("Cersei", "Lannis")
--			executor.execute_delete (a_person)
--				-- Results in a precondition violation.
--		end

--feature -- Queries with criteria

--	composite_search_criterion : PS_CRITERION
--		-- Combining criteria.
--		local
--			first_name_criterion: PS_CRITERION
--			last_name_criterion: PS_CRITERION
--			age_criterion: PS_CRITERION
--		do
--			first_name_criterion :=
--				factory [[ "first_name", factory.equals, "Albo" ]]

--			last_name_criterion :=
--				factory [[ "last_name", factory.equals, "Bitossi" ]]

--			age_criterion :=
--				factory [[ agent age_more_than (?, 20)]]

--			Result := first_name_criterion and last_name_criterion and not age_criterion

--			-- using double brackets for compactness (comment this Result to get the previous one).
--			Result := factory [[ "first_name", "=", "Albo" ]]
--				and factory [[ "last_name", "=", "Bitossi" ]]
--				and not factory [[ agent age_more_than (?, 20) ]]
--		end

--feature -- Deletion queries

--	delete_person_with_deletion_query (last_name: STRING)
--		-- Delete person with `last_name' using a deletion query.
--		local
--			deletion_query: PS_OBJECT_QUERY [PERSON]
--			criterion: PS_PREDEFINED_CRITERION
--		do
--			create deletion_query.make
--			create criterion.make ("last_name", "=", last_name)
--			deletion_query.set_criterion (criterion)
--			executor.execute_deletion_query (deletion_query)
--		end

--feature -- Transaction handling

--	update_ages
--		-- Increase the age of all persons by one.
--		local
--			query: PS_OBJECT_QUERY [PERSON]
--			transaction: PS_TRANSACTION
--		do
--			create query.make
--			transaction := executor.new_transaction

--			executor.execute_query_within_transaction (query, transaction)

--			across query as query_result
--			loop
--				query_result.item.celebrate_birthday
--				executor.execute_update_within_transaction
--					(query_result.item, transaction)
--			end

--			transaction.commit

--			-- The commit may have failed.
--			if transaction.has_error then
--				if attached transaction.error.message as msg then
--					print ("Commit has failed. Error: " + msg)
--				end
--			end
--		end

--feature -- Error handling

--	do_something_with_error_handling
--		-- Perform some operations. Deal with errors in case of a problem.
--		do
--			-- Some complicated operations.
--		rescue
--				my_visitor.visit (executor.last_error)
--				if my_visitor.shall_retry then
--					retry
--				else
--					-- The exception propagates upwards, and maybe
--					-- another feature can handle it.
--				end
--			end

--feature -- Utilities

--	age_more_than (person: PERSON; age: INTEGER): BOOLEAN
--		-- Age check on `person' used as an agent routine.
--		require
--			age_non_negative: age >= 0
--		do
--			Result:= person.age > age
--		end

--	print_result (lis: LINKED_LIST [PERSON])
--		-- Utility to print a query result.
--		do
--			across lis as local_list
--			loop
--				io.new_line
--				print (local_list.item.first_name + " ")
--				print (local_list.item.last_name + ", age: ")
--				print (local_list.item.age)
--			end
--			io.new_line
--		end

--	print_children_result (lis: LINKED_LIST [CHILD])
--		-- Utility to print a query result.
--		do
--			across lis as local_list
--			loop
--				io.new_line
--				print (local_list.item.first_name + " ")
--				print (local_list.item.last_name + ", age: ")
--				print (local_list.item.age)
--			end
--			io.new_line
--		end
end
