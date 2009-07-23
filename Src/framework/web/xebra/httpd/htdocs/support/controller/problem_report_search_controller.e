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

create
	make

feature -- Initialization

	make
		do
			Precursor
			create internal_problem_reports.make (2)
			internal_problem_reports.extend (create {PROBLEM_REPORT_BEAN}.make)
			internal_problem_reports.extend (create {PROBLEM_REPORT_BEAN}.make)
			create responsibles.make (3)
			responsibles.extend ("Asterix")
			responsibles.extend ("Obelix")
			responsibles.extend ("idefix")
		end

feature -- Basic Functionality

	responsibles: ARRAYED_LIST [STRING]

	internal_problem_reports: ARRAYED_LIST [PROBLEM_REPORT_BEAN]

	problem_reports: LIST [PROBLEM_REPORT_BEAN]
		do
			Result := internal_problem_reports
		end

	priorities: LIST [STRING]
		do
			Result := all_responsibles
		end

	severities: LIST [STRING]
		do
			Result := all_responsibles
		end

	categories: LIST [STRING]
		do
			Result := all_responsibles
		end

	all_responsibles: LIST [STRING]
		do
			Result := responsibles
		end

end
