note
	description : "tests application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
--			execute_read_example
--			execute_write_example
--			execute_guest_reports
--			execute_row_count
--			execute_report_guest
--			execute_iterator
--			test_add_user
--			test_countries
--			test_registration_token
--			test_membership_creation_date
--			test_user_role
--			test_role_description
--			test_security_questions
--			test_question_from_email
--			test_user_creation_date
--			test_user_from_email
--			test_user_form_username
--			test_categories
--			test_classes
--			test_severities
--			test_priorities
--			test_initialize_problem_report
--			test_temporary_problem_report
--			test_problem_reports_guest_2
--			test_responsibles
--			test_row_count_responsible_default
--			test_problem_report_responsibles
--			test_token_from_username
--			test_row_count_responsible_by_user
--			test_problem_report_by_uer
--			test_temporary_interaction
--			test_row_count_problem_by_user
			db_setup ("EiffelFromDB")
		end


	execute_read_example
		local
			l_prov: REPORT_DATA_PROVIDER
		do
			create l_prov.make (connection)
--			across l_prov.problem_reports ("jvelilla", False, 15, 3) as c loop
--				print (c.item.string_8)
--				io.put_new_line
--			end
		end


	execute_guest_reports
		local
			l_prov: REPORT_DATA_PROVIDER
		do
			print ("%NGuest Reports")
			create l_prov.make (connection)
			l_prov.connect
--			across l_prov.problem_reports_guest_2 (1, 2, 0, 0) as c loop
--			 	print (c.item.string_8)
--			end
			l_prov.disconnect
		end

	execute_write_example
		local
			l_prov: REPORT_DATA_PROVIDER
		do
			create l_prov.make (connection)
			print (l_prov.new_problem_report_id ("jvelilla"))
		end

	execute_report_guest
		local
			l_prov: REPORT_DATA_PROVIDER
		do
			create l_prov.make (connection)
			print (l_prov.problem_report (18628))
		end


	execute_iterator
		local
			l_prov: REPORT_DATA_PROVIDER
		do
			create l_prov.make (connection)

--			across l_prov.problem_reports ("jvelilla", False, 0, 0) as c  loop
--				print (c.item)
--				io.put_new_line
--			end
		end


	test_add_user
		local
			ld: REPORT_DATA_PROVIDER
			ll: LOGIN_DATA_PROVIDER
		do
			create ld.make (connection)
			create ll.make (connection)
			ld.add_user ("test008", "test008","test006", "test008", "test008", "answer", "token", 1)
			if attached ll.user_from_username ("test008") then
				print ("User exist")
			else
				print ("user does not exist")
			end
		end


	test_token_from_username
		local
			ll: LOGIN_DATA_PROVIDER
		do
			create ll.make (connection)
			if attached ll.token_from_username ("jvelilla") as l_token then
				print ("User activated")
			else
				print ("User not activated")
			end
		end

	test_countries
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			across l_db.countries  as c loop
				print (c.item.ouput)
			end
			l_db.disconnect
		end


	test_registration_token
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.token_from_email ("test001"))
		end

	test_membership_creation_date
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.membership_creation_date ("jvelilla"))
		end

	test_user_role
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.role ("jvelilla"))
			print (l_db.role ("raphaels"))
		end


	test_role_description
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.role_description ("Responsible"))
		end


	test_security_questions
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			across l_db.security_questions as c  loop print (c.item.output)  end
			l_db.disconnect
		end

	test_question_from_email
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			print (l_db.question_from_email ("javier.hector@gmail.com"))
		end


	test_user_creation_date
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			print (l_db.user_creation_date ("jvelilla"))
		end

	test_user_from_email
		local
			l_db: LOGIN_DATA_PROVIDER
			l_tuple: detachable TUPLE [first_name: READABLE_STRING_32; last_name: READABLE_STRING_32; user_name: READABLE_STRING_32]
		do
			create l_db.make (connection)
			l_db.connect
			l_tuple := l_db.user_from_email ("test@test.com")
			print (l_tuple.at (1).out +"%N")
			print (l_tuple.at (2).out +"%N")
			print (l_tuple.at (3).out +"%N")
		end

	test_user_form_username
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			print (l_db.user_from_username ("jvelilla").name)
		end

	test_categories
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			across l_db.categories ("jvelilla") as c loop
				print (c.item.string)
				io.put_new_line
			end
			l_db.disconnect
		end


	test_classes
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			across l_db.classes as c loop
				print (c.item.string)
				io.put_new_line
			end
			l_db.disconnect
		end

	test_severities
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			across l_db.severities as c loop
				print (c.item.string)
				io.put_new_line
			end
			l_db.disconnect
		end

	test_priorities
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			across l_db.priorities as c loop
				print (c.item.string)
				io.put_new_line
			end
			l_db.disconnect
		end

	test_initialize_problem_report
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)

			l_db.initialize_problem_report (l_db.new_problem_report_id ("jvelilla"), "1", "1", "1", "1", "True", "test", "14.05", "Win8", "Test", "Test")
		end


	 test_temporary_problem_report
	 	local
			l_db: REPORT_DATA_PROVIDER
			l_tuple: detachable TUPLE [synopsis: detachable STRING_32;
										release: detachable STRING;
										confidential: detachable STRING;
										environment: detachable STRING;
										description: detachable STRING_32;
										toreproduce: detachable STRING_32;
										priority_synopsis: detachable STRING_32;
										category_synopsis: detachable STRING;
										severity_synopsis: detachable STRING;
										class_synopsis: detachable STRING;
										user_name: detachable STRING;
										responsible: detachable STRING]
			l_report_number: INTEGER
		do
			create l_db.make (connection)
			l_report_number := l_db.new_problem_report_id ("jvelilla")
			l_db.initialize_problem_report (l_report_number, "1", "1", "1", "1", "True", "test", "14.05", "Win8", "Test", "Test")
			l_tuple := l_db.temporary_problem_report (l_report_number)
		end

	test_problem_reports_guest_2
		local
			l_db: REPORT_DATA_PROVIDER
		do
				-- Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID
			create l_db.make (connection)
			across l_db.problem_reports_guest (1, 2, 0, "1,2,3", "CategorySynopsis", 1, "","",0) as c loop
				print (c.item.string_8)
			end
		end


	test_responsibles
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			across l_db.responsibles as c loop print (c.item.string_8) end
		end


	test_row_count_responsible_default
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.row_count_problem_report_responsible (0,0,0,0,"1,2,3,4,5","", Void, 0))
		end


	test_row_count_responsible_by_user
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
--			l_db.row_count_problem_report_user (a_username: STRING_8, a_category: INTEGER_32, a_status, a_filter: READABLE_STRING_32, a_content: INTEGER_32)
			print (l_db.row_count_problem_report_user ("jvelilla", 0, "1,2,3,4","", 0))
		end


	test_problem_report_responsibles
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
--			l_db.problem_reports_responsibles (a_page_number, a_rows_per_page, a_category, a_severity, a_priority, a_responsible: INTEGER_32, a_column: READABLE_STRING_32, a_order: INTEGER_32, a_status, a_username: READABLE_STRING_32, a_filter: detachable READABLE_STRING_32, a_content: INTEGER_32)
			across l_db.problem_reports_responsibles (1, 10, 0, 0, 0, 0, "number", 1, "1,2,3,4", "", Void,0) as c loop
				print (c.item.string_8)
			end
		end


	test_problem_report_by_uer
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
--			across l_db.problem_report (1) as c loop
--				print (c.item.string_8)
--			end
		end

	test_temporary_interaction
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			if attached l_db.temporary_interaction_2 (17745) as l_tuple then
				if attached l_tuple.at(1) as l_item1 then
					print (l_item1); io.put_new_line
				end
				if attached l_tuple.at(2) as l_item1 then
					print (l_item1); io.put_new_line
				end
				if attached l_tuple.at(3) as l_item1 then
					print (l_item1); io.put_new_line
				end
				if attached l_tuple.at(4) as l_item1 then
					print (l_item1); io.put_new_line
				end
			end
		end

	test_row_count_problem_by_user
		local
			l_db: REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.row_count_problem_report_user ("jvelilla",0,"1,2,3,4","",0))
		end

