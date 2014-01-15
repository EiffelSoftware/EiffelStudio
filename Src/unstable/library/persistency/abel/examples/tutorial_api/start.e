note
	description: "The main class for this tutorial."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	START
inherit
	PS_ABEL_EXPORT

create
	make


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			factory: PS_IN_MEMORY_REPOSITORY_FACTORY
		do
			create factory.make
			repository := factory.new_repository

			create criterion_factory
			explore
		end

feature -- Access

	repository: PS_REPOSITORY
			-- The main repository.

	criterion_factory: PS_CRITERION_FACTORY
			-- A factory for criterion objects.

feature -- Tutorial

	explore
			-- Do all tutorial functions.
		do
				-- First populate the repository with some data.
			insert_persons
				-- Check the result.
			print_persons

				-- Do a simple update on Berno Citrini and check the result.
			update_berno_citrini
			print_persons

				-- Searching for "Berno" in the result set is tedious...
				-- There's a better way using selection criteria:
			update_berno_citrini_smart
			print_persons

				-- There's a lot more you can do with queries and criteria.
			explore_criteria

				-- ABEL is able to handle whole object graphs as well.
			insert_children -- Insert
			print_children	-- Retrieve
			update_john_doe	-- Update

				-- ABEL does not support delete operations.
				-- Deletions may be dangerous as it may introduce Void references
				-- when deleting a database object which is still referenced by another object.

				-- Instead of deletions, a garbage collection mechanism is planned for the future.
				-- A direct implication of this design decision is the notion of a "root" object.
				-- Root objects, and all objects reachable from them, cannot be deleted by the
				-- garbage collector.

			explore_root_objects

				-- Loading whole object graphs may be too expensive in some cases.
				-- ABEL provides an alternative query mechanism which returns value tuples.
			explore_tuple_queries

			io.new_line
		end

feature -- Printing results

	print_persons
			-- Print all persons in the repository
		local
			query: PS_QUERY [PERSON]
		do
				-- To retrieve data we need to create a query object.
				-- Note that the generic argunent in PS_QUERY denotes
				-- the type of objects we're interested in.
			create query.make

				-- Now let the repository execute the query and retrieve the result.
				-- Note that we don't need a transaction for read-only operations.
			repository.execute_query (query)

				-- We can use the familiar across syntax to iterate over the result.
			across
				query as person_cursor
			from
				print ("Printing all PERSON objects in the repository:%N")
			loop
				print (person_cursor.item)
			end

				-- You should always check for errors.
				-- If an error happens, {PS_QUERY}.has_error is `True',
				-- and the cursor will be `after'.
				-- No exception is thrown, therefore there is a risk
				-- that the error may go unnoticed.
			if query.has_error then
				print ("An error occurred during retrieve!%N")
			end

				-- When you're finished, close the query.
			query.close
		end

	print_children
			-- Print all children in the repository
		local
			query: PS_QUERY [CHILD]
		do
			create query.make
			repository.execute_query (query)

			across
				query as person_cursor
			from
				print ("Printing all CHILD objects in the repository:%N")
			loop
				print (person_cursor.item)
			end

				-- Don't forget to check for errors
				-- and then close the query.
			if query.has_error then
				print ("An error occurred during retrieve!%N")
			end

			query.close
		end

feature -- Initialization

	insert_persons
			-- Populate the repository with some person objects.
		local
			p1, p2, p3: PERSON
			transaction: PS_TRANSACTION
		do

			create p1.make_with_age ("Albo", "Bitossi", 1)
			create p2.make_with_age ("Berno", "Citrini", 3)
			create p3.make ("Dumbo", "Ermini")

			print ("Insert 3 new persons in the database")
			io.new_line

				-- To insert data we first need to open a transaction.
			transaction := repository.new_transaction

				-- Now we can insert all three persons.
				-- Before doing any kind of operation please always check
				-- for errors, else you might get a precondition violation.
			if not transaction.has_error then
				transaction.insert (p1)
			end
			if not transaction.has_error then
				transaction.insert (p2)
			end
			if not transaction.has_error then
				transaction.insert (p3)
			end

				-- Finally we can commit the transaction to make the changes effective.
			if not transaction.has_error then
				transaction.commit
			end

				-- Note that a commit may also fail and return an error.
			if transaction.has_error then
				print ("An error occurred during insert!%N")
			end
		end

	insert_children
			-- Populate the repository with some children objects.
		local
			c1, c2, c3: CHILD
			transaction: PS_TRANSACTION
		do
			create c1.make ("Baby", "Doe")
			create c2.make ("John", "Doe")
			create c3.make ("Grandpa", "Doe")
			c1.set_father (c2)
			c2.set_father (c3)


			print ("Insert 3 children in the database.%N")

			transaction := repository.new_transaction

				-- It is sufficient to just insert "Baby Joe", as the other CHILD objects
				-- are (transitively) referenced and thus inserted automatically.
			if not transaction.has_error then
				transaction.insert (c1)
			end

			if not transaction.has_error then
				transaction.commit
			end

			if transaction.has_error then
				print ("An error occurred during insert!%N")
			end

		end

