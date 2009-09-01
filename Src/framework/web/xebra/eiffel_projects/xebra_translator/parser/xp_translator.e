note
	description: "[
			Reads a xebra scriptlet file and generates an eiffel class.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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

	make (a_name: STRING; a_force: BOOLEAN)
			-- Initialization for {XP_TRANSLATOR}.
		require
			a_name_valid: attached a_name and then not a_name.is_empty
		local
			l_page_taglib: XTL_PAGE_CONF_TAG_LIB
		do
			create output_path.make_from_string ("./generated/")
			output_path.extend (a_name)
			name := a_name
			create registry.make (output_path, a_force)
			create xeb_parser.make (registry)
			create l_page_taglib.make_with_arguments ("page")
			registry.put_tag_lib (l_page_taglib)
			l_page_taglib.set_parser (xeb_parser)
		ensure
			output_path_attached: attached output_path
			name_attached: attached name
			registry_attached: attached registry
		end

feature -- Access

	output_path: FILE_NAME assign set_output_path
			-- Defines where the files should be written

feature {NONE} -- Access

	xeb_parser: XT_XEB_PARSER
			-- The xeb file parser

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
		ensure
			output_path_set: output_path = a_path
		end

	set_name (a_name: like name)
			-- Sets the name
		require
			a_name_is_valid: attached a_name and not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: a_name = name
		end

feature -- Main Processing

	process_with_dir (a_xeb_directory: FILE_NAME; a_force: BOOLEAN)
			--`a_xeb_directory': Where are the xeb files located?
			--`force': Should the servlet_generators be generated regardless if they're outdated or not?
			-- Translates xeb files to servlet generators
		require
			a_xeb_directory_attached: attached a_xeb_directory
		local
			l_directory: DIRECTORY
		do
			create l_directory.make (a_xeb_directory)
			process_with_files (search_for_xeb (l_directory), a_force)
		end

	process_with_files (a_files: LIST [FILE_NAME];  a_force: BOOLEAN)
			-- `a_files': All the files of a folder with xeb files
			-- Generates classes for all the xeb files in `a_files' using `a_taglib_folder' for the taglib
		require
			a_files_attached: attached a_files
		local
			l_generator_app_generator: XGEN_SERVLET_GENERATOR_APP_GENERATOR
			l_webapp_gen: XGEN_WEBAPP_GENERATOR
			l_translation_config_path: FILE_NAME
		do
			l_translation_config_path := output_path.twin
			log.dprint ("********************$Revision$**********************", log.debug_configuration)
			log.dprint ("************************************************************", log.debug_start_stop_components)
			log.dprint ("*                  .taglib processing start...             *", log.debug_start_stop_components)
			log.dprint ("************************************************************", log.debug_start_stop_components)
			l_translation_config_path.set_file_name ({XU_CONSTANTS}.Webapp_config_file)
			parse_translation_conf (l_translation_config_path, registry)
			if not attached registry.taglib_configuration or error_manager.has_errors then
				log.eprint ("Taglib configuration either not existing or corrupted! Aborting translation.", generating_type)
			else
				parse_taglibs (registry)
				log.dprint ("************************************************************", log.debug_start_stop_components)
				log.dprint ("*                    .xeb processing start...              *", log.debug_start_stop_components)
				log.dprint ("************************************************************", log.debug_start_stop_components)
				log.dprint ("Files to process: " + a_files.count.out, log.debug_start_stop_components)
				from
					a_files.start
				until
					a_files.after
				loop
					if a_files.item.out.ends_with (".xeb") then -- ugly.
						process_file (a_files.item, agent process_xeb_file (?, ?, a_files.item, a_files.item.out, a_force))
					else
						process_file (a_files.item, agent process_xrpc_file (?, ?, a_files.item, a_files.item.out, a_force))
					end
					a_files.forth
				end
				log.dprint ("Processing done.", log.debug_start_stop_components)
				registry.resolve_all_templates
				log.dprint ("Resolving done.", log.debug_tasks)
				create l_generator_app_generator.make (registry)
				l_generator_app_generator.put_servlet_generator_generators (registry.retrieve_servlet_generator_generators)
				l_generator_app_generator.generate (output_path.twin)
				create l_webapp_gen.make_with_servlets (name, output_path, l_generator_app_generator.servlet_generator_generators)
				l_webapp_gen.generate
			end
		end

