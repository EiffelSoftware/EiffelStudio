indexing
	description: "Root class for communication between COM component and compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_MANAGER
	
inherit
	SHARED_EIFFEL_PROJECT
		export {NONE}
			all
		end
	
	PROJECT_CONTEXT
		export {NONE}
			all
		end
		
	EIFFEL_ENV
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize structure.
		do
			valid_ace_file := False
			create last_error_message.make_from_string ("No project loaded")
			create eifgen_init.make
				--| FIXME do not forget to call `dispose' one day !
		end

feature -- Access

	compiler: IEIFFEL_COMPILER_INTERFACE is
			-- Compiler.
		do
			if compiler_internal = Void then
				create compiler_internal.make
			end
			Result := compiler_internal
		end
		
	system_browser: IEIFFEL_SYSTEM_BROWSER_INTERFACE is
			-- System Browser.
		require
			project_initialized: valid_project
		do
			if system_browser_internal = Void then
				create system_browser_internal.make
			end
			Result := system_browser_internal
		end

	completion_information: IEIFFEL_COMPLETION_INFO_INTERFACE is
			-- Completion information.
		do
			if completion_information_internal = Void then
				create completion_information_internal.make
			end
			Result := completion_information_internal
		end
			
	html_doc_generator: IEIFFEL_HTMLDOC_GENERATOR_INTERFACE is
			-- Html document generator for the project
		require
			project_initialized: valid_project
		do
			if html_doc_generator_internal = Void then
				create html_doc_generator_internal.make
			end
			Result := html_doc_generator_internal
		end
			
	valid_project: BOOLEAN is
			-- Is project valid?
		do
			Result := Valid_project_ref.item
		end

	last_error_message: STRING
			-- Last error message.

	is_compiled: BOOLEAN is
			-- Has system been compiled?
		do
			Result := compiler.is_successful
		end
		
	project_has_updated: BOOLEAN is
			-- Have the project files been updated since last compilation.
		local
			classes: ARRAY [CLASS_C]
			i, count: INTEGER
		do
			if Eiffel_project.initialized and Eiffel_project.system_defined and then Eiffel_system.Workbench.successful then
				classes := Eiffel_system.Workbench.system.classes.sorted_classes
				count := classes.count
				from
					i := 1
				until
					Result or else i > count
				loop
					if not classes.item (i).is_external then
						-- We don't need to query external classes.
						Result := classes.item (i).lace_class.date_has_changed
					end
					i := i + 1
				end
			end	
		end	

	project_file_name: STRING is
			-- Full path to .epr file.
		local
			f: FILE_NAME
		do
			if Eiffel_project.initialized and project_properties /= Void and project_properties.system_name /= Void then
				create f.make_from_string (Eiffel_project.project_directory.name)
				f.set_file_name (project_properties.system_name)
				f.add_extension ("epr")
				Result := f				
			end
		end

	ace_file_name: STRING is
			-- Full path to Ace file.
		do
			if Eiffel_project.initialized then
				Result := Eiffel_ace.file_name				
			end
		end

	project_directory: STRING is
			-- Project directory.
		do
			if Eiffel_project.initialized then
				Result := Eiffel_project.project_directory.name				
			end
		end
		
	project_properties: IEIFFEL_PROJECT_PROPERTIES_INTERFACE is
			-- Project Properties.
			-- Void until a project is opened.
		require
			project_initialized: valid_project
		do
			Result := project_properties_internal
		end

feature -- Basic Operations

	retrieve_project (file_name: STRING) is
			-- Retrieve project.
		require
			non_void_file_name: file_name /= Void
			valid_file_name: not file_name.is_empty
		local
			rescued: BOOLEAN
			file: RAW_FILE
		do
			if not Valid_project_ref.item then
				if not rescued then
					if file_name /= Void then
						create file.make (valid_file_name (file_name))
						if not file.exists or else file.is_directory then
							last_error_message := "File does not exist"
						else
							if not Eiffel_project.initialized then
								open_project_file (file_name)
								if not Eiffel_project.retrieval_error then
									create {PROJECT_PROPERTIES} project_properties_internal.make
									Valid_project_ref.set_item (True)
								end
							else
								last_error_message := "Project has already been initialized"
							end
						end
					else
						last_error_message := "File name is void"
					end
				end
			end
		rescue
			last_error_message := "Project could not be retrieved"
			rescued := True
			retry
		end

	create_project (ace_name: STRING; project_directory_path: STRING) is
			-- Create new project.
		require
			non_void_ace_name: ace_name /= Void
			valid_ace_name: not ace_name.is_empty
			non_void_project_directory: project_directory_path /= Void
			valid_project_direction: not project_directory_path.is_empty
		local
			enum: ECOM_X__EIF_COMPILATION_TYPES_ENUM
			dir: DIRECTORY
		do
			if not Valid_project_ref.item then
				if ace_name /= Void and project_directory_path /= Void then
					if  not Eiffel_project.initialized then
						check_ace_file (ace_name)
						if valid_ace_file then
							Project_directory_name.wipe_out
							Project_directory_name.set_directory (project_directory_path)
							
							create dir.make (project_directory_path)
							if not dir.exists then
								dir.create_dir
							end
							
							create project_dir.make (project_directory_path, Void)
							Eiffel_project.make_new (project_dir, True, Void, Void)
							if Eiffel_project.initialized then
								Eiffel_ace.set_file_name (ace_name)
								create {PROJECT_PROPERTIES} project_properties_internal.make
								create enum
								Valid_project_ref.set_item (True)
							else
								last_error_message := "Project could not be initialized"
							end
						else
							last_error_message := "Could not load project settings"
						end
					else
						last_error_message := "Project has already been initialized"
					end
				else
					last_error_message := "File name is void"
				end
			end
		end
		
feature {NONE} -- Project directory access

	project_dir: PROJECT_DIRECTORY
			-- Location of the project directory.

	project_file: PROJECT_EIFFEL_FILE
			-- Location of the file where all the information 
			-- about the current project are saved.
			
feature {NONE} -- Project Initialization

	open_project_file (file_name: STRING) is
			-- Initialize project as a new one or retrieving
			-- existing data in the valid directory `project_dir'.
		require
			file_name_non_void: file_name /= Void
		local
			dir_name: STRING
		do
			dir_name := file_name.substring (1, file_name.last_index_of
				(Operating_environment.Directory_separator, file_name.count) - 1)

				--| Retrieve existing project
			create project_file.make (file_name)
			
			create project_dir.make (dir_name, project_file)
			Project_directory_name.wipe_out
			Project_directory_name.set_directory (dir_name)

			retrieve_project_internal
		end

	retrieve_project_internal is
			-- Retrieve a project from the disk.
		require
			project_directory_exists: project_dir /= Void
		local
			project_name: STRING
		do	
				-- Retrieve the project
			Eiffel_project.make (project_dir)

			if Eiffel_project.retrieval_error then
				if Eiffel_project.manager.is_created then
					Eiffel_project.manager.on_project_close
				end
				if Eiffel_project.is_incompatible then
					last_error_message := "Project has been created with another version"
				else
					if Eiffel_project.is_corrupted then
						last_error_message := "Project is corrupted"
					elseif Eiffel_project.retrieval_interrupted then
						last_error_message := "Project retrieval interrupted"
					end
				end
			elseif Eiffel_project.incomplete_project then
				last_error_message := "Project is incomplete"
			elseif Eiffel_project.read_write_error then
				last_error_message := "Read/Write error"
			end

			if not Eiffel_project.error_occurred then
				project_name := project_dir.name
				if project_name.item (project_name.count) = Operating_environment.Directory_separator then
					project_name.keep_head (project_name.count -1)
				end
			end
		end
							