feature -- Data modification

	update_berno_citrini
			-- Increase the age of Berno Citrini by one.
		local
			query: PS_QUERY [PERSON]
			transaction: PS_TRANSACTION
			berno: PERSON
		do
			print ("Updating Berno Citrini's age by one.%N")

				-- Create query and transaction.
			create query.make
			transaction := repository.new_transaction

				-- As we're doing a read followed by a write, we
				-- need to execute the query within a transaction.
			if not transaction.has_error then
				transaction.execute_query (query)
			end

				-- Search for Berno Citrini
			across
				query as cursor
			loop
				if cursor.item.first_name ~  "Berno" then
					berno := cursor.item

						-- Change the object.
					berno.celebrate_birthday

						-- Perform the database update.
						-- Note that it's not actually necessary to check
						-- for an error here, because the across loop would
						-- have an early exit.
					transaction.update (berno)
				end
			end

				-- Don't forget to close the query. This has to
				-- be done before committing the transaction.
			query.close

				-- Make the changes effective.
			if not transaction.has_error then
				transaction.commit
			end

				-- Check if the transaction was successful.
			if transaction.has_error then
				print ("An error occurred during update!%N")
			end
		end

	update_berno_citrini_smart
			-- Increase the age of Berno Citrini by one.
			-- Make use of criteria.
		local
			query: PS_QUERY [PERSON]
			cursor: ITERATION_CURSOR [PERSON]
			transaction: PS_TRANSACTION
			berno: PERSON
		do
			print ("Updating Berno Citrini's age by one (the smart way).%N")

				-- Create query and transaction.
			create query.make
			transaction := repository.new_transaction

				-- Only select the person with first name `Berno'.
			query.set_criterion (criterion_factory.new_predefined ("first_name", "=", "Berno"))

				-- As we're doing a read followed by a write, we need to execute
				-- the query within a transaction.
			if not transaction.has_error then
				transaction.execute_query (query)
			end

				-- The result now only contains Berno Citrini.

				-- The cursor may be after if Berno cannot be found
				-- in the database, or when an error occurred.
			cursor := query.new_cursor

			if not cursor.after then
				berno := cursor.item

				check correct: berno.first_name ~ "Berno" end

					-- Perform the update.
				berno.celebrate_birthday
				transaction.update (berno)
			end

				-- Close and commit.
			query.close

			if not transaction.has_error then
				transaction.commit
			end

				-- Check if the transaction was successful.
			if transaction.has_error then
				print ("An error occurred during update!%N")
			end
		end


	update_john_doe
			-- Try to update John Doe in several ways.
		local
			transaction: PS_TRANSACTION
			baby: CHILD
			john: CHILD
			grandpa: CHILD
		do
			transaction := repository.new_transaction

				-- Get "Baby Doe" from the database.
				-- We're using a small helper function to get a specific CHILD object.
			if attached get_child (transaction, "Baby") as baby_doe then

				baby := baby_doe

					-- Note that John and Grandpa Doe got loaded as well
					-- because they were referenced by Baby Doe.
				check attached baby.father as f then
					john := f
				end
				check attached john.father as f then
					grandpa := f
				end

				john.celebrate_birthday

					-- You can give `john' as an argument to the update function.
				if not transaction.has_error then
					transaction.update (john)
				end

					-- Check the result:

					-- A database error may happen even in production code,
					-- in which case it is ok not to be able to retrieve john,
					-- but if we do, then both `retrieved_john' and `john' are the same.
				if attached get_child (transaction, "John") as retrieved_john then
					check equal: retrieved_john ~ john end
				end

					-- During an update operation ABEL will follow all references.
					-- Therefore John Doe gets updated automatically when you update Baby Doe.
				john.celebrate_birthday
				if not transaction.has_error then
					transaction.update (baby)
				end

					-- Check the result:
				if attached get_child (transaction, "John") as retrieved_john then
					check equal: retrieved_john ~ john end
				end

					-- As Grandpa doesn't have any references, the above trick doesn't work.
				john.celebrate_birthday
				if not transaction.has_error then
					transaction.update (grandpa)
				end

				if attached get_child (transaction, "John") as retrieved_john then
					check not_updated: retrieved_john.age /= john.age end
				end

					-- Updating the whole object graph could be costly in some cases.
					-- ABEL provides an alternative. A direct update only updates the object
					-- given in its argument, and does not follow any references.
				if not transaction.has_error then
					transaction.direct_update (john)
				end

					-- Check the result:
				if attached get_child (transaction, "John") as retrieved_john then
					check equal: retrieved_john ~ john end
				end

					-- Check that the update really only affects the immediate argument.
				john.celebrate_birthday
				grandpa.celebrate_birthday

				if not transaction.has_error then
					transaction.direct_update (john)
				end

				if attached get_child (transaction, "John") as retrieved_john then
					check equal_age:
						retrieved_john.age = john.age
					end
					check grandpa_not_updated:
						attached retrieved_john.father as retrieved_grandpa
						and then retrieved_grandpa.age /= grandpa.age
					end
				end
			end

				-- Commit the transaction.
			if not transaction.has_error then
				transaction.commit
			end

				-- Never forget to check for errors.
			if transaction.has_error then
				print ("An error occured in `update_john_doe'.%N")
			end
		end

	get_child (transaction: PS_TRANSACTION; first_name: STRING): detachable CHILD
			-- Retrieve the child with `first_name' from the database.
			-- The result will be Void if the object could not be found, or when
			-- an error occured.
		local
			query: PS_QUERY [CHILD]
			cursor: ITERATION_CURSOR [CHILD]
		do
			create query.make
			query.set_criterion (criterion_factory.new_predefined ("first_name", criterion_factory.equals, first_name))

				-- The transaction may already have an error.
			if not transaction.has_error then
				transaction.execute_query (query)
				cursor := query.new_cursor

					-- Note that the cursor may be `after' when:
					-- 1) The object isn't present in the database
					-- 2) or an error occurred.
				if not cursor.after then
					Result := cursor.item
				end
			end
			query.close
		end

