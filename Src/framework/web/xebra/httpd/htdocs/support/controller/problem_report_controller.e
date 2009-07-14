note
	description: "Summary description for {LOGIN_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROBLEM_REPORT_CONTROLLER

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
			create internal_priority_list.make (3)
			internal_priority_list.extend ("Item 1")
			internal_priority_list.extend ("Item 2")
			internal_priority_list.extend ("Item 3")
		end

feature -- Basic Functionality

	internal_priority_list: ARRAYED_LIST [STRING]

	save (a_problem_report: ANY)
		do
			-- TODO
		end
		
	priority_list: LIST [STRING]
		do
			Result := internal_priority_list
		end	

end
