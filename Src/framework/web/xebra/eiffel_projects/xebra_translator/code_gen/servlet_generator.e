note
	description: "Summary description for {SERVLET_GENERATOR}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SERVLET_GENERATOR

feature --

	path: STRING
	servlet_name: STRING
	stateful: BOOLEAN
	controller_type: STRING

	make (a_path, a_servlet_name: STRING; a_stateful: BOOLEAN; a_controller_type: STRING)
		require
			path_is_not_empty: not a_path.is_empty
		do
			path := a_path
			servlet_name := a_servlet_name
			stateful := a_stateful
			controller_type := a_controller_type
		end

	build_make_for_servlet_generator: FEATURE_ELEMENT
			-- Serializes the request feature of the {SERVLET}
		do
			create Result.make ("make")
			Result.append_expression ("create controller." + constructor_name)
		end

	build_handle_request_feature_for_servlet (root_tag: TAG_SERIALIZER): FEATURE_ELEMENT
			-- Serializes the request feature of the {SERVLET}
		do
			create Result.make (request_name)
			Result.append_expression ("create Result." + constructor_name)
			root_tag.generate (Result)
		end

	generate
			--
		local
			buf: INDENDATION_STREAM
			servlet_class: CLASS_ELEMENT
			file: PLAIN_TEXT_FILE
		do
			create file.make_open_write (path + servlet_name.as_lower + "_servlet.e")
			create buf.make (file)
			create servlet_class.make (servlet_name.as_upper + "_servlet.e")
			if stateful then
				servlet_class.set_inherit (Stateful_servlet_class)
			else
				servlet_class.set_inherit (Stateless_servlet_class)
			end
			servlet_class.set_inherit ("SERVLET")
			servlet_class.set_constructor_name ("make")
			servlet_class.add_variable_by_name_type ("controller", controller_type)
			servlet_class.add_feature (build_make_for_servlet_generator)
			servlet_class.add_feature (build_handle_request_feature_for_servlet (get_root_tag))
			servlet_class.serialize (buf)
			file.close
		end

	get_root_tag: TAG_SERIALIZER
			-- Returns the root tag of the compiled xeb file
		deferred
		end

feature --Constants

	Stateful_servlet_class: STRING = "STATEFUL_SERVLET"
	Stateless_servlet_class: STRING = "STATELESS_SERVLET"
	Request_name: STRING = "handle_request (request: REQUEST): RESPONSE"
	constructor_name: STRING = "make"

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
