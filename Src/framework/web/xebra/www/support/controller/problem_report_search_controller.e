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
			make
		end
	G_SHARED_SUPPORT_GLOBAL_STATE

create
	make

feature -- Initialization

	make
		do
			Precursor
			create internal_problem_reports.make (2)
			internal_problem_reports.extend (create {PROBLEM_REPORT_BEAN}.make)
			internal_problem_reports.extend (create {PROBLEM_REPORT_BEAN}.make)
			internal_problem_reports.extend (create {PROBLEM_REPORT_BEAN}.make)
			internal_problem_reports.extend (create {PROBLEM_REPORT_BEAN}.make)
			internal_problem_reports.extend (create {PROBLEM_REPORT_BEAN}.make)
			internal_problem_reports.extend (create {PROBLEM_REPORT_BEAN}.make)
			create responsibles.make (3)
			responsibles.extend ("Asterix")
			responsibles.extend ("Obelix")
			responsibles.extend ("idefix")
		end

feature -- Access

	overall_count: INTEGER
		-- The number of all the results
	
feature -- Basic Functionality

	responsibles: ARRAYED_LIST [STRING]

	internal_problem_reports: ARRAYED_LIST [PROBLEM_REPORT_BEAN]

	problem_reports: LIST [PROBLEM_REPORT_BEAN]
		local
			l_tmp: TUPLE [list: LIST [PROBLEM_REPORT_BEAN]; row_count: INTEGER]
		do
			l_tmp := global_state.persistence.load_skeleton_problem_reports (0, 20)
			overall_count := l_tmp.row_count
			Result := l_tmp.list
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

end
