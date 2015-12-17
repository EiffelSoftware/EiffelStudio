note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_CONTACT_SERVLET

inherit
	XWA_SERVLET redefine make end

create
	make

feature-- Access

	controller_1: LOGIN_CONTROLLER

	controller_2: LOGIN_CONTROLLER

	internal_controllers: LIST [XWA_CONTROLLER]

	b: LOGIN_BEAN

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
		end

	render_html_page (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		local
			l_temp_0: STRING
			l_temp_2: STRING
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
				-- line: 4 row: 6 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_88)
				-- line: 5 row: 1 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_34)
				-- line: 4 row: 45 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_101)
				-- line: 4 row: 38 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 4 row: 45 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_102)
				-- line: 5 row: 1 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_36)
				-- line: 5 row: 6 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_88)
				-- line: 6 row: 1 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_54)
				-- line: 5 row: 26 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_103)
				-- line: 5 row: 88 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_104)
				-- line: 5 row: 84 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_105)
				-- line: 5 row: 88 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 5 row: 89 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_106)
				-- line: 6 row: 1 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_56)
				-- line: 6 row: 4 of file: ./contact.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_90)
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
			if validation_errors.empty then
			create b.make
			end
		end

	fill_bean (a_request: XH_REQUEST): BOOLEAN
			--<Precursor>
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
