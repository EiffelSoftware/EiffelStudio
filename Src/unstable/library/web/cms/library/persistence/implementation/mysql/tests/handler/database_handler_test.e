note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	DATABASE_HANDLER_TEST

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		select
			default_create
		end
	ABSTRACT_DB_TEST
		rename
			default_create as default_db_test
		end


feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			(create {CLEAN_DB}).clean_db(connection)
		end

	on_clean
			-- <Precursor>
		do
		end


feature -- Test routines

	test_wrong_database_query
			-- New test routine
		local
			l_parameters: STRING_TABLE[detachable ANY]
		do
			create l_parameters.make (0)
			handler.set_query (create {DATABASE_QUERY}.data_reader ("Sellect from users", l_parameters))
			handler.execute_query
		    assert ("Has error:", handler.has_error)
		end



	test_sequences_of_wrong_and_correct_queries
			-- New test routine
		local
			l_parameters: STRING_TABLE[detachable ANY]
		do
			create l_parameters.make (0)
			handler.set_query (create {DATABASE_QUERY}.data_reader ("Sellect from users;", l_parameters))
			handler.execute_query
		    assert ("Has error:", handler.has_error)

			handler.set_query (create {DATABASE_QUERY}.data_reader ("Select * from users;", l_parameters))
			handler.execute_query
		    assert ("Not Has error:",not handler.has_error)
		end


feature -- Handler

 	handler: DATABASE_HANDLER
 		once
 			create {DATABASE_HANDLER_IMPL} Result.make (connection )
 		end

end


