note
	description: "[
		Creates a servlet generator file in the servlet_gen path.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XGEN_SERVLET_GENERATOR_GENERATOR

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XU_SHARED_OUTPUTTER

create
	make, make_empty, make_minimal

feature {NONE} -- Initialization

	make_minimal (a_servlet_name: STRING; a_path: FILE_NAME; a_force: BOOLEAN)
			-- `a_servlet_name': The name of the servlet
			-- `a_path': The path where the generator should be generated to
		require
			a_servlet_name_attached: attached a_servlet_name
			a_path_attached: attached a_path
			not_a_servlet_name_is_empty: not a_servlet_name.is_empty
			not_a_path_is_empty: not a_path.is_empty
		do
			make (a_servlet_name, False, create {XP_TAG_ELEMENT}.make_empty, a_path, False, a_force)
		end

	make (a_servlet_name: STRING; a_stateful: BOOLEAN; a_root_tag: XP_TAG_ELEMENT; a_path: FILE_NAME; a_is_template, a_force: BOOLEAN)
			-- `a_servlet_name': The name of ther servlet which has to be generated
			-- `a_stateful': Is the controller stateful?
			-- `a_root_tag': The root tag of the parsed xeb file
			-- `a_is_template': Is the xeb a template, and has it therefore not to be generated
		require
			a_servlet_name_valid: attached a_servlet_name and not a_servlet_name.is_empty
			a_path: not a_path.is_empty
		do
			servlet_name := a_servlet_name
			root_tag := a_root_tag
			create path.make_from_string (a_path)
			uid_counter := 0
			create controller_table.make (1)
			force := a_force
		ensure
			servlet_name_attached: attached servlet_name
			root_tag_attached: attached root_tag
			controller_table_attached: attached controller_table
			path_attached: attached path
			uid_counter_initialized: uid_counter = 0
			force_set: force = a_force
		end

	make_empty
			-- Creates an empty {xgen_servlet_generator_generator}
		do
			create controller_table.make (1)
			create path.make_from_string (".")
			create root_tag.make_empty
			create servlet_name.make_empty
		ensure
			controller_table_attached: attached controller_table
		end

feature {NONE} -- Access

	uid_counter: NATURAL
			-- Internal counter used to generate unique identifiers

feature -- Access

	is_xrpc: BOOLEAN
			-- Is the servlet_gen_gen a xrpc generator?

	force: BOOLEAN
			-- Should the output be forced

	controller_table: HASH_TABLE [STRING, STRING]
			-- controller instvars of the resulting servlet

	root_tag: XP_TAG_ELEMENT assign set_root_tag
			-- The root tag of the parsed xeb file

	servlet_name: STRING
			-- The name of ther servlet which has to be generated

	path: FILE_NAME
			-- The path, were the servlet_generator should be generated

	absorb (a_other: XGEN_SERVLET_GENERATOR_GENERATOR)
			-- Takes all attributes of `a_other'
		require
			a_other_attached: a_other /= Void
		do
			servlet_name := a_other.servlet_name
			root_tag := a_other.root_tag.copy_tag_tree
			path := a_other.path
			uid_counter := 0
		end

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
			-- Adds a controller variable
			-- `a_identifier' and `a_class' for a controller instvar of the resulting servlet
		require
			a_identifier_attached: a_identifier /= Void
			a_class_attached: a_class /= Void
		do
			controller_table.put (a_class, a_identifier)
		end

	set_root_tag (a_root_tag: XP_TAG_ELEMENT)
			-- Sets the root tag.
			-- `a_root_tag': The root tag to set
		require
			a_root_tag_attached: attached a_root_tag
		do
			root_tag := a_root_tag
		ensure
			root_tag_set: root_tag = a_root_tag
		end

	transform_to_xrpc
			-- Transforms the servlet_gen_gen to a xrpc servlet gen gen
		do
			is_xrpc := True
		ensure
			is_xrpc: is_xrpc
		end

feature -- Basic functionality

	generate (a_path: FILE_NAME)
			-- Generates the servlet generator class if needed
			-- `a_path': The path in which the file should be generated
		require
			path_is_attached: attached path
			path_is_not_empty: not a_path.is_empty
		local
			buf:XU_INDENDATION_FORMATTER
			servlet_gen_class: XEL_CLASS_ELEMENT
			l_filename: FILE_NAME
			l_directory: DIRECTORY
			l_util: XU_FILE_UTILITIES
		do
			l_filename := a_path.twin
			l_filename.extend ({XU_CONSTANTS}.generated_folder_name)
			create l_directory.make (l_filename)
			if not l_directory.exists then
				l_directory.create_dir
			end
			l_filename.extend ({XU_CONSTANTS}.servlet_gen_name)
			create l_directory.make (l_filename)
			if not l_directory.exists then
				l_directory.create_dir
			end

			l_filename.set_file_name (Generator_Prefix.as_lower + servlet_name.as_lower + "_servlet_generator.e")
			create l_util
			if l_util.file_is_older_than (l_filename, root_tag.date) or force then
				if attached l_util.plain_text_file_write (l_filename) as l_file then
					create servlet_gen_class.make (Generator_Prefix.as_upper + servlet_name.as_upper + "_SERVLET_GENERATOR")
					if is_xrpc then
						servlet_gen_class.set_inherit (Servlet_xrpc_generator_class)
						servlet_gen_class.set_constructor_name ("make_xrpc")
					else
						servlet_gen_class.set_inherit (Servlet_generator_class)
						servlet_gen_class.set_constructor_name ("make")
					end

					build_generate_for_servlet_generator (servlet_gen_class)
					create buf.make (l_file)
					servlet_gen_class.serialize (buf)
					l_util.close
					o.dprint ("Servlet generator generated at: " + l_filename, 1)
				end
			else
				o.dprint ("Already up to date: " + l_filename, 1)
			end
		end

feature {NONE} -- Implementation

	build_generate_for_servlet_generator (a_class: XEL_CLASS_ELEMENT)
			-- Builds the feature which generates a servlet_generator
		require
			a_class_attached: attached a_class
		local
			generate_feature: XEL_FEATURE_ELEMENT
		do
			create generate_feature.make ("get_root_tag: " + Tag_serializer_class)
			a_class.add_feature (generate_feature)
			generate_feature.append_local ("stack", "ARRAYED_STACK [" + Tag_serializer_class + "]")
			generate_feature.append_local ("root_tag, temp", Tag_serializer_class)
			generate_feature.append_expression ("create stack.make (10)")

			root_tag.build_tag_tree (generate_feature, Current)
			generate_feature.append_expression ("Result := root_tag")
		end

feature -- Constants

	Tag_serializer_class: STRING = "XTAG_TAG_SERIALIZER"
	Servlet_generator_class: STRING = "XGEN_SERVLET_GENERATOR"
	Servlet_xrpc_generator_class: STRING = "XGEN_XRPC_SERVLET_GENERATOR"
	Generator_Prefix: STRING = "g_"

invariant
	controller_table_attached: attached controller_table
	servlet_name_attached: attached servlet_name
	path_attached: attached path
	root_tag_attached: attached root_tag

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
