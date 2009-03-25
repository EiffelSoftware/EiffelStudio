note
	description: "[
		Generates and links all the needed classes for a web application.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEBAPP_GENERATOR

create
	make

feature -- Access

	webapp_name: STRING
			-- Defines the name of the web application

	path: STRING
			-- The path where the classes should be generated

	servlets: LIST [ROOT_SERVLET_ELEMENT]
			-- All the parsed servlets

	put_servlet (servlet: ROOT_SERVLET_ELEMENT)
			-- Adds a servlet to the list
		do
			servlets.extend (servlet)
		end

feature -- Initialization

	make (a_name, a_path: STRING)
			-- `a_name': The name of the web application
			-- `a_path': The path, where all the classes should be generated
		do
			webapp_name := a_name
			path := a_path
			create {LINKED_LIST [ROOT_SERVLET_ELEMENT]} servlets.make
		end

feature -- Processing

	generate
			-- Generates all the classes for the webapp and links them together.
			--  1. {SERVLET} for every xeb-page
			--  2. {REQUEST_HANDLER}
			--  3. {APPLICATION} which starts the application
		local
			buf: INDENDATION_STREAM
			servlet: ROOT_SERVLET_ELEMENT
			request_class: CLASS_ELEMENT
			application_class: CLASS_ELEMENT
			file: PLAIN_TEXT_FILE
		do
				-- Generate all the {SERVLET} classes
			from
				servlets.start
			until
				servlets.after
			loop
				servlet := servlets.item
				create file.make_open_write (path + servlet.name.as_lower + ".e")
				create buf.make (file)
				buf.set_ind_character ('%T')
				servlet.serialize (buf)
				servlets.forth
				file.close
			end

				-- Generate the {REQUEST_HANDLER} class
			webapp_name.to_lower
			create file.make_open_write (path + webapp_name + "_request_handler.e")
			create buf.make (file)
			buf.set_ind_character ('%T')
			webapp_name.to_upper
			create request_class.make (webapp_name + "_REQUEST_HANDLER")
			request_class.set_inherit ("REQUEST_HANDLER")
			request_class.set_constructor_name ("make")
			request_class.add_feature (generate_constructor_for_request_handler (servlets))
			request_class.serialize (buf)
			file.close

				-- Generate the {APPLICATION} class
			create file.make_open_write (path + webapp_name.as_lower + "_application.e")
			create buf.make (file)
			buf.set_ind_character ('%T')
			create application_class.make (webapp_name.as_upper + "_APPLICATION")
			application_class.set_constructor_name ("make")
			application_class.add_feature (generate_contructor_for_application)
			application_class.serialize (buf)
			file.close

		end

	generate_contructor_for_application: FEATURE_ELEMENT
			-- Generates the constructor for the application
		local
			constructor: FEATURE_ELEMENT
			feature_body: LIST [SERVLET_ELEMENT]
			locals: LIST [VARIABLE_ELEMENT]
			request_handler_local: VARIABLE_ELEMENT
		do
			create {LINKED_LIST [SERVLET_ELEMENT]} feature_body.make
			feature_body.extend (wrap ("create request_handler.make"))
			feature_body.extend (wrap ("request_handler.run"))
			create request_handler_local.make ("request_handler", webapp_name.as_upper + "_REQUEST_HANDLER")
			create {LINKED_LIST [VARIABLE_ELEMENT]} locals.make
			locals.extend (request_handler_local)
			create constructor.make_with_locals ("make", feature_body, locals)
			Result := constructor
		end

	generate_constructor_for_request_handler (some_servlets: LIST [ROOT_SERVLET_ELEMENT]): FEATURE_ELEMENT
			-- Generates the constructor for the request handler
		local
			constructor: FEATURE_ELEMENT
			feature_body: LIST [SERVLET_ELEMENT]
			locals: LIST [VARIABLE_ELEMENT]
			servlet: ROOT_SERVLET_ELEMENT
		do
			create {LINKED_LIST [SERVLET_ELEMENT]} feature_body.make
			feature_body.extend (wrap ("create request_pool.make  (10, agent servlet_handler_spawner)"))
			feature_body.extend (wrap ("create {HASH_TABLE [SESSION, STRING]} session_map.make (5)"))
			feature_body.extend (wrap ("create {HASH_TABLE [STATELESS_SERVLET, STRING]} stateless_servlets.make (5)"))
			from
				some_servlets.start
			until
				some_servlets.after
			loop
				servlet := some_servlets.item
				feature_body.extend (wrap ("stateless_servlets.put (create {"
					+ servlet.name.as_upper + "}.make , %"" + webapp_name.as_lower + "/" + servlet.name.as_lower  + ".xeb%")"))
				some_servlets.forth
			end
			create {ARRAYED_LIST [VARIABLE_ELEMENT]} locals.make (10)
			create constructor.make_with_locals ("make", feature_body, locals)
			Result := constructor
		end

	wrap (code: STRING): PLAIN_CODE_ELEMENT
		do
			create Result.make (code)
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
