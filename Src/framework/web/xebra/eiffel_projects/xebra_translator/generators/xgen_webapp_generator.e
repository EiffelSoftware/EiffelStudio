note
	description: "[
		Generates and links all the needed classes for a web application.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XGEN_WEBAPP_GENERATOR

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

create
	make, make_with_servlets

feature {NONE} -- Initialization

	make (a_name: STRING;a_path: FILE_NAME)
			-- `a_name': The name of the web application
			-- `a_path': The path, where all the classes should be generated
		require
			a_name_attached: a_name /= Void
			a_path_attached: a_path /= Void
			a_name_is_not_empty: not a_name.is_empty
			a_path_is_not_empty: not a_path.is_empty
		do
			make_with_servlets (a_name, a_path, create {LINKED_LIST [XGEN_SERVLET_GENERATOR_GENERATOR]}.make)
		end

	make_with_servlets (a_name: STRING; a_path: FILE_NAME; a_servlets: LIST [XGEN_SERVLET_GENERATOR_GENERATOR])
			-- `a_name': The name of the web application
			-- `a_path': The path, where all the classes should be generated
			-- `a_servlets': List of the servlet generator generators for the webapp
		require
			a_servlets_attached: a_servlets /= Void
			a_name_attached: a_name /= Void
			a_path_attached: a_path /= Void
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

	path: FILE_NAME
			-- The path where the classes should be generated

	servlets: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]
			-- All the parsed servlets

	put_servlet_generator_generators (a_servlet_gg: LIST [XGEN_SERVLET_GENERATOR_GENERATOR])
			-- Adds a servlet to the list
		require
			a_servlet_gg_attached: a_servlet_gg /= Void
		do
			servlets := a_servlet_gg
		ensure
			servlets_set: servlets = a_servlet_gg
		end

feature -- Basic Functionality

	generate
			-- Generates all the classes (except the servlets) for the webapp and links them together.
			--  1. {XWA_SERVER_CONNECTION_HANDLER}
			--  2. {APPLICATION} which starts the application
			--  3. {G_SHARED_X_GLOBAL_STATE} which contains global state of the application
		require
			path_is_not_empty: not path.is_empty
			webapp_name_is_not_empty: not webapp_name.is_empty
		local
			l_buf:XU_INDENDATION_FORMATTER
			l_request_class: XEL_CLASS_ELEMENT
			l_application_class: XEL_CLASS_ELEMENT
			l_filename: FILE_NAME
			l_directory: DIRECTORY
			l_util: XU_FILE_UTILITIES
		do
				-- Generate the {XWA_SERVER_CONNECTION_HANDLER} class
			l_filename := path.twin
			l_filename.extend ({XU_CONSTANTS}.generated_folder_name)
			create l_directory.make (l_filename)
			if not l_directory.exists then
				l_directory.create_dir
			end

			l_filename.set_file_name (Generator_Prefix.as_lower + webapp_name.as_lower + "_" + Server_con_handler_class.as_lower + ".e")

			create l_util
			if attached l_util.plain_text_file_write (l_filename) as l_file then
				create l_buf.make (l_file)
				l_buf.set_ind_character ('%T')
				create l_request_class.make (Generator_Prefix.as_upper + webapp_name.as_upper + "_" + Server_con_handler_class)
				l_request_class.set_inherit ("XWA_" + Server_con_handler_class)
				l_request_class.set_constructor_name ("make")
				l_request_class.add_feature (generate_constructor_for_server_conn_handler (servlets))
				l_request_class.serialize (l_buf)
				l_util.close
			end

				-- Generate the {APPLICATION} class
			l_filename := path.twin
			l_filename.extend ({XU_CONSTANTS}.generated_folder_name)
			l_filename.set_file_name (Generator_Prefix.as_lower + webapp_name.as_lower + "_application.e")

			create l_util
			if attached l_util.plain_text_file_write (l_filename) as l_file then
				create l_buf.make (l_file)
				create l_application_class.make (Generator_Prefix.as_upper + webapp_name.as_upper + "_APPLICATION")
				l_application_class.set_inherit ("XWA_APPLICATION")
				l_application_class.set_constructor_name ("make")
				l_application_class.add_feature (generate_contructor_for_application)
				l_application_class.serialize (l_buf)
				l_util.close
			end

				-- Generate the {G_SHARED_X_GLOBAL_STATE} class
			l_filename := path.twin
			l_filename.extend ({XU_CONSTANTS}.generated_folder_name)
			l_filename.set_file_name (Generator_Prefix.as_lower + "shared_" + webapp_name.as_lower + "_global_state.e")

			create l_util
			if attached l_util.plain_text_file_write (l_filename) as l_file then
				create l_buf.make (l_file)
				create l_application_class.make (Generator_Prefix.as_upper + "SHARED_" + webapp_name.as_upper + "_GLOBAL_STATE")
				l_application_class.set_inherit ("ANY")
				l_application_class.add_feature (generate_once_feature_for_global_state)
				l_application_class.serialize (l_buf)
				l_util.close
			end
		end

feature {NONE} -- Implementation

	generate_once_feature_for_global_state: XEL_FEATURE_ELEMENT
			-- Builds the global state feature
		do
			create Result.make ("global_state: " + webapp_name.as_upper + "_GLOBAL_STATE")
			Result.set_once
			Result.append_expression ("create Result.make")
		ensure
			result_attached: attached Result
		end

	generate_contructor_for_application: XEL_FEATURE_ELEMENT
			-- Generates the constructor for the application
		do
			create Result.make ("initialize_server_connection_handler")
			Result.append_expression ("create " + "{" + Generator_Prefix.as_upper + webapp_name.as_upper + "_" + Server_con_handler_class + "} server_connection_handler.make")
		ensure
			result_attached: attached Result
		end

	generate_constructor_for_server_conn_handler (some_servlets: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]): XEL_FEATURE_ELEMENT
			-- Generates the constructor for the request handler
		require
			some_servlets_attached: attached some_servlets
		local
			l_servlet: XGEN_SERVLET_GENERATOR_GENERATOR
			l_postfix: STRING
			l_cursor: INTEGER
		do
			create Result.make ("add_servlets")
			from
				l_cursor := some_servlets.index
				some_servlets.start
			until
				some_servlets.after
			loop
				l_servlet := some_servlets.item
				if l_servlet.is_generated then
					if l_servlet.is_xrpc then
						l_postfix := ".xrpc"
					else
						l_postfix := ".xeb"
					end
					Result.append_expression ("stateless_servlets.put (create {"
						+ Generator_Prefix.as_upper + l_servlet.servlet_name.as_upper + "_SERVLET}.make, %"/" + webapp_name.as_lower + "/" + transform_to_url (l_servlet.servlet_name.as_lower) + l_postfix + "%")")
					some_servlets.forth
				end
			end
			some_servlets.go_i_th (l_cursor)
		ensure
			result_attached: attached Result
		end

	transform_to_url (a_servlet_name: STRING): STRING
			-- Replaces all underscores by slashes
		do
			Result := a_servlet_name.twin
			Result.replace_substring_all ({XU_CONSTANTS}.Folder_replacement_string, "/")
		end

feature {NONE} -- Constants

	Server_con_handler_class: STRING = "SERVER_CONN_HANDLER"
	Generator_Prefix: STRING = "g_"

invariant
	webapp_name_attached: webapp_name /= Void
	path_attached: path /= Void
	servlets_attached: servlets /= Void
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
