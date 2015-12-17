note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_RESERVATIONS_SERVLET

inherit
	XWA_SERVLET redefine make end

create
	make

feature-- Access

	controller_1: RESERVATION_CONTROLLER

	controller_2: LOGIN_CONTROLLER

	internal_controllers: LIST [XWA_CONTROLLER]

	b: LOGIN_BEAN

	new_reservation: RESERVATION

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
			create controller_1.default_create
				-- no debug information
				-- no debug information
			internal_controllers.extend (controller_1)
				-- no debug information
				-- no debug information
			create controller_2.default_create
				-- no debug information
				-- no debug information
			internal_controllers.extend (controller_2)
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			create b.make
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			create new_reservation.make
		end

	set_all_booleans (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		do
				-- line: 19 row: 19 of file: ./master_template.xeb
				-- line: 19 row: 19 of file: ./master_template.xeb
			render_conditions ["class_temp_0"] := controller_2.authenticated
				-- line: 24 row: 1 of file: ./master_template.xeb
				-- line: 24 row: 1 of file: ./master_template.xeb
			render_conditions ["class_temp_1"] := controller_2.not_authenticated
				-- line: 8 row: 1 of file: ./reservations.xeb
				-- line: 8 row: 1 of file: ./reservations.xeb
			render_conditions ["class_temp_2"] := controller_1.not_authenticated
				-- line: 43 row: 1 of file: ./reservations.xeb
				-- line: 43 row: 1 of file: ./reservations.xeb
			render_conditions ["class_temp_3"] := controller_1.authenticated
				-- line: 18 row: 1 of file: ./reservations.xeb
				-- line: 18 row: 1 of file: ./reservations.xeb
			render_conditions ["class_temp_4"] := controller_1.authenticated_admin
				-- line: 21 row: 1 of file: ./reservations.xeb
				-- line: 21 row: 1 of file: ./reservations.xeb
			render_conditions ["class_temp_5"] := controller_1.not_authenticated_admin
				-- line: 34 row: 1 of file: ./reservations.xeb
				-- line: 34 row: 1 of file: ./reservations.xeb
			render_conditions ["class_temp_6"] := controller_1.authenticated_admin
				-- line: 37 row: 1 of file: ./reservations.xeb
				-- line: 37 row: 1 of file: ./reservations.xeb
			render_conditions ["class_temp_7"] := controller_1.not_authenticated_admin
				-- line: 103 row: 1 of file: ./reservations.xeb
				-- line: 103 row: 1 of file: ./reservations.xeb
			render_conditions ["class_temp_8"] := controller_1.authenticated_admin
		end

	handle_form_internal (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			--<Precursor>
		do
				-- line: 19 row: 19 of file: ./master_template.xeb
				-- line: 19 row: 19 of file: ./master_template.xeb
			if attached render_conditions ["class_temp_0"] and then render_conditions ["class_temp_0"] then
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			if attached a_request.argument_table ["l_temp_0"] as form_argument then
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			from
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			a_request.argument_table.start
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			until
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			a_request.argument_table.after
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			loop
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			if attached l_agent_table [a_request.argument_table.key_for_iteration] as l_agent and then not a_request.argument_table.item_for_iteration.is_empty then
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			l_agent.call ([a_request])
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			end
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			a_request.argument_table.forth
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			end
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			end
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			end
				-- line: 19 row: 19 of file: ./master_template.xeb
				-- line: 19 row: 19 of file: ./master_template.xeb
			end
				-- line: 24 row: 1 of file: ./master_template.xeb
				-- line: 24 row: 1 of file: ./master_template.xeb
			if attached render_conditions ["class_temp_1"] and then render_conditions ["class_temp_1"] then
				-- line: 24 row: 1 of file: ./master_template.xeb
				-- line: 24 row: 1 of file: ./master_template.xeb
			end
				-- line: 8 row: 1 of file: ./reservations.xeb
				-- line: 8 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_2"] and then render_conditions ["class_temp_2"] then
				-- line: 8 row: 1 of file: ./reservations.xeb
				-- line: 8 row: 1 of file: ./reservations.xeb
			end
				-- line: 43 row: 1 of file: ./reservations.xeb
				-- line: 43 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_3"] and then render_conditions ["class_temp_3"] then
				-- line: 18 row: 1 of file: ./reservations.xeb
				-- line: 18 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_4"] and then render_conditions ["class_temp_4"] then
				-- line: 18 row: 1 of file: ./reservations.xeb
				-- line: 18 row: 1 of file: ./reservations.xeb
			end
				-- line: 21 row: 1 of file: ./reservations.xeb
				-- line: 21 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_5"] and then render_conditions ["class_temp_5"] then
				-- line: 21 row: 1 of file: ./reservations.xeb
				-- line: 21 row: 1 of file: ./reservations.xeb
			end
				-- line: 34 row: 1 of file: ./reservations.xeb
				-- line: 34 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_6"] and then render_conditions ["class_temp_6"] then
				-- line: 34 row: 1 of file: ./reservations.xeb
				-- line: 34 row: 1 of file: ./reservations.xeb
			end
				-- line: 37 row: 1 of file: ./reservations.xeb
				-- line: 37 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_7"] and then render_conditions ["class_temp_7"] then
				-- line: 37 row: 1 of file: ./reservations.xeb
				-- line: 37 row: 1 of file: ./reservations.xeb
			end
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			if attached a_request.argument_table ["l_temp_3"] as form_argument then
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			if attached agent_table ["l_temp_3"] as l_agent_table then
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			from
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			a_request.argument_table.start
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			until
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			a_request.argument_table.after
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			loop
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			if attached l_agent_table [a_request.argument_table.key_for_iteration] as l_agent and then not a_request.argument_table.item_for_iteration.is_empty then
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			l_agent.call ([a_request])
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			end
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			a_request.argument_table.forth
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			end
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			end
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			end
				-- line: 43 row: 1 of file: ./reservations.xeb
				-- line: 43 row: 1 of file: ./reservations.xeb
			end
				-- line: 103 row: 1 of file: ./reservations.xeb
				-- line: 103 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_8"] and then render_conditions ["class_temp_8"] then
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			if attached a_request.argument_table ["l_temp_7"] as form_argument then
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			if attached agent_table ["l_temp_7"] as l_agent_table then
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			from
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			a_request.argument_table.start
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			until
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			a_request.argument_table.after
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			loop
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			if attached l_agent_table [a_request.argument_table.key_for_iteration] as l_agent and then not a_request.argument_table.item_for_iteration.is_empty then
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			l_agent.call ([a_request])
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			end
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			a_request.argument_table.forth
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			end
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			end
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			end
				-- line: 103 row: 1 of file: ./reservations.xeb
				-- line: 103 row: 1 of file: ./reservations.xeb
			end
		end

	render_html_page (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		local
			l_temp_0: STRING
			l_temp_2: STRING
			l_temp_3: STRING
			l_temp_4: LIST [RESERVATION]
			l_temp_6: STRING
			l_temp_7: STRING
			l_temp_8: STRING
			name_errors: STRING
			l_temp_9: STRING
			date_errors: STRING
			l_temp_11: STRING
			persons_errors: STRING
			l_temp_12: STRING
			description_errors: STRING
			l_temp_14: STRING
		do
				-- line: 2 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_0)
				-- line: 45 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 3 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 10 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_3)
				-- line: 4 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 5 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 6 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 6 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_5)
				-- line: 6 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 7 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 6 row: 31 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_7)
				-- line: 7 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_8)
				-- line: 7 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 8 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_9)
				-- line: 8 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_10)
				-- line: 8 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 8 row: 104 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_11)
				-- line: 8 row: 104 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 9 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_13)
				-- line: 9 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 9 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 10 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_14)
				-- line: 10 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 44 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 11 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 43 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 12 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 27 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 13 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 26 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 14 row: 3 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 19 row: 19 of file: ./master_template.xeb
				-- line: 19 row: 19 of file: ./master_template.xeb
			if attached render_conditions ["class_temp_0"] and then render_conditions ["class_temp_0"] then
				-- line: 15 row: 13 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_20)
				-- line: 16 row: 1 of file: ./master_template.xeb
				-- line: 16 row: 1 of file: ./master_template.xeb
			if attached {STRING} controller_2.username as l_text then 
				-- line: 16 row: 1 of file: ./master_template.xeb
			response.append (l_text)
				-- line: 16 row: 1 of file: ./master_template.xeb
				-- line: 16 row: 1 of file: ./master_template.xeb
			else
				-- line: 16 row: 1 of file: ./master_template.xeb
			response.append (controller_2.username.out)
				-- line: 16 row: 1 of file: ./master_template.xeb
				-- line: 16 row: 1 of file: ./master_template.xeb
			end
				-- line: 16 row: 14 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			l_temp_0:= unique_id
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			response.append ("<form id=%"l_temp_0%" action=%"" +request.uri + "%" method=%"post%">")
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			agent_table ["l_temp_0"] := create {HASH_TABLE [PROCEDURE, STRING]}.make (3)
				-- line: 17 row: 5 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 18 row: 1 of file: ./master_template.xeb
				-- line: 18 row: 1 of file: ./master_template.xeb
				-- line: 18 row: 1 of file: ./master_template.xeb
			l_temp_2 := unique_id
				-- line: 18 row: 1 of file: ./master_template.xeb
				-- line: 18 row: 1 of file: ./master_template.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_0']['" + l_temp_2+ "'].value='" + l_temp_2+ "'; document.forms['l_temp_0'].submit(); return false;%">Logout</a><input type=%"hidden%" name =%"" + l_temp_2+ "%" />")
				-- line: 18 row: 1 of file: ./master_template.xeb
				-- line: 18 row: 1 of file: ./master_template.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 18 row: 1 of file: ./master_template.xeb
				-- line: 18 row: 1 of file: ./master_template.xeb
			l_agent_table [l_temp_2] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 18 row: 1 of file: ./master_template.xeb
				-- line: 18 row: 1 of file: ./master_template.xeb
			controller_2.logout (a_object)
				-- line: 18 row: 1 of file: ./master_template.xeb
				-- line: 18 row: 1 of file: ./master_template.xeb
			end (?, b) -- COMMAND_LINK_TAG
				-- line: 18 row: 1 of file: ./master_template.xeb
				-- line: 18 row: 1 of file: ./master_template.xeb
			end
				-- line: 18 row: 4 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
			response.append("<input type=%"hidden%" name=%"l_temp_0%" value=%""+l_temp_0+"%" />")
				-- line: 19 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 19 row: 3 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 19 row: 19 of file: ./master_template.xeb
				-- line: 19 row: 19 of file: ./master_template.xeb
			end
				-- line: 21 row: 3 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_25)
				-- line: 24 row: 1 of file: ./master_template.xeb
				-- line: 24 row: 1 of file: ./master_template.xeb
			if attached render_conditions ["class_temp_1"] and then render_conditions ["class_temp_1"] then
				-- line: 22 row: 5 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 23 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 22 row: 30 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_28)
				-- line: 23 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 23 row: 3 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 24 row: 1 of file: ./master_template.xeb
				-- line: 24 row: 1 of file: ./master_template.xeb
			end
				-- line: 25 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_30)
				-- line: 26 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 26 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 27 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 27 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 28 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_32)
				-- line: 28 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 28 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 37 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 29 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 30 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_34)
				-- line: 29 row: 16 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 30 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_36)
				-- line: 30 row: 3 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 36 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_37)
				-- line: 31 row: 10 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_38)
				-- line: 32 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_39)
				-- line: 31 row: 42 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_40)
				-- line: 31 row: 38 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 31 row: 42 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 32 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 32 row: 10 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_38)
				-- line: 33 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_39)
				-- line: 32 row: 57 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 32 row: 53 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_44)
				-- line: 32 row: 57 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 33 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 33 row: 3 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 34 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_39)
				-- line: 33 row: 38 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_45)
				-- line: 33 row: 34 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_46)
				-- line: 33 row: 38 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 34 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 34 row: 10 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_38)
				-- line: 35 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_39)
				-- line: 34 row: 47 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_47)
				-- line: 34 row: 43 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 34 row: 47 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 35 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 35 row: 7 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_49)
				-- line: 36 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_50)
				-- line: 36 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 37 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 37 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 38 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_51)
				-- line: 38 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 38 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 41 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_52)
				-- line: 39 row: 3 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 4 row: 4 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 5 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_53)
				-- line: 4 row: 35 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_44)
				-- line: 5 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_36)
				-- line: 5 row: 4 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 8 row: 1 of file: ./reservations.xeb
				-- line: 8 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_2"] and then render_conditions ["class_temp_2"] then
				-- line: 6 row: 5 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 7 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_54)
				-- line: 6 row: 42 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_55)
				-- line: 7 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_56)
				-- line: 7 row: 4 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 8 row: 1 of file: ./reservations.xeb
				-- line: 8 row: 1 of file: ./reservations.xeb
			end
				-- line: 8 row: 4 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 43 row: 1 of file: ./reservations.xeb
				-- line: 43 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_3"] and then render_conditions ["class_temp_3"] then
				-- line: 9 row: 5 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			l_temp_3:= unique_id
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			response.append ("<form id=%"l_temp_3%" action=%"" +request.uri + "%" method=%"post%">")
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			agent_table ["l_temp_3"] := create {HASH_TABLE [PROCEDURE, STRING]}.make (3)
				-- line: 10 row: 5 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 41 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_57)
				-- line: 11 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 22 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 12 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 13 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 12 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_62)
				-- line: 13 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 13 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 14 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 13 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_64)
				-- line: 14 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 14 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 15 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 14 row: 18 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_65)
				-- line: 15 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 15 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 18 row: 1 of file: ./reservations.xeb
				-- line: 18 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_4"] and then render_conditions ["class_temp_4"] then
				-- line: 16 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 17 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 16 row: 18 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_67)
				-- line: 17 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 17 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 18 row: 1 of file: ./reservations.xeb
				-- line: 18 row: 1 of file: ./reservations.xeb
			end
				-- line: 18 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 21 row: 1 of file: ./reservations.xeb
				-- line: 21 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_5"] and then render_conditions ["class_temp_5"] then
				-- line: 19 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 20 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 19 row: 19 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_68)
				-- line: 20 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 20 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 21 row: 1 of file: ./reservations.xeb
				-- line: 21 row: 1 of file: ./reservations.xeb
			end
				-- line: 21 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 22 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 23 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_70)
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
			l_temp_4 := controller_1.global_state.db.reservations
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
			from --l_temp_4
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
			l_temp_4.start
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
			until
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
			l_temp_4.after
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
			loop
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
			if attached {RESERVATION} l_temp_4.item as reservation then
				-- line: 25 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 38 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_71)
				-- line: 26 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 27 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 26 row: 53 of file: ./reservations.xeb
				-- line: 26 row: 53 of file: ./reservations.xeb
			if attached {STRING} reservation.name as l_text then 
				-- line: 26 row: 53 of file: ./reservations.xeb
			response.append (l_text)
				-- line: 26 row: 53 of file: ./reservations.xeb
				-- line: 26 row: 53 of file: ./reservations.xeb
			else
				-- line: 26 row: 53 of file: ./reservations.xeb
			response.append (reservation.name.out)
				-- line: 26 row: 53 of file: ./reservations.xeb
				-- line: 26 row: 53 of file: ./reservations.xeb
			end
				-- line: 27 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 27 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 28 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 27 row: 57 of file: ./reservations.xeb
				-- line: 27 row: 57 of file: ./reservations.xeb
			if attached {STRING} reservation.date.out as l_text then 
				-- line: 27 row: 57 of file: ./reservations.xeb
			response.append (l_text)
				-- line: 27 row: 57 of file: ./reservations.xeb
				-- line: 27 row: 57 of file: ./reservations.xeb
			else
				-- line: 27 row: 57 of file: ./reservations.xeb
			response.append (reservation.date.out.out)
				-- line: 27 row: 57 of file: ./reservations.xeb
				-- line: 27 row: 57 of file: ./reservations.xeb
			end
				-- line: 28 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 28 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 29 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 28 row: 58 of file: ./reservations.xeb
				-- line: 28 row: 58 of file: ./reservations.xeb
			if attached {STRING} reservation.s_persons as l_text then 
				-- line: 28 row: 58 of file: ./reservations.xeb
			response.append (l_text)
				-- line: 28 row: 58 of file: ./reservations.xeb
				-- line: 28 row: 58 of file: ./reservations.xeb
			else
				-- line: 28 row: 58 of file: ./reservations.xeb
			response.append (reservation.s_persons.out)
				-- line: 28 row: 58 of file: ./reservations.xeb
				-- line: 28 row: 58 of file: ./reservations.xeb
			end
				-- line: 29 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 29 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 34 row: 1 of file: ./reservations.xeb
				-- line: 34 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_6"] and then render_conditions ["class_temp_6"] then
				-- line: 30 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 32 row: 14 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_73)
				-- line: 31 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 32 row: 1 of file: ./reservations.xeb
				-- line: 32 row: 1 of file: ./reservations.xeb
				-- line: 32 row: 1 of file: ./reservations.xeb
			l_temp_6 := unique_id
				-- line: 32 row: 1 of file: ./reservations.xeb
				-- line: 32 row: 1 of file: ./reservations.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_3']['" + l_temp_6+ "'].value='" + l_temp_6+ "'; document.forms['l_temp_3'].submit(); return false;%">Delete</a><input type=%"hidden%" name =%"" + l_temp_6+ "%" />")
				-- line: 32 row: 1 of file: ./reservations.xeb
				-- line: 32 row: 1 of file: ./reservations.xeb
			if attached agent_table ["l_temp_3"] as l_agent_table then
				-- line: 32 row: 1 of file: ./reservations.xeb
				-- line: 32 row: 1 of file: ./reservations.xeb
			l_agent_table [l_temp_6] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 32 row: 1 of file: ./reservations.xeb
				-- line: 32 row: 1 of file: ./reservations.xeb
			controller_1.delete (a_object)
				-- line: 32 row: 1 of file: ./reservations.xeb
				-- line: 32 row: 1 of file: ./reservations.xeb
			end (?, reservation) -- COMMAND_LINK_TAG
				-- line: 32 row: 1 of file: ./reservations.xeb
				-- line: 32 row: 1 of file: ./reservations.xeb
			end
				-- line: 32 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 32 row: 14 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 33 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_74)
				-- line: 34 row: 1 of file: ./reservations.xeb
				-- line: 34 row: 1 of file: ./reservations.xeb
			end
				-- line: 34 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 37 row: 1 of file: ./reservations.xeb
				-- line: 37 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_7"] and then render_conditions ["class_temp_7"] then
				-- line: 35 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 36 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_73)
				-- line: 35 row: 50 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_75)
				-- line: 35 row: 46 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_68)
				-- line: 35 row: 50 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 36 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 36 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 37 row: 1 of file: ./reservations.xeb
				-- line: 37 row: 1 of file: ./reservations.xeb
			end
				-- line: 37 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 38 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 38 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
			l_temp_4.forth
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
			end -- if attached reservation
				-- line: 39 row: 1 of file: ./reservations.xeb
				-- line: 39 row: 1 of file: ./reservations.xeb
			end -- from l_temp_4
				-- line: 40 row: 5 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_76)
				-- line: 41 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_77)
				-- line: 41 row: 5 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 42 row: 1 of file: ./reservations.xeb
				-- line: 42 row: 1 of file: ./reservations.xeb
			response.append("<input type=%"hidden%" name=%"l_temp_3%" value=%""+l_temp_3+"%" />")
				-- line: 42 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 42 row: 4 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 43 row: 1 of file: ./reservations.xeb
				-- line: 43 row: 1 of file: ./reservations.xeb
			end
				-- line: 43 row: 4 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 103 row: 1 of file: ./reservations.xeb
				-- line: 103 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_8"] and then render_conditions ["class_temp_8"] then
				-- line: 44 row: 5 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 45 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_53)
				-- line: 44 row: 39 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_78)
				-- line: 45 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_36)
				-- line: 45 row: 5 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			l_temp_7:= unique_id
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			response.append ("<form id=%"l_temp_7%" action=%"" +request.uri + "%" method=%"post%">")
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			agent_table ["l_temp_7"] := create {HASH_TABLE [PROCEDURE, STRING]}.make (3)
				-- line: 46 row: 5 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 101 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_79)
				-- line: 47 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 59 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_71)
				-- line: 48 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 49 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 48 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_62)
				-- line: 49 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 49 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 58 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 50 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			l_temp_8 := unique_id
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			response.append("<input type=%"text%" value=%""+controller_1.logged_in_name+"%" size=%"20%" name=%"l_temp_8%" />")
				-- line: 51 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 52 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 53 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 54 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
			if attached {LIST [STRING]} validation_errors ["a_name"] as error_list then
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
			from
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
			error_list.start
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
			until
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
			error_list.after
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
			loop
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
			name_errors:= error_list.item
				-- line: 55 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 55 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_80)
				-- line: 55 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_81)
				-- line: 56 row: 1 of file: ./reservations.xeb
				-- line: 56 row: 1 of file: ./reservations.xeb
			if attached {STRING} name_errors.out as l_text then 
				-- line: 56 row: 1 of file: ./reservations.xeb
			response.append (l_text)
				-- line: 56 row: 1 of file: ./reservations.xeb
				-- line: 56 row: 1 of file: ./reservations.xeb
			else
				-- line: 56 row: 1 of file: ./reservations.xeb
			response.append (name_errors.out.out)
				-- line: 56 row: 1 of file: ./reservations.xeb
				-- line: 56 row: 1 of file: ./reservations.xeb
			end
				-- line: 56 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
			error_list.forth
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
			end
				-- line: 57 row: 1 of file: ./reservations.xeb
				-- line: 57 row: 1 of file: ./reservations.xeb
			end
				-- line: 57 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 58 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 58 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 59 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 59 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 70 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_71)
				-- line: 60 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 61 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 60 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_64)
				-- line: 61 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 61 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 69 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 62 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			l_temp_9 := unique_id
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			response.append("<script language=%"javascript1.2%" type=%"text/javascript%" >")
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			response.append("<!--%N")
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			response.append("var l_temp_10 = new CodeThatCalendar(caldef1);")
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			response.append("%N//-->")
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			response.append("</script>")
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			response.append("<input type=%"text%" name=%"l_temp_9%" value=%""+new_reservation.date.out+"%"/>")
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			response.append("<input type=%"button%" onclick=%"l_temp_10.popup('l_temp_9');%" value=%"select%" />")
				-- line: 63 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 64 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 65 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
			if attached {LIST [STRING]} validation_errors ["a_date"] as error_list then
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
			from
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
			error_list.start
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
			until
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
			error_list.after
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
			loop
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
			date_errors:= error_list.item
				-- line: 66 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 66 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_80)
				-- line: 66 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_81)
				-- line: 67 row: 1 of file: ./reservations.xeb
				-- line: 67 row: 1 of file: ./reservations.xeb
			if attached {STRING} date_errors.out as l_text then 
				-- line: 67 row: 1 of file: ./reservations.xeb
			response.append (l_text)
				-- line: 67 row: 1 of file: ./reservations.xeb
				-- line: 67 row: 1 of file: ./reservations.xeb
			else
				-- line: 67 row: 1 of file: ./reservations.xeb
			response.append (date_errors.out.out)
				-- line: 67 row: 1 of file: ./reservations.xeb
				-- line: 67 row: 1 of file: ./reservations.xeb
			end
				-- line: 67 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
			error_list.forth
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
			end
				-- line: 68 row: 1 of file: ./reservations.xeb
				-- line: 68 row: 1 of file: ./reservations.xeb
			end
				-- line: 68 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 69 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 69 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 70 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 70 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 83 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_71)
				-- line: 71 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 72 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 71 row: 18 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_65)
				-- line: 72 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 72 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 82 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 73 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			l_temp_11 := unique_id
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			response.append("<input type=%"text%" value=%""+new_reservation.s_persons+"%" size=%"20%" name=%"l_temp_11%" />")
				-- line: 74 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 75 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 76 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 77 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 78 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
			if attached {LIST [STRING]} validation_errors ["a_s_persons"] as error_list then
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
			from
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
			error_list.start
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
			until
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
			error_list.after
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
			loop
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
			persons_errors:= error_list.item
				-- line: 79 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 79 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_80)
				-- line: 79 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_81)
				-- line: 80 row: 1 of file: ./reservations.xeb
				-- line: 80 row: 1 of file: ./reservations.xeb
			if attached {STRING} persons_errors.out as l_text then 
				-- line: 80 row: 1 of file: ./reservations.xeb
			response.append (l_text)
				-- line: 80 row: 1 of file: ./reservations.xeb
				-- line: 80 row: 1 of file: ./reservations.xeb
			else
				-- line: 80 row: 1 of file: ./reservations.xeb
			response.append (persons_errors.out.out)
				-- line: 80 row: 1 of file: ./reservations.xeb
				-- line: 80 row: 1 of file: ./reservations.xeb
			end
				-- line: 80 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
			error_list.forth
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
			end
				-- line: 81 row: 1 of file: ./reservations.xeb
				-- line: 81 row: 1 of file: ./reservations.xeb
			end
				-- line: 81 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 82 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 82 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 83 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 83 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 94 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_71)
				-- line: 84 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 85 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 84 row: 22 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_82)
				-- line: 85 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 85 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 93 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 86 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			l_temp_12 := unique_id
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			response.append("<textarea rows=%"5%" cols=%"45%" name=%"l_temp_12%">"+new_reservation.description+"</textarea>")
				-- line: 87 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 88 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 89 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
			if attached {LIST [STRING]} validation_errors ["a_description"] as error_list then
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
			from
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
			error_list.start
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
			until
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
			error_list.after
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
			loop
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
			description_errors:= error_list.item
				-- line: 90 row: 9 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_72)
				-- line: 90 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_80)
				-- line: 90 row: 15 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_81)
				-- line: 91 row: 1 of file: ./reservations.xeb
				-- line: 91 row: 1 of file: ./reservations.xeb
			if attached {STRING} description_errors.out as l_text then 
				-- line: 91 row: 1 of file: ./reservations.xeb
			response.append (l_text)
				-- line: 91 row: 1 of file: ./reservations.xeb
				-- line: 91 row: 1 of file: ./reservations.xeb
			else
				-- line: 91 row: 1 of file: ./reservations.xeb
			response.append (description_errors.out.out)
				-- line: 91 row: 1 of file: ./reservations.xeb
				-- line: 91 row: 1 of file: ./reservations.xeb
			end
				-- line: 91 row: 8 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
			error_list.forth
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
			end
				-- line: 92 row: 1 of file: ./reservations.xeb
				-- line: 92 row: 1 of file: ./reservations.xeb
			end
				-- line: 92 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 93 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 93 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 94 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 94 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 100 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_71)
				-- line: 95 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 99 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_83)
				-- line: 96 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 98 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_84)
				-- line: 97 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
			response.append("<button name=%"l_temp_13%" type=%"submit%">Save</button>")
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
			l_temp_14 := unique_id
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
			response.append("<input type=%"hidden%" name=%""+l_temp_14+"%" value =%""+l_temp_14+"%" />")
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
			if attached agent_table ["l_temp_7"] as l_agent_table then
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
			l_agent_table [l_temp_14] := agent (a_request: XH_REQUEST) do
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
			if fill_bean (a_request) then
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
			controller_1.save (new_reservation)
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
			end
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
			end
				-- line: 97 row: 59 of file: ./reservations.xeb
				-- line: 97 row: 59 of file: ./reservations.xeb
			end -- XTAG_F_BUTTON_TAG
				-- line: 98 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 98 row: 7 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 99 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 99 row: 6 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 100 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 100 row: 5 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 101 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_77)
				-- line: 101 row: 5 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
			response.append("<input type=%"hidden%" name=%"l_temp_7%" value=%""+l_temp_7+"%" />")
				-- line: 102 row: 1 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 102 row: 4 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 103 row: 1 of file: ./reservations.xeb
				-- line: 103 row: 1 of file: ./reservations.xeb
			end
				-- line: 103 row: 3 of file: ./reservations.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 40 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 41 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 41 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 42 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_85)
				-- line: 42 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 42 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 43 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 43 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 44 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_86)
				-- line: 44 row: 2 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 45 row: 1 of file: ./master_template.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_87)
		end

	clean_up_after_render (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		do
				-- line: 19 row: 19 of file: ./master_template.xeb
				-- line: 19 row: 19 of file: ./master_template.xeb
			if attached render_conditions ["class_temp_0"] and then render_conditions ["class_temp_0"] then
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 1 of file: ./master_template.xeb
				-- line: 19 row: 19 of file: ./master_template.xeb
				-- line: 19 row: 19 of file: ./master_template.xeb
			end
				-- line: 24 row: 1 of file: ./master_template.xeb
				-- line: 24 row: 1 of file: ./master_template.xeb
			if attached render_conditions ["class_temp_1"] and then render_conditions ["class_temp_1"] then
				-- line: 24 row: 1 of file: ./master_template.xeb
				-- line: 24 row: 1 of file: ./master_template.xeb
			end
				-- line: 8 row: 1 of file: ./reservations.xeb
				-- line: 8 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_2"] and then render_conditions ["class_temp_2"] then
				-- line: 8 row: 1 of file: ./reservations.xeb
				-- line: 8 row: 1 of file: ./reservations.xeb
			end
				-- line: 43 row: 1 of file: ./reservations.xeb
				-- line: 43 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_3"] and then render_conditions ["class_temp_3"] then
				-- line: 18 row: 1 of file: ./reservations.xeb
				-- line: 18 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_4"] and then render_conditions ["class_temp_4"] then
				-- line: 18 row: 1 of file: ./reservations.xeb
				-- line: 18 row: 1 of file: ./reservations.xeb
			end
				-- line: 21 row: 1 of file: ./reservations.xeb
				-- line: 21 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_5"] and then render_conditions ["class_temp_5"] then
				-- line: 21 row: 1 of file: ./reservations.xeb
				-- line: 21 row: 1 of file: ./reservations.xeb
			end
				-- line: 34 row: 1 of file: ./reservations.xeb
				-- line: 34 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_6"] and then render_conditions ["class_temp_6"] then
				-- line: 34 row: 1 of file: ./reservations.xeb
				-- line: 34 row: 1 of file: ./reservations.xeb
			end
				-- line: 37 row: 1 of file: ./reservations.xeb
				-- line: 37 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_7"] and then render_conditions ["class_temp_7"] then
				-- line: 37 row: 1 of file: ./reservations.xeb
				-- line: 37 row: 1 of file: ./reservations.xeb
			end
				-- line: 43 row: 1 of file: ./reservations.xeb
				-- line: 43 row: 1 of file: ./reservations.xeb
			end
				-- line: 103 row: 1 of file: ./reservations.xeb
				-- line: 103 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_8"] and then render_conditions ["class_temp_8"] then
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 102 row: 1 of file: ./reservations.xeb
				-- line: 103 row: 1 of file: ./reservations.xeb
				-- line: 103 row: 1 of file: ./reservations.xeb
			end
			if validation_errors.empty then
			create b.make
			end
			if validation_errors.empty then
			create new_reservation.make
			end
		end

	fill_bean (a_request: XH_REQUEST): BOOLEAN
			--<Precursor>
		local
			l_temp_0: BOOLEAN
			l_temp_1: XWA_VALIDATOR
			l_temp_2: BOOLEAN
			l_temp_3: XWA_VALIDATOR
			l_temp_4: DATE
			l_temp_5: BOOLEAN
			l_temp_6: XWA_VALIDATOR
			l_temp_7: BOOLEAN
			l_temp_8: XWA_VALIDATOR
		do
			Result := True
				-- no debug information
				-- line: 19 row: 19 of file: ./master_template.xeb
				-- line: 19 row: 19 of file: ./master_template.xeb
			if attached render_conditions ["class_temp_0"] and then render_conditions ["class_temp_0"] then
				-- line: 19 row: 19 of file: ./master_template.xeb
				-- line: 19 row: 19 of file: ./master_template.xeb
			end
				-- line: 24 row: 1 of file: ./master_template.xeb
				-- line: 24 row: 1 of file: ./master_template.xeb
			if attached render_conditions ["class_temp_1"] and then render_conditions ["class_temp_1"] then
				-- line: 24 row: 1 of file: ./master_template.xeb
				-- line: 24 row: 1 of file: ./master_template.xeb
			end
				-- line: 8 row: 1 of file: ./reservations.xeb
				-- line: 8 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_2"] and then render_conditions ["class_temp_2"] then
				-- line: 8 row: 1 of file: ./reservations.xeb
				-- line: 8 row: 1 of file: ./reservations.xeb
			end
				-- line: 43 row: 1 of file: ./reservations.xeb
				-- line: 43 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_3"] and then render_conditions ["class_temp_3"] then
				-- line: 18 row: 1 of file: ./reservations.xeb
				-- line: 18 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_4"] and then render_conditions ["class_temp_4"] then
				-- line: 18 row: 1 of file: ./reservations.xeb
				-- line: 18 row: 1 of file: ./reservations.xeb
			end
				-- line: 21 row: 1 of file: ./reservations.xeb
				-- line: 21 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_5"] and then render_conditions ["class_temp_5"] then
				-- line: 21 row: 1 of file: ./reservations.xeb
				-- line: 21 row: 1 of file: ./reservations.xeb
			end
				-- line: 34 row: 1 of file: ./reservations.xeb
				-- line: 34 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_6"] and then render_conditions ["class_temp_6"] then
				-- line: 34 row: 1 of file: ./reservations.xeb
				-- line: 34 row: 1 of file: ./reservations.xeb
			end
				-- line: 37 row: 1 of file: ./reservations.xeb
				-- line: 37 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_7"] and then render_conditions ["class_temp_7"] then
				-- line: 37 row: 1 of file: ./reservations.xeb
				-- line: 37 row: 1 of file: ./reservations.xeb
			end
				-- line: 43 row: 1 of file: ./reservations.xeb
				-- line: 43 row: 1 of file: ./reservations.xeb
			end
				-- line: 103 row: 1 of file: ./reservations.xeb
				-- line: 103 row: 1 of file: ./reservations.xeb
			if attached render_conditions ["class_temp_8"] and then render_conditions ["class_temp_8"] then
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			if attached a_request.argument_table ["l_temp_8"] as argument then
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			l_temp_0 := True
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_1.make
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			if not l_temp_1.validate (argument) then
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			l_temp_0 := False
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			add_error ("a_name", l_temp_1.message)
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			end
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			create {XWA_ALPHA_NUMERIC_VALIDATOR}l_temp_1.make
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			if not l_temp_1.validate (argument) then
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			l_temp_0 := False
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			add_error ("a_name", l_temp_1.message)
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			end
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			Result := Result and l_temp_0
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			if l_temp_0 then
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			new_reservation.name := argument
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			end
				-- line: 54 row: 1 of file: ./reservations.xeb
				-- line: 54 row: 1 of file: ./reservations.xeb
			end
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			if attached a_request.argument_table ["l_temp_9"] as argument then
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			l_temp_2 := True
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_3.make
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			if not l_temp_3.validate (argument) then
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			l_temp_2 := False
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			add_error ("a_date", l_temp_3.message)
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			end
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			Result := Result and l_temp_2
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			if l_temp_2 then
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			create l_temp_4.make_now
if l_temp_4.date_valid (argument, "[0]mm/[0]dd/yyyy") then
create l_temp_4.make_from_string (argument, "[0]mm/[0]dd/yyyy")
	new_reservation.date := l_temp_4
end
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			end
				-- line: 65 row: 1 of file: ./reservations.xeb
				-- line: 65 row: 1 of file: ./reservations.xeb
			end
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			if attached a_request.argument_table ["l_temp_11"] as argument then
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			l_temp_5 := True
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_6.make
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			if not l_temp_6.validate (argument) then
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			l_temp_5 := False
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			add_error ("a_s_persons", l_temp_6.message)
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			end
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			create {XWA_NUMBER_VALIDATOR}l_temp_6.make
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			if not l_temp_6.validate (argument) then
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			l_temp_5 := False
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			add_error ("a_s_persons", l_temp_6.message)
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			end
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			create {XWA_BIGGER_THAN_ZERO_VALIDATOR}l_temp_6.make
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			if not l_temp_6.validate (argument) then
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			l_temp_5 := False
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			add_error ("a_s_persons", l_temp_6.message)
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			end
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			Result := Result and l_temp_5
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			if l_temp_5 then
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			new_reservation.s_persons := argument
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			end
				-- line: 78 row: 1 of file: ./reservations.xeb
				-- line: 78 row: 1 of file: ./reservations.xeb
			end
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			if attached a_request.argument_table ["l_temp_12"] as argument then
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			l_temp_7 := True
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			create {XWA_NOT_EMPTY_VALIDATOR}l_temp_8.make
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			if not l_temp_8.validate (argument) then
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			l_temp_7 := False
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			add_error ("a_description", l_temp_8.message)
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			end
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			Result := Result and l_temp_7
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			if l_temp_7 then
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			new_reservation.description := argument
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			end
				-- line: 89 row: 1 of file: ./reservations.xeb
				-- line: 89 row: 1 of file: ./reservations.xeb
			end
				-- line: 103 row: 1 of file: ./reservations.xeb
				-- line: 103 row: 1 of file: ./reservations.xeb
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
