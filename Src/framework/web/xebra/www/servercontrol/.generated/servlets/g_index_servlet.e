note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_INDEX_SERVLET

inherit
	XWA_SERVLET redefine make end

create
	make

feature-- Access

	controller_1: MAIN_CONTROLLER

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
		end

	handle_form_internal (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			--<Precursor>
		do
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			if attached a_request.argument_table ["l_temp_0"] as form_argument then
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			from
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			a_request.argument_table.start
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			until
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			a_request.argument_table.after
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			loop
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			if attached l_agent_table [a_request.argument_table.key_for_iteration] as l_agent and then not a_request.argument_table.item_for_iteration.is_empty then
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			l_agent.call ([a_request])
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			end
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			a_request.argument_table.forth
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			end
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			end
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			end
		end

	render_html_page (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		local
			l_temp_0: STRING
			l_temp_2: STRING
			l_temp_4: STRING
			l_temp_5: LIST [XC_SERVER_MODULE_BEAN]
			l_temp_7: STRING
			l_temp_9: STRING
			l_temp_10: LIST [XC_WEBAPP_BEAN]
			wappurl: STRING
			l_temp_12: STRING
			l_temp_14: STRING
			l_temp_16: STRING
			l_temp_18: STRING
		do
				-- line: 2 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_0)
				-- line: 92 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 3 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 9 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_3)
				-- line: 4 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 5 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_5)
				-- line: 4 row: 29 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 5 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_7)
				-- line: 5 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 6 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 7 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_8)
				-- line: 7 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_9)
				-- line: 7 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 8 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_10)
				-- line: 8 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_11)
				-- line: 8 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 9 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 9 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 91 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_13)
				-- line: 10 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 90 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_14)
				-- line: 11 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 14 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 12 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 13 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 12 row: 38 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 13 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 13 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 14 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 14 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 86 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 15 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			l_temp_0:= unique_id
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			response.append ("<form id=%"l_temp_0%" action=%"" +request.uri + "%" method=%"post%">")
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			agent_table ["l_temp_0"] := create {HASH_TABLE [PROCEDURE, STRING]}.make (17)
				-- line: 17 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 18 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_20)
				-- line: 17 row: 20 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 18 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 19 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 30 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 20 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 24 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_25)
				-- line: 21 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 22 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 21 row: 12 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_28)
				-- line: 22 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 22 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 23 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 22 row: 15 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_30)
				-- line: 23 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 23 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 24 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 24 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 27 row: 9 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_25)
				-- line: 25 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_32)
				-- line: 25 row: 25 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 25 row: 20 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_34)
				-- line: 25 row: 25 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 26 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_36)
				-- line: 27 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 26 row: 68 of file: ./index.xeb
				-- line: 26 row: 68 of file: ./index.xeb
				-- line: 26 row: 68 of file: ./index.xeb
			l_temp_2 := unique_id
				-- line: 26 row: 68 of file: ./index.xeb
				-- line: 26 row: 68 of file: ./index.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_0']['" + l_temp_2+ "'].value='" + l_temp_2+ "'; document.forms['l_temp_0'].submit(); return false;%">shutdown</a><input type=%"hidden%" name =%"" + l_temp_2+ "%" />")
				-- line: 26 row: 68 of file: ./index.xeb
				-- line: 26 row: 68 of file: ./index.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 26 row: 68 of file: ./index.xeb
				-- line: 26 row: 68 of file: ./index.xeb
			l_agent_table [l_temp_2] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 26 row: 68 of file: ./index.xeb
				-- line: 26 row: 68 of file: ./index.xeb
			controller_1.shutdown_server
				-- line: 26 row: 68 of file: ./index.xeb
				-- line: 26 row: 68 of file: ./index.xeb
			end (?, Void) -- COMMAND_LINK_TAG
				-- line: 26 row: 68 of file: ./index.xeb
				-- line: 26 row: 68 of file: ./index.xeb
			end
				-- line: 26 row: 71 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_37)
				-- line: 26 row: 137 of file: ./index.xeb
				-- line: 26 row: 137 of file: ./index.xeb
				-- line: 26 row: 137 of file: ./index.xeb
			l_temp_4 := unique_id
				-- line: 26 row: 137 of file: ./index.xeb
				-- line: 26 row: 137 of file: ./index.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_0']['" + l_temp_4+ "'].value='" + l_temp_4+ "'; document.forms['l_temp_0'].submit(); return false;%">reload config file</a><input type=%"hidden%" name =%"" + l_temp_4+ "%" />")
				-- line: 26 row: 137 of file: ./index.xeb
				-- line: 26 row: 137 of file: ./index.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 26 row: 137 of file: ./index.xeb
				-- line: 26 row: 137 of file: ./index.xeb
			l_agent_table [l_temp_4] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 26 row: 137 of file: ./index.xeb
				-- line: 26 row: 137 of file: ./index.xeb
			controller_1.reload_config
				-- line: 26 row: 137 of file: ./index.xeb
				-- line: 26 row: 137 of file: ./index.xeb
			end (?, Void) -- COMMAND_LINK_TAG
				-- line: 26 row: 137 of file: ./index.xeb
				-- line: 26 row: 137 of file: ./index.xeb
			end
				-- line: 27 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 27 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 27 row: 9 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 29 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_38)
				-- line: 30 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_39)
				-- line: 30 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 31 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_20)
				-- line: 30 row: 13 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_40)
				-- line: 31 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 33 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 34 row: 1 of file: ./index.xeb
				-- line: 34 row: 1 of file: ./index.xeb
			if attached {STRING} controller_1.get_modules as l_text then 
				-- line: 34 row: 1 of file: ./index.xeb
			response.append (l_text)
				-- line: 34 row: 1 of file: ./index.xeb
				-- line: 34 row: 1 of file: ./index.xeb
			else
				-- line: 34 row: 1 of file: ./index.xeb
			response.append (controller_1.get_modules.out)
				-- line: 34 row: 1 of file: ./index.xeb
				-- line: 34 row: 1 of file: ./index.xeb
			end
				-- line: 34 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 50 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 35 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 40 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_25)
				-- line: 36 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 37 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 36 row: 12 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_28)
				-- line: 37 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 37 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 38 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 37 row: 16 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 38 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 38 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 39 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 38 row: 15 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 39 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 39 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 40 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 40 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
			l_temp_5 := controller_1.modules
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
			from --l_temp_5
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
			l_temp_5.start
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
			until
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
			l_temp_5.after
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
			loop
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
			if attached {XC_SERVER_MODULE_BEAN} l_temp_5.item as module then
				-- line: 41 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 47 row: 9 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_25)
				-- line: 42 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_32)
				-- line: 43 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 42 row: 46 of file: ./index.xeb
				-- line: 42 row: 46 of file: ./index.xeb
			if attached {STRING} module.name as l_text then 
				-- line: 42 row: 46 of file: ./index.xeb
			response.append (l_text)
				-- line: 42 row: 46 of file: ./index.xeb
				-- line: 42 row: 46 of file: ./index.xeb
			else
				-- line: 42 row: 46 of file: ./index.xeb
			response.append (module.name.out)
				-- line: 42 row: 46 of file: ./index.xeb
				-- line: 42 row: 46 of file: ./index.xeb
			end
				-- line: 43 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 44 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_44)
				-- line: 45 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 44 row: 57 of file: ./index.xeb
				-- line: 44 row: 57 of file: ./index.xeb
			if attached {STRING} module.is_launched.out as l_text then 
				-- line: 44 row: 57 of file: ./index.xeb
			response.append (l_text)
				-- line: 44 row: 57 of file: ./index.xeb
				-- line: 44 row: 57 of file: ./index.xeb
			else
				-- line: 44 row: 57 of file: ./index.xeb
			response.append (module.is_launched.out.out)
				-- line: 44 row: 57 of file: ./index.xeb
				-- line: 44 row: 57 of file: ./index.xeb
			end
				-- line: 45 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 46 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_44)
				-- line: 47 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 46 row: 56 of file: ./index.xeb
				-- line: 46 row: 56 of file: ./index.xeb
			if attached {STRING} module.is_running.out as l_text then 
				-- line: 46 row: 56 of file: ./index.xeb
			response.append (l_text)
				-- line: 46 row: 56 of file: ./index.xeb
				-- line: 46 row: 56 of file: ./index.xeb
			else
				-- line: 46 row: 56 of file: ./index.xeb
			response.append (module.is_running.out.out)
				-- line: 46 row: 56 of file: ./index.xeb
				-- line: 46 row: 56 of file: ./index.xeb
			end
				-- line: 46 row: 58 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_45)
				-- line: 46 row: 133 of file: ./index.xeb
				-- line: 46 row: 133 of file: ./index.xeb
				-- line: 46 row: 133 of file: ./index.xeb
			l_temp_7 := unique_id
				-- line: 46 row: 133 of file: ./index.xeb
				-- line: 46 row: 133 of file: ./index.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_0']['" + l_temp_7+ "'].value='" + l_temp_7+ "'; document.forms['l_temp_0'].submit(); return false;%">stop</a><input type=%"hidden%" name =%"" + l_temp_7+ "%" />")
				-- line: 46 row: 133 of file: ./index.xeb
				-- line: 46 row: 133 of file: ./index.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 46 row: 133 of file: ./index.xeb
				-- line: 46 row: 133 of file: ./index.xeb
			l_agent_table [l_temp_7] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 46 row: 133 of file: ./index.xeb
				-- line: 46 row: 133 of file: ./index.xeb
			controller_1.shutdown_mod (a_object)
				-- line: 46 row: 133 of file: ./index.xeb
				-- line: 46 row: 133 of file: ./index.xeb
			end (?, module.name) -- COMMAND_LINK_TAG
				-- line: 46 row: 133 of file: ./index.xeb
				-- line: 46 row: 133 of file: ./index.xeb
			end
				-- line: 46 row: 136 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_37)
				-- line: 46 row: 213 of file: ./index.xeb
				-- line: 46 row: 213 of file: ./index.xeb
				-- line: 46 row: 213 of file: ./index.xeb
			l_temp_9 := unique_id
				-- line: 46 row: 213 of file: ./index.xeb
				-- line: 46 row: 213 of file: ./index.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_0']['" + l_temp_9+ "'].value='" + l_temp_9+ "'; document.forms['l_temp_0'].submit(); return false;%">restart</a><input type=%"hidden%" name =%"" + l_temp_9+ "%" />")
				-- line: 46 row: 213 of file: ./index.xeb
				-- line: 46 row: 213 of file: ./index.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 46 row: 213 of file: ./index.xeb
				-- line: 46 row: 213 of file: ./index.xeb
			l_agent_table [l_temp_9] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 46 row: 213 of file: ./index.xeb
				-- line: 46 row: 213 of file: ./index.xeb
			controller_1.relaunch_mod (a_object)
				-- line: 46 row: 213 of file: ./index.xeb
				-- line: 46 row: 213 of file: ./index.xeb
			end (?, module.name) -- COMMAND_LINK_TAG
				-- line: 46 row: 213 of file: ./index.xeb
				-- line: 46 row: 213 of file: ./index.xeb
			end
				-- line: 46 row: 214 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_46)
				-- line: 47 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 47 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 47 row: 9 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 48 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_47)
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
			l_temp_5.forth
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
			end -- if attached module
				-- line: 49 row: 1 of file: ./index.xeb
				-- line: 49 row: 1 of file: ./index.xeb
			end -- from l_temp_5
				-- line: 49 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 50 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_39)
				-- line: 51 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 52 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_20)
				-- line: 51 row: 13 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
				-- line: 52 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 53 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 54 row: 1 of file: ./index.xeb
				-- line: 54 row: 1 of file: ./index.xeb
			if attached {STRING} controller_1.get_webapps as l_text then 
				-- line: 54 row: 1 of file: ./index.xeb
			response.append (l_text)
				-- line: 54 row: 1 of file: ./index.xeb
				-- line: 54 row: 1 of file: ./index.xeb
			else
				-- line: 54 row: 1 of file: ./index.xeb
			response.append (controller_1.get_webapps.out)
				-- line: 54 row: 1 of file: ./index.xeb
				-- line: 54 row: 1 of file: ./index.xeb
			end
				-- line: 54 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 82 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 55 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 66 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_25)
				-- line: 56 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 57 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 56 row: 12 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_28)
				-- line: 57 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 57 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 58 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 57 row: 20 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_49)
				-- line: 58 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 58 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 59 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 58 row: 12 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_50)
				-- line: 59 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 59 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 60 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 59 row: 19 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_51)
				-- line: 60 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 60 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 61 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 60 row: 15 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_52)
				-- line: 61 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 61 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 61 row: 22 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 61 row: 17 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_53)
				-- line: 61 row: 22 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 62 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_54)
				-- line: 62 row: 21 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 62 row: 16 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_55)
				-- line: 62 row: 21 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 63 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_56)
				-- line: 64 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 63 row: 24 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_57)
				-- line: 64 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 65 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_58)
				-- line: 66 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 66 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
			l_temp_10 := controller_1.webapps
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
			from --l_temp_10
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
			l_temp_10.start
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
			until
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
			l_temp_10.after
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
			loop
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
			if attached {XC_WEBAPP_BEAN} l_temp_10.item as webapp then
				-- line: 67 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 80 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_25)
				-- line: 68 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 69 row: 1 of file: ./index.xeb
				-- line: 69 row: 1 of file: ./index.xeb
				-- line: 69 row: 1 of file: ./index.xeb
			wappurl := "../"
				-- line: 69 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 70 row: 1 of file: ./index.xeb
				-- line: 70 row: 1 of file: ./index.xeb
			wappurl := "" + wappurl + ""+webapp.app_config.name.value.out+""
				-- line: 70 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 71 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 70 row: 92 of file: ./index.xeb
			response.append ("<a href=%""+wappurl+"%">")
				-- line: 70 row: 88 of file: ./index.xeb
				-- line: 70 row: 88 of file: ./index.xeb
			if attached {STRING} webapp.app_config.name.value.out as l_text then 
				-- line: 70 row: 88 of file: ./index.xeb
			response.append (l_text)
				-- line: 70 row: 88 of file: ./index.xeb
				-- line: 70 row: 88 of file: ./index.xeb
			else
				-- line: 70 row: 88 of file: ./index.xeb
			response.append (webapp.app_config.name.value.out.out)
				-- line: 70 row: 88 of file: ./index.xeb
				-- line: 70 row: 88 of file: ./index.xeb
			end
				-- line: 70 row: 92 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_60)
				-- line: 71 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 71 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 72 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 71 row: 74 of file: ./index.xeb
				-- line: 71 row: 74 of file: ./index.xeb
			if attached {STRING} webapp.app_config.webapp_host.value.out as l_text then 
				-- line: 71 row: 74 of file: ./index.xeb
			response.append (l_text)
				-- line: 71 row: 74 of file: ./index.xeb
				-- line: 71 row: 74 of file: ./index.xeb
			else
				-- line: 71 row: 74 of file: ./index.xeb
			response.append (webapp.app_config.webapp_host.value.out.out)
				-- line: 71 row: 74 of file: ./index.xeb
				-- line: 71 row: 74 of file: ./index.xeb
			end
				-- line: 72 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 72 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 73 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 72 row: 67 of file: ./index.xeb
				-- line: 72 row: 67 of file: ./index.xeb
			if attached {STRING} webapp.app_config.port.value.out as l_text then 
				-- line: 72 row: 67 of file: ./index.xeb
			response.append (l_text)
				-- line: 72 row: 67 of file: ./index.xeb
				-- line: 72 row: 67 of file: ./index.xeb
			else
				-- line: 72 row: 67 of file: ./index.xeb
			response.append (webapp.app_config.port.value.out.out)
				-- line: 72 row: 67 of file: ./index.xeb
				-- line: 72 row: 67 of file: ./index.xeb
			end
				-- line: 73 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 73 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 74 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 73 row: 71 of file: ./index.xeb
				-- line: 73 row: 71 of file: ./index.xeb
			if attached {STRING} webapp.app_config.is_interactive.out as l_text then 
				-- line: 73 row: 71 of file: ./index.xeb
			response.append (l_text)
				-- line: 73 row: 71 of file: ./index.xeb
				-- line: 73 row: 71 of file: ./index.xeb
			else
				-- line: 73 row: 71 of file: ./index.xeb
			response.append (webapp.app_config.is_interactive.out.out)
				-- line: 73 row: 71 of file: ./index.xeb
				-- line: 73 row: 71 of file: ./index.xeb
			end
				-- line: 74 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 74 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 75 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 74 row: 48 of file: ./index.xeb
				-- line: 74 row: 48 of file: ./index.xeb
			if attached {STRING} webapp.status as l_text then 
				-- line: 74 row: 48 of file: ./index.xeb
			response.append (l_text)
				-- line: 74 row: 48 of file: ./index.xeb
				-- line: 74 row: 48 of file: ./index.xeb
			else
				-- line: 74 row: 48 of file: ./index.xeb
			response.append (webapp.status.out)
				-- line: 74 row: 48 of file: ./index.xeb
				-- line: 74 row: 48 of file: ./index.xeb
			end
				-- line: 75 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 75 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 76 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 75 row: 54 of file: ./index.xeb
				-- line: 75 row: 54 of file: ./index.xeb
			if attached {STRING} webapp.sessions.out as l_text then 
				-- line: 75 row: 54 of file: ./index.xeb
			response.append (l_text)
				-- line: 75 row: 54 of file: ./index.xeb
				-- line: 75 row: 54 of file: ./index.xeb
			else
				-- line: 75 row: 54 of file: ./index.xeb
			response.append (webapp.sessions.out.out)
				-- line: 75 row: 54 of file: ./index.xeb
				-- line: 75 row: 54 of file: ./index.xeb
			end
				-- line: 76 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 76 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 77 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 76 row: 57 of file: ./index.xeb
				-- line: 76 row: 57 of file: ./index.xeb
			if attached {STRING} webapp.is_disabled.out as l_text then 
				-- line: 76 row: 57 of file: ./index.xeb
			response.append (l_text)
				-- line: 76 row: 57 of file: ./index.xeb
				-- line: 76 row: 57 of file: ./index.xeb
			else
				-- line: 76 row: 57 of file: ./index.xeb
			response.append (webapp.is_disabled.out.out)
				-- line: 76 row: 57 of file: ./index.xeb
				-- line: 76 row: 57 of file: ./index.xeb
			end
				-- line: 76 row: 59 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_45)
				-- line: 76 row: 155 of file: ./index.xeb
				-- line: 76 row: 155 of file: ./index.xeb
				-- line: 76 row: 155 of file: ./index.xeb
			l_temp_12 := unique_id
				-- line: 76 row: 155 of file: ./index.xeb
				-- line: 76 row: 155 of file: ./index.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_0']['" + l_temp_12+ "'].value='" + l_temp_12+ "'; document.forms['l_temp_0'].submit(); return false;%">on</a><input type=%"hidden%" name =%"" + l_temp_12+ "%" />")
				-- line: 76 row: 155 of file: ./index.xeb
				-- line: 76 row: 155 of file: ./index.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 76 row: 155 of file: ./index.xeb
				-- line: 76 row: 155 of file: ./index.xeb
			l_agent_table [l_temp_12] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 76 row: 155 of file: ./index.xeb
				-- line: 76 row: 155 of file: ./index.xeb
			controller_1.disable_webapp (a_object)
				-- line: 76 row: 155 of file: ./index.xeb
				-- line: 76 row: 155 of file: ./index.xeb
			end (?, webapp.app_config.name.value.out) -- COMMAND_LINK_TAG
				-- line: 76 row: 155 of file: ./index.xeb
				-- line: 76 row: 155 of file: ./index.xeb
			end
				-- line: 76 row: 158 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_37)
				-- line: 76 row: 254 of file: ./index.xeb
				-- line: 76 row: 254 of file: ./index.xeb
				-- line: 76 row: 254 of file: ./index.xeb
			l_temp_14 := unique_id
				-- line: 76 row: 254 of file: ./index.xeb
				-- line: 76 row: 254 of file: ./index.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_0']['" + l_temp_14+ "'].value='" + l_temp_14+ "'; document.forms['l_temp_0'].submit(); return false;%">off</a><input type=%"hidden%" name =%"" + l_temp_14+ "%" />")
				-- line: 76 row: 254 of file: ./index.xeb
				-- line: 76 row: 254 of file: ./index.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 76 row: 254 of file: ./index.xeb
				-- line: 76 row: 254 of file: ./index.xeb
			l_agent_table [l_temp_14] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 76 row: 254 of file: ./index.xeb
				-- line: 76 row: 254 of file: ./index.xeb
			controller_1.enable_webapp (a_object)
				-- line: 76 row: 254 of file: ./index.xeb
				-- line: 76 row: 254 of file: ./index.xeb
			end (?, webapp.app_config.name.value.out) -- COMMAND_LINK_TAG
				-- line: 76 row: 254 of file: ./index.xeb
				-- line: 76 row: 254 of file: ./index.xeb
			end
				-- line: 76 row: 255 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_46)
				-- line: 77 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 77 row: 5 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_59)
				-- line: 78 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 77 row: 54 of file: ./index.xeb
				-- line: 77 row: 54 of file: ./index.xeb
			if attached {STRING} webapp.dev_mode.out as l_text then 
				-- line: 77 row: 54 of file: ./index.xeb
			response.append (l_text)
				-- line: 77 row: 54 of file: ./index.xeb
				-- line: 77 row: 54 of file: ./index.xeb
			else
				-- line: 77 row: 54 of file: ./index.xeb
			response.append (webapp.dev_mode.out.out)
				-- line: 77 row: 54 of file: ./index.xeb
				-- line: 77 row: 54 of file: ./index.xeb
			end
				-- line: 77 row: 56 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_45)
				-- line: 77 row: 156 of file: ./index.xeb
				-- line: 77 row: 156 of file: ./index.xeb
				-- line: 77 row: 156 of file: ./index.xeb
			l_temp_16 := unique_id
				-- line: 77 row: 156 of file: ./index.xeb
				-- line: 77 row: 156 of file: ./index.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_0']['" + l_temp_16+ "'].value='" + l_temp_16+ "'; document.forms['l_temp_0'].submit(); return false;%">on</a><input type=%"hidden%" name =%"" + l_temp_16+ "%" />")
				-- line: 77 row: 156 of file: ./index.xeb
				-- line: 77 row: 156 of file: ./index.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 77 row: 156 of file: ./index.xeb
				-- line: 77 row: 156 of file: ./index.xeb
			l_agent_table [l_temp_16] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 77 row: 156 of file: ./index.xeb
				-- line: 77 row: 156 of file: ./index.xeb
			controller_1.dev_mode_on_webapp (a_object)
				-- line: 77 row: 156 of file: ./index.xeb
				-- line: 77 row: 156 of file: ./index.xeb
			end (?, webapp.app_config.name.value.out) -- COMMAND_LINK_TAG
				-- line: 77 row: 156 of file: ./index.xeb
				-- line: 77 row: 156 of file: ./index.xeb
			end
				-- line: 77 row: 159 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_37)
				-- line: 77 row: 261 of file: ./index.xeb
				-- line: 77 row: 261 of file: ./index.xeb
				-- line: 77 row: 261 of file: ./index.xeb
			l_temp_18 := unique_id
				-- line: 77 row: 261 of file: ./index.xeb
				-- line: 77 row: 261 of file: ./index.xeb
			response.append ("<a href=%"#%" onclick=%"document.forms['l_temp_0']['" + l_temp_18+ "'].value='" + l_temp_18+ "'; document.forms['l_temp_0'].submit(); return false;%">off</a><input type=%"hidden%" name =%"" + l_temp_18+ "%" />")
				-- line: 77 row: 261 of file: ./index.xeb
				-- line: 77 row: 261 of file: ./index.xeb
			if attached agent_table ["l_temp_0"] as l_agent_table then
				-- line: 77 row: 261 of file: ./index.xeb
				-- line: 77 row: 261 of file: ./index.xeb
			l_agent_table [l_temp_18] := agent (a_request: XH_REQUEST; a_object: detachable ANY) do
				-- line: 77 row: 261 of file: ./index.xeb
				-- line: 77 row: 261 of file: ./index.xeb
			controller_1.dev_mode_off_webapp (a_object)
				-- line: 77 row: 261 of file: ./index.xeb
				-- line: 77 row: 261 of file: ./index.xeb
			end (?, webapp.app_config.name.value.out) -- COMMAND_LINK_TAG
				-- line: 77 row: 261 of file: ./index.xeb
				-- line: 77 row: 261 of file: ./index.xeb
			end
				-- line: 77 row: 262 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_46)
				-- line: 78 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 79 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_61)
				-- line: 80 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 80 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
			l_temp_10.forth
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
			end -- if attached webapp
				-- line: 81 row: 1 of file: ./index.xeb
				-- line: 81 row: 1 of file: ./index.xeb
			end -- from l_temp_10
				-- line: 81 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 82 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_39)
				-- line: 84 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 85 row: 1 of file: ./index.xeb
				-- line: 85 row: 1 of file: ./index.xeb
			response.append("<input type=%"hidden%" name=%"l_temp_0%" value=%""+l_temp_0+"%" />")
				-- line: 85 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_62)
				-- line: 85 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 86 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 86 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 89 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 87 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 88 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_64)
				-- line: 87 row: 43 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 88 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 88 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 89 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 89 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 90 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 90 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 91 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_65)
				-- line: 91 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 92 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_66)
		end

	clean_up_after_render (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		do
		end

	fill_bean (a_request: XH_REQUEST): BOOLEAN
			--<Precursor>
		do
			Result := True
				-- no debug information
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
