note
	description: "[
			Reads a xebra scriptlet file and generates an eiffel class.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_TRANSLATOR

inherit
	XU_ERROR_MANAGED_FILE
	XU_SHARED_OUTPUTTER

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Initialization for {XP_TRANSLATOR}.
		do
			create output_path.make_from_string ("./generated/")
			output_path.extend (a_name)
			name := a_name
			create servlet_gen_path.make
			create registry.make (output_path)
		end

feature {NONE} -- Access

feature -- Access

	output_path: FILE_NAME assign set_output_path
			-- Defines where the files should be written

	servlet_gen_path: FILE_NAME assign set_servlet_gen_path
			-- Defines where the servlets should be generated

	name: STRING assign set_name
			-- Name of the system

	registry: XP_SERVLET_GG_REGISTRY
			-- Registry to store all the extracted data

feature -- Status setting

	set_output_path (a_path: like output_path)
			-- Sets the output_path
		require
			a_path_is_valid: attached a_path not a_path.is_empty
		do
			output_path := a_path
		end

	set_servlet_gen_path (a_path: like servlet_gen_path)
			-- Sets the servlet_gen_path
		require
			a_path_is_valid: attached a_path and not a_path.is_empty
		do
			servlet_gen_path := a_path
		end

	set_name (a_name: like name)
			-- Sets the name
		require
			a_name_is_valid: attached a_name and not a_name.is_empty
		do
			name := a_name
		end

feature -- Processing

	process_with_files (a_files: LIST [STRING]; a_taglib_folder: FILE_NAME)
			-- `a_files': All the files of a folder with xeb files
			-- `a_taglib_folder': Path to the folder the tag library definitions
			-- Generates classes for all the xeb files in `a_files' using `a_taglib_folder' for the taglib
		require
			a_files_attached: attached a_files
			a_taglib_folder_attached: attached a_taglib_folder
		local
			l_generator_app_generator: XGEN_SERVLET_GENERATOR_APP_GENERATOR
			l_webapp_gen: XGEN_WEBAPP_GENERATOR
			l_path: FILE_NAME
		do
			l_path := output_path.twin
			create registry.make (servlet_gen_path)
			parse_taglibs (a_taglib_folder, registry)

			o.iprint ("Processing start...")
			from
				a_files.start
			until
				a_files.after
			loop
				if a_files.item.ends_with (".xeb") then
					l_path := output_path.twin
					l_path.set_file_name (a_files.item)
					process_file (l_path, agent process_xeb_file (?, l_path, a_files.item))
				end
				a_files.forth
			end
			o.iprint ("Processing done.")
			registry.resolve_all_templates
			create l_generator_app_generator.make
			l_generator_app_generator.put_servlet_generator_generators (registry.retrieve_servlet_generator_generators)
			l_generator_app_generator.generate (servlet_gen_path)
			create l_webapp_gen.make_with_servlets (name, output_path, l_generator_app_generator.servlet_generator_generators)
			l_webapp_gen.generate
		end

	process_xeb_file (a_file: KL_TEXT_INPUT_FILE; a_path: FILE_NAME; a_file_name: STRING)
		require
			a_file_attached: attached a_file
			a_file_open: a_file.is_open_read
			a_path: attached a_path
			a_file_name: attached a_file_name
		do
			o.iprint ("Processing '" + a_file.name + "'...")
			add_template_to_registry (a_file_name.substring (1, a_file_name.index_of ('.', 1)-1), a_file, a_path, registry)
		end

	add_template_to_registry (a_servlet_name: STRING; a_stream: KL_TEXT_INPUT_FILE; a_path: FILE_NAME; a_registry: XP_SERVLET_GG_REGISTRY)
			-- Transforms `a_stream' to a {XGEN_SERVLET_GENERATOR_GENERATOR}
		require
			servlet_name_valid: attached a_servlet_name and not a_servlet_name.is_empty
			a_stream_attached: attached a_stream
			a_path_attached: attached a_path
			a_registry_attached: attached a_registry
		local
			l_root_tag: XP_TAG_ELEMENT
			l_controller_class: STRING
			l_parser: XM_PARSER
			l_p_callback: XP_XML_PARSER_CALLBACKS
			l_external_resolver: XP_EXTERNAL_RESOLVER
			l_template: XP_TEMPLATE
		do
			create l_external_resolver
			create {XM_EIFFEL_PARSER} l_parser.make
			l_parser.set_dtd_resolver (l_external_resolver)
			l_parser.set_entity_resolver (l_external_resolver)
			create {XP_XML_PARSER_CALLBACKS} l_p_callback.make (l_parser, a_path)
			l_p_callback.put_registry (a_registry)
			l_parser.set_callbacks (l_p_callback)
			l_parser.parse_from_stream (a_stream)

			l_root_tag := l_p_callback.root_tag
			l_controller_class := l_p_callback.controller_class
			create l_template.make (l_root_tag, l_p_callback.is_template, l_controller_class, a_servlet_name)
			l_template.date := a_stream.time_stamp
			a_registry.put_template (a_servlet_name, l_template)
		end

	parse_taglibs (taglib_folder: STRING; a_registry: XP_SERVLET_GG_REGISTRY)
			-- Generates tag libraries from all the the *.taglib files in the directory
		require
			taglib_folder_valid: attached taglib_folder and not taglib_folder.is_empty
		local
			dir: DIRECTORY
			files: LIST [STRING]
		do
			create dir.make (taglib_folder)
			files := dir.linear_representation
			from
				files.start
			until
				files.after
			loop
				if files.item.ends_with (".taglib") then
					process_file (files.item, agent process_taglib_with_stream (a_registry, ?))
				end
				files.forth
			end
		end

	process_taglib_with_stream (a_registry: XP_SERVLET_GG_REGISTRY; a_stream: KI_CHARACTER_INPUT_STREAM)
			-- Trasforms stream to tag library and adds it to `a_taglibs'
		require
			a_registry_attached: attached a_registry
			a_stream_attached: attached a_stream
		local
			l_parser: XM_PARSER
			l_p_callback: XP_TAGLIB_PARSER_CALLBACKS
		do
			create {XM_EIFFEL_PARSER} l_parser.make
			create l_p_callback.make
			l_parser.set_callbacks (l_p_callback)
			l_parser.parse_from_stream (a_stream)
			a_registry.put_tag_lib (l_p_callback.taglib.id, l_p_callback.taglib)
		end

invariant
	servlet_gen_path_attached: servlet_gen_path /= Void
	registry_attached: registry /= Void
	output_path_attached: output_path /= Void
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
