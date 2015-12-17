note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_PROTECTED___RESPONSIBLES___DEFAULT_SERVLET

inherit
	XWA_SERVLET redefine make end

create
	make

feature-- Access

	controller_1: PROBLEM_REPORT_SEARCH_CONTROLLER

	controller_2: LOGIN_CONTROLLER

	internal_controllers: LIST [XWA_CONTROLLER]

	query: PROBLEM_REPORT_QUERY

	class_temp_4: HASH_TABLE [STRING , STRING]

	class_temp_5: HASH_TABLE [STRING , STRING]

	class_temp_6: HASH_TABLE [STRING , STRING]

	drop_down_temp: PROBLEM_REPORT_BEAN

	class_temp_7: HASH_TABLE [STRING , STRING]

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
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			create query.make
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			create class_temp_4.make (5)
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			create class_temp_5.make (5)
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			create class_temp_6.make (5)
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			create drop_down_temp.make
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			create class_temp_7.make (5)
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
			render_conditions ["class_temp_8"] := controller_2.is_not_logged_in
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
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			if attached a_request.argument_table ["l_temp_6"] as form_argument then
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			if attached agent_table ["l_temp_6"] as l_agent_table then
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			from
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			a_request.argument_table.start
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			until
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			a_request.argument_table.after
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			loop
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			if attached l_agent_table [a_request.argument_table.key_for_iteration] as l_agent and then not a_request.argument_table.item_for_iteration.is_empty then
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			l_agent.call ([a_request])
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			a_request.argument_table.forth
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			if attached a_request.argument_table ["l_temp_24"] as form_argument then
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			if attached agent_table ["l_temp_24"] as l_agent_table then
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			from
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			a_request.argument_table.start
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			until
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			a_request.argument_table.after
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			loop
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			if attached l_agent_table [a_request.argument_table.key_for_iteration] as l_agent and then not a_request.argument_table.item_for_iteration.is_empty then
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			l_agent.call ([a_request])
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			a_request.argument_table.forth
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			end
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_8"] and then render_conditions ["class_temp_8"] then
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
			l_temp_7: STRING
			l_temp_8: STRING
			l_temp_9: LIST [STRING]
			l_temp_10: STRING
			l_temp_11: STRING
			l_temp_12: STRING
			l_temp_13: STRING
			l_temp_14: LIST [STRING]
			l_temp_15: STRING
			l_temp_16: STRING
			l_temp_17: STRING
			l_temp_18: LIST [STRING]
			l_temp_19: STRING
			l_temp_21: STRING
			l_temp_22: NATURAL
			l_temp_23: LIST [PROBLEM_REPORT_BEAN]
			l_temp_24: STRING
			l_temp_25: STRING
			l_temp_26: LIST [STRING]
			l_temp_27: STRING
			l_temp_28: NATURAL
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
				-- line: 3 row: 3 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 8 row: 1 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_149)
				-- line: 4 row: 4 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 5 row: 1 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_79)
				-- line: 5 row: 1 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 5 row: 4 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 4 row: 4 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 218 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_147)
				-- line: 5 row: 5 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 9 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_80)
				-- line: 6 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 9 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_81)
				-- line: 8 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_150)
				-- line: 9 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_83)
				-- line: 9 row: 5 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 9 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 10 row: 5 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_151)
				-- line: 10 row: 51 of file: ./protected/responsibles/default.xeb
			response.append ("NoText")
				-- line: 11 row: 5 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_152)
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_6:= unique_id
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ("<form id=%"l_temp_6%" action=%"" +request.uri + "%" method=%"post%">")
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			agent_table ["l_temp_6"] := create {HASH_TABLE [PROCEDURE, STRING]}.make (5)
				-- line: 12 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 67 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_153)
				-- line: 13 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 66 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_154)
				-- line: 14 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 33 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 15 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 22 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_155)
				-- line: 16 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 19 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_156)
				-- line: 18 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_157)
				-- line: 19 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 19 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 21 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_158)
				-- line: 20 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 21 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 21 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 22 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 22 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 25 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_159)
				-- line: 23 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_7 := unique_id
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<input type=%"text%" value=%""+query.submitter+"%" size=%"15%" name=%"l_temp_7%" maxLength=%"101%"/>")
				-- line: 24 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 25 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 25 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 28 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_155)
				-- line: 27 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_160)
				-- line: 28 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 28 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 32 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_159)
				-- line: 29 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_8 := unique_id
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<select name=%"l_temp_8%">")
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			from
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_9 := controller_1.categories
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_9.start
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			until
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_9.after
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			loop
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_10 := unique_id
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_9.item.is_equal ("1") then
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<option selected=%"true%" value=%""+l_temp_10+"%">" + l_temp_9.item.out + "</option>")
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<option value=%""+l_temp_10+"%">" + l_temp_9.item.out + "</option>")
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			class_temp_4[l_temp_10] := l_temp_9.item
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_9.forth
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("</select>")
				-- line: 30 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_11 := unique_id
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<label for=%"l_temp_11%">Open</label>")
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<input type=%"checkbox%"name=%"a_name%"/>")
				-- line: 31 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 32 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 32 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 33 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 33 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 49 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 34 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 38 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_155)
				-- line: 35 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 36 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_34)
				-- line: 35 row: 33 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_161)
				-- line: 36 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 36 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 37 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_158)
				-- line: 37 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 37 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 38 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 38 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 41 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_159)
				-- line: 39 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_12 := unique_id
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<input type=%"text%" value=%""+query.responsible+"%" size=%"20%" name=%"l_temp_12%" maxLength=%"101%"/>")
				-- line: 40 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 41 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 41 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 45 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_155)
				-- line: 43 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_162)
				-- line: 44 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_163)
				-- line: 44 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 44 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 45 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 45 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 48 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_159)
				-- line: 46 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_13 := unique_id
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<select name=%"l_temp_13%">")
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			from
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_14 := controller_1.severities
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_14.start
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			until
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_14.after
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			loop
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_15 := unique_id
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_14.item.is_equal ("1") then
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<option selected=%"true%" value=%""+l_temp_15+"%">" + l_temp_14.item.out + "</option>")
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<option value=%""+l_temp_15+"%">" + l_temp_14.item.out + "</option>")
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			class_temp_5[l_temp_15] := l_temp_14.item
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_14.forth
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("</select>")
				-- line: 47 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 48 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 48 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 49 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 49 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 65 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 50 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 53 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_155)
				-- line: 52 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_164)
				-- line: 53 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 53 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 57 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_159)
				-- line: 54 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_16 := unique_id
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<input type=%"text%" value=%""+query.page_size+"%" size=%"3%" name=%"l_temp_16%" maxLength=%"3%"/>")
				-- line: 55 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 56 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_165)
				-- line: 55 row: 71 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_166)
				-- line: 56 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 56 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 57 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 57 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 61 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_155)
				-- line: 59 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_167)
				-- line: 60 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_163)
				-- line: 60 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 60 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 61 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 61 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 64 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_159)
				-- line: 62 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_17 := unique_id
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<select name=%"l_temp_17%">")
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			from
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_18 := controller_1.priorities
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_18.start
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			until
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_18.after
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			loop
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_19 := unique_id
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_18.item.is_equal ("1") then
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<option selected=%"true%" value=%""+l_temp_19+"%">" + l_temp_18.item.out + "</option>")
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<option value=%""+l_temp_19+"%">" + l_temp_18.item.out + "</option>")
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			class_temp_6[l_temp_19] := l_temp_18.item
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_18.forth
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("</select>")
				-- line: 63 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 64 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 64 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 65 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 65 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 66 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_168)
				-- line: 66 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 67 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_137)
				-- line: 67 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<button name=%"l_temp_20%" type=%"submit%">Search</button>")
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_21 := unique_id
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<input type=%"hidden%" name=%""+l_temp_21+"%" value =%""+l_temp_21+"%" />")
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			if attached agent_table ["l_temp_6"] as l_agent_table then
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			l_agent_table [l_temp_21] := agent (a_request: XH_REQUEST) do
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			if fill_bean (a_request) then
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			controller_1.search (query)
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 68 row: 1 of file: ./protected/responsibles/default.xeb
			end -- XTAG_F_BUTTON_TAG
				-- line: 68 row: 5 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<input type=%"hidden%" name=%"l_temp_6%" value=%""+l_temp_6+"%" />")
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_44)
				-- line: 69 row: 5 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 217 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_169)
				-- line: 70 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 72 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_170)
				-- line: 71 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 72 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 72 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 101 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_171)
				-- line: 73 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 79 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_172)
				-- line: 74 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 78 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_156)
				-- line: 75 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 76 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 76 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} controller_1.overall_count.out as l_text then 
				-- line: 76 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (l_text)
				-- line: 76 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 76 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 76 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (controller_1.overall_count.out.out)
				-- line: 76 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 76 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 77 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_173)
				-- line: 78 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 78 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 79 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 79 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 100 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_174)
				-- line: 80 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 99 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_175)
				-- line: 81 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 98 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 82 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 86 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_176)
				-- line: 83 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 84 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_177)
				-- line: 84 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 84 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 85 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_179)
				-- line: 85 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 85 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 86 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 86 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 93 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_180)
				-- line: 87 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 92 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_181)
				-- line: 88 row: 12 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_182)
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
			from
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_22 := 1
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
			until
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_22 > 10
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
			loop
				-- line: 89 row: 12 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_182)
				-- line: 90 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_183)
				-- line: 89 row: 39 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_184)
				-- line: 90 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 90 row: 12 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_182)
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_22 := l_temp_22 + 1
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 91 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 91 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 92 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 92 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 93 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 93 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 97 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_185)
				-- line: 94 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 95 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_186)
				-- line: 95 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 95 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 96 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_187)
				-- line: 96 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 96 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 97 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 97 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 98 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 98 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 99 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_137)
				-- line: 99 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 100 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 100 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 101 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 101 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 185 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_188)
				-- line: 102 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 135 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 103 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 106 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_189)
				-- line: 105 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_190)
				-- line: 106 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_191)
				-- line: 106 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 109 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_192)
				-- line: 107 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 108 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_193)
				-- line: 108 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 108 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 109 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_191)
				-- line: 109 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 112 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_192)
				-- line: 110 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 111 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_193)
				-- line: 111 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 111 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 112 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_191)
				-- line: 112 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 115 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_192)
				-- line: 113 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 114 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_193)
				-- line: 114 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 114 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 115 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_191)
				-- line: 115 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 118 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_194)
				-- line: 117 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_195)
				-- line: 118 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_191)
				-- line: 118 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 121 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_196)
				-- line: 120 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_197)
				-- line: 121 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_191)
				-- line: 121 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 124 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_198)
				-- line: 123 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_199)
				-- line: 124 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_191)
				-- line: 124 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 127 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_200)
				-- line: 126 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_201)
				-- line: 127 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_191)
				-- line: 127 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 130 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_202)
				-- line: 129 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_203)
				-- line: 130 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_191)
				-- line: 130 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 134 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_204)
				-- line: 132 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_205)
				-- line: 133 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_206)
				-- line: 133 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 133 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 134 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_191)
				-- line: 134 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 135 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 135 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_23 := controller_1.problem_reports
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			from --l_temp_23
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_23.start
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			until
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_23.after
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			loop
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {PROBLEM_REPORT_BEAN} l_temp_23.item as problem_report then
				-- line: 136 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_207)
				-- line: 183 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_154)
				-- line: 137 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 182 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 138 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 141 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 139 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 140 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_34)
				-- line: 139 row: 69 of file: ./protected/responsibles/default.xeb
				-- line: 139 row: 69 of file: ./protected/responsibles/default.xeb
			if attached {STRING} problem_report.number as l_text then 
				-- line: 139 row: 69 of file: ./protected/responsibles/default.xeb
			response.append (l_text)
				-- line: 139 row: 69 of file: ./protected/responsibles/default.xeb
				-- line: 139 row: 69 of file: ./protected/responsibles/default.xeb
			else
				-- line: 139 row: 69 of file: ./protected/responsibles/default.xeb
			response.append (problem_report.number.out)
				-- line: 139 row: 69 of file: ./protected/responsibles/default.xeb
				-- line: 139 row: 69 of file: ./protected/responsibles/default.xeb
			end
				-- line: 140 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 140 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 141 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 141 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 147 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 142 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 146 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_208)
				-- line: 143 row: 12 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_182)
				-- line: 144 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ("<div class=%""+problem_report.status+"%">")
				-- line: 144 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 145 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_209)
				-- line: 146 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 146 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 147 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 147 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 153 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 148 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 152 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_208)
				-- line: 149 row: 12 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_182)
				-- line: 150 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ("<div class=%""+problem_report.priority+"%">")
				-- line: 150 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 151 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_210)
				-- line: 152 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 152 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 153 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 153 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 159 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 154 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 158 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_208)
				-- line: 155 row: 12 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_182)
				-- line: 156 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ("<div class=%""+problem_report.severity+"%">")
				-- line: 156 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 157 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_211)
				-- line: 158 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 158 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 159 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 159 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 162 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 160 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 161 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 161 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} problem_report.synopsis as l_text then 
				-- line: 161 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (l_text)
				-- line: 161 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 161 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 161 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (problem_report.synopsis.out)
				-- line: 161 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 161 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 161 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 162 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 162 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 167 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 163 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 166 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_212)
				-- line: 164 row: 12 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_182)
				-- line: 165 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 165 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} problem_report.submitter as l_text then 
				-- line: 165 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (l_text)
				-- line: 165 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 165 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 165 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (problem_report.submitter.out)
				-- line: 165 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 165 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 165 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 166 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 166 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 167 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 167 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 172 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 168 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_24:= unique_id
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ("<form id=%"l_temp_24%" action=%"" +request.uri + "%" method=%"post%">")
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			agent_table ["l_temp_24"] := create {HASH_TABLE [PROCEDURE, STRING]}.make (3)
				-- line: 169 row: 12 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_182)
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_25 := unique_id
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<select name=%"l_temp_25%">")
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			from
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_26 := controller_1.all_responsibles
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_26.start
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			until
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_26.after
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			loop
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_27 := unique_id
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_26.item.is_equal ("1") then
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<option selected=%"true%" value=%""+l_temp_27+"%">" + l_temp_26.item.out + "</option>")
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<option value=%""+l_temp_27+"%">" + l_temp_26.item.out + "</option>")
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			class_temp_7[l_temp_27] := l_temp_26.item
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_26.forth
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("</select>")
				-- line: 170 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			response.append("<input type=%"hidden%" name=%"l_temp_24%" value=%""+l_temp_24+"%" />")
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_44)
				-- line: 171 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 172 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 172 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 175 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 173 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 174 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 174 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} problem_report.category as l_text then 
				-- line: 174 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (l_text)
				-- line: 174 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 174 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 174 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (problem_report.category.out)
				-- line: 174 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 174 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 174 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 175 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 175 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 178 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 176 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 177 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 177 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} problem_report.release as l_text then 
				-- line: 177 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (l_text)
				-- line: 177 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 177 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 177 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (problem_report.release.out)
				-- line: 177 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 177 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 177 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 178 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 178 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 181 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 179 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 180 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 180 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} problem_report.date as l_text then 
				-- line: 180 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (l_text)
				-- line: 180 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 180 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 180 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (problem_report.date.out)
				-- line: 180 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 180 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 180 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 181 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 181 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 182 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 182 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 183 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_168)
				-- line: 183 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_23.forth
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			end -- if attached problem_report
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 184 row: 1 of file: ./protected/responsibles/default.xeb
			end -- from l_temp_23
				-- line: 184 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 185 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_137)
				-- line: 185 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 214 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_213)
				-- line: 186 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 192 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_214)
				-- line: 187 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 191 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_156)
				-- line: 188 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 189 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 189 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} controller_1.overall_count.out as l_text then 
				-- line: 189 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (l_text)
				-- line: 189 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 189 row: 1 of file: ./protected/responsibles/default.xeb
			else
				-- line: 189 row: 1 of file: ./protected/responsibles/default.xeb
			response.append (controller_1.overall_count.out.out)
				-- line: 189 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 189 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 190 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_173)
				-- line: 191 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 191 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 192 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 192 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 213 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_174)
				-- line: 193 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 212 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_175)
				-- line: 194 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 211 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 195 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 199 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_176)
				-- line: 196 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 197 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_177)
				-- line: 197 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 197 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 198 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_179)
				-- line: 198 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 198 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 199 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 199 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 206 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_180)
				-- line: 200 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 205 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_181)
				-- line: 201 row: 12 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_182)
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
			from
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_28 := 1
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
			until
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_28 > 10
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
			loop
				-- line: 202 row: 13 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_215)
				-- line: 203 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_183)
				-- line: 202 row: 40 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_184)
				-- line: 203 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 203 row: 12 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_182)
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_28 := l_temp_28 + 1
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 204 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 204 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 205 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 205 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 206 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 206 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 210 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_185)
				-- line: 207 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 208 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_186)
				-- line: 208 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 208 row: 11 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 209 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_216)
				-- line: 209 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_178)
				-- line: 209 row: 10 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 210 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 210 row: 9 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 211 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 211 row: 8 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 212 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_137)
				-- line: 212 row: 7 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 213 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 213 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 214 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 214 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 216 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_217)
				-- line: 215 row: 6 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 216 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 216 row: 5 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 217 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 217 row: 4 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 218 row: 1 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 218 row: 3 of file: ./protected/responsibles/default.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 6 row: 4 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 7 row: 1 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_49)
				-- line: 7 row: 1 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 7 row: 3 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 8 row: 1 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 8 row: 2 of file: ./support_plain.xeb
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
			if attached render_conditions ["class_temp_8"] and then render_conditions ["class_temp_8"] then
				-- line: 46 row: 1 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 44 row: 8 of file: ./support_master.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 11 row: 2 of file: ./support_plain.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_218)
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
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 69 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 171 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			end
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_8"] and then render_conditions ["class_temp_8"] then
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			end
			if validation_errors.empty then
			create query.make
			end
			if validation_errors.empty then
			create drop_down_temp.make
			end
		end

	fill_bean (a_request: XH_REQUEST): BOOLEAN
			--<Precursor>
		local
			l_temp_0: BOOLEAN
			l_temp_1: BOOLEAN
			l_temp_2: BOOLEAN
			l_temp_3: BOOLEAN
			l_temp_4: BOOLEAN
			l_temp_5: BOOLEAN
			l_temp_6: BOOLEAN
			l_temp_7: BOOLEAN
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
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
			if attached a_request.argument_table ["l_temp_7"] as argument then
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_0 := True
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
			Result := Result and l_temp_0
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_0 then
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
			query.submitter := argument
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 24 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			if attached a_request.argument_table ["l_temp_8"] as argument then
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_1 := True
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			Result := Result and l_temp_1
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_1 then
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} class_temp_4[argument] as dd_argument then query.category := dd_argument end
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 30 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			if attached a_request.argument_table ["l_temp_11"] as argument then
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_2 := True
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			Result := Result and l_temp_2
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_2 then
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			query.open := argument.as_lower.is_equal ("checked")
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 31 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
			if attached a_request.argument_table ["l_temp_12"] as argument then
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_3 := True
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
			Result := Result and l_temp_3
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_3 then
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
			query.responsible := argument
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 40 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			if attached a_request.argument_table ["l_temp_13"] as argument then
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_4 := True
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			Result := Result and l_temp_4
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_4 then
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} class_temp_5[argument] as dd_argument then query.severity := dd_argument end
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 47 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
			if attached a_request.argument_table ["l_temp_16"] as argument then
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_5 := True
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
			Result := Result and l_temp_5
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_5 then
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
			query.page_size := argument
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 55 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			if attached a_request.argument_table ["l_temp_17"] as argument then
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_6 := True
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			Result := Result and l_temp_6
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_6 then
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} class_temp_6[argument] as dd_argument then query.priority := dd_argument end
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 63 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			if attached a_request.argument_table ["l_temp_25"] as argument then
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			l_temp_7 := True
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			Result := Result and l_temp_7
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			if l_temp_7 then
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			if attached {STRING} class_temp_7[argument] as dd_argument then drop_down_temp.responsible := dd_argument end
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
				-- line: 170 row: 1 of file: ./protected/responsibles/default.xeb
			end
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			end
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_8"] and then render_conditions ["class_temp_8"] then
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
