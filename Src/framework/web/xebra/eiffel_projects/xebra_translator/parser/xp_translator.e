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
			create xeb_parser.make_with_registry (registry)
			create l_page_taglib.make_with_arguments ("page")
			registry.put_tag_lib (l_page_taglib.id, l_page_taglib)
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

feature -- Processing

	process_with_dir (a_xeb_directory: FILE_NAME; a_tag_lib_directory: FILE_NAME; a_force: BOOLEAN)
			--`a_xeb_directory': Where are the xeb files located?
			--`a_tag_lib_directory': Where are the taglibs located?
			--`force': Should the servlet_generators be generated regardless if they're outdated or not?
			-- Translates xeb files to servlet generators
		require
			a_xeb_directory_attached: attached a_xeb_directory
			a_tag_lib_directory_attached: attached a_tag_lib_directory
		local
			l_directory: DIRECTORY
		do
			create l_directory.make (a_xeb_directory)
			process_with_files (search_rec_for_xeb (l_directory), a_tag_lib_directory, a_force)
		end

	search_rec_for_xeb (a_directory: DIRECTORY): LIST [FILE_NAME]
			-- `l_directory': In which directory to search
			-- `already_found': All the files already found
			-- Searches recursively over the directory to find all xeb files
		require
			a_directory_attached: attached a_directory
		local
			l_directory_name: FILE_NAME
			l_util: XU_FILE_UTILITIES
		do
			create {ARRAYED_LIST [FILE_NAME]}Result.make (5)
			create l_directory_name.make_from_string (a_directory.name)
			create l_util.make
			Result := l_util.scan_for_files (l_directory_name.out, -1, "(\.xeb$)|(\.xrpc$)", "EIFGENs|\.svn")
		end

	process_with_files (a_files: LIST [FILE_NAME]; a_taglib_folder: FILE_NAME; a_force: BOOLEAN)
			-- `a_files': All the files of a folder with xeb files
			-- `a_taglib_folder': Path to the folder the tag library definitions
			-- Generates classes for all the xeb files in `a_files' using `a_taglib_folder' for the taglib
		require
			a_files_attached: attached a_files
			a_taglib_folder_attached: attached a_taglib_folder
		local
			l_generator_app_generator: XGEN_SERVLET_GENERATOR_APP_GENERATOR
			l_webapp_gen: XGEN_WEBAPP_GENERATOR
		do
			o.iprint ("********************$Revision$**********************")
			o.iprint ("************************************************************")
			o.iprint ("*                  .taglib processing start...             *")
			o.iprint ("************************************************************")
			parse_taglibs (a_taglib_folder, registry)
			o.iprint ("************************************************************")
			o.iprint ("*                    .xeb processing start...              *")
			o.iprint ("************************************************************")
			from
				a_files.start
			until
				a_files.after
			loop
				if a_files.item.out.ends_with (".xeb") then
					process_file (a_files.item, agent process_xeb_file (?, ?, a_files.item, a_files.item.out, a_force))
				else
					process_file (a_files.item, agent process_xrpc_file (?, ?, a_files.item, a_files.item.out, a_force))
				end
				a_files.forth
			end
			o.iprint ("Processing done.")
			registry.resolve_all_templates
			create l_generator_app_generator.make
			l_generator_app_generator.put_servlet_generator_generators (registry.retrieve_servlet_generator_generators)
			l_generator_app_generator.generate (output_path.twin)
			create l_webapp_gen.make_with_servlets (name, output_path, l_generator_app_generator.servlet_generator_generators)
			l_webapp_gen.generate
		end

	process_xeb_file (a_source: STRING; a_file: PLAIN_TEXT_FILE; a_path: FILE_NAME; a_file_name: STRING; a_force: BOOLEAN)
		require
			a_source_attached: attached a_source
			a_path: attached a_path
			a_file_name: attached a_file_name
		do
			o.iprint ("Processing '" + a_path + "'...")
			add_template_to_registry (generate_name_from_file_name (a_path), a_source, a_path, registry, a_file.date, a_force)
		end

	process_xrpc_file (a_source: STRING; a_file: PLAIN_TEXT_FILE; a_path: FILE_NAME; a_file_name: STRING; a_force: BOOLEAN)
		require
			a_source_attached: attached a_source
			a_path: attached a_path
			a_file_name: attached a_file_name
		do
			o.iprint ("Processing '" + a_path + "'...")
			add_xrpc_to_registry (generate_name_from_file_name (a_path), a_source, a_path, registry, a_file.date, a_force)
		end

	generate_name_from_file_name (a_file_name: FILE_NAME): STRING
		local
			l_output_path, l_file_name: STRING
			l_i: INTEGER
			l_raw_file: RAW_FILE
			l_util: FILE_UTILITIES
		do
			create l_util
			l_output_path := l_util.absolute_path (output_path.out, True)
			l_file_name := l_util.absolute_path (a_file_name.out, True)
			check not l_output_path.starts_with ("..") and not l_output_path.starts_with (".") end
			check not l_file_name.starts_with ("..") and not l_file_name.starts_with (".") end
			from
				l_i := 1
			until
				l_i > l_output_path.count and not (l_output_path [l_i] = l_file_name [l_i])
			loop
				l_i := l_i + 1
			end
			Result := l_file_name.substring (l_i+1, l_file_name.last_index_of ('.', l_file_name.count)-1)
			Result.replace_substring_all ("/", "___") -- UNIX
			Result.replace_substring_all ("\", "___") -- WINDOWS
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
				o.dprint ("Parsing of : " + a_path + " was unsuccessfull" , 10)
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
				o.dprint ("Parsing of : " + a_path + " was unsuccessfull" , 10)
			end
		end

	parse_taglibs (taglib_folder: STRING; a_registry: XP_SERVLET_GG_REGISTRY)
			-- Generates tag libraries from all the the *.taglib files in the directory
		require
			taglib_folder_valid: attached taglib_folder and not taglib_folder.is_empty
			a_registry_attached: attached a_registry
		local
			l_directory: FILE_NAME
			l_files: LIST [FILE_NAME]
			l_util: XU_FILE_UTILITIES
		do
			o.dprint ("Searching for tag libraries in folder: " + taglib_folder, 1)
			create l_util.make
			create l_directory.make_from_string (taglib_folder)
			l_files := l_util.scan_for_files (l_directory.out, -1, "(\.taglib$)", "EIFGENs|\.svn")
			from
				l_files.start
			until
				l_files.after
			loop
				o.dprint ("Processing file: " + l_files.item.out, 1)
				process_file (l_files.item, agent process_taglib_with_stream (a_registry, ?, ?))
				l_files.forth
			end
		end

	process_taglib_with_stream (a_registry: XP_SERVLET_GG_REGISTRY; a_source: STRING; a_file: PLAIN_TEXT_FILE)
			-- Trasforms stream to tag library and adds it to `a_taglibs'
		require
			a_registry_attached: attached a_registry
			a_source_attached: attached a_source
		local
			l_parser: XT_TAGLIB_PARSER
			l_taglib: XTL_TAG_LIBRARY
		do
			create l_parser.make
			l_taglib := l_parser.parse (a_source)

			if attached l_taglib then
				o.iprint ("Successfully parsed taglib: " + l_taglib.id)
				a_registry.put_tag_lib (l_taglib.id, l_taglib)
			else
				error_manager.add_error (create {XERROR_PARSE}.make (["Something went wrong while parsing a taglib: " + a_file.name]), False)
			end
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
