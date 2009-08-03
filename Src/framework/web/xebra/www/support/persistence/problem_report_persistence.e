note
	description: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROBLEM_REPORT_PERSISTENCE

feature {NONE} -- Access


feature -- Basic functionality

	open: BOOLEAN
		deferred
		end

	save_new_problem_report (a_report: PROBLEM_REPORT_BEAN)
			-- Saves a new bug report
		require
			a_report_attached: attached a_report
		deferred
		end

	load_skeleton_problem_reports (a_from, a_size: INTEGER): TUPLE [list: LIST [PROBLEM_REPORT_BEAN]; row_count: INTEGER]
			-- `a_max': Maximal number of results in List
		require
			a_from_valid: a_from >= 0
			a_size_valid: a_size >= 0
		deferred
		ensure
			Result_attached: attached Result
		end

	priorities: LIST [STRING]
		deferred
		ensure
			Result_attached: attached Result
		end

	severities: LIST [STRING]
		deferred
		ensure
			Result_attached: attached Result
		end

	categories: LIST [STRING]
		deferred
		ensure
			Result_attached: attached Result
		end

	responsibles: LIST [STRING]
		deferred
		ensure
			Result_attached: attached Result
		end

end
