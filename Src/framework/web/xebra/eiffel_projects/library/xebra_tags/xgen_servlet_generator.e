note
	description: "Summary description for {SERVLET_GENERATOR}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XGEN_SERVLET_GENERATOR

feature --

	path: STRING
		-- Path to which the servlet is generated

	servlet_name: STRING
		-- The name of the servlet

	stateful: BOOLEAN
		-- Is the servlet stateful?

	internal_root_tag: XTAG_TAG_SERIALIZER
		-- root_tag cache

	controller_id_table: HASH_TABLE [STRING, STRING]
		-- All the used controllers and their respective class. Key: identifier; Value: Class

	make (a_path, a_servlet_name: STRING; a_controller_id_table: HASH_TABLE [STRING, STRING])
		require
			path_is_not_empty: not a_path.is_empty
		do
			path := a_path
			servlet_name := a_servlet_name
			internal_root_tag := get_root_tag
			controller_id_table := a_controller_id_table
		end

	build_make_for_servlet_generator (a_class: XEL_SERVLET_CLASS_ELEMENT)
			-- Serializes the request feature of the {SERVLET}
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
		do
			a_root_tag.generate (a_class, create {HASH_TABLE [STRING, STRING]}.make (5))
		end

	generate
			--
		local
			buf: XU_INDENDATION_STREAM
			servlet_class: XEL_SERVLET_CLASS_ELEMENT
			file: PLAIN_TEXT_FILE
			l_filename: STRING

		do
			l_filename := path + Generator_Prefix.as_lower + servlet_name.as_lower + "_servlet.e"
			create file.make (l_filename)
			if not file.is_creatable then
				print ("ERROR file is not writable '" + l_filename + "'") --FIXME: proper error handling, l_ local vars
			end
			file.open_write
			if not file.is_open_write then
				print ("ERROR cannot open file '" + l_filename + "'") --FIXME: proper error handling, l_ local vars
			end
			create buf.make (file)
			create servlet_class.make (Generator_Prefix.as_upper + servlet_name.as_upper + "_SERVLET")
			if stateful then
				servlet_class.set_inherit (Stateful_servlet_class)
			else
				servlet_class.set_inherit (Stateless_servlet_class)
			end
			servlet_class.set_inherit (Stateless_servlet_class + " redefine make end")
			servlet_class.set_constructor_name ("make")
			build_make_for_servlet_generator (servlet_class)
			from
				controller_id_table.start
			until
				controller_id_table.after
			loop
				servlet_class.add_variable_by_name_type (controller_id_table.key_for_iteration, controller_id_table.item_for_iteration)
				controller_id_table.forth
			end
			--servlet_class.add_feature (build_internal_controller_for_servlet)
			servlet_class.add_variable_by_name_type ("internal_controllers", "LIST [XWA_CONTROLLER]")
			build_handle_request_feature_for_servlet (servlet_class, internal_root_tag)
			servlet_class.serialize (buf)
			file.close

		end

	get_root_tag: XTAG_TAG_SERIALIZER
			-- Returns the root tag of the compiled xeb file
		deferred
		end

feature --Constants

	Stateful_servlet_class: STRING = "XWA_STATEFUL_SERVLET"
	Stateless_servlet_class: STRING = "XWA_STATELESS_SERVLET"

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
