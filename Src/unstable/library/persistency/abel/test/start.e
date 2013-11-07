note
	description: "Summary description for {START}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	START

inherit
	PS_EIFFELSTORE_EXPORT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			factory: PS_REPOSITORY_FACTORY
			executor: PS_EXECUTOR
			data: PS_TEST_DATA
			query: PS_OBJECT_QUERY[SPECIAL[PERSON]]

			query2: PS_OBJECT_QUERY[REFERENCE_CLASS_1]
		do
			create factory
			create data.make
			create executor.make (factory.create_in_memory_repository)
			executor.execute_insert (data.reference_cycle)
			executor.execute_insert (data.array_of_persons)
			executor.execute_insert (data.data_structures_1)

			create query.make
			executor.execute_query (query)
			across query as cursor loop cursor.item.do_nothing end

			create query2.make
			executor.execute_query (query2)
			across query2 as cursor loop cursor.item.do_nothing end


		end

end
