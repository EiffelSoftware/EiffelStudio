note
	description: "Summary description for {SERVLET_GENERATOR_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	XGEN_SERVLET_GENERATOR_GENERATOR

create
	make

feature {NONE} -- Initialization

	make (a_servlet_name, a_controller_type: STRING; a_stateful: BOOLEAN; a_root_tag: XP_TAG_ELEMENT; a_path: STRING)
			-- `a_servlet_name': The name of ther servlet which has to be generated
			-- `a_controller_type': The type of the controller
			-- `a_stateful': Is the controller stateful?
			-- `a_root_tag': The root tag of the parsed xeb file
		do
			servlet_name := a_servlet_name
			controller_type := a_controller_type
			stateful := a_stateful
			root_tag := a_root_tag
			path := a_path
		end

feature {NONE} -- Access

	root_tag: XP_TAG_ELEMENT
			-- The root tag of the parsed xeb file

feature -- Basic functionality

	controller_type: STRING
			-- The type of the controller

	servlet_name: STRING
			-- The name of ther servlet which has to be generated

	stateful: BOOLEAN
			-- Is the controller stateful?

	path: STRING
			-- The path, were the servlet_generator should be generated

	generate (a_path: STRING)
			-- Generates the servlet generator class			
		require
			path_is_not_empty: not a_path.is_empty
		local
			buf:XU_INDENDATION_STREAM
			servlet_gen_class: XEL_CLASS_ELEMENT
			file: PLAIN_TEXT_FILE
		do
			create file.make_open_write (a_path + servlet_name.as_lower + "_servlet_generator.e")
			create buf.make (file)
			create servlet_gen_class.make (servlet_name.as_upper + "_SERVLET_GENERATOR")
			servlet_gen_class.set_inherit (Servlet_generator_class)
			servlet_gen_class.set_constructor_name ("make")
			servlet_gen_class.add_feature (build_generate_for_servlet_generator)
			servlet_gen_class.serialize (buf)
			file.close
		end

feature {NONE} -- Implementation

	build_generate_for_servlet_generator: XEL_FEATURE_ELEMENT
			-- Builds the feature which generates a servlet_generator
		do
			create Result.make ("get_root_tag: " + Tag_serializer_class)
			Result.append_local ("stack", "ARRAYED_STACK [" + Tag_serializer_class + "]")
			Result.append_local ("root_tag, temp", Tag_serializer_class)
			Result.append_expression ("create stack.make (10)")
			root_tag.build_tag_tree (Result)
			Result.append_expression ("Result := root_tag")
		end

feature -- Constants

	Tag_serializer_class: STRING = "XTAG_TAG_SERIALIZER"
	Servlet_generator_class: STRING = "XGEN_SERVLET_GENERATOR"

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