feature {NONE} -- Implementation

	compiler_internal: COMPILER
		-- Compiler.
	
	system_browser_internal: SYSTEM_BROWSER
		-- System Browser.
	
	completion_information_internal: COMPLETION_INFORMATION
		-- Member completion information.
	
	html_doc_generator_internal: HTML_DOC_GENERATOR
		-- Html doc generator.

	valid_file_name (file_name: STRING): STRING is
			-- Generate a valid file name from `file_name'
			--| Useful when the file name is a directory with a 
			--| directory separator at the end.
		require
			file_name_not_void: file_name /= Void
		local
			last_char: CHARACTER
		do
			last_char := file_name.item (file_name.count)
			if last_char = Operating_environment.Directory_separator then
				Result := clone (file_name)
				Result.remove (file_name.count)
			else
				Result := file_name	
			end
		end
	
	check_ace_file (ace_name: STRING) is
			-- Check if ace file `ace_name' exists and is readable.
		require
			name_not_void: ace_name /= Void
		local
			ace_file: FILE
		do
			valid_ace_file := False
			if not ace_name.is_empty then
				create {RAW_FILE} ace_file.make (ace_name)
				valid_ace_file := ace_file.exists and ace_file.is_readable
			end
		end
		
	project_properties_internal: IEIFFEL_PROJECT_PROPERTIES_INTERFACE
			-- Instance-specific representation of project properties.
			-- Might be Void if another instance succesfully initialized project.
		
	valid_ace_file: BOOLEAN
			-- Was last file checked by `check_ace_file' a valid ace file?
			
	eifgen_init: INIT_SERVERS
			-- Run-time.
			
	Valid_project_ref: BOOLEAN_REF is
			-- Has a valid project been loaded already?
		once
			create Result
			Result.set_item (False)
		end
		
end -- class PROJECT_MANAGER
