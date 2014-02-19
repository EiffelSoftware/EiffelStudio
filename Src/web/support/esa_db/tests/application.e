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
			execute_report_guest
		end


	execute_read_example
		local
			l_prov: ESA_DATA_PROVIDER
			list: LIST[REPORT]
		do
			create l_prov.make
			list := l_prov.problem_reports ("jvelilla", False, 15, 3)
			across list as l loop print (l.item) end
		end


	execute_guest_reports
		local
			l_prov: ESA_DATA_PROVIDER
			list: LIST[REPORT]
		do
			print ("%NGuest Reports")
			create l_prov.make
			list := l_prov.problem_reports_guest (1, 2)
			across list as l loop print (l.item.string_8); io.put_new_line end
		end

	execute_row_count
		local
			l_prov: ESA_DATA_PROVIDER
		do
			create l_prov.make
			print ("RowCount { ProblemReports } :" + l_prov.row_count ("ProblemReports").out)
			print ("RowCount { Contacts } :" + l_prov.row_count ("Contacts").out)
 			print ("RowCount { NotExist } :" + l_prov.row_count ("NotExist").out)
			print ("RowCount { Memberships } :" + l_prov.row_count ("Memberships").out)
		end


	execute_write_example
		local
			l_prov: ESA_DATA_PROVIDER
		do
			create l_prov.make
			print (l_prov.new_problem_report_id ("jvelilla"))
		end

	execute_report_guest
		local
			l_prov: ESA_DATA_PROVIDER
		do
			create l_prov.make
			print (l_prov.problem_report (18628))
		end


end
