note
	description: "[
		Generates and links all the needed classes for a web application.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XGEN_WEBAPP_GENERATOR

create
	make, make_with_servlets

feature {NONE} -- Initialization

	make (a_name, a_path: STRING)
			-- `a_name': The name of the web application
			-- `a_path': The path, where all the classes should be generated
		require
			a_name_is_not_empty: not a_name.is_empty
			a_path_is_not_empty: not a_path.is_empty
		do
			make_with_servlets (a_name, a_path, create {LINKED_LIST [XGEN_SERVLET_GENERATOR_GENERATOR]}.make)
		end

	make_with_servlets (a_name, a_path: STRING; a_servlets: LIST [XGEN_SERVLET_GENERATOR_GENERATOR])
			-- `a_name': The name of the web application
			-- `a_path': The path, where all the classes should be generated
			-- `a_servlets': List of the servlet generator generators for the webapp
		require
			a_name_is_not_empty: not a_name.is_empty
			a_path_is_not_empty: not a_path.is_empty
		do
			servlets := a_servlets
			webapp_name := a_name
			path := a_path
		end

feature -- Access

	webapp_name: STRING
			-- Defines the name of the web application

	path: STRING
			-- The path where the classes should be generated

	servlets: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]
			-- All the parsed servlets

	put_servlet_generator_generators (a_servlet_gg: LIST [XGEN_SERVLET_GENERATOR_GENERATOR])
			-- Adds a servlet to the list
		do
			servlets := a_servlet_gg
		end

feature -- Basic Functionality

	generate
			-- Generates all the classes (except the servlets) for the webapp and links them together.
			--  1. {REQUEST_HANDLER}
			--  2. {APPLICATION} which starts the application
		require
			path_is_not_empty: not path.is_empty
			webapp_name_is_not_empty: not webapp_name.is_empty
		local
			buf:XU_INDENDATION_STREAM
			request_class: XEL_CLASS_ELEMENT
			application_class: XEL_CLASS_ELEMENT
			file: PLAIN_TEXT_FILE
		do
				-- Generate the {REQUEST_HANDLER} class
			webapp_name.to_lower
			create file.make_open_write (path + webapp_name + "_request_handler.e")
			create buf.make (file)
			buf.set_ind_character ('%T')
			webapp_name.to_upper
			create request_class.make (webapp_name + "_REQUEST_HANDLER")
			request_class.set_inherit ("XWA_SERVER_CONN_HANDLER")
			request_class.set_constructor_name ("make")
			request_class.add_feature (generate_constructor_for_request_handler (servlets))
			request_class.serialize (buf)
			file.close

				-- Generate the {APPLICATION} class
			create file.make_open_write (path + webapp_name.as_lower + "_application.e")
			create buf.make (file)
			create application_class.make (webapp_name.as_upper + "_APPLICATION")
			application_class.set_constructor_name ("make")
			application_class.add_feature (generate_contructor_for_application)
			application_class.serialize (buf)
			file.close
		end

feature {NONE} -- Implementation

	generate_contructor_for_application: XEL_FEATURE_ELEMENT
			-- Generates the constructor for the application
		do
			create Result.make ("make")
			Result.append_expression ("create request_handler.make")
			Result.append_expression ("request_handler.run")
			Result.append_local ("request_handler", webapp_name.as_upper + "_REQUEST_HANDLER")
		end

	generate_constructor_for_request_handler (some_servlets: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]): XEL_FEATURE_ELEMENT
			-- Generates the constructor for the request handler
		local
			servlet: XGEN_SERVLET_GENERATOR_GENERATOR
		do
			create Result.make ("make")
			Result.append_expression ("create request_pool.make  (10, agent servlet_handler_spawner)")
			Result.append_expression ("create {HASH_TABLE [XH_SESSION, STRING]} session_map.make (1)")
			Result.append_expression ("create {HASH_TABLE [XWA_STATELESS_SERVLET, STRING]} stateless_servlets.make (1)")
			from
				some_servlets.start
			until
				some_servlets.after
			loop
				servlet := some_servlets.item
				Result.append_expression ("stateless_servlets.put (create {"
					+ servlet.servlet_name.as_upper + "_SERVLET}.make , %"/" + webapp_name.as_lower + "/" + servlet.servlet_name.as_lower  + ".xeb%")")
				some_servlets.forth
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
		]"
end
