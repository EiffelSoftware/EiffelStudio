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
			internal_priority_list.extend ("High")
			internal_priority_list.extend ("Medium")
			internal_priority_list.extend ("Low")
			create internal_category_list.make (4)
			internal_category_list.extend (".NET")
			internal_category_list.extend ("C Compilation")
			internal_category_list.extend ("Compiler")
			internal_category_list.extend ("Debugger")
			create internal_confidential_list.make (2)
			internal_confidential_list.extend ("Yes")
			internal_confidential_list.extend ("No")
			create internal_class_list.make (5)
			internal_class_list.extend ("Bug")
			internal_class_list.extend ("Documentation")
			internal_class_list.extend ("Feature Request")
			internal_class_list.extend ("Installation")
			internal_class_list.extend ("Support")
			create internal_severity_list.make (3)
			internal_severity_list.extend ("Critical")
			internal_severity_list.extend ("Serious")
			internal_severity_list.extend ("Non-Critical")
		end

feature -- Basic Functionality

	internal_priority_list: ARRAYED_LIST [STRING]
	internal_category_list: ARRAYED_LIST [STRING]
	internal_confidential_list: ARRAYED_LIST [STRING]
	internal_class_list: ARRAYED_LIST [STRING]
	internal_severity_list: ARRAYED_LIST [STRING]
	responsibles: ARRAYED_LIST [STRING]

	save (a_problem_report: ANY)
		do
			if attached {PROBLEM_REPORT_BEAN} a_problem_report as problem_report then
				print ("Success: " + problem_report.out)
			else
				print (a_problem_report)
			end
		end
		
	priority_list: LIST [STRING]
		do
			Result := internal_priority_list
		end
		
	category_list: LIST [STRING]
		do
			Result := internal_category_list
		end
	
	confidential_list: LIST [STRING]
		do
			Result := internal_confidential_list
		end
		
	e_class_list: LIST [STRING]
		do
			Result := internal_class_list
		end
		
	severity_list: LIST [STRING]
		do
			Result := internal_severity_list
		end		
	
	environment_info: STRING
		do
			if attached current_request.headers_in ["User-Agent"] as l_user_agent then
				Result := l_user_agent
			else
				Result := ""
			end
		end

end
