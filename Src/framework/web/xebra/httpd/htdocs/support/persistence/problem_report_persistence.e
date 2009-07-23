note
	description: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROBLEM_REPORT_PERSISTENCE

feature {NONE} -- Access


feature -- Basic functionality

	save_new_problem_report (a_report: PROBLEM_REPORT_BEAN)
			-- Saves a new bug report
		require
			a_report_attached: attached a_report
		deferred
		end

end
