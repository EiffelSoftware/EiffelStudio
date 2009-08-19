note
	description: "Summary description for {LOGIN_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROBLEM_REPORT_SEARCH_CONTROLLER

inherit
	XWA_CONTROLLER
		redefine
			on_load		
		end

	G_SHARED_SUPPORT_GLOBAL_STATE
		undefine
			default_create
		end

create
	make

feature -- Initialization

	make
		do
			default_create
			create {ARRAYED_LIST [PROBLEM_REPORT_BEAN]} internal_problem_reports.make (2)
			create internal_query.make
			create responsibles.make (3)
		end

feature -- Access

	overall_count: INTEGER
		-- The number of all the results

feature {NONE} -- Access

	internal_query: PROBLEM_REPORT_QUERY
			-- The query data to search for bug reports

	internal_problem_reports: LIST [PROBLEM_REPORT_BEAN]
			-- The resulting set of bug reports retrieved with the query data

feature -- Basic Functionality

	responsibles: ARRAYED_LIST [STRING]

	problem_reports: LIST [PROBLEM_REPORT_BEAN]
		do
			Result := internal_problem_reports
		end

	priorities: LIST [STRING]
		do
			Result := global_state.persistence.priorities
		end

	severities: LIST [STRING]
		do
			Result := global_state.persistence.severities
		end

	categories: LIST [STRING]
		do
			Result := global_state.persistence.categories
		end

	all_responsibles: LIST [STRING]
		do
			Result := global_state.persistence.responsibles
		end

	search (a_query: PROBLEM_REPORT_QUERY)
		local
				l_tmp: TUPLE [list: LIST [PROBLEM_REPORT_BEAN]; row_count: INTEGER]
		do
			internal_query := a_query
			if attached internal_query then
				l_tmp := global_state.persistence.load_skeleton_problem_reports (internal_query)
				overall_count := l_tmp.row_count
				internal_problem_reports := l_tmp.list
			end
			print ("search")
		ensure
			internal_query_set: internal_query = a_query
		end

feature -- Preliminary processing		

	on_load (a_request: XH_REQUEST; a_response: XH_RESPONSE)
		do
			print ("on_load")

		end

end
