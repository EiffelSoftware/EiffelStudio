note
	description: "Summary description for {APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	PS_ABEL_EXPORT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			factory: PS_IN_MEMORY_REPOSITORY_FACTORY
--			executor: PS_EXECUTOR
			data: PS_TEST_DATA
--			query: PS_OBJECT_QUERY[SPECIAL[TEST_PERSON]]

--			query2: PS_OBJECT_QUERY[REFERENCE_CLASS_1]

			factory2: TEST_DATA_FACTORY
			sp_factory: SPECIAL_FACTORY
			any: ANY
			reflector: REFLECTED_REFERENCE_OBJECT
		do
--			create factory2
--			create sp_factory
--			any := factory2.nested_embedded_with_copysemantics
--			create reflector.make (any)
--			across
--				1 |..| reflector.field_count as idx
--			loop
--				print (reflector.field_type (idx.item))
--			end
--			print (any)
--			print (factory2.object_graph_cycle)
--			create factory
--			create data.make
--			create executor.make (factory.create_in_memory_repository)
--			executor.execute_insert (data.reference_cycle)
--			executor.execute_insert (data.array_of_persons)
--			executor.execute_insert (data.data_structures_1)

--			create query.make
--			executor.execute_query (query)
--			across query as cursor loop cursor.item.do_nothing end

--			create query2.make
--			executor.execute_query (query2)
--			across query2 as cursor loop cursor.item.do_nothing end


		end

end
