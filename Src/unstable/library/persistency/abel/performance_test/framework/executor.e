note
	description: "Summary description for {TEST_PROVIDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXECUTOR

create
	make

feature {NONE} -- Initialization


	make (a_controller: CONTROLLER)
			-- Perform all tests.
		do
			controller := a_controller
			create criterion_factory
			create emitter.make (controller)
		end

feature -- Access

	controller: CONTROLLER

	criterion_factory: PS_CRITERION_FACTORY

	emitter: EMITTER

feature -- Test execution

	perform_tests
			-- Perform all tests for the given controller.
		do

			measure_insert_flat
			measure_insert_deep
			measure_query_flat_all
			measure_query_flat_select
			measure_query_deep_all
			measure_query_deep_select
			emitter.write_results

		end


feature -- Insertion tests

	measure_insert_flat
			-- Measure the time to insert flat objects.
		local
			i: INTEGER
			transaction: PS_TRANSACTION

			generated_objects: ARRAYED_LIST [MY_FLAT_CLASS]
			new_object: MY_FLAT_CLASS
		do
			from
				i := 1
				create generated_objects.make (controller.object_count)
			until
				i > controller.object_count
			loop
				create new_object.make (i)
				generated_objects.extend (new_object)
				i := i + 1
			variant
				controller.object_count - i + 1
			end

			emitter.start ("insert_flat")
			from
				i := 1
			until
				i > controller.object_count
			loop
				transaction := controller.repository.new_transaction
				transaction.insert (generated_objects[i])
				transaction.commit
				i := i + 1
			variant
				controller.object_count - i + 1
			end

			emitter.stop
		end

	measure_insert_deep
			-- Measure the time to insert object graphs.
		local
			i: INTEGER
			transaction: PS_TRANSACTION

			generated_objects: ARRAYED_LIST [DOUBLE_CELL [INTEGER, OBJECT_GRAPH_ITEM]]
			new_object: DOUBLE_CELL [INTEGER, OBJECT_GRAPH_ITEM]
			obj_factory: OBJECT_GRAPH_FACTORY

			query: PS_QUERY [DOUBLE_CELL [INTEGER, OBJECT_GRAPH_ITEM]]
		do
			from
				i := 1
				create generated_objects.make (controller.object_count)
				create obj_factory
			until
				i > controller.object_count
			loop
				create new_object.make (i, obj_factory.linear_object_graph)
				generated_objects.extend (new_object)
				i := i + 1
			variant
				controller.object_count - i + 1
			end

			emitter.start ("insert_deep")
			from
				i := 1
			until
				i > controller.object_count
			loop
				transaction := controller.repository.new_transaction
				transaction.insert (generated_objects[i])
				transaction.commit
				i := i + 1
			variant
				controller.object_count - i + 1
			end

			emitter.stop
		end

feature -- Query tests

	measure_query_flat_all
			-- Measure the query performance when retrieving all objects.
		local
			query: PS_QUERY [MY_FLAT_CLASS]
		do
			emitter.start ("query_flat_all")

			create query.make
			controller.repository.execute_query (query)
			across
				query as res
			loop
				do_nothing
			end

			query.close

			emitter.stop
		end

	measure_query_flat_select
			-- Measure query performance when selecting individual objects.
		local
			i: INTEGER
			step: INTEGER
			query: PS_QUERY [MY_FLAT_CLASS]
		do
			step := (controller.object_count / controller.selection_count).ceiling
			emitter.start ("query_flat_select")

			from
				i := 1
			until
				i > controller.object_count
			loop
				create query.make_with_criterion (criterion_factory.new_predefined ("identifier", "=", i))
				controller.repository.execute_query (query)

				across
					query as res
				loop
					do_nothing
				end
				i := i + step
			variant
				controller.object_count - i + step
			end
			emitter.stop
		end

	measure_query_deep_all
			-- Measure query performance when retrieving all object graphs.
		local
			query: PS_QUERY [DOUBLE_CELL [INTEGER, OBJECT_GRAPH_ITEM]]
		do
			emitter.start ("query_deep_all")

			create query.make
			controller.repository.execute_query (query)
			across
				query as res
			loop
				do_nothing
			end

			query.close

			emitter.stop
		end


	measure_query_deep_select
			-- Measure query performance when selecting individual object graphs.
		local
			i: INTEGER
			step: INTEGER
			query: PS_QUERY [DOUBLE_CELL [INTEGER, OBJECT_GRAPH_ITEM]]
		do
			step := (controller.object_count / controller.selection_count).ceiling
			emitter.start ("query_deep_select")

			from
				i := 1
			until
				i > controller.object_count
			loop
				create query.make_with_criterion (criterion_factory.new_predefined ("first", "=", i))
				controller.repository.execute_query (query)

				across
					query as res
				loop
					do_nothing
				end
				i := i + step
			variant
				controller.object_count - i + step
			end
			emitter.stop
		end


feature -- Update tests


end
