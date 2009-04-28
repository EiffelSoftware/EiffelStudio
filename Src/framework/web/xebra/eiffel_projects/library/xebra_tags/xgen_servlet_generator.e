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

	controller_types: LIST [STRING]
		-- All the used controllers (main page and subpages)

	make (a_path, a_servlet_name: STRING; a_stateful: BOOLEAN; a_controller_types: LIST [STRING])
		require
			path_is_not_empty: not a_path.is_empty
		do
			path := a_path
			servlet_name := a_servlet_name
			stateful := a_stateful
			controller_types := a_controller_types
		end

	build_make_for_servlet_generator (a_class: XEL_SERVLET_CLASS_ELEMENT)
			-- Serializes the request feature of the {SERVLET}
		do
			a_class.make_feature.append_expression ("Precursor")
			from
				controller_types.start
			until
				controller_types.after
			loop
				a_class.make_feature.append_expression ("create controller.make")	
				controller_types.forth
			end
		end

	build_internal_controller_for_servlet: XEL_FEATURE_ELEMENT
			-- Serializes the request feature of the {SERVLET}
		do
			create Result.make ("internal_controller: XWA_CONTROLLER")
			Result.append_expression ("Result := controller")
		end

	build_handle_request_feature_for_servlet (a_class: XEL_SERVLET_CLASS_ELEMENT; root_tag: XTAG_TAG_SERIALIZER)
			-- Serializes the request feature of the {SERVLET}		
		do
			root_tag.generate (a_class, create {HASH_TABLE [STRING, STRING]}.make (10))
		end

	generate
			--
		local
			buf: XU_INDENDATION_STREAM
			servlet_class: XEL_SERVLET_CLASS_ELEMENT
			file: PLAIN_TEXT_FILE
		do
			create file.make_open_write (path + servlet_name.as_lower + "_g_servlet.e")
			create buf.make (file)
			create servlet_class.make (servlet_name.as_upper + "_G_SERVLET")
			if stateful then
				servlet_class.set_inherit (Stateful_servlet_class)
			else
				servlet_class.set_inherit (Stateless_servlet_class)
			end
			servlet_class.set_inherit (Stateless_servlet_class + " redefine make end")
			servlet_class.set_constructor_name ("make")
			from
				controller_types.start
			until
				controller_types.after
			loop
				servlet_class.add_variable_by_name_type ("controller", controller_types.item)
				controller_types.forth
			end
			build_make_for_servlet_generator (servlet_class)
			servlet_class.add_feature (build_internal_controller_for_servlet)
			build_handle_request_feature_for_servlet (servlet_class, get_root_tag)
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
