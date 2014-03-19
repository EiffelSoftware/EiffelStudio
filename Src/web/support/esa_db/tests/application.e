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
			test_problem_report_responsibles
		end


	execute_read_example
		local
			l_prov: ESA_REPORT_DATA_PROVIDER
		do
			create l_prov.make (connection)
			across l_prov.problem_reports ("jvelilla", False, 15, 3) as c loop
				print (c.item.string_8)
				io.put_new_line
			end
		end


	execute_guest_reports
		local
			l_prov: ESA_REPORT_DATA_PROVIDER
		do
			print ("%NGuest Reports")
			create l_prov.make (connection)
			l_prov.connect
			across l_prov.problem_reports_guest (1, 2, 0, 0) as c loop
			 	print (c.item.string_8)
			end
			l_prov.disconnect
		end

	execute_row_count
		local
			l_prov: ESA_REPORT_DATA_PROVIDER
		do
			create l_prov.make (connection)
			print ("RowCount { ProblemReports } :" + l_prov.row_count ("ProblemReports").out)
			print ("RowCount { Contacts } :" + l_prov.row_count ("Contacts").out)
 			print ("RowCount { NotExist } :" + l_prov.row_count ("NotExist").out)
			print ("RowCount { Memberships } :" + l_prov.row_count ("Memberships").out)
		end


	execute_write_example
		local
			l_prov: ESA_REPORT_DATA_PROVIDER
		do
			create l_prov.make (connection)
			print (l_prov.new_problem_report_id ("jvelilla"))
		end

	execute_report_guest
		local
			l_prov: ESA_REPORT_DATA_PROVIDER
		do
			create l_prov.make (connection)
			print (l_prov.problem_report (18628))
		end


	execute_iterator
		local
			l_prov: ESA_REPORT_DATA_PROVIDER
		do
			create l_prov.make (connection)

			across l_prov.problem_reports ("jvelilla", False, 0, 0) as c  loop
				print (c.item)
				io.put_new_line
			end
		end


	test_add_user
		local
			ld: ESA_REPORT_DATA_PROVIDER
		do
			create ld.make (connection)
			if ld.add_user ("test002", "test002","test002", "test002", "test002", "answer", "token", 1) then
			end
		end


	test_countries
		local
			l_db: ESA_LOGIN_DATA_PROVIDER
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
			l_db: ESA_LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.token_from_email ("test001"))
		end

	test_membership_creation_date
		local
			l_db: ESA_LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.membership_creation_date ("jvelilla"))
		end

	test_user_role
		local
			l_db: ESA_LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.role ("jvelilla"))
			print (l_db.role ("raphaels"))
		end


	test_role_description
		local
			l_db: ESA_LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.role_description ("Responsible"))
		end


	test_security_questions
		local
			l_db: ESA_LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			across l_db.security_questions as c  loop print (c.item.output)  end
			l_db.disconnect
		end

	test_question_from_email
		local
			l_db: ESA_LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			print (l_db.question_from_email ("javier.hector@gmail.com"))
		end


	test_user_creation_date
		local
			l_db: ESA_LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			print (l_db.user_creation_date ("jvelilla"))
		end

	test_user_from_email
		local
			l_db: ESA_LOGIN_DATA_PROVIDER
			l_tuple: detachable TUPLE[STRING,STRING,STRING]
		do
			create l_db.make (connection)
			l_db.connect
			l_tuple := l_db.user_from_email ("javier.hector@gmail.com")
			print (l_tuple.at (1).out +"%N")
			print (l_tuple.at (2).out +"%N")
			print (l_tuple.at (3).out +"%N")
		end

	test_user_form_username
		local
			l_db: ESA_LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			print (l_db.user_from_username ("jvelilla").name)
		end

	test_categories
		local
			l_db: ESA_REPORT_DATA_PROVIDER
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
			l_db: ESA_REPORT_DATA_PROVIDER
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
			l_db: ESA_REPORT_DATA_PROVIDER
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
			l_db: ESA_REPORT_DATA_PROVIDER
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
			l_db: ESA_REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)

			l_db.initialize_problem_report (l_db.new_problem_report_id ("jvelilla"), "1", "1", "1", "1", "True", "test", "14.05", "Win8", "Test", "Test")
		end


	 test_temporary_problem_report
	 	local
			l_db: ESA_REPORT_DATA_PROVIDER
			l_tuple: detachable TUPLE[synopsis : detachable STRING;
															   release: detachable STRING;
															   confidential: detachable STRING;
															   environment: detachable STRING;
															   description: detachable STRING;
															   toreproduce: detachable STRING;
															   priority_synopsis: detachable STRING;
															   category_synopsis: detachable STRING;
															   severity_synopsis: detachable STRING;
															   class_synopsis: detachable STRING;
															   user_name: detachable STRING;
															   responsible: detachable STRING
															   ]
			l_report_number: INTEGER
		do
			create l_db.make (connection)
			l_report_number := l_db.new_problem_report_id ("jvelilla")
			l_db.initialize_problem_report (l_report_number, "1", "1", "1", "1", "True", "test", "14.05", "Win8", "Test", "Test")
			l_tuple := l_db.temporary_problem_report (l_report_number)
		end

	test_problem_reports_guest_2
		local
			l_db: ESA_REPORT_DATA_PROVIDER
		do
				-- Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, StatusID
			create l_db.make (connection)
			across l_db.problem_reports_guest_2 (1, 2, 0, 0, "CategorySynopsis", 1) as c loop
				print (c.item.string_8)
			end
		end


	test_responsibles
		local
			l_db: ESA_REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			across l_db.responsibles as c loop print (c.item.string_8) end
		end


	test_row_count_responsible_default
		local
			l_db: ESA_REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			print (l_db.row_count_problem_report_responsible (0,0,0,0,"1,2,3,4,5",""))
		end


	test_problem_report_responsibles
		local
			l_db: ESA_REPORT_DATA_PROVIDER
		do
			create l_db.make (connection)
			across l_db.problem_reports_responsibles (1, 10, 0, 0, 0, 0, "number", 1, "1,2,3,4", "") as c loop
				print (c.item.string_8)
			end
		end


feature -- Implementation

	connection: ESA_DATABASE_CONNECTION
		once
			create {ESA_DATABASE_CONNECTION_ODBC}Result.make_common
		end

end
