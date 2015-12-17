note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_PROTECTED___PROBLEM_REPORT_FORM_SERVLET

inherit
	XWA_SERVLET redefine make end

create
	make

feature-- Access

	controller_1: PROBLEM_REPORT_CONTROLLER

	controller_2: LOGIN_CONTROLLER

	internal_controllers: LIST [XWA_CONTROLLER]

	problem_report: PROBLEM_REPORT_BEAN

	class_temp_4: HASH_TABLE [STRING , STRING]

	class_temp_5: HASH_TABLE [STRING , STRING]

	class_temp_6: HASH_TABLE [STRING , STRING]

	class_temp_7: HASH_TABLE [STRING , STRING]

	class_temp_8: HASH_TABLE [STRING , STRING]

feature-- Implementation

	make
			--<Precursor>
		do
				-- no debug information
				-- no debug information
			Precursor
				-- no debug information
				-- no debug information
			create {ARRAYED_LIST [XWA_CONTROLLER]} internal_controllers.make (2)
				-- no debug information
				-- no debug information
			create controller_1.make
				-- no debug information
				-- no debug information
			internal_controllers.extend (controller_1)
				-- no debug information
				-- no debug information
			create controller_2.default_create
				-- no debug information
				-- no debug information
			internal_controllers.extend (controller_2)
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			create problem_report.make
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			create class_temp_4.make (5)
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			create class_temp_5.make (5)
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			create class_temp_6.make (5)
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			create class_temp_7.make (5)
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			create class_temp_8.make (5)
		end

	set_all_booleans (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		do
				-- line: 23 row: 1 of file: ./support_master.xeb
				-- line: 23 row: 1 of file: ./support_master.xeb
			render_conditions ["class_temp_0"] := controller_2.is_logged_in
				-- line: 29 row: 1 of file: ./support_master.xeb
				-- line: 29 row: 1 of file: ./support_master.xeb
			render_conditions ["class_temp_1"] := controller_2.is_not_logged_in
				-- line: 34 row: 1 of file: ./support_master.xeb
				-- line: 34 row: 1 of file: ./support_master.xeb
			render_conditions ["class_temp_2"] := controller_2.is_logged_in
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			render_conditions ["class_temp_3"] := controller_2.is_logged_in
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			render_conditions ["class_temp_9"] := controller_2.is_not_logged_in
		end

	handle_form_internal (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			--<Precursor>
		do
				-- line: 23 row: 1 of file: ./support_master.xeb
				-- line: 23 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_0"] and then render_conditions ["class_temp_0"] then
				-- line: 23 row: 1 of file: ./support_master.xeb
				-- line: 23 row: 1 of file: ./support_master.xeb
			end
				-- line: 29 row: 1 of file: ./support_master.xeb
				-- line: 29 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_1"] and then render_conditions ["class_temp_1"] then
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			if attached a_request.argument_table ["l_temp_0"] as form_argument then
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			from
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			a_request.argument_table.start
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			until
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			a_request.argument_table.after
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			loop
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			if attached l_agent_table [a_request.argument_table.key_for_iteration] as l_agent and then not a_request.argument_table.item_for_iteration.is_empty then
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			l_agent.call ([a_request])
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			end
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			a_request.argument_table.forth
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			end
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			end
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			end
				-- line: 29 row: 1 of file: ./support_master.xeb
				-- line: 29 row: 1 of file: ./support_master.xeb
			end
				-- line: 34 row: 1 of file: ./support_master.xeb
				-- line: 34 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_2"] and then render_conditions ["class_temp_2"] then
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			if attached a_request.argument_table ["l_temp_3"] as form_argument then
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			if attached agent_table ["l_temp_3"] as l_agent_table then
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			from
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			a_request.argument_table.start
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			until
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			a_request.argument_table.after
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			loop
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			if attached l_agent_table [a_request.argument_table.key_for_iteration] as l_agent and then not a_request.argument_table.item_for_iteration.is_empty then
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			l_agent.call ([a_request])
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			end
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			a_request.argument_table.forth
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			end
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			end
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			end
				-- line: 34 row: 1 of file: ./support_master.xeb
				-- line: 34 row: 1 of file: ./support_master.xeb
			end
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_3"] and then render_conditions ["class_temp_3"] then
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_6"] as form_argument then
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			if attached agent_table ["l_temp_6"] as l_agent_table then
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			from
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			a_request.argument_table.start
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			until
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			a_request.argument_table.after
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			if attached l_agent_table [a_request.argument_table.key_for_iteration] as l_agent and then not a_request.argument_table.item_for_iteration.is_empty then
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			l_agent.call ([a_request])
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			a_request.argument_table.forth
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			end
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_9"] and then render_conditions ["class_temp_9"] then
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			end
		end

	render_html_page (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		local
			l_temp_0: STRING
			l_temp_2: STRING
			l_temp_3: STRING
			l_temp_5: STRING
			l_temp_6: STRING
			category_error: STRING
			l_temp_7: STRING
			l_temp_8: LIST [STRING]
			l_temp_9: STRING
			severity_error: STRING
			l_temp_10: STRING
			l_temp_11: LIST [STRING]
			l_temp_12: STRING
			class_error: STRING
			l_temp_13: STRING
			l_temp_14: LIST [STRING]
			l_temp_15: STRING
			priority_error: STRING
			l_temp_16: STRING
			l_temp_17: LIST [STRING]
			l_temp_18: STRING
			l_temp_19: STRING
			release_error: STRING
			confidential_errors: STRING
			l_temp_20: STRING
			l_temp_21: LIST [STRING]
			l_temp_22: STRING
			environment_errors: STRING
			l_temp_23: STRING
			synopsis_errors: STRING
			l_temp_24: STRING
			description_errors: STRING
			l_temp_25: STRING
			to_reproduce_text_errors: STRING
			l_temp_26: STRING
			l_temp_28: STRING
		do
				-- line: 2 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_0)
				-- line: 75 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 3 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 4 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 10 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_3)
				-- line: 5 row: 3 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 8 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_5)
				-- line: 6 row: 4 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 7 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_7)
				-- line: 7 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_8)
				-- line: 7 row: 3 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 8 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_9)
				-- line: 8 row: 3 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 9 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_10)
				-- line: 9 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_11)
				-- line: 9 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 10 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 10 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 74 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_13)
				-- line: 11 row: 3 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 63 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_14)
				-- line: 12 row: 4 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 57 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 13 row: 5 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 56 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 14 row: 6 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 15 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 14 row: 82 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_20)
				-- line: 14 row: 82 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 15 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 15 row: 6 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 39 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 16 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 24 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_25)
				-- line: 17 row: 8 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 17 row: 50 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 17 row: 46 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_28)
				-- line: 17 row: 50 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 18 row: 8 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_30)
				-- line: 19 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 18 row: 34 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_32)
				-- line: 19 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 19 row: 8 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 23 row: 1 of file: ./support_master.xeb
				-- line: 23 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_0"] and then render_conditions ["class_temp_0"] then
				-- line: 20 row: 11 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 20 row: 71 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_34)
				-- line: 20 row: 57 of file: ./support_master.xeb
				-- line: 20 row: 57 of file: ./support_master.xeb
			if attached {STRING} controller_2.user_name as l_text then 
				-- line: 20 row: 57 of file: ./support_master.xeb
			response.append (l_text)
				-- line: 20 row: 57 of file: ./support_master.xeb
				-- line: 20 row: 57 of file: ./support_master.xeb
			else
				-- line: 20 row: 57 of file: ./support_master.xeb
			response.append (controller_2.user_name.out)
				-- line: 20 row: 57 of file: ./support_master.xeb
				-- line: 20 row: 57 of file: ./support_master.xeb
			end
				-- line: 20 row: 67 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 20 row: 71 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 21 row: 9 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_36)
				-- line: 22 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_37)
				-- line: 21 row: 59 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_38)
				-- line: 22 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 22 row: 8 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 23 row: 1 of file: ./support_master.xeb
				-- line: 23 row: 1 of file: ./support_master.xeb
			end
				-- line: 23 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 24 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 24 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 36 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_39)
				-- line: 25 row: 8 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 35 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_40)
				-- line: 26 row: 9 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 29 row: 1 of file: ./support_master.xeb
				-- line: 29 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_1"] and then render_conditions ["class_temp_1"] then
				-- line: 29 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 27 row: 10 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			l_temp_0:= unique_id
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			response.append ("<form id=%"l_temp_0%" action=%"" +request.uri + "%" method=%"post%">")
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			agent_table ["l_temp_0"] := create {HASH_TABLE [PROCEDURE, STRING]}.make (1)
				-- line: 27 row: 64 of file: ./support_master.xeb
				-- line: 27 row: 64 of file: ./support_master.xeb
				-- line: 27 row: 64 of file: ./support_master.xeb
			l_temp_2 := unique_id
				-- line: 27 row: 64 of file: ./support_master.xeb
				-- line: 27 row: 64 of file: ./support_master.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_0']['" + l_temp_2+ "'].value='" + l_temp_2+ "'; document.forms['l_temp_0'].submit(); return false;%">Login</a><input type=%"hidden%" name =%"" + l_temp_2+ "%" />")
				-- line: 27 row: 64 of file: ./support_master.xeb
				-- line: 27 row: 64 of file: ./support_master.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 27 row: 64 of file: ./support_master.xeb
				-- line: 27 row: 64 of file: ./support_master.xeb
			l_agent_table [l_temp_2] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 27 row: 64 of file: ./support_master.xeb
				-- line: 27 row: 64 of file: ./support_master.xeb
			controller_2.login
				-- line: 27 row: 64 of file: ./support_master.xeb
				-- line: 27 row: 64 of file: ./support_master.xeb
			end (?, Void) -- COMMAND_LINK_TAG
				-- line: 27 row: 64 of file: ./support_master.xeb
				-- line: 27 row: 64 of file: ./support_master.xeb
			end
				-- line: 27 row: 73 of file: ./support_master.xeb
				-- line: 27 row: 73 of file: ./support_master.xeb
			response.append("<input type=%"hidden%" name=%"l_temp_0%" value=%""+l_temp_0+"%" />")
				-- line: 27 row: 73 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_44)
				-- line: 27 row: 76 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_45)
				-- line: 28 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_34)
				-- line: 27 row: 95 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_46)
				-- line: 28 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 28 row: 9 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 29 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_47)
				-- line: 29 row: 1 of file: ./support_master.xeb
				-- line: 29 row: 1 of file: ./support_master.xeb
			end
				-- line: 29 row: 9 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 34 row: 1 of file: ./support_master.xeb
				-- line: 34 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_2"] and then render_conditions ["class_temp_2"] then
				-- line: 34 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 30 row: 10 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			l_temp_3:= unique_id
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			response.append ("<form id=%"l_temp_3%" action=%"" +request.uri + "%" method=%"post%">")
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			agent_table ["l_temp_3"] := create {HASH_TABLE [PROCEDURE, STRING]}.make (3)
				-- line: 31 row: 11 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 32 row: 1 of file: ./support_master.xeb
				-- line: 32 row: 1 of file: ./support_master.xeb
				-- line: 32 row: 1 of file: ./support_master.xeb
			l_temp_5 := unique_id
				-- line: 32 row: 1 of file: ./support_master.xeb
				-- line: 32 row: 1 of file: ./support_master.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_3']['" + l_temp_5+ "'].value='" + l_temp_5+ "'; document.forms['l_temp_3'].submit(); return false;%">Logout</a><input type=%"hidden%" name =%"" + l_temp_5+ "%" />")
				-- line: 32 row: 1 of file: ./support_master.xeb
				-- line: 32 row: 1 of file: ./support_master.xeb
			if attached agent_table ["l_temp_3"] as l_agent_table then
				-- line: 32 row: 1 of file: ./support_master.xeb
				-- line: 32 row: 1 of file: ./support_master.xeb
			l_agent_table [l_temp_5] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 32 row: 1 of file: ./support_master.xeb
				-- line: 32 row: 1 of file: ./support_master.xeb
			controller_2.logout
				-- line: 32 row: 1 of file: ./support_master.xeb
				-- line: 32 row: 1 of file: ./support_master.xeb
			end (?, Void) -- COMMAND_LINK_TAG
				-- line: 32 row: 1 of file: ./support_master.xeb
				-- line: 32 row: 1 of file: ./support_master.xeb
			end
				-- line: 32 row: 10 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 33 row: 1 of file: ./support_master.xeb
				-- line: 33 row: 1 of file: ./support_master.xeb
			response.append("<input type=%"hidden%" name=%"l_temp_3%" value=%""+l_temp_3+"%" />")
				-- line: 33 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_44)
				-- line: 33 row: 9 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 34 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_47)
				-- line: 34 row: 1 of file: ./support_master.xeb
				-- line: 34 row: 1 of file: ./support_master.xeb
			end
				-- line: 34 row: 8 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 35 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 35 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 36 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 36 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 37 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_49)
				-- line: 37 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 37 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 38 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_50)
				-- line: 38 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 38 row: 6 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 39 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 39 row: 6 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 47 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_51)
				-- line: 40 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_3"] and then render_conditions ["class_temp_3"] then
				-- line: 43 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 41 row: 8 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 3 row: 3 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 23 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_52)
				-- line: 4 row: 4 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 22 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_53)
				-- line: 5 row: 5 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 6 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_54)
				-- line: 5 row: 21 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_55)
				-- line: 6 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_56)
				-- line: 6 row: 5 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 12 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_57)
				-- line: 7 row: 6 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 8 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 7 row: 17 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 7 row: 102 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 7 row: 98 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 7 row: 102 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 8 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_62)
				-- line: 8 row: 6 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 9 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 8 row: 17 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 8 row: 76 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 8 row: 72 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_64)
				-- line: 8 row: 76 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 9 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_62)
				-- line: 9 row: 6 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 10 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 9 row: 17 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 9 row: 88 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_65)
				-- line: 9 row: 84 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 9 row: 88 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 10 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_62)
				-- line: 10 row: 6 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 11 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 10 row: 17 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 10 row: 77 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_67)
				-- line: 10 row: 73 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_68)
				-- line: 10 row: 77 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 11 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_62)
				-- line: 11 row: 5 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 12 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 12 row: 5 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 13 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_54)
				-- line: 12 row: 25 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_70)
				-- line: 13 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_56)
				-- line: 13 row: 5 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 17 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_57)
				-- line: 14 row: 6 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 15 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 14 row: 17 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 14 row: 84 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_71)
				-- line: 14 row: 80 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 14 row: 84 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 15 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_62)
				-- line: 15 row: 6 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 16 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 15 row: 17 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 15 row: 98 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_73)
				-- line: 15 row: 94 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_74)
				-- line: 15 row: 98 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 16 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_62)
				-- line: 16 row: 5 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 17 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 17 row: 5 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 18 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_54)
				-- line: 17 row: 27 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_75)
				-- line: 18 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_56)
				-- line: 18 row: 5 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 21 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_57)
				-- line: 19 row: 6 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 20 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 19 row: 17 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 19 row: 108 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_76)
				-- line: 19 row: 104 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_77)
				-- line: 19 row: 108 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 20 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_62)
				-- line: 20 row: 5 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 21 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 21 row: 4 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 22 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 22 row: 3 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 23 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 23 row: 3 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 28 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_78)
				-- line: 24 row: 4 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 25 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_79)
				-- line: 25 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 25 row: 4 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 4 row: 3 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 5 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_80)
				-- line: 4 row: 57 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_81)
				-- line: 4 row: 52 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_271)
				-- line: 4 row: 57 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_83)
				-- line: 5 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 5 row: 3 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 10 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_139)
				-- line: 7 row: 22 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_272)
				-- line: 8 row: 38 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_273)
				-- line: 8 row: 34 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_274)
				-- line: 8 row: 38 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 9 row: 3 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_275)
				-- line: 10 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_141)
				-- line: 10 row: 3 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 197 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_222)
				-- line: 12 row: 4 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_276)
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_6:= unique_id
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ("<form id=%"l_temp_6%" action=%"" +request.uri + "%" method=%"post%">")
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			agent_table ["l_temp_6"] := create {HASH_TABLE [PROCEDURE, STRING]}.make (5)
				-- line: 13 row: 4 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 98 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_111)
				-- line: 14 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 38 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 15 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 21 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 16 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 20 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_277)
				-- line: 17 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 18 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_278)
				-- line: 17 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 17 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 18 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 18 row: 25 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_280)
				-- line: 19 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_281)
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			if attached {LIST [STRING]} validation_errors ["category"] as error_list then
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			from
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			error_list.start
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			until
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			error_list.after
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			category_error:= error_list.item
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			error_list.forth
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			end
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
				-- line: 18 row: 114 of file: ./protected/problem_report_form.xeb
			end
				-- line: 19 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 19 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 20 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 20 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 21 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 21 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 26 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_282)
				-- line: 22 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_7 := unique_id
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<select name=%"l_temp_7%">")
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			from
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_8 := controller_1.category_list
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_8.start
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			until
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_8.after
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_9 := unique_id
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_8.item.is_equal (problem_report.category) then
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<option selected=%"true%" value=%""+l_temp_9+"%">" + l_temp_8.item.out + "</option>")
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			else
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<option value=%""+l_temp_9+"%">" + l_temp_8.item.out + "</option>")
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			class_temp_4[l_temp_9] := l_temp_8.item
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_8.forth
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("</select>")
				-- line: 23 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 24 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 25 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 26 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 26 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 32 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 27 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 31 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_283)
				-- line: 28 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 28 row: 124 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_278)
				-- line: 28 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 28 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 28 row: 124 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 29 row: 17 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_284)
				-- line: 30 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_281)
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			if attached {LIST [STRING]} validation_errors ["severity"] as error_list then
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			from
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			error_list.start
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			until
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			error_list.after
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			severity_error:= error_list.item
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			error_list.forth
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			end
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 29 row: 106 of file: ./protected/problem_report_form.xeb
			end
				-- line: 30 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 30 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 31 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 31 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 32 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 32 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 37 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 33 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_10 := unique_id
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<select name=%"l_temp_10%">")
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			from
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_11 := controller_1.severity_list
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_11.start
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			until
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_11.after
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_12 := unique_id
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_11.item.is_equal ("1") then
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<option selected=%"true%" value=%""+l_temp_12+"%">" + l_temp_11.item.out + "</option>")
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			else
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<option value=%""+l_temp_12+"%">" + l_temp_11.item.out + "</option>")
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			class_temp_5[l_temp_12] := l_temp_11.item
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_11.forth
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("</select>")
				-- line: 34 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 35 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 36 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 37 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 37 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 38 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 38 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 62 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 39 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 45 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 40 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 44 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_285)
				-- line: 41 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 41 row: 124 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_278)
				-- line: 41 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 41 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 41 row: 124 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 42 row: 14 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_286)
				-- line: 42 row: 104 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_281)
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			if attached {LIST [STRING]} validation_errors ["class"] as error_list then
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			from
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			error_list.start
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			until
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			error_list.after
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			class_error:= error_list.item
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			error_list.forth
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			end
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
				-- line: 42 row: 97 of file: ./protected/problem_report_form.xeb
			end
				-- line: 42 row: 104 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 43 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_287)
				-- line: 44 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 44 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 45 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 45 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 50 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 46 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_13 := unique_id
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<select name=%"l_temp_13%">")
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			from
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_14 := controller_1.e_class_list
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_14.start
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			until
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_14.after
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_15 := unique_id
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_14.item.is_equal ("1") then
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<option selected=%"true%" value=%""+l_temp_15+"%">" + l_temp_14.item.out + "</option>")
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			else
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<option value=%""+l_temp_15+"%">" + l_temp_14.item.out + "</option>")
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			class_temp_6[l_temp_15] := l_temp_14.item
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_14.forth
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("</select>")
				-- line: 47 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 48 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 49 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 50 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 50 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 56 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 51 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 55 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_288)
				-- line: 52 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 52 row: 124 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_278)
				-- line: 52 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 52 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 52 row: 124 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 53 row: 17 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_289)
				-- line: 54 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_281)
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			if attached {LIST [STRING]} validation_errors ["priority"] as error_list then
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			from
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			error_list.start
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			until
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			error_list.after
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			priority_error:= error_list.item
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			error_list.forth
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			end
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
				-- line: 53 row: 106 of file: ./protected/problem_report_form.xeb
			end
				-- line: 54 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 54 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 55 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 55 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 56 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 56 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 61 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 57 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_16 := unique_id
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<select name=%"l_temp_16%">")
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			from
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_17 := controller_1.priority_list
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_17.start
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			until
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_17.after
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_18 := unique_id
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_17.item.is_equal ("1") then
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<option selected=%"true%" value=%""+l_temp_18+"%">" + l_temp_17.item.out + "</option>")
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			else
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<option value=%""+l_temp_18+"%">" + l_temp_17.item.out + "</option>")
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			class_temp_7[l_temp_18] := l_temp_17.item
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_17.forth
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("</select>")
				-- line: 58 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 59 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 60 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 61 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 61 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 62 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 62 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 97 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 63 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 69 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 64 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 68 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_290)
				-- line: 65 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 65 row: 124 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_278)
				-- line: 65 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 65 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 65 row: 124 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 67 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_291)
				-- line: 68 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 68 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 69 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 69 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 81 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 70 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_292)
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_19 := unique_id
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<input type=%"text%" value=%""+problem_report.release+"%" size=%"14%" name=%"l_temp_19%" />")
				-- line: 71 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 72 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 74 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_293)
				-- line: 80 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_281)
				-- line: 75 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			if attached {LIST [STRING]} validation_errors ["release_input"] as error_list then
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			from
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			error_list.start
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			until
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			error_list.after
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			release_error:= error_list.item
				-- line: 76 row: 9 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 77 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_90)
				-- line: 77 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_91)
				-- line: 77 row: 9 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 78 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 1 of file: ./protected/problem_report_form.xeb
			if attached {STRING} release_error.out as l_text then 
				-- line: 78 row: 1 of file: ./protected/problem_report_form.xeb
			response.append (l_text)
				-- line: 78 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 1 of file: ./protected/problem_report_form.xeb
			else
				-- line: 78 row: 1 of file: ./protected/problem_report_form.xeb
			response.append (release_error.out.out)
				-- line: 78 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 78 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			error_list.forth
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			end
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 78 row: 30 of file: ./protected/problem_report_form.xeb
			end
				-- line: 79 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_294)
				-- line: 80 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 80 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 81 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 81 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 91 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 82 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 90 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_295)
				-- line: 83 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 84 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_296)
				-- line: 83 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 83 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 84 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 84 row: 21 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_297)
				-- line: 89 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_281)
				-- line: 85 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			if attached {LIST [STRING]} validation_errors ["confidential"] as error_list then
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			from
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			error_list.start
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			until
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			error_list.after
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			confidential_errors:= error_list.item
				-- line: 86 row: 9 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 86 row: 58 of file: ./protected/problem_report_form.xeb
				-- line: 86 row: 58 of file: ./protected/problem_report_form.xeb
			if attached {STRING} confidential_errors.out as l_text then 
				-- line: 86 row: 58 of file: ./protected/problem_report_form.xeb
			response.append (l_text)
				-- line: 86 row: 58 of file: ./protected/problem_report_form.xeb
				-- line: 86 row: 58 of file: ./protected/problem_report_form.xeb
			else
				-- line: 86 row: 58 of file: ./protected/problem_report_form.xeb
			response.append (confidential_errors.out.out)
				-- line: 86 row: 58 of file: ./protected/problem_report_form.xeb
				-- line: 86 row: 58 of file: ./protected/problem_report_form.xeb
			end
				-- line: 87 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_298)
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			error_list.forth
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 88 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 88 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 89 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 89 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 90 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 90 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 91 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 91 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 96 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 92 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_20 := unique_id
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<select name=%"l_temp_20%">")
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			from
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_21 := controller_1.confidential_list
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_21.start
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			until
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_21.after
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_22 := unique_id
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_21.item.is_equal ("1") then
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<option selected=%"true%" value=%""+l_temp_22+"%">" + l_temp_21.item.out + "</option>")
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			else
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<option value=%""+l_temp_22+"%">" + l_temp_21.item.out + "</option>")
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			class_temp_8[l_temp_22] := l_temp_21.item
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_21.forth
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("</select>")
				-- line: 93 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 94 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 95 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 96 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 96 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 97 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 97 row: 4 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 98 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_137)
				-- line: 99 row: 4 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_299)
				-- line: 195 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_111)
				-- line: 100 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 110 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 101 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 109 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 102 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 108 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_300)
				-- line: 103 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 104 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_301)
				-- line: 103 row: 119 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 103 row: 119 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 104 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 104 row: 20 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_302)
				-- line: 107 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_281)
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			if attached {LIST [STRING]} validation_errors ["environment_text"] as error_list then
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			from
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			error_list.start
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			until
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			error_list.after
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			environment_errors:= error_list.item
				-- line: 105 row: 9 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 105 row: 57 of file: ./protected/problem_report_form.xeb
				-- line: 105 row: 57 of file: ./protected/problem_report_form.xeb
			if attached {STRING} environment_errors.out as l_text then 
				-- line: 105 row: 57 of file: ./protected/problem_report_form.xeb
			response.append (l_text)
				-- line: 105 row: 57 of file: ./protected/problem_report_form.xeb
				-- line: 105 row: 57 of file: ./protected/problem_report_form.xeb
			else
				-- line: 105 row: 57 of file: ./protected/problem_report_form.xeb
			response.append (environment_errors.out.out)
				-- line: 105 row: 57 of file: ./protected/problem_report_form.xeb
				-- line: 105 row: 57 of file: ./protected/problem_report_form.xeb
			end
				-- line: 106 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_298)
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			error_list.forth
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			end
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 106 row: 30 of file: ./protected/problem_report_form.xeb
			end
				-- line: 107 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 107 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 108 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 108 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 109 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 109 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 110 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 110 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 117 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 111 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 116 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 112 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_23 := unique_id
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<textarea rows=%"3%" cols=%"80%" name=%"l_temp_23%">"+controller_1.environment_info+"</textarea>")
				-- line: 113 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 114 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 115 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 116 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 116 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 117 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 117 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 127 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 118 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 126 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 119 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 125 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_303)
				-- line: 120 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 121 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_304)
				-- line: 120 row: 116 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 120 row: 116 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 121 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 121 row: 17 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_305)
				-- line: 124 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_281)
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			if attached {LIST [STRING]} validation_errors ["synopsis_text"] as error_list then
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			from
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			error_list.start
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			until
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			error_list.after
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			synopsis_errors:= error_list.item
				-- line: 122 row: 9 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 122 row: 54 of file: ./protected/problem_report_form.xeb
				-- line: 122 row: 54 of file: ./protected/problem_report_form.xeb
			if attached {STRING} synopsis_errors.out as l_text then 
				-- line: 122 row: 54 of file: ./protected/problem_report_form.xeb
			response.append (l_text)
				-- line: 122 row: 54 of file: ./protected/problem_report_form.xeb
				-- line: 122 row: 54 of file: ./protected/problem_report_form.xeb
			else
				-- line: 122 row: 54 of file: ./protected/problem_report_form.xeb
			response.append (synopsis_errors.out.out)
				-- line: 122 row: 54 of file: ./protected/problem_report_form.xeb
				-- line: 122 row: 54 of file: ./protected/problem_report_form.xeb
			end
				-- line: 123 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_298)
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			error_list.forth
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			end
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
				-- line: 123 row: 30 of file: ./protected/problem_report_form.xeb
			end
				-- line: 124 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 124 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 125 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 125 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 126 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 126 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 127 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 127 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 134 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 128 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 133 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 129 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_24 := unique_id
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<input type=%"text%" value=%"%" size=%"70%" name=%"l_temp_24%" />")
				-- line: 130 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 131 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 132 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 133 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 133 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 134 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 135 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_306)
				-- line: 143 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 136 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 142 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 137 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 141 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_307)
				-- line: 138 row: 9 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 139 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_308)
				-- line: 138 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 138 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 139 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 140 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_309)
				-- line: 141 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 141 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 142 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 142 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 143 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 143 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 148 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 144 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 146 row: 12 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 145 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 145 row: 47 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_310)
				-- line: 145 row: 47 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 146 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_294)
				-- line: 146 row: 12 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 147 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_119)
				-- line: 148 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 149 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_311)
				-- line: 161 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 150 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 160 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 151 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 159 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_312)
				-- line: 152 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 153 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_313)
				-- line: 152 row: 119 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 152 row: 119 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 153 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 153 row: 20 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_314)
				-- line: 158 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_281)
				-- line: 154 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			if attached {LIST [STRING]} validation_errors ["description_text"] as error_list then
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			from
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			error_list.start
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			until
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			error_list.after
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			description_errors:= error_list.item
				-- line: 155 row: 9 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 155 row: 53 of file: ./protected/problem_report_form.xeb
				-- line: 155 row: 53 of file: ./protected/problem_report_form.xeb
			if attached {STRING} description_errors as l_text then 
				-- line: 155 row: 53 of file: ./protected/problem_report_form.xeb
			response.append (l_text)
				-- line: 155 row: 53 of file: ./protected/problem_report_form.xeb
				-- line: 155 row: 53 of file: ./protected/problem_report_form.xeb
			else
				-- line: 155 row: 53 of file: ./protected/problem_report_form.xeb
			response.append (description_errors.out)
				-- line: 155 row: 53 of file: ./protected/problem_report_form.xeb
				-- line: 155 row: 53 of file: ./protected/problem_report_form.xeb
			end
				-- line: 156 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_298)
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			error_list.forth
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 157 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 157 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 158 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 158 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 159 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 159 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 160 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 160 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 161 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 161 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 169 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 162 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 167 row: 11 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 163 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_25 := unique_id
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<textarea rows=%"15%" cols=%"80%" name=%"l_temp_25%"></textarea>")
				-- line: 164 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 165 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 167 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_315)
				-- line: 167 row: 11 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 168 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_316)
				-- line: 169 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 169 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 182 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 170 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 181 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 171 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 180 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_317)
				-- line: 172 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 173 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_278)
				-- line: 172 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_279)
				-- line: 172 row: 120 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 173 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 174 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_318)
				-- line: 179 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_281)
				-- line: 175 row: 9 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			if attached {LIST [STRING]} validation_errors ["to_reproduce_text"] as error_list then
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			from
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			error_list.start
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			until
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			error_list.after
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			loop
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			to_reproduce_text_errors:= error_list.item
				-- line: 176 row: 10 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 176 row: 60 of file: ./protected/problem_report_form.xeb
				-- line: 176 row: 60 of file: ./protected/problem_report_form.xeb
			if attached {STRING} to_reproduce_text_errors as l_text then 
				-- line: 176 row: 60 of file: ./protected/problem_report_form.xeb
			response.append (l_text)
				-- line: 176 row: 60 of file: ./protected/problem_report_form.xeb
				-- line: 176 row: 60 of file: ./protected/problem_report_form.xeb
			else
				-- line: 176 row: 60 of file: ./protected/problem_report_form.xeb
			response.append (to_reproduce_text_errors.out)
				-- line: 176 row: 60 of file: ./protected/problem_report_form.xeb
				-- line: 176 row: 60 of file: ./protected/problem_report_form.xeb
			end
				-- line: 177 row: 9 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_319)
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			error_list.forth
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 178 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 178 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 179 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 179 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 180 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 180 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 181 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 181 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 182 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 182 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 189 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 183 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 187 row: 11 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_320)
				-- line: 184 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_26 := unique_id
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<textarea rows=%"10%" cols=%"80%" name=%"l_temp_26%"></textarea>")
				-- line: 185 row: 8 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 186 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 187 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 187 row: 11 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 188 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_316)
				-- line: 189 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 189 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 194 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 190 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 193 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_321)
				-- line: 191 row: 7 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<button name=%"l_temp_27%" type=%"submit%">Preview</button>")
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_28 := unique_id
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<input type=%"hidden%" name=%""+l_temp_28+"%" value =%""+l_temp_28+"%" />")
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			if attached agent_table ["l_temp_6"] as l_agent_table then
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			l_agent_table [l_temp_28] := agent (a_request: XH_REQUEST) do
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			if fill_bean (a_request) then
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			controller_1.save (problem_report)
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 192 row: 1 of file: ./protected/problem_report_form.xeb
			end -- XTAG_F_BUTTON_TAG
				-- line: 192 row: 6 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 193 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 193 row: 5 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 194 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 194 row: 4 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 195 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_137)
				-- line: 195 row: 4 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			response.append("<input type=%"hidden%" name=%"l_temp_6%" value=%""+l_temp_6+"%" />")
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_44)
				-- line: 196 row: 3 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 197 row: 1 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 197 row: 2 of file: ./protected/problem_report_form.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 26 row: 4 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 27 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_49)
				-- line: 27 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 27 row: 3 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 28 row: 1 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 28 row: 2 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 42 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 43 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_47)
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			end
				-- line: 43 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_9"] and then render_conditions ["class_temp_9"] then
				-- line: 46 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 44 row: 8 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 31 row: 2 of file: ./support_side.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_86)
				-- line: 45 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 46 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_47)
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			end
				-- line: 46 row: 6 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 47 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 47 row: 6 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 55 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_87)
				-- line: 48 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 48 row: 105 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_88)
				-- line: 48 row: 101 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_89)
				-- line: 48 row: 105 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 49 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_90)
				-- line: 49 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_91)
				-- line: 50 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_92)
				-- line: 51 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_93)
				-- line: 50 row: 81 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_94)
				-- line: 51 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 51 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 54 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_95)
				-- line: 52 row: 8 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 53 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_96)
				-- line: 53 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 53 row: 7 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 54 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 54 row: 6 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 55 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 55 row: 5 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 56 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 56 row: 4 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 57 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 57 row: 4 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 62 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_97)
				-- line: 58 row: 5 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 59 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_98)
				-- line: 59 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 59 row: 5 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 60 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_99)
				-- line: 60 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 60 row: 5 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 61 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_100)
				-- line: 61 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 61 row: 4 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 62 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 62 row: 3 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 63 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 64 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_101)
				-- line: 68 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_102)
				-- line: 67 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_103)
				-- line: 68 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_104)
				-- line: 68 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 73 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_102)
				-- line: 72 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_105)
				-- line: 73 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_104)
				-- line: 73 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 74 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_106)
				-- line: 74 row: 2 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 75 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_107)
		end

	clean_up_after_render (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		do
				-- line: 23 row: 1 of file: ./support_master.xeb
				-- line: 23 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_0"] and then render_conditions ["class_temp_0"] then
				-- line: 23 row: 1 of file: ./support_master.xeb
				-- line: 23 row: 1 of file: ./support_master.xeb
			end
				-- line: 29 row: 1 of file: ./support_master.xeb
				-- line: 29 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_1"] and then render_conditions ["class_temp_1"] then
				-- line: 29 row: 1 of file: ./support_master.xeb
				-- line: 29 row: 1 of file: ./support_master.xeb
			end
				-- line: 34 row: 1 of file: ./support_master.xeb
				-- line: 34 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_2"] and then render_conditions ["class_temp_2"] then
				-- line: 34 row: 1 of file: ./support_master.xeb
				-- line: 34 row: 1 of file: ./support_master.xeb
			end
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_3"] and then render_conditions ["class_temp_3"] then
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 196 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			end
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_9"] and then render_conditions ["class_temp_9"] then
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			end
			if validation_errors.empty then
			create problem_report.make
			end
		end

	fill_bean (a_request: XH_REQUEST): BOOLEAN
			--<Precursor>
		local
			l_temp_0: BOOLEAN
			l_temp_1: XWA_VALIDATOR
			l_temp_2: BOOLEAN
			l_temp_3: XWA_VALIDATOR
			l_temp_4: BOOLEAN
			l_temp_5: XWA_VALIDATOR
			l_temp_6: BOOLEAN
			l_temp_7: XWA_VALIDATOR
			l_temp_8: BOOLEAN
			l_temp_9: XWA_VALIDATOR
			l_temp_10: BOOLEAN
			l_temp_11: XWA_VALIDATOR
			l_temp_12: BOOLEAN
			l_temp_13: XWA_VALIDATOR
			l_temp_14: BOOLEAN
			l_temp_15: XWA_VALIDATOR
			l_temp_16: BOOLEAN
			l_temp_17: XWA_VALIDATOR
			l_temp_18: BOOLEAN
			l_temp_19: XWA_VALIDATOR
		do
			Result := True
				-- no debug information
				-- line: 23 row: 1 of file: ./support_master.xeb
				-- line: 23 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_0"] and then render_conditions ["class_temp_0"] then
				-- line: 23 row: 1 of file: ./support_master.xeb
				-- line: 23 row: 1 of file: ./support_master.xeb
			end
				-- line: 29 row: 1 of file: ./support_master.xeb
				-- line: 29 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_1"] and then render_conditions ["class_temp_1"] then
				-- line: 29 row: 1 of file: ./support_master.xeb
				-- line: 29 row: 1 of file: ./support_master.xeb
			end
				-- line: 34 row: 1 of file: ./support_master.xeb
				-- line: 34 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_2"] and then render_conditions ["class_temp_2"] then
				-- line: 34 row: 1 of file: ./support_master.xeb
				-- line: 34 row: 1 of file: ./support_master.xeb
			end
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_3"] and then render_conditions ["class_temp_3"] then
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_7"] as argument then
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_0 := True
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_1.make
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			if not l_temp_1.validate (argument) then
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_0 := False
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			add_error ("category", l_temp_1.message)
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			Result := Result and l_temp_0
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_0 then
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			if attached {STRING} class_temp_4[argument] as dd_argument then problem_report.category := dd_argument end
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 25 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_10"] as argument then
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_2 := True
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_3.make
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			if not l_temp_3.validate (argument) then
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_2 := False
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			add_error ("severity", l_temp_3.message)
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			Result := Result and l_temp_2
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_2 then
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			if attached {STRING} class_temp_5[argument] as dd_argument then problem_report.severity := dd_argument end
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 36 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_13"] as argument then
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_4 := True
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_5.make
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			if not l_temp_5.validate (argument) then
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_4 := False
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			add_error ("class", l_temp_5.message)
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			Result := Result and l_temp_4
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_4 then
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			if attached {STRING} class_temp_6[argument] as dd_argument then problem_report.e_class := dd_argument end
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 49 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_16"] as argument then
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_6 := True
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_7.make
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			if not l_temp_7.validate (argument) then
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_6 := False
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			add_error ("priority", l_temp_7.message)
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			Result := Result and l_temp_6
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_6 then
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			if attached {STRING} class_temp_7[argument] as dd_argument then problem_report.priority := dd_argument end
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 60 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_19"] as argument then
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_8 := True
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_9.make
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			if not l_temp_9.validate (argument) then
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_8 := False
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			add_error ("release_input", l_temp_9.message)
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			Result := Result and l_temp_8
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_8 then
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			problem_report.release := argument
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 73 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_20"] as argument then
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_10 := True
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_11.make
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			if not l_temp_11.validate (argument) then
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_10 := False
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			add_error ("confidential", l_temp_11.message)
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			Result := Result and l_temp_10
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_10 then
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			if attached {STRING} class_temp_8[argument] as dd_argument then problem_report.confidential := dd_argument end
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 95 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_23"] as argument then
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_12 := True
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_13.make
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			if not l_temp_13.validate (argument) then
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_12 := False
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			add_error ("environment_text", l_temp_13.message)
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			Result := Result and l_temp_12
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_12 then
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			problem_report.environment_text := argument
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 115 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_24"] as argument then
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_14 := True
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_15.make
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			if not l_temp_15.validate (argument) then
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_14 := False
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			add_error ("synopsis_text", l_temp_15.message)
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			Result := Result and l_temp_14
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_14 then
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			problem_report.synopsis := argument
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 132 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_25"] as argument then
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_16 := True
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_17.make
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			if not l_temp_17.validate (argument) then
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_16 := False
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			add_error ("description_text", l_temp_17.message)
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			Result := Result and l_temp_16
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_16 then
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			problem_report.description_text := argument
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 166 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			if attached a_request.argument_table ["l_temp_26"] as argument then
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_18 := True
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_19.make
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			if not l_temp_19.validate (argument) then
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			l_temp_18 := False
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			add_error ("to_reproduce_text", l_temp_19.message)
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			Result := Result and l_temp_18
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			if l_temp_18 then
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			problem_report.to_reproduce_text := argument
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
				-- line: 187 row: 1 of file: ./protected/problem_report_form.xeb
			end
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			end
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_9"] and then render_conditions ["class_temp_9"] then
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"end
