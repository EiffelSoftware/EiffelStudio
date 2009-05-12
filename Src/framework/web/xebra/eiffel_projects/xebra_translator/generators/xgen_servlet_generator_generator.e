note
	description: "Summary description for {SERVLET_GENERATOR_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	XGEN_SERVLET_GENERATOR_GENERATOR

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

create
	make, make_empty, make_minimal

feature {NONE} -- Initialization

	make_minimal (a_servlet_name: STRING; a_path: STRING)
		require
			not_a_servlet_name_is_empty: not a_servlet_name.is_empty
			not_a_path_is_empty: not a_path.is_empty
			a_servlet_name_attached: a_servlet_name /= Void
			a_path_attached: a_path /= Void
		do
			make (a_servlet_name, False, Void, a_path, False, "")
		end

	make (a_servlet_name: STRING; a_stateful: BOOLEAN; a_root_tag: XP_TAG_ELEMENT; a_path: STRING; a_is_template: BOOLEAN; a_controller_class: STRING)
			-- `a_servlet_name': The name of ther servlet which has to be generated
			-- `a_controller_types': The types of the controllers
			-- `a_stateful': Is the controller stateful?
			-- `a_root_tag': The root tag of the parsed xeb file
			-- `a_is_template': Is the xeb a template, and has it therefore not to be generated
		require
			a_servlet_name_valid: attached a_servlet_name and not a_servlet_name.is_empty
			a_path: not a_path.is_empty
		do
			servlet_name := a_servlet_name
			stateful := a_stateful
			root_tag := a_root_tag
			path := a_path
			is_template := a_is_template
			uid_counter := 0
			if attached a_controller_class as a then
				controller_class := a_controller_class
			else
				controller_class := ""
			end

			create controller_table.make (1)
		end

	make_empty
		do
			create controller_table.make (1)
		end

feature {NONE} -- Access

	uid_counter: NATURAL
			-- Internal counter used to generate unique identifiers

feature -- Access

	absorb (a_other: XGEN_SERVLET_GENERATOR_GENERATOR)
		require
			a_other_attached: a_other /= Void
		do
			servlet_name := a_other.servlet_name
			stateful := a_other.stateful
			root_tag := a_other.root_tag.copy_tag_tree
			path := a_other.path
			is_template := a_other.is_template
			uid_counter := 0
			controller_class := a_other.controller_class
		end

	controller_class: STRING
			-- The class of the used controller

	controller_table: HASH_TABLE [STRING, STRING]
			-- controller instvars of the resulting servlet

	next_unique_identifier: STRING
			-- Generates a new unique identifier for the controllers
		do
			uid_counter := uid_counter + 1
			Result := unique_identifier
		ensure
			unique_identifier_changed: not (unique_identifier.is_equal (old unique_identifier))
			result_set: attached Result
		end

	unique_identifier: STRING
			-- Returns the last controller uid
		do
			Result := "controller_" + uid_counter.out
		ensure
			result_set: attached Result
		end

	add_controller (a_identifier: STRING; a_class: STRING)
			-- `a_identifier' and `a_class' for a controller instvar of the resulting servlet
		require
			a_identifier_attached: a_identifier /= Void
			a_class_attached: a_class /= Void
		do
			controller_table.put (a_class, a_identifier)
		end

	root_tag: XP_TAG_ELEMENT assign set_root_tag
			-- The root tag of the parsed xeb file

	set_root_tag (a_root_tag: XP_TAG_ELEMENT)
		do
			root_tag := a_root_tag
		ensure
			root_tag_set: root_tag = a_root_tag
		end

	is_template: BOOLEAN
			-- Is the xeb a template, and has it therefore not to be generated

feature -- Basic functionality

	servlet_name: STRING
			-- The name of ther servlet which has to be generated

	stateful: BOOLEAN
			-- Is the controller stateful?

	path: STRING
			-- The path, were the servlet_generator should be generated

	generate (a_path: STRING; templates: LIST [XGEN_SERVLET_GENERATOR_GENERATOR])
			-- Generates the servlet generator class			
		require
			path_is_attached: attached path
			templates_is_attached: attached templates
			path_is_not_empty: not a_path.is_empty
		local
			buf:XU_INDENDATION_STREAM
			servlet_gen_class: XEL_CLASS_ELEMENT
			file: PLAIN_TEXT_FILE
			l_filename: STRING
		do
			if not is_template then
				l_filename := a_path + Generator_Prefix.as_lower + servlet_name.as_lower + "servlet_generator.e"
				create file.make (l_filename)
				if not file.is_creatable then
					error_manager.add_error (create {XERROR_FILE_NOT_CREATABLE}.make (l_filename), false)
				end
				file.open_write
				if not file.is_open_write then
					error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_filename), false)
				end

				create buf.make (file)
				create servlet_gen_class.make (Generator_Prefix.as_upper + servlet_name.as_upper + "SERVLET_GENERATOR")
					-- TODO add an underline before "SERVLET_GENERATOR". Implicates change in other places as well!
				servlet_gen_class.set_inherit (Servlet_generator_class)
				servlet_gen_class.set_constructor_name ("make")
				build_generate_for_servlet_generator (servlet_gen_class, templates)
				servlet_gen_class.serialize (buf)
				file.close
			end
		end

	copy_generator: XGEN_SERVLET_GENERATOR_GENERATOR
			-- Copies current
		do
			create Result.make (servlet_name, stateful, root_tag.copy_tag_tree, path, is_template, controller_class)
		ensure
			result_attached: attached Result
		end

	accept_tag_visitor (visitor: XP_TAG_ELEMENT_VISITOR)
			-- applies visitor on `root_tag'
		require
			visitor_attached: visitor /= Void
		do
			root_tag.accept (visitor)
		end

feature {NONE} -- Implementation

	build_generate_for_servlet_generator (a_class: XEL_CLASS_ELEMENT; templates: LIST [XGEN_SERVLET_GENERATOR_GENERATOR])
			-- Builds the feature which generates a servlet_generator
		require
			a_class_attached: a_class /= Void
			templates_attached: templates /= Void
		local
			generate_feature: XEL_FEATURE_ELEMENT
			uid: STRING
			visitor: XP_REGION_TAG_ELEMENT_VISITOR
			uid_visitor: XP_UID_TAG_VISITOR
		do
			create generate_feature.make ("get_root_tag: " + Tag_serializer_class)
			a_class.add_feature (generate_feature)
			generate_feature.append_local ("stack", "ARRAYED_STACK [" + Tag_serializer_class + "]")
			generate_feature.append_local ("root_tag, temp", Tag_serializer_class)
			generate_feature.append_expression ("create stack.make (10)")

			root_tag.build_tag_tree (generate_feature, templates, Current)

			generate_feature.append_expression ("Result := root_tag")
		end

feature -- Constants

	Tag_serializer_class: STRING = "XTAG_TAG_SERIALIZER"
	Servlet_generator_class: STRING = "XGEN_SERVLET_GENERATOR"
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
