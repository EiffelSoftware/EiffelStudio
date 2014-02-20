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
			create controller_1.make
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
		end

	render_html_page (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		local
			loop_index: NATURAL
			l_temp_0: NATURAL
			l_temp_1: LIST [STRING]
			doc_url: STRING
			aplusb: STRING
		do
				-- line: 140 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_0)
				-- line: 2 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 3 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 32 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_2)
				-- line: 4 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 31 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_3)
				-- line: 30 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 31 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_5)
				-- line: 31 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 32 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 32 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 139 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_7)
				-- line: 33 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 34 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_8)
				-- line: 33 row: 40 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_9)
				-- line: 34 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_10)
				-- line: 35 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_11)
				-- line: 43 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 36 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_13)
				-- line: 35 row: 64 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_14)
				-- line: 36 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 36 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 39 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 38 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 39 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 39 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 42 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 40 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 41 row: 1 of file: ./index.xeb
			response.append ("This is a text")
				-- line: 41 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 42 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 42 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 43 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 44 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_11)
				-- line: 63 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 45 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_13)
				-- line: 44 row: 65 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_20)
				-- line: 45 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 45 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 52 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 51 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_21)
				-- line: 52 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 52 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 58 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 57 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_23)
				-- line: 58 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 58 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 62 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 59 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 60 row: 1 of file: ./index.xeb
				-- line: 60 row: 1 of file: ./index.xeb
			if attached {STRING} controller_1.the_text as l_text then 
				-- line: 60 row: 1 of file: ./index.xeb
			response.append (l_text)
				-- line: 60 row: 1 of file: ./index.xeb
				-- line: 60 row: 1 of file: ./index.xeb
			else
				-- line: 60 row: 1 of file: ./index.xeb
			response.append (controller_1.the_text.out)
				-- line: 60 row: 1 of file: ./index.xeb
				-- line: 60 row: 1 of file: ./index.xeb
			end
				-- line: 60 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 61 row: 1 of file: ./index.xeb
				-- line: 61 row: 1 of file: ./index.xeb
			if attached {STRING} controller_1.xebra_documentation_url as l_text then 
				-- line: 61 row: 1 of file: ./index.xeb
			response.append (l_text)
				-- line: 61 row: 1 of file: ./index.xeb
				-- line: 61 row: 1 of file: ./index.xeb
			else
				-- line: 61 row: 1 of file: ./index.xeb
			response.append (controller_1.xebra_documentation_url.out)
				-- line: 61 row: 1 of file: ./index.xeb
				-- line: 61 row: 1 of file: ./index.xeb
			end
				-- line: 61 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 62 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 62 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 63 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 64 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_11)
				-- line: 81 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 65 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_13)
				-- line: 64 row: 61 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_24)
				-- line: 65 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 65 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 72 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 71 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_25)
				-- line: 72 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 73 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_26)
				-- line: 80 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 74 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 79 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_28)
				-- line: 75 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 78 row: 1 of file: ./index.xeb
				-- line: 78 row: 1 of file: ./index.xeb
				-- line: 78 row: 1 of file: ./index.xeb
				-- line: 78 row: 1 of file: ./index.xeb
			from
				-- line: 78 row: 1 of file: ./index.xeb
				-- line: 78 row: 1 of file: ./index.xeb
			l_temp_0 := 1
				-- line: 78 row: 1 of file: ./index.xeb
				-- line: 78 row: 1 of file: ./index.xeb
			until
				-- line: 78 row: 1 of file: ./index.xeb
				-- line: 78 row: 1 of file: ./index.xeb
			l_temp_0 > 5
				-- line: 78 row: 1 of file: ./index.xeb
				-- line: 78 row: 1 of file: ./index.xeb
			loop
				-- line: 78 row: 1 of file: ./index.xeb
				-- line: 78 row: 1 of file: ./index.xeb
			loop_index := l_temp_0
				-- line: 76 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 77 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 76 row: 13 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_30)
				-- line: 76 row: 53 of file: ./index.xeb
				-- line: 76 row: 53 of file: ./index.xeb
			if attached {STRING} loop_index.out as l_text then 
				-- line: 76 row: 53 of file: ./index.xeb
			response.append (l_text)
				-- line: 76 row: 53 of file: ./index.xeb
				-- line: 76 row: 53 of file: ./index.xeb
			else
				-- line: 76 row: 53 of file: ./index.xeb
			response.append (loop_index.out.out)
				-- line: 76 row: 53 of file: ./index.xeb
				-- line: 76 row: 53 of file: ./index.xeb
			end
				-- line: 77 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 77 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 78 row: 1 of file: ./index.xeb
				-- line: 78 row: 1 of file: ./index.xeb
			l_temp_0 := l_temp_0 + 1
				-- line: 78 row: 1 of file: ./index.xeb
				-- line: 78 row: 1 of file: ./index.xeb
			end
				-- line: 78 row: 4 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_27)
				-- line: 79 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_32)
				-- line: 79 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 80 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 80 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 81 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 83 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 108 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 84 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_13)
				-- line: 83 row: 64 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_34)
				-- line: 84 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 84 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 91 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 90 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_35)
				-- line: 91 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 91 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 100 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 99 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_36)
				-- line: 100 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 100 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 107 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 101 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 106 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_37)
				-- line: 102 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
			l_temp_1 := controller_1.my_items
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
			from --l_temp_1
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
			l_temp_1.start
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
			until
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
			l_temp_1.after
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
			loop
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
			if attached {STRING} l_temp_1.item as entry then
				-- line: 103 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 104 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_29)
				-- line: 103 row: 38 of file: ./index.xeb
				-- line: 103 row: 38 of file: ./index.xeb
			if attached {STRING} entry as l_text then 
				-- line: 103 row: 38 of file: ./index.xeb
			response.append (l_text)
				-- line: 103 row: 38 of file: ./index.xeb
				-- line: 103 row: 38 of file: ./index.xeb
			else
				-- line: 103 row: 38 of file: ./index.xeb
			response.append (entry.out)
				-- line: 103 row: 38 of file: ./index.xeb
				-- line: 103 row: 38 of file: ./index.xeb
			end
				-- line: 104 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_31)
				-- line: 104 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
			l_temp_1.forth
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
			end -- if attached entry
				-- line: 105 row: 1 of file: ./index.xeb
				-- line: 105 row: 1 of file: ./index.xeb
			end -- from l_temp_1
				-- line: 105 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 106 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_38)
				-- line: 106 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 107 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 107 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 108 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 110 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 123 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 111 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_13)
				-- line: 110 row: 69 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_39)
				-- line: 111 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 111 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 115 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 114 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_40)
				-- line: 115 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 115 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 118 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_22)
				-- line: 117 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_41)
				-- line: 118 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 118 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 122 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 119 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 120 row: 1 of file: ./index.xeb
				-- line: 120 row: 1 of file: ./index.xeb
				-- line: 120 row: 1 of file: ./index.xeb
			doc_url := controller_1.xebra_documentation_url
				-- line: 120 row: 36 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_42)
				-- line: 121 row: 1 of file: ./index.xeb
			response.append ("<a href=%""+doc_url+"%">")
				-- line: 120 row: 89 of file: ./index.xeb
				-- line: 120 row: 89 of file: ./index.xeb
			if attached {STRING} doc_url as l_text then 
				-- line: 120 row: 89 of file: ./index.xeb
			response.append (l_text)
				-- line: 120 row: 89 of file: ./index.xeb
				-- line: 120 row: 89 of file: ./index.xeb
			else
				-- line: 120 row: 89 of file: ./index.xeb
			response.append (doc_url.out)
				-- line: 120 row: 89 of file: ./index.xeb
				-- line: 120 row: 89 of file: ./index.xeb
			end
				-- line: 120 row: 90 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_43)
				-- line: 121 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_44)
				-- line: 121 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 122 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 122 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 123 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 124 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_11)
				-- line: 136 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 125 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_13)
				-- line: 124 row: 63 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_45)
				-- line: 125 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 125 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 130 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 129 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_46)
				-- line: 130 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 130 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 135 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_19)
				-- line: 131 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 132 row: 1 of file: ./index.xeb
				-- line: 132 row: 1 of file: ./index.xeb
				-- line: 132 row: 1 of file: ./index.xeb
			aplusb := "PLUS"
				-- line: 132 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 133 row: 1 of file: ./index.xeb
				-- line: 133 row: 1 of file: ./index.xeb
			aplusb := "a" + aplusb + "b"
				-- line: 133 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 134 row: 1 of file: ./index.xeb
				-- line: 134 row: 1 of file: ./index.xeb
			if attached {STRING} aplusb as l_text then 
				-- line: 134 row: 1 of file: ./index.xeb
			response.append (l_text)
				-- line: 134 row: 1 of file: ./index.xeb
				-- line: 134 row: 1 of file: ./index.xeb
			else
				-- line: 134 row: 1 of file: ./index.xeb
			response.append (aplusb.out)
				-- line: 134 row: 1 of file: ./index.xeb
				-- line: 134 row: 1 of file: ./index.xeb
			end
				-- line: 134 row: 3 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 135 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 135 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 136 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 138 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_33)
				-- line: 139 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_47)
				-- line: 139 row: 2 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_1)
				-- line: 140 row: 1 of file: ./index.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_48)
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
