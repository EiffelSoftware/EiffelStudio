note
	description: "The main class for this tutorial."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	START

create
	make


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			backend: PS_IN_MEMORY_BACKEND
			factory: PS_IN_MEMORY_REPOSITORY_FACTORY
		do
			create criterion_factory
			create factory
			repository := factory.create_in_memory_repository
--			create backend.wipe_out
--			create {PS_NEW_REPOSITORY} repository.make (backend)
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
			insert_children
			print_children

				-- Do some update operations.
			update_john_doe

				-- ABEL does not support delete operations.
				-- Deletions may be dangerous as it may introduce Void references
				-- when deleting a database object which is still referenced by another object.

				-- Instead of deletions, a garbage collection mechanism is planned for the future.
				-- A direct implication of this design decision is the notion of a "root" object.
				-- Root objects, and all objects reachable from them, cannot be deleted by the
				-- garbage collector.

			--explore_root_objects

			io.new_line
		end

feature -- Printing results

	print_persons
			-- Print all persons in the repository
		local
			query: PS_OBJECT_QUERY[PERSON]
		do
			-- To retrieve data we need to create a query object.
			-- Note that the generic argunent in PS_OBJECT_QUERY denotes
			-- the type of objects we're interested in.
			create query.make

			-- Now let the repository execute the query and retrieve the result.
			-- Note that we don't need a transaction context for read-only operations.
			repository.execute_query (query)

			-- We can use the familiar across syntax to iterate over the result.
			across
				query as person_cursor
			from
				print ("Printing all PERSON objects in the repository:%N")
			loop
				print (person_cursor.item.first_name)
				print (" ")
				print (person_cursor.item.last_name)
				print (", age ")
				print (person_cursor.item.age)
				io.new_line
			end

			-- Don't forget to close the query.
			query.close
		end

	print_children
			-- Print all children in the repository
		local
			query: PS_OBJECT_QUERY[CHILD]
		do
			create query.make
			repository.execute_query (query)

			across
				query as person_cursor
			from
				print ("Printing all CHILD objects in the repository:%N")
			loop
				print (person_cursor.item.first_name)
				print (" ")
				print (person_cursor.item.last_name)
				print (", age ")
				print (person_cursor.item.age)

				-- Note that referenced items get loaded as well.
				if attached person_cursor.item.father as father then
					print (", father: ")
					print (father.first_name)
				end

				io.new_line
			end

			query.close
		end

feature -- Initialization

	insert_persons
			-- Populate the repository with some person objects.
		local
			p1, p2, p3: PERSON
			transaction: PS_TRANSACTION_CONTEXT
		do

			create p1.make_with_age ("Albo", "Bitossi", 1)
			create p2.make_with_age ("Berno", "Citrini", 3)
			create p3.make ("Dumbo", "Ermini")

			print ("Insert 3 new persons in the database")
			io.new_line

				-- To insert data we first need to open a transaction context.
			transaction := repository.new_transaction_context

				-- Now we can insert all three persons.
			transaction.insert (p1)
			transaction.insert (p2)
			transaction.insert (p3)

				-- Finally we can commit the transaction to make the changes effective.
			transaction.commit
		end

	insert_children
			-- Populate the repository with some children objects.
		local
			c1, c2, c3: CHILD
			transaction: PS_TRANSACTION_CONTEXT
		do
			create c1.make ("Baby", "Doe")
			create c2.make ("John", "Doe")
			create c3.make ("Grandpa", "Doe")
			c1.set_father (c2)
			c2.set_father (c3)


			print ("Insert 3 children in the database")
			io.new_line

			transaction := repository.new_transaction_context

				-- It is sufficient to just insert "Baby Joe", as the other CHILD objects
				-- are (transitively) referenced and thus inserted automatically.
			transaction.insert (c1)

			transaction.commit

		end

