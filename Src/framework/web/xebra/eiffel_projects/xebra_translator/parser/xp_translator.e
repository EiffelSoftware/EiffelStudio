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
		require
			a_name_valid: attached a_name and then not a_name.is_empty
		local
			l_page_taglib: XTL_PAGE_CONF_TAG_LIB
		do
			create output_path.make_from_string ("./generated/")
			output_path.extend (a_name)
			name := a_name
			create registry.make (output_path)
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

	process_with_dir (a_xeb_directory: FILE_NAME; a_tag_lib_directory: FILE_NAME)
			--`a_xeb_directory': Where are the xeb files located?
			--`a_tag_lib_directory': Where are the taglibs located?
			-- Translates xeb files to servlet generators
		require
			a_xeb_directory_attached: attached a_xeb_directory
			a_tag_lib_directory_attached: attached a_tag_lib_directory
		local
			l_directory: DIRECTORY
		do
			create l_directory.make (a_xeb_directory)
			process_with_files (search_rec_for_xeb (l_directory), a_tag_lib_directory)
		end

	search_rec_for_xeb (a_directory: DIRECTORY): LIST [XP_FILE_NAME]
			-- `l_directory': In which directory to search
			-- `already_found': All the files already found
			-- Searches recursively over the directory to find all xeb files
		require
			a_directory_attached: attached a_directory
		local
			l_files: LIST [STRING]
			l_file: RAW_FILE
			l_file_name: XP_FILE_NAME
			l_directory_name: XP_FILE_NAME
		do
			create {ARRAYED_LIST [XP_FILE_NAME]}Result.make (5)
			create l_directory_name.make_from_string (a_directory.name)
			from
				l_files := a_directory.linear_representation
				l_files.start
			until
				l_files.after
			loop
				l_file_name := l_directory_name.twin
				l_file_name.set_file_name (l_files.item)
				create l_file.make_open_read (l_file_name)
				if not l_file.is_symlink and then not l_files.item.is_equal (".") and not l_files.item.is_equal ("..") then
					if l_file.is_directory and then not l_files.item.is_equal ("EIFGENs") then
						l_file_name := l_directory_name.twin
						l_file_name.extend (l_files.item)
						Result.append (search_rec_for_xeb (create {DIRECTORY}.make (l_file_name)))
					elseif l_file.name.ends_with (".xeb") then
						Result.extend (l_file_name)
					end
				end
				l_file.close
				l_files.forth
			end
		end

	process_with_files (a_files: LIST [XP_FILE_NAME]; a_taglib_folder: FILE_NAME)
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
				process_file (a_files.item, agent process_xeb_file (?, a_files.item, a_files.item.file_name))
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

	process_xeb_file (a_source: STRING; a_path: XP_FILE_NAME; a_file_name: STRING)
		require
			a_source_attached: attached a_source
			a_path: attached a_path
			a_file_name: attached a_file_name
		do
			o.iprint ("Processing '" + a_path + "'...")
			add_template_to_registry (generate_name_from_file_name (a_path), a_source, a_path, registry)
		end

	generate_name_from_file_name (a_file_name: XP_FILE_NAME): STRING
		local
			l_output_path, l_file_name: STRING
			l_i: INTEGER
		do
			l_output_path := output_path.out
			l_file_name := a_file_name.out
			from
				l_i := 1
			until
				l_i > l_output_path.count and not (l_output_path [l_i] = l_file_name [l_i])
			loop
				l_i := l_i + 1
			end
			Result := l_file_name.substring (l_i+1, l_file_name.count - (".xeb").count) -- Magic number
			Result.replace_substring_all ("/", "_") -- UNIX
			Result.replace_substring_all ("\", "_") -- WINDOWS
		end

	add_template_to_registry (a_servlet_name: STRING; a_source: STRING; a_path: FILE_NAME; a_registry: XP_SERVLET_GG_REGISTRY)
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
			dir: DIRECTORY
			files: LIST [STRING]
			file: FILE_NAME
		do
			o.dprint ("Searching for tag libraries in folder: " + taglib_folder, 10)
			create dir.make (create {FILE_NAME}.make_from_string (taglib_folder))
			files := dir.linear_representation
			from
				files.start
			until
				files.after
			loop
				if files.item.ends_with (".taglib") then
					o.dprint ("Processing file: " + files.item, 10)
					create file.make_from_string (taglib_folder)
					file.set_file_name (files.item)
					process_file (file, agent process_taglib_with_stream (a_registry, ?))
				end
				files.forth
			end
		end

	process_taglib_with_stream (a_registry: XP_SERVLET_GG_REGISTRY; a_source: STRING)
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
				error_manager.add_error (create {XERROR_PARSE}.make (["Something went wrong while parsing a taglib: " + "TODO NAME"]), False)
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
