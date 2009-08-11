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
	G_SHARED_SUPPORT_GLOBAL_STATE

create
	make

feature -- Initialization

	make
		do
			Precursor
			create internal_priority_list.make (3)
			create internal_category_list.make (4)
			create internal_confidential_list.make (2)
			internal_confidential_list.extend ("Yes")
			internal_confidential_list.extend ("No")
			create internal_class_list.make (5)
			create internal_severity_list.make (3)
			create responsibles.make (3)
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
			Result := global_state.persistence.priorities
		end

	category_list: LIST [STRING]
		do
			Result := global_state.persistence.categories
		end

	confidential_list: LIST [STRING]
		do
			Result := internal_confidential_list
		end

	e_class_list: LIST [STRING]
		do
			Result := global_state.persistence.classes
		end

	severity_list: LIST [STRING]
		do
			Result := global_state.persistence.severities
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
