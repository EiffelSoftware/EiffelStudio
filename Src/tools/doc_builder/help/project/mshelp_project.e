indexing
	description: "Microsoft Help 2.0 Project (VSIP)."
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
		do
			create template_file.make_from_string (Shared_constants.Application_constants.Templates_path)
			template_file.extend ("HelpProjectTemplate.hwproj")
			create template.make (template_file)
			template.add_symbol ("project_name", name)
			template.add_symbol ("files", retrieve_files (False, True))
			template.add_symbol ("directories", retrieve_files (True, True))
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
			template.add_symbol ("files", retrieve_files (False, False))
			template.save_file (Help_directory.out + "\" + name + ".HxF")
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
			template.save_file (Help_directory.out + "\" + name + ".HxC")
			create collection_file.make (template.template_filename)
		end

	project_file: PLAIN_TEXT_FILE
			-- Project File	

	files_file: PLAIN_TEXT_FILE
			-- Project File
		
	collection_file: PLAIN_TEXT_FILE
			-- Table of Contents File

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

	retrieve_files (get_dirs, tags: BOOLEAN): STRING is
			-- Retrieve the project files string or directories string if `get_dirs'
		local
			l_help_topic: TABLE_OF_CONTENTS_NODE
			l_help_topics: ARRAYED_LIST [TABLE_OF_CONTENTS_NODE]
			l_title, l_url: STRING
			l_util: UTILITY_FUNCTIONS
		do		
			create l_util
			create Result.make_empty
			from
				l_help_topics := toc.nodes (True)
				l_help_topics.start
			until
				l_help_topics.after
			loop
				l_help_topics.forth
				l_help_topic :=  l_help_topics.item
				l_url := l_help_topic.url
				l_title := l_help_topic.title
				if get_dirs then
					if l_help_topic.url_is_directory then
						Result.append ("<Dir ")
						if l_url /= Void then
							l_url := l_util.toc_friendly_url (l_url)
							l_url := l_util.directory_no_file_name (l_url)
							Result.append ("Url=%"" + l_url + "%"")
						end					
						if tags and then l_title /= Void then
							Result.append (" Title=%"" + l_title + "%"")
						end
						Result.append ("/>%N")
					end
				else
					Result.append ("%T<File ")
					if l_url /= Void then
						l_url := l_util.toc_friendly_url (l_url)
						l_url := l_util.file_no_extension (l_url)
						l_url.append (".html")
						Result.append ("Url=%"" + l_url + "%"")
					end
					
					if tags and then l_title /= Void then
						Result.append (" Title=%"" + l_title + "%"")
					end
					Result.append ("/>%N")					
				end
				l_help_topics.forth
			end
			if not get_dirs then
						-- Retrieve images
				Result.append (retrieve_images (Shared_constants.Application_constants.Temporary_help_directory))
			end					
		ensure
			non_void_result: Result /= Void
		end

	retrieve_images (a_path: STRING): STRING is
			-- Retrieve all image files and add to list of files in project
		require
			path_not_void: a_path /= Void
			path_exists: (create {DIRECTORY}.make (a_path)).exists
		local
			l_cnt: INTEGER
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
				l_dir.open_read
				l_dir.start
				create Result.make_empty
			until
				l_cnt = l_dir.count
			loop
				l_dir.readentry
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
						Result.replace_substring_all (shared_constants.application_constants.temporary_help_directory, "")
						Result.append ("/>%N")
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

end -- class MSHELP_PROJECT
