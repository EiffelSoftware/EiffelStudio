note
	description: "[
		{XGEN_XRPC_SERVLET_GENERATOR}.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XGEN_XRPC_SERVLET_GENERATOR

inherit
	XGEN_SERVLET_GENERATOR
		redefine
			generate
		end

feature -- Initialization

	make_xrpc (a_path, a_servlet_name: STRING; a_controller_id_table: HASH_TABLE [TUPLE [class_name: STRING; creator: STRING], STRING]; a_current_file_path: STRING;
				a_constants_class: XEL_CONSTANTS_CLASS_ELEMENT; a_api_class_name: STRING)
			-- Precursor
		require
			a_api_class_name_attached: attached a_api_class_name
		do
			make (a_path, a_servlet_name, a_controller_id_table, a_current_file_path, a_constants_class)
			api_class_name := a_api_class_name
		end

feature -- Access

	api_class_name: STRING
			-- The class name of the api

feature -- Implementation

	generate
			-- <Precursor>
		local
			l_buf: XU_INDENDATION_FORMATTER
			l_servlet_class: XEL_XRPC_CLASS_ELEMENT
			l_filename: FILE_NAME
			l_current_file: PLAIN_TEXT_FILE
			l_generate: BOOLEAN
			l_servlets_directory: DIRECTORY
			l_util: XU_FILE_UTILITIES
			l_executed_filename: FILE_NAME
		do
			l_filename := path.twin
			l_filename.extend ({XU_CONSTANTS}.Generated_folder_name)
			create l_servlets_directory.make (l_filename)
			if not l_servlets_directory.exists then
				l_servlets_directory.create_dir
			end
			l_filename.extend ({XU_CONSTANTS}.Servlets_folder_name)
			create l_servlets_directory.make (l_filename)
			if not l_servlets_directory.exists then
				l_servlets_directory.create_dir
			debug
				end
			end

			l_filename.set_file_name (Generator_Prefix.as_lower + servlet_name.as_lower + "_xrpc_servlet.e")
			create l_current_file.make (current_file_path)
			create l_util
			if attached l_util.plain_text_file_write (l_filename) as l_file then
				log.iprint ("The xrpc_servlet '" + l_filename + "' is being generated...")
				create l_buf.make (l_file)
				create l_servlet_class.make_with_constants (Generator_Prefix.as_upper + servlet_name.as_upper + "_SERVLET", constants_class)
				l_servlet_class.set_inherit (Servlet_xrpc_class_name + " [" + api_class_name + "] redefine namespace end")
				l_servlet_class.set_constructor_name ("make")
				build_handle_request_feature_for_servlet (l_servlet_class, root_tag)
				l_servlet_class.serialize (l_buf)
				l_util.close
				log.iprint ("done.")
			end
			l_executed_filename := path.twin
			l_executed_filename.extend ({XU_CONSTANTS}.Generated_folder_name)
			l_executed_filename.set_file_name ({XU_CONSTANTS}.Servlet_gen_executed_file)
			if attached {PLAIN_TEXT_FILE} l_util.plain_text_file_write (l_executed_filename) as l_file then
				l_file.put_string ("File generated for server xebra server")
				l_util.close
			end
		end

feature -- Implement

	Servlet_xrpc_class_name: STRING = "XWA_XRPC_SERVLET"

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
