indexing
	description: "Microsoft Help 2.0 Project (VSIP)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSHELP_PROJECT

inherit
	HELP_PROJECT
	
	UTILITY_FUNCTIONS
	
	TABLE_OF_CONTENTS_CONSTANTS

create
	make

feature -- File

	generate_files is
			-- Generate necessary files
		do
			create_project_file
			create_files_file
			create_collection_file
			create_stylesheet_file
			create_hxk_files
		end		

feature {NONE}  -- File

	create_toc_file is
			-- Create table of contents file
		local
			template: PLAIN_TEXT_TEMPLATE_FILE
			template_file: FILE_NAME
		do
			create template_file.make_from_string (Shared_constants.Application_constants.Templates_path)
			template_file.extend ("HelpTOCTemplate.HxT")
			create template.make (template_file)
			template.add_symbol ("toc", full_toc_text)
			template.save_file (toc_file_name)
		end	

	create_project_file is
			-- Create the actual project file for Visual Studio
		local
			template: PLAIN_TEXT_TEMPLATE_FILE
			template_file: FILE_NAME
			l_files_string: STRING
		do
			create template_file.make_from_string (Shared_constants.Application_constants.Templates_path)
			template_file.extend ("HelpProjectTemplate.hwproj")
			create template.make (template_file)
			template.add_symbol ("project_name", name)
			l_files_string := retrieve_files (Help_directory, False, True)
			l_files_string.append ("%T<File Url=%"NamedUrl.HxK%" />%N%T<File Url=%"FIndex.HxK%" />%N%T<File Url=%"KIndex.HxK%" />%N")
			template.add_symbol ("files", l_files_string)
			template.add_symbol ("directories", retrieve_files (Help_directory, True, True))
			template.save_file (project_file_name)
			create project_file.make (template.template_filename)
		end

	create_files_file is
			-- Create the project include files file
		local
			template: PLAIN_TEXT_TEMPLATE_FILE
			template_file: FILE_NAME
		do
			create template_file.make_from_string (Shared_constants.Application_constants.templates_path)
			template_file.extend ("HelpFilesTemplate.HxF")
			create template.make (template_file)
			template.add_symbol ("files", retrieve_files (help_directory, False, False))
			template.save_file (Help_directory.name + "\" + name + ".HxF")
			create files_file.make (template.template_filename)
		end
		
	create_collection_file is
			-- Create the projects collection file
		local
			template: PLAIN_TEXT_TEMPLATE_FILE		
			template_file: FILE_NAME
		do
			create template_file.make_from_string (Shared_constants.Application_constants.templates_path)
			template_file.extend ("HelpCollectionTemplate.HxC")
			create template.make (template_file)
			template.add_symbol ("project_name", name)
			template.save_file (Help_directory.name + "\" + name + ".HxC")
			create collection_file.make (template.template_filename)
		end
		
	create_hxk_files is
			-- Create the projects hxk files
		local
			template: PLAIN_TEXT_TEMPLATE_FILE
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string (Shared_constants.Application_constants.templates_path)
			l_file_name.extend ("NamedURL.HxK")
			create template.make (l_file_name.string)
			template.save_file (Help_directory.name + "\" + "NamedURL.HxK")

			create l_file_name.make_from_string (Shared_constants.Application_constants.templates_path)
			l_file_name.extend ("KIndex.HxK")
			create template.make (l_file_name.string)
			template.save_file (Help_directory.name + "\" + "KIndex.HxK")

			create l_file_name.make_from_string (Shared_constants.Application_constants.templates_path)
			l_file_name.extend ("FIndex.HxK")
			create template.make (l_file_name.string)
			template.save_file (Help_directory.name + "\" + "FIndex.HxK")			
		end

	create_stylesheet_file is
			-- Create the stylesheet
		do
			copy_stylesheet (temporary_help_location (Shared_project.root_directory, False))
		end

	project_file: PLAIN_TEXT_FILE
			-- Project File	

	files_file: PLAIN_TEXT_FILE
			-- Project File
		
	collection_file: PLAIN_TEXT_FILE
			-- Table of Contents File

	named_url_file: PLAIN_TEXT_FILE

	kindex_file: PLAIN_TEXT_FILE

	findex_file: PLAIN_TEXT_FILE

feature -- Commands

	build_table_of_contents is
			-- Build table of contents
		do
			create_toc_file
		end

	generate is
			-- Generate help project
		do
			generate_files
		end		

feature {NONE} -- Project

	retrieve_files (a_dir: DIRECTORY; get_dirs, tags: BOOLEAN): STRING is
			-- Retrieve the project files string or directories string if `get_dirs'
		local
			l_cnt,
			l_upper_count: INTEGER
			l_folder: DIRECTORY
			l_name: DIRECTORY_NAME
			l_url: STRING
			l_util: UTILITY_FUNCTIONS
		do		
			create l_util
			from
				l_cnt := 0
				l_upper_count := a_dir.count
				a_dir.open_read
				a_dir.start
				create Result.make_empty
			until
				l_cnt = l_upper_count
			loop
				a_dir.readentry
				if not (a_dir.lastentry.is_equal (".") or a_dir.lastentry.is_equal (".."))then
					create l_name.make_from_string (a_dir.name)
					l_name.extend (a_dir.lastentry)
					l_folder ?= create {DIRECTORY}.make (l_name)
					if l_folder.exists and then not l_folder.is_empty then
						if get_dirs then
							l_url := l_util.toc_friendly_url (a_dir.name.twin)			
							Result.append ("<Dir ")
							Result.append ("Url=%"" + l_url + "%"")
							Result.replace_substring_all ("/", "\")
							Result.replace_substring_all (shared_constants.application_constants.temporary_html_directory.string + "\", "")
							Result.append (" />%N")
						end
						Result.append (retrieve_files (l_folder, get_dirs, tags))
					else
						if not get_dirs and then (create {RAW_FILE}.make (l_name.string)).exists then
							l_url := l_util.toc_friendly_url (l_name.string)
							Result.append ("%T<File Url=%"" + l_url + "%"")
							Result.replace_substring_all ("/", "\")
							Result.replace_substring_all (shared_constants.application_constants.temporary_html_directory.string + "\", "")
							Result.append (" />%N")
						end						
					end
				end				
				l_cnt := l_cnt + 1
			end
			Result.replace_substring_all (" \>", " />")
		ensure
			non_void_result: Result /= Void
		end

	retrieve_images (a_path: STRING): STRING is
			-- Retrieve all image files and add to list of files in project
		require
			path_not_void: a_path /= Void
			path_exists: (create {DIRECTORY}.make (a_path)).exists
		local
			l_cnt,
			l_upper_count: INTEGER
			l_file: RAW_FILE
			l_dir, l_folder: DIRECTORY
			l_name: DIRECTORY_NAME
			l_url: STRING
			l_util: UTILITY_FUNCTIONS
		do
			create l_dir.make (a_path)
			create l_util
			from
				l_cnt := 0
				l_upper_count := l_dir.count
				l_dir.open_read
				l_dir.start
				create Result.make_empty
			until
				l_cnt = l_upper_count
			loop
				l_dir.readentry
				if not (l_dir.lastentry.is_equal (".") or l_dir.lastentry.is_equal (".."))then
					create l_name.make_from_string (a_path)
					l_name.extend (l_dir.lastentry)
					l_folder ?= create {DIRECTORY}.make (l_name)
					if l_folder.exists and then not l_folder.is_empty then
						Result.append (retrieve_images (l_name))
					else
						l_file ?= create {RAW_FILE}.make (l_name.string)
						if l_file /= Void and then image_file_types.has (file_type (l_file.name)) then				
							l_url := l_util.toc_friendly_url (l_file.name)
							Result.append ("%T<File Url=%"" + l_url + "%"")
							Result.replace_substring_all (shared_constants.application_constants.temporary_html_directory, "")
							Result.append ("/>%N")
						end
					end
				end				
				l_cnt := l_cnt + 1
			end
		end	

feature {NONE} -- Implementation

	compiled_filename_extension: STRING is
			-- Extension for this project compiled file
		do
			Result := "HxS"
		end

	project_filename_extension: STRING is
			-- Extension for this project type
		do
			Result := "HWProj"
		end
		
	toc_filename_extension: STRING is
			-- Extension for compiled help file
		do
			Result := "HxT"
		end

	full_toc_text: STRING is
			-- Full TOC text
		local
			l_formatter: TABLE_OF_CONTENTS_MSHELP_FORMATTER
		do
			create l_formatter.make (toc)
			Result := l_formatter.mshelp_text
		end		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class MSHELP_PROJECT
