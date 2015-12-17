note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_PROTECTED___SUBMITTED_INTERACTION_SERVLET

inherit
	XWA_SERVLET redefine make end

create
	make

feature-- Access

	controller_1: LOGIN_CONTROLLER

	internal_controllers: LIST [XWA_CONTROLLER]

feature-- Implementation

	make
			--<Precursor>
		do
				-- no debug information
				-- no debug information
			Precursor
				-- no debug information
				-- no debug information
			create {ARRAYED_LIST [XWA_CONTROLLER]} internal_controllers.make (1)
				-- no debug information
				-- no debug information
			create controller_1.default_create
				-- no debug information
				-- no debug information
			internal_controllers.extend (controller_1)
		end

	set_all_booleans (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		do
				-- line: 23 row: 1 of file: ./support_master.xeb
				-- line: 23 row: 1 of file: ./support_master.xeb
			render_conditions ["class_temp_0"] := controller_1.is_logged_in
				-- line: 29 row: 1 of file: ./support_master.xeb
				-- line: 29 row: 1 of file: ./support_master.xeb
			render_conditions ["class_temp_1"] := controller_1.is_not_logged_in
				-- line: 34 row: 1 of file: ./support_master.xeb
				-- line: 34 row: 1 of file: ./support_master.xeb
			render_conditions ["class_temp_2"] := controller_1.is_logged_in
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			render_conditions ["class_temp_3"] := controller_1.is_logged_in
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			render_conditions ["class_temp_4"] := controller_1.is_not_logged_in
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
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			end
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_4"] and then render_conditions ["class_temp_4"] then
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
			if attached {STRING} controller_1.user_name as l_text then 
				-- line: 20 row: 57 of file: ./support_master.xeb
			response.append (l_text)
				-- line: 20 row: 57 of file: ./support_master.xeb
				-- line: 20 row: 57 of file: ./support_master.xeb
			else
				-- line: 20 row: 57 of file: ./support_master.xeb
			response.append (controller_1.user_name.out)
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
			controller_1.login
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
			controller_1.logout
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
				-- line: 3 row: 3 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 4 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_80)
				-- line: 3 row: 67 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_81)
				-- line: 3 row: 62 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_323)
				-- line: 3 row: 67 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_83)
				-- line: 4 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 5 row: 3 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_110)
				-- line: 47 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_85)
				-- line: 6 row: 4 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 46 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_324)
				-- line: 7 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 12 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_325)
				-- line: 8 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 11 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 9 row: 7 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 9 row: 57 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_114)
				-- line: 9 row: 50 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_326)
				-- line: 9 row: 57 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 10 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_119)
				-- line: 11 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 11 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 12 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 12 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 17 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_327)
				-- line: 13 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 16 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 14 row: 7 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 14 row: 59 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_114)
				-- line: 14 row: 52 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_328)
				-- line: 14 row: 59 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 15 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_119)
				-- line: 16 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 16 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 17 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 17 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 22 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_329)
				-- line: 18 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 21 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 19 row: 7 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 19 row: 62 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_114)
				-- line: 19 row: 55 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_330)
				-- line: 19 row: 62 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 20 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_119)
				-- line: 21 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 21 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 22 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 22 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 27 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_331)
				-- line: 23 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 26 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_113)
				-- line: 25 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_332)
				-- line: 26 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 26 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 27 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 27 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 32 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 28 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 31 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_320)
				-- line: 29 row: 7 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 29 row: 44 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_114)
				-- line: 29 row: 37 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_333)
				-- line: 29 row: 44 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 30 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_90)
				-- line: 30 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_91)
				-- line: 30 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 31 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 31 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 32 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 32 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 38 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_132)
				-- line: 33 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 37 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_320)
				-- line: 34 row: 7 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 34 row: 51 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_114)
				-- line: 34 row: 44 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_133)
				-- line: 34 row: 51 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_116)
				-- line: 35 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_90)
				-- line: 35 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_91)
				-- line: 36 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_334)
				-- line: 37 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 37 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 38 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 38 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 45 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_112)
				-- line: 39 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 44 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_335)
				-- line: 40 row: 7 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- AN ERROR OCCURED WHILE GENERATION OF XTAG_F_COMMAND_LINK_TAG!
				-- line: 42 row: 7 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_136)
				-- AN ERROR OCCURED WHILE GENERATION OF XTAG_F_COMMAND_LINK_TAG!
				-- line: 43 row: 6 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 44 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_117)
				-- line: 44 row: 5 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 45 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_120)
				-- line: 45 row: 4 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 46 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_137)
				-- line: 46 row: 3 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 47 row: 1 of file: ./protected/submitted_interaction.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 47 row: 2 of file: ./protected/submitted_interaction.xeb
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
			if attached render_conditions ["class_temp_4"] and then render_conditions ["class_temp_4"] then
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
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			end
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_4"] and then render_conditions ["class_temp_4"] then
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			end
		end

	fill_bean (a_request: XH_REQUEST): BOOLEAN
			--<Precursor>
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
				-- line: 43 row: 1 of file: ./support_master.xeb
				-- line: 43 row: 1 of file: ./support_master.xeb
			end
				-- line: 46 row: 1 of file: ./support_master.xeb
				-- line: 46 row: 1 of file: ./support_master.xeb
			if attached render_conditions ["class_temp_4"] and then render_conditions ["class_temp_4"] then
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