feature -- Data modification

	update_berno_citrini
			-- Increase the age of Berno Citrini by one.
		local
			query: PS_OBJECT_QUERY[PERSON]
			context: PS_TRANSACTION_CONTEXT
		do
			print ("Updating Berno Citrini's age by one.%N")

				-- Create query and transaction context.
			create query.make
			context := repository.new_transaction_context

				-- As we're doing a read followed by a write, we need to execute
				-- the query within a transaction context.
			context.execute_query (query)

				-- Search for Berno Citrini
			across
				query as cursor
			loop
				if cursor.item.first_name.is_equal ("Berno") then

					-- Do the update on the Eiffel object.
					cursor.item.celebrate_birthday

					-- Tell ABEL to update the database object.
					context.update (cursor.item)

				end
			end

				-- Don't forget to close the query.
				-- This has to be done before committing the transaction.
			query.close

				-- Make the changes effective
			context.commit
		end

	update_berno_citrini_smart
			-- Increase the age of Berno Citrini by one.
			-- Make use of criteria.
		local
			query: PS_OBJECT_QUERY[PERSON]
			context: PS_TRANSACTION_CONTEXT
			berno: PERSON
		do
			print ("Updating Berno Citrini's age by one (the smart way).%N")

				-- Create query and transaction context.
			create query.make
			context := repository.new_transaction_context

				-- Only select the person with first name `Berno'.
			query.set_criterion (criterion_factory.new_predefined ("first_name", "=", "Berno"))

				-- As we're doing a read followed by a write, we need to execute
				-- the query within a transaction context.
			context.execute_query (query)

				-- The result now only contains Berno Citrini
			berno := query.new_cursor.item
			check correct: berno.first_name.is_equal ("Berno") end

				-- Perform the update
			berno.celebrate_birthday
			context.update (berno)

				-- Cleanup
			query.close
			context.commit
		end


	update_john_doe
			-- Try to update John Doe in several ways.
		local
			transaction: PS_TRANSACTION_CONTEXT
			query: PS_OBJECT_QUERY [CHILD]
			baby: CHILD
			john: CHILD
			grandpa: CHILD
		do
			transaction := repository.new_transaction_context
			create query.make

				-- Get "Baby Doe" from the database
			query.set_criterion (criterion_factory.new_predefined ("first_name", "=", "Baby"))
			transaction.execute_query (query)

			baby := query.new_cursor.item
				-- Note that John and Grandpa Doe got loaded as well because they were referenced
				-- by Baby Doe.
			check attached baby.father as f then
				john := f
			end
			check attached john.father as f then
				grandpa := f
			end

				-- You can give `john' as an argument to the update function.
			john.celebrate_birthday
			transaction.update (john)

			query.reset
			query.set_criterion (criterion_factory.new_predefined ("first_name", "=", "John"))
			transaction.execute_query (query)
			check equal: query.new_cursor.item.is_deep_equal (john) end

				-- You can also update `john' via the reference from Baby Doe.
			john.celebrate_birthday
			transaction.update (baby)
			query.reset -- Note: reset keeps the criterion.
			transaction.execute_query (query)
			check equal: query.new_cursor.item.is_deep_equal (john) end

				-- It is not possible via Grandpa Doe however, as Grandpa doesn't have a reference to John...
			john.celebrate_birthday
			transaction.update (grandpa)
			query.reset
			transaction.execute_query (query)
			check not_updated: query.new_cursor.item.age /= john.age end

				-- Updating the whole object graph could be costly in some cases.
				-- ABEL provides an alternative. A direct update only updates the object
				-- given in its argument, and does not follow any references.
			transaction.direct_update (john)
			query.reset
			transaction.execute_query (query)
			check equal: query.new_cursor.item.age = john.age end

				-- Check that the update really only affects the immediate argument.
			john.celebrate_birthday
			grandpa.celebrate_birthday

			transaction.direct_update (john)

			query.reset
			transaction.execute_query (query)
			check
				john_updated: query.new_cursor.item.age = john.age
			end
			check
				grandpa_not_updated:
					attached query.new_cursor.item.father as new_grandpa
					and then new_grandpa.age /= grandpa.age
			end

			query.close
			transaction.commit
		end

feature -- Criteria

	explore_criteria
			-- See what can be done with criteria.
		local
			query: PS_OBJECT_QUERY [PERSON]
		do
				-- Predefined criteria work on any attribute of a basic or string type.
			print ("Select all persons with age > 2")
			create query.make_with_criterion (criterion_factory.new_predefined ("age", ">", 2))

			repository.execute_query (query)
			print_result (query)
			query.close

				-- For string types you can use the `like' operator.
				-- `like' compares against a pattern with wild cards:
				-- '*' for an arbitrary number of unknown characters and
				-- '?' for a single unknown character.

			print ("Select all persons whose last name ends with *ni.%N")
			create query.make_with_criterion (criterion_factory.new_predefined ("last_name", "like", "*ni"))

			repository.execute_query (query)
			print_result (query)

				-- By the way, there's a shortcut to close and recreate a query:
			query.reset

				-- It is possible to combine criteria using `and' and `or'.

			print ("Select all persons whose last name ends with *ni and with age = 5.%N")
			query.set_criterion (
				criterion_factory.new_predefined ("last_name", "like", "*ni")
				and
				criterion_factory.new_predefined ("age", "=", 5))

			repository.execute_query (query)
			print_result (query)
			query.reset

				-- There's a second type of criteria using an agent.
				-- Agent criteria are a bit safer to use, but internally they cannot be
				-- converted to a backend-specific query and are thus don't offer any performance improvements.
			print ("Select all persons with age = 5, using an agent.%N")

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


	print_result (query: PS_OBJECT_QUERY [PERSON])
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
		end

	check_exception
			-- Show that a wrong attribute name leads to an exception.
		local
			retried: BOOLEAN
			query: PS_OBJECT_QUERY[PERSON]
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
			query: PS_OBJECT_QUERY [CHILD]
			transaction: PS_TRANSACTION_CONTEXT
		do
			-- By default any root of an object graph during `insert'
			-- is also a garbage collection root.

			-- In our case, this is true for all PERSON objects and
			-- for the "Baby Doe" CHILD object:

			print ("Print name and root status of all CHILD objects:%N")

			transaction := repository.new_transaction_context
			create query.make

			transaction.execute_query (query)
			across
				query as cursor
			loop
				print (cursor.item.first_name + " " + cursor.item.last_name)
				print (", is_root: ")
					-- The root status can be queried with `{PS_TRANSACTION_CONTEXT}.is_root'.
				print (transaction.is_root (cursor.item))
				io.new_line
			end

			-- It is possible to filter the query result according to the
			-- root status of an object:

			print ("Print all CHILD root objects:%N")

			query.reset
			query.set_is_non_root_ignored (True)
			transaction.execute_query (query)
			across
				query as cursor
			loop
				print (cursor.item.first_name + " " + cursor.item.last_name + "%N")
			end

			-- You can declare an object as root or non-root manually.
			check attached query.new_cursor.item.father as john then
				transaction.declare_root (john)
			end

			print ("Print all CHILD root objects, after declaring John Doe as root:%N")

			query.reset -- Note that the `query.is_non_root_ignored' attibute survives a reset.
			transaction.execute_query (query)
			across
				query as cursor
			loop
				print (cursor.item.first_name + " " + cursor.item.last_name + "%N")
			end

			transaction.declare_non_root (query.new_cursor.item)

			print ("Print all CHILD root objects, after declaring Baby Doe as non-root:%N")

			query.reset
			transaction.execute_query (query)
			across
				query as cursor2
			loop
				print (cursor2.item.first_name + " " + cursor2.item.last_name + "%N")
			end

			-- Once a garbage collector is implemented in ABEL, declaring an object
			-- as non-root and then running the GC is comparable to a delete.
		end

end