feature -- Implementation

	connection: DATABASE_CONNECTION
		once
			create {DATABASE_CONNECTION_ODBC}Result.make_common
		end



	to_hexadecimal (a_string: STRING): STRING
         -- Convert Current bit sequence into the corresponding
         -- hexadecimal notation.
      local
      	l_ic: STRING_ITERATION_CURSOR
      	l_string: STRING
      do
      	create Result.make_empty
      	create l_ic.make (a_string)
      	across l_ic as c  loop
    		 l_string := c.item.code.to_hex_string
    		 l_string.prune_all_leading ('0')
     		 Result.append_string(l_string)
      	end
      end


	db_setup (a_database_name: STRING)
		local
			l_connection: DATABASE_CONNECTION
			l_handler: DATABASE_HANDLER
			l_parameters: STRING_TABLE[ANY]
			l_sql: STRING
		do

			create l_parameters.make (0)

				 -- Connection
			create {DATABASE_CONNECTION_ODBC} l_connection.login_with_connection_string ("Driver={SQL Server};Server=JVELILLA;Database=test;Uid=sa;Pwd=Eiffel1405;")

			l_sql := read_file ("create_db_sql2000.sql")
			l_sql.replace_substring_all ("$(database_name)", a_database_name)
				 -- Create Database
			create {DATABASE_HANDLER_IMPL} l_handler.make (l_connection)

			l_handler.set_query (create {DATABASE_QUERY}.data_reader (l_sql, l_parameters))

			l_handler.execute_change

			 	-- Table, SP, View and User Defined Functions

			 	-- Initilize Basic Data

		end

	read_file (a_name: STRING): STRING
		local
				f: RAW_FILE
				content: STRING
			do
			create f.make_open_read (Current_dir + a_name)
			if f.exists and then f.is_readable then
				f.read_stream (f.count)
				f.close
				content := f.last_string
				print("%N Content of the file:%N" + content)
			else
				print("%N the file does not exist")
			end
			Result := content
		end


	current_dir: STRING
		do
			Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("..")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("..")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("database")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("mssql")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
		end


end