feature -- Criteria

	explore_criteria
			-- See what can be done with criteria.
		local
			query: PS_QUERY [PERSON]
		do
				-- Predefined criteria work on any attribute of a basic or string type.
			print ("Select all persons with age > 2:%N")
			create query.make_with_criterion (criterion_factory.new_predefined ("age", criterion_factory.greater, 2))

			repository.execute_query (query)
			print_result (query)

				-- If you don't plan on reusing the query object, always call `close'.
			query.close
				-- Else you can also call `reset'.
				-- Reset will close a query first if necessary and then prepare it for the next
				-- execution. `reset' does not change the criterion or other retrieval parameter.
			query.reset


				-- For string types you can use the `like' operator.
				-- `like' compares against a pattern with wild cards:
				-- '*' for an arbitrary number of unknown characters and
				-- '?' for a single unknown character.

			print ("Select all persons whose last name ends with *ni:%N")
			query.set_criterion (criterion_factory.new_predefined ("last_name", criterion_factory.like_string, "*ni"))

			repository.execute_query (query)
			print_result (query)

				-- It is possible to combine criteria using `and' and `or'.

			print ("Select all persons whose last name ends with *ni and with age = 5:%N")
			query.reset
			query.set_criterion (
				criterion_factory.new_predefined ("last_name", criterion_factory.like_string, "*ni")
				and
				criterion_factory.new_predefined ("age", criterion_factory.equals, 5))

			repository.execute_query (query)
			print_result (query)
			query.reset

				-- There's a second type of criteria using an agent.
				-- Agent criteria are a bit safer to use, but internally they cannot be
				-- converted to a backend-specific query and are thus don't offer any performance improvements.
			print ("Select all persons with age = 5, using an agent:%N")

			query.set_criterion (
				criterion_factory.new_agent (
					agent (p: PERSON): BOOLEAN
						do
							Result := p.age = 5
						end
					)
				)
			repository.execute_query (query)
			print_result (query)
			query.close

				-- The use of attribute names in predefined criteria might seem scary.
				-- ABEL however can detect a wrong attribute name at runtime and will throw
				-- a precondition violation.

				-- Enable the next statement if you want to see this:
			--check_exception
		end


	print_result (query: PS_QUERY [PERSON])
			-- Print all results in `query'.
		do
			across
				query as person_cursor
			loop
				print (person_cursor.item.first_name)
				print (" ")
				print (person_cursor.item.last_name)
				print (", age ")
				print (person_cursor.item.age)
				io.new_line
			end

				-- Always check for an error.
			if query.has_error then
				print ("An error occurred during retrieve.%N")
			end
		end

	check_exception
			-- Show that a wrong attribute name leads to an exception.
		local
			retried: BOOLEAN
			query: PS_QUERY [PERSON]
		do
			if not retried then

				create query.make
				query.set_criterion (criterion_factory.new_predefined ("a_bogus_name", "=", 42))
				print ("Error, no exception raised!")
			end
		rescue
			retried := True
			print ("An invalid attribute name in a criterion has been detected")
			retry
		end

feature -- Root objects

	explore_root_objects
			-- See what can be done with the `root' status of an object.
		local
			query: PS_QUERY [CHILD]
			l_cursor: ITERATION_CURSOR [CHILD]
			transaction: PS_TRANSACTION
		do
				-- By default any root of an object graph during `insert'
				-- is also a garbage collection root.

				-- In our case, this is true for all PERSON objects and
				-- for the "Baby Doe" CHILD object:

			print ("Print name and root status of all CHILD objects:%N")

			transaction := repository.new_transaction
			create query.make

			if not transaction.has_error then
				transaction.execute_query (query)
			end

			across
				query as cursor
			loop
				print (cursor.item.first_name + " " + cursor.item.last_name)
				print (", is_root: ")
					-- The root status can be queried with {PS_TRANSACTION}.is_root.
				print (transaction.is_root (cursor.item))
				io.new_line
			end

				-- It is possible to filter the query result according to the
				-- root status of an object:

			print ("Print all CHILD root objects:%N")

			query.reset
			query.set_is_non_root_ignored (True)
			if not transaction.has_error then
				transaction.execute_query (query)
			end

			across
				query as cursor
			loop
				print (cursor.item.first_name + " " + cursor.item.last_name + "%N")
			end

				-- You can declare an object as root or non-root manually.
			l_cursor := query.new_cursor
			if not l_cursor.after then
				check attached l_cursor.item.father as john then
					transaction.mark_root (john)
				end
			end


			print ("Print all CHILD root objects, after declaring John Doe as root:%N")

			query.reset
				 -- Note that the `query.is_non_root_ignored' attibute survives a reset.
			check still_ignored: query.is_non_root_ignored end

			if not transaction.has_error then
				transaction.execute_query (query)
			end
			across
				query as cursor
			loop
				print (cursor.item.first_name + " " + cursor.item.last_name + "%N")
			end

			l_cursor := query.new_cursor
			if not l_cursor.after then
				transaction.unmark_root (l_cursor.item)
			end

			print ("Print all CHILD root objects, after declaring Baby Doe as non-root:%N")

			query.reset
			if not transaction.has_error then
				transaction.execute_query (query)
			end
			across
				query as cursor2
			loop
				print (cursor2.item.first_name + " " + cursor2.item.last_name + "%N")
			end

				-- Cleanup
			query.close
			if not transaction.has_error then
				transaction.commit
			end

			if transaction.has_error then
				print ("An error occurred during `explore_root_objects'.%N")
			end

				-- Once a garbage collector is implemented in ABEL, declaring an object
				-- as non-root and then running the GC is comparable to a delete.
		end

