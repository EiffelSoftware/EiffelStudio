note
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DB_PROBLEM_REPORT_PERSISTENCE

inherit
	PROBLEM_REPORT_PERSISTENCE
	
create
	make

feature -- Basic functionality

	save_new_problem_report (a_report: PROBLEM_REPORT_BEAN)
			-- Saves a new bug report
		require
			a_report_attached: attached a_report
		do
		end

end
