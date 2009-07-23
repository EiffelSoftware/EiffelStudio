note
	description: "Summary description for {LOGIN_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROBLEM_REPORT_QUERY

inherit
	ANY
		redefine
			out
		end

create
	make

feature -- Initialization

	make
		do
			priority := ""
			page_size := ""
			severity := ""
			responsible := ""
			category := ""
			submitter := ""
			open := False
		end
		
feature -- Access

	open: BOOLEAN assign set_open
	
	set_open (a_open: BOOLEAN)
		do
			open := a_open
		end

	submitter: STRING assign set_submitter
	
	set_submitter (a_submitter: STRING)
		do
			submitter := a_submitter
		end

	category: STRING assign set_category
	
	set_category (a_category: STRING)
		do
			category := a_category
		end
	
	responsible: STRING assign set_responsible
	
	set_responsible (a_responsible: STRING)
		do
			responsible := a_responsible
		end
	
	priority: STRING assign set_priority
	
	set_priority (a_priority: STRING)
		do
		end
		
	page_size: STRING assign set_page_size
	
	set_page_size (a_page_size: STRING)
		do
			page_size := a_page_size
		end
	
	severity: STRING assign set_severity
	
	set_severity (a_severity: STRING)
		do
			severity := a_severity
		end
	
	out: STRING
		do
			Result := "PROBLEM_REPORT_QUERY"
		end
	
end