feature {NONE} -- Processing

	process_xeb_file (a_source: STRING; a_file: PLAIN_TEXT_FILE; a_path: FILE_NAME; a_file_name: STRING; a_force: BOOLEAN)
		require
			a_source_attached: attached a_source
			a_path: attached a_path
			a_file_name: attached a_file_name
		do
			log.dprint ("Processing '" + a_path + "'...", log.debug_tasks)
			add_template_to_registry (generate_name_from_file_name (a_path), a_source, a_path, registry, a_file.date, a_force)
		end

	process_xrpc_file (a_source: STRING; a_file: PLAIN_TEXT_FILE; a_path: FILE_NAME; a_file_name: STRING; a_force: BOOLEAN)
			-- Processes an xrpc-file and adds it to the registry
		require
			a_source_attached: attached a_source
			a_path: attached a_path
			a_file_name: attached a_file_name
		do
			log.dprint ("Processing '" + a_path + "'...", log.debug_tasks)
			add_xrpc_to_registry (generate_name_from_file_name (a_path), a_source, a_path, registry, a_file.date, a_force)
		end

	process_taglib_with_stream (a_registry: XP_SERVLET_GG_REGISTRY; a_source: STRING; a_file: PLAIN_TEXT_FILE)
			-- Trasforms stream to tag library and adds it to `a_taglibs'
		require
			a_registry_attached: attached a_registry
			a_source_attached: attached a_source
		local
			l_parser: XT_TAGLIB_PARSER
			l_taglib: detachable XTL_TAG_LIBRARY
		do
			create l_parser.make
			l_taglib := l_parser.parse (a_source)

			if attached l_taglib then
				log.dprint ("Successfully parsed taglib: " + l_taglib.id, log.debug_tasks)
				a_registry.put_tag_lib (l_taglib)
			else
				error_manager.add_error (create {XERROR_PARSE}.make (["Something went wrong while parsing a taglib: " + a_file.name]), False)
			end
		end

feature {NONE} -- Parsing

	parse_translation_conf (a_file_name: FILE_NAME; a_registry: XP_SERVLET_GG_REGISTRY)
			--Parses the config file to get all the date for the tag libs
		require
			a_registry_attached: attached a_registry
		local
			l_configuration: LIST [TUPLE [STRING, STRING, STRING]]
			l_webapp_config_reader: XC_WEBAPP_JSON_CONFIG_READER
		do
			create l_webapp_config_reader
			if attached {XC_WEBAPP_CONFIG} l_webapp_config_reader.process_file (a_file_name) as l_w then
				l_configuration := l_w.taglibs
				a_registry.set_taglibrary_config (l_configuration)
			end
		end

	add_xrpc_to_registry (a_servlet_name: STRING; a_source: STRING; a_path: FILE_NAME; a_registry: XP_SERVLET_GG_REGISTRY; a_date: INTEGER; a_force: BOOLEAN)
			-- Transforms `a_stream' to a {XGEN_SERVLET_GENERATOR_GENERATOR}
		require
			servlet_name_valid: attached a_servlet_name and not a_servlet_name.is_empty
			a_source_attached: attached a_source
			a_path_attached: attached a_path
			a_registry_attached: attached a_registry
		local
			l_template: XP_TEMPLATE
		do
			xeb_parser.set_source_path (a_path)
			if xeb_parser.parse (a_source) then
				l_template := xeb_parser.template
				l_template.template_name := a_servlet_name
				xeb_parser.template.date := a_date
				xeb_parser.template.force := a_force
				a_registry.put_xrpc (a_servlet_name, xeb_parser.template)
			else
				log.eprint ("Parsing of : " + a_path + " was unsuccessful", generating_type)
			end
		end

	add_template_to_registry (a_servlet_name: STRING; a_source: STRING; a_path: FILE_NAME; a_registry: XP_SERVLET_GG_REGISTRY; a_date: INTEGER; a_force: BOOLEAN)
			-- Transforms `a_stream' to a {XGEN_SERVLET_GENERATOR_GENERATOR}
		require
			servlet_name_valid: attached a_servlet_name and not a_servlet_name.is_empty
			a_source_attached: attached a_source
			a_path_attached: attached a_path
			a_registry_attached: attached a_registry
		local
			l_template: XP_TEMPLATE
		do
			xeb_parser.set_source_path (a_path)
			if xeb_parser.parse (a_source) then
				l_template := xeb_parser.template
				l_template.template_name := a_servlet_name
				xeb_parser.template.date := a_date
				xeb_parser.template.force := a_force
				a_registry.put_template (a_servlet_name, xeb_parser.template)
			else
				log.eprint ("Parsing of : " + a_path + " was unsuccessful", generating_type)
			end
		end

	parse_taglibs (a_registry: XP_SERVLET_GG_REGISTRY)
			-- Generates tag libraries from all the the *.taglib files in the directory
		require
			a_registry_attached: attached a_registry
		local
			l_taglibrary_file_name: FILE_NAME
			l_cursor: INTEGER
		do
			if attached {LIST [TUPLE [name: STRING; ecf: STRING; path: STRING]]} a_registry.taglib_configuration as l_config then
				from
					l_cursor := l_config.index
					l_config.start
				until
					l_config.after
				loop
					create l_taglibrary_file_name.make_from_string (l_config.item.path)
					l_taglibrary_file_name.set_file_name ({XU_CONSTANTS}.Taglib_config_file)
					log.dprint ("Processing file: " + l_taglibrary_file_name, log.debug_tasks)
					process_file (l_taglibrary_file_name, agent process_taglib_with_stream (a_registry, ?, ?))
					l_config.forth
				end
				l_config.go_i_th (l_cursor)
			else
				log.eprint ("Configuration file is corrupted or missing!", generating_type)
			end
		end

feature {NONE} -- Utility

	search_for_xeb (a_directory: DIRECTORY): LIST [FILE_NAME]
			-- `l_directory': In which directory to search
			-- Searches recursively over the directory to find all xeb files
		require
			a_directory_attached: attached a_directory
		local
			l_directory_name: FILE_NAME
			l_util: XU_FILE_UTILITIES
			l_includes, l_excludes: ARRAYED_LIST [STRING]
		do
			create {ARRAYED_LIST [FILE_NAME]}Result.make (5)
			create l_directory_name.make_from_string (a_directory.name)
			create l_util
			create l_includes.make (2)
			l_includes.extend ("*" + {XU_CONSTANTS}.Extension_xeb)
			l_includes.extend ("*" + {XU_CONSTANTS}.Extension_xrpc)
			create l_excludes.make (2)
			l_excludes.extend ({XU_CONSTANTS}.Dir_eifgen)
			l_excludes.extend ({XU_CONSTANTS}.Dir_svn)
			Result := l_util.scan_for_files (l_directory_name.out, -1, l_includes, l_excludes)
		end

	generate_name_from_file_name (a_file_name: FILE_NAME): STRING
			-- Transforms a file name and eventual folders into a class name
		local
			l_output_path, l_file_name: STRING
			i: INTEGER
			l_util: XU_FILE_UTILITIES
		do
			create l_util
			l_output_path := output_path.out
			l_file_name := a_file_name.out
			from
				i := 1
			until
				i > l_output_path.count and not (l_output_path [i] = l_file_name [i])
			loop
				i := i + 1
			end
			Result := l_file_name.substring (i + 1, l_file_name.last_index_of ('.', l_file_name.count) - 1)
			Result.replace_substring_all ("/", {XU_CONSTANTS}.Folder_replacement_string) -- UNIX
			Result.replace_substring_all ("\", {XU_CONSTANTS}.Folder_replacement_string) -- WINDOWS
		end

invariant
	output_path_attached: attached output_path
	name_attached: attached name
	registry_attached: attached registry

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
