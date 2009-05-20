note
	description: "Summary description for {SERVLET_GENERATOR}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XGEN_SERVLET_GENERATOR

inherit
	XU_SHARED_OUTPUTTER
	ERROR_SHARED_MULTI_ERROR_MANAGER

feature -- Initialization

	make (a_path, a_servlet_name: STRING; a_controller_id_table: HASH_TABLE [STRING, STRING]; a_current_file_path: STRING)
		require
			a_path_is_not_valid: attached a_path and not a_path.is_empty
			a_servlet_name_valid: attached a_servlet_name and not a_servlet_name.is_empty
			a_current_file_path_valid: attached a_current_file_path and not a_current_file_path.is_empty
			a_controller_id_table_attached: attached a_controller_id_table
		do
			create path.make_from_string (a_path)
			servlet_name := a_servlet_name
			internal_root_tag := get_root_tag
			controller_id_table := a_controller_id_table
			create current_file_path.make_from_string (a_current_file_path)
		end

feature {NONE} -- Access

	path: FILE_NAME
		-- Path to which the servlet is generated

	servlet_name: STRING
		-- The name of the servlet

	stateful: BOOLEAN
		-- Is the servlet stateful?

	internal_root_tag: XTAG_TAG_SERIALIZER
		-- root_tag cache

	controller_id_table: HASH_TABLE [STRING, STRING]
		-- All the used controllers and their respective class. Key: identifier; Value: Class

	current_file_path: FILE_NAME
		-- The path of Current file

feature -- Access

	get_root_tag: XTAG_TAG_SERIALIZER
			-- Returns the root tag of the compiled xeb file
		deferred
		ensure
			Result_attached: attached Result
		end

feature {NONE} -- Implementation

	build_make_for_servlet_generator (a_class: XEL_SERVLET_CLASS_ELEMENT)
			-- Serializes the request feature of the {SERVLET}
		require
			a_class_attached: attached a_class
		local
			uid: STRING
		do
			a_class.make_feature.append_expression ("Precursor")
			a_class.make_feature.append_expression ("create {ARRAYED_LIST [XWA_CONTROLLER]} internal_controllers.make (" + controller_id_table.count.out + ")")
			from
				controller_id_table.start
			until
				controller_id_table.after
			loop
				a_class.make_feature.append_expression ("create " + controller_id_table.key_for_iteration + ".make")
				a_class.make_feature.append_expression ("internal_controllers.extend (" + controller_id_table.key_for_iteration + ")")
				controller_id_table.forth
			end
		end

	build_handle_request_feature_for_servlet (a_class: XEL_SERVLET_CLASS_ELEMENT; a_root_tag: XTAG_TAG_SERIALIZER)
			-- Serializes the request feature of the {SERVLET}
		require
			a_class_attached: attached a_class
			a_root_tag_attached: attached a_root_tag
		do
			a_root_tag.generate (a_class, create {HASH_TABLE [STRING, STRING]}.make (5))
		end

feature -- Basic Functionality

	generate
			-- Generates a servlet
		local
			l_buf: XU_INDENDATION_STREAM
			l_servlet_class: XEL_SERVLET_CLASS_ELEMENT
			l_file: PLAIN_TEXT_FILE
			l_filename: FILE_NAME
			l_current_file: PLAIN_TEXT_FILE
			l_generate: BOOLEAN
		do
			l_filename := path.twin
			l_filename.set_file_name (Generator_Prefix.as_lower + servlet_name.as_lower + "_servlet.e")
			create l_current_file.make (current_file_path)
			create l_file.make (l_filename)

			if not l_current_file.exists then
				o.iprint ("File does not exist: " + l_current_file.name + ". Regenerating file.")
				l_generate := True
			else
				if not l_file.exists then
					o.iprint ("File does not exist: " + l_file.name + ". Regenerating file.")
					l_generate := True
				else
					if (l_current_file.date > l_file.date) then
						o.iprint ("File outdated: " + l_file.name + ". Regenerating file.")
						l_generate := True
					end
				end
			end

			if l_generate  then
				o.iprint ("The servlet '" + l_filename + "' is being generated...")

				if not l_file.is_creatable then
					error_manager.add_error (create {XERROR_FILE_NOT_CREATABLE}.make (l_filename), false)
				else
					l_file.open_write
					if not l_file.is_open_write then
						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_filename), false)
					else
						create l_buf.make (l_file)
						create l_servlet_class.make (Generator_Prefix.as_upper + servlet_name.as_upper + "_SERVLET")
						l_servlet_class.set_inherit (Servlet_class_name + " redefine make end")
						l_servlet_class.set_constructor_name ("make")
						build_make_for_servlet_generator (l_servlet_class)
						from
							controller_id_table.start
						until
							controller_id_table.after
						loop
							l_servlet_class.add_variable_by_name_type (controller_id_table.key_for_iteration, controller_id_table.item_for_iteration)
							controller_id_table.forth
						end
						l_servlet_class.add_variable_by_name_type ("internal_controllers", "LIST [XWA_CONTROLLER]")
						build_handle_request_feature_for_servlet (l_servlet_class, internal_root_tag)
						l_servlet_class.serialize (l_buf)
						l_file.close
						o.iprint ("done.")
					end
				end

			else
				o.iprint ("Already up to date : " + l_filename)
			end
		end

feature --Constants

	Stateful_servlet_class: STRING = "XWA_STATEFUL_SERVLET"
	Stateless_servlet_class: STRING = "XWA_STATELESS_SERVLET"
	servlet_class_name: STRING = "XWA_SERVLET"

	Constructor_name: STRING = "make"
	Response_name: STRING = "response"
	Generator_Prefix: STRING = "g_"

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
