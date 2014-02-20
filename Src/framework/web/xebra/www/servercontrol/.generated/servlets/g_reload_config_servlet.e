note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_RELOAD_CONFIG_SERVLET

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
		end

	render_html_page (request: XH_REQUEST; response: XH_RESPONSE)
			--<Precursor>
		do
				-- line: 22 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_67)
				-- line: 2 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 8 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_3)
				-- line: 3 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 4 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_5)
				-- line: 3 row: 29 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 4 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_7)
				-- line: 4 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 5 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 6 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_8)
				-- line: 6 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_9)
				-- line: 6 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 7 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_10)
				-- line: 7 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_11)
				-- line: 7 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 8 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_12)
				-- line: 8 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 21 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_13)
				-- line: 9 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 20 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_14)
				-- line: 10 row: 4 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_68)
				-- line: 13 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_15)
				-- line: 11 row: 6 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 12 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_16)
				-- line: 11 row: 43 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_70)
				-- line: 12 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 12 row: 4 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_68)
				-- line: 13 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 13 row: 4 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_68)
				-- line: 16 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_18)
				-- line: 15 row: 4 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_71)
				-- line: 16 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 16 row: 4 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_68)
				-- line: 19 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_63)
				-- line: 17 row: 6 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_69)
				-- line: 18 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_64)
				-- line: 17 row: 47 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_6)
				-- line: 18 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 18 row: 4 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_68)
				-- line: 19 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 19 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 20 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_17)
				-- line: 20 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 21 row: 1 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_65)
				-- line: 21 row: 2 of file: ./reload_config.xeb
			response.append ({G_SERVLET_CONSTANTS}.class_temp_4)
				-- line: 22 row: 1 of file: ./reload_config.xeb
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