feature -- Tuple queries

	explore_tuple_queries
			-- See what can be done with tuple queries.
		local
			query: PS_TUPLE_QUERY [CHILD]
			transaction: PS_TRANSACTION
			projection: ARRAYED_LIST [STRING]
		do
				-- Tuple queries are very similar to normal queries.
				-- I.e. you can query for CHILD objects by creating
				-- a PS_TUPLE_QUERY [CHILD]
			create query.make

				-- It is also possible to add criteria. Agent criteria are not supported
				-- for tuple queries however.
				-- Lets search for all CHILD objects with last name Doe.
			query.set_criterion (criterion_factory ("last_name", criterion_factory.equals, "Doe"))

				-- The big advantage of tuple queries is that you can define which attributes
				-- should be loaded. Therefore you can avoid loading a whole object graph
				-- if you're just interested in e.g. the first name.
			create projection.make_from_array (<<"first_name">>)
			query.set_projection (projection)

				-- Tuple queries are executed by either using {PS_REPSOITORY}.execute_tuple_query
				-- or {PS_TRANSACTION}.execute_tuple_query.
			repository.execute_tuple_query (query)

				-- The result of the query is a TUPLE containing the requested attributes,
				-- in the order of the projection array.
			print ("Printing the first name of all persons using a tuple query:%N")
			across
				query as cursor
			loop
					-- It is possible to downcast the TUPLE to a tagged tuple with correct type.
				check attached {TUPLE [first_name: STRING]} cursor.item as tuple then
					print (tuple.first_name)
					io.new_line
				end
			end

				-- It is possible to include reference-type attributes as well.
			query.reset
			create projection.make_from_array (<<"first_name", "father">>)
			query.set_projection (projection)

				-- We're now executing the query in a transaction such that we can
				-- use the results for subsequent write operations.
			transaction := repository.new_transaction
			if not transaction.has_error then
				transaction.execute_tuple_query (query)
			end

				-- Search for John Doe
			across
				query as cursor
			loop
				check attached {TUPLE [first_name: STRING; father: detachable CHILD]} cursor.item as tuple then

					if tuple.first_name.is_equal ("John") then

							-- ABEL does not support updates on an object returned as TUPLE.
							-- One of the reasons for this design decision is that the updates
							-- bypass the encapsulation of an object and thus may violate
							-- an invariant.
							-- An attempt to update a tuple object will result in a precondition
							-- violation.
						check update_not_possible: not transaction.is_persistent (tuple) end
							-- It is however possible to update referenced objects.
						if attached tuple.father as grandpa then

							print ("Printing Grandpa Doe, retrieved as reference attribute in a tuple query:%N")
							print (grandpa.first_name + " " + grandpa.last_name + "%N")

							grandpa.set_father (create {CHILD}.make ("Great-Grandpa", "Doe"))
							transaction.update (grandpa)
						end
					end
				end
			end

				-- Let's check if the update worked.
			print ("Printing first name and father of all CHILD objects, after adding a father to Grandpa Doe:%N")
			query.reset
			if not transaction.has_error then
				transaction.execute_tuple_query (query)
			end
			across
				query as cursor
			loop
				check attached {TUPLE [first_name: STRING; father: detachable CHILD]} cursor.item as tuple then

					print (tuple.first_name)
					if attached tuple.father as father then

						print (", father: " + father.first_name)
					end
					io.new_line
				end
			end


				-- Commit and check for errors.
			query.close

			if not transaction.has_error then
				transaction.commit
			end

			if transaction.has_error then
				print ("An error occurred during `explore_tuple_queries'.%N")
			end
		end

feature -- Common pitfalls

	failing_update
			-- Trying to update a new person object.
		local
			bob: PERSON
			transaction: PS_TRANSACTION
		do
			create bob.make ("Robert", "Baratheon")
			transaction := repository.new_transaction
				-- Error: Bob was not inserted / retrieved before.
				-- The result is a precondition violation.
			transaction.update (bob)
			transaction.commit
		end

	update_after_commit
			-- Update after transaction committed.
		local
			joff: PERSON
			transaction: PS_TRANSACTION
		do
			create joff.make ("Joffrey", "Baratheon")
			transaction := repository.new_transaction
			transaction.insert (joff)
			transaction.commit

			joff.celebrate_birthday

				-- Prepare can be used to restart a transaction.
			transaction.prepare

				-- Error: Joff was not inserted / retrieved before.
				-- The result is a precondition violation.
			transaction.update (joff)

				-- Note: After commit and prepare,`transaction'
				-- represents a completely new transaction.
		end

end
