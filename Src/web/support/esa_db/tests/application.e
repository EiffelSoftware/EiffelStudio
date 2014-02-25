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
			test_user_from_email
--			test_user_form_username
		end


	execute_read_example
		local
			l_prov: ESA_REPORT_DATA_PROVIDER
			list: LIST[REPORT]
		do
			create l_prov.make (connection)
			list := l_prov.problem_reports ("jvelilla", False, 15, 3)
			across list as l loop print (l.item) end
		end


	execute_guest_reports
		local
			l_prov: ESA_REPORT_DATA_PROVIDER
			list: ESA_DATA_VALUE
		do
			print ("%NGuest Reports")
			create l_prov.make (connection)
			list := l_prov.problem_reports_guest (1, 2)
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

			across l_prov.problem_reports_2 ("jvelilla", False, 15, 3) as c  loop
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


	connection: ESA_DATABASE_CONNECTION
		once
			create {ESA_DATABASE_CONNECTION_ODBC}Result.make_common
		end

end
