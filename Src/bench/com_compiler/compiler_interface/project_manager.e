indexing
	description: "Root class for communication between COM component and compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_MANAGER
	
inherit
--	CEIFFEL_PROJECT_COCLASS_IMP
--		rename 
--			make as make_project_coclass
--		redefine
--			project_file_name,
--			ace_file_name,
--			project_directory,
--			valid_project,
--			last_error_message,
--			last_exception,
--			compiler,
--			is_compiled,
--			project_has_updated,
--			system_browser,
--			project_properties,
--			completion_information,
--			html_doc_generator,
--			retrieve_eiffel_project,
--			create_eiffel_project,
--			retrieve_project,
--			create_project
--		end
	
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
		
	PROJECT_MANAGER_ERRORS
		export
			{NONE} all
		end
		
	EXCEPTIONS
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize structure.
		do
--			make_project_coclass
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
		require else
			project_initialized: valid_project
		do
			if project_successfully_loaded then
				if system_browser_internal = Void then
					create system_browser_internal.make
				end
				Result := system_browser_internal
			else
				raise (last_error_message)
			end
		end

	completion_information: IEIFFEL_COMPLETION_INFO_INTERFACE is
			-- Completion information.
		do
			if project_successfully_loaded then
				if completion_information_internal = Void then
					create completion_information_internal.make
				end
				Result := completion_information_internal
			else
				raise (last_error_message)
			end
		end
			
	html_doc_generator: IEIFFEL_HTMLDOC_GENERATOR_INTERFACE is
			-- Html document generator for project
		require else
			project_initialized: valid_project
		do
			if project_successfully_loaded then
				if html_doc_generator_internal = Void then
					create html_doc_generator_internal.make
				end
				Result := html_doc_generator_internal
			else
				raise (last_error_message)
			end
		end
			
	valid_project: BOOLEAN is
			-- Is project valid?
		do
			Result := Valid_project_ref.item
		end

	last_error_message: STRING
			-- Last error message.
			
	last_exception: EXCEPTION
			-- last exception raised

	is_compiled: BOOLEAN is
			-- Has system been compiled?
		do
			Result := compiler.is_successful
		end
		
	project_has_updated: BOOLEAN is
			-- Have the project files been updated since last compilation.
		local
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
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
					a_class := classes.item(i)
					if a_class /= Void and then not a_class.is_precompiled and then not a_class.is_external then
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
		require else
			project_initialized: valid_project
		do
			Result := project_properties_internal
		end

feature -- Basic Operations

	retrieve_eiffel_project (a_project_file_name: STRING) is
			-- Retrieve Eiffel Project
			-- `a_project_file_name' [in].  
		require else
			non_void_file_name: a_project_file_name /= Void
			valid_file_name: not a_project_file_name.is_empty
		local
			l_file: RAW_FILE
			l_exception: EXCEPTION
			retried: BOOLEAN
		do
			-- clear last exception
			last_exception := Void
			
			-- load project
			if not valid_project then
				create l_file.make (valid_file_name (a_project_file_name))
				if not l_file.exists or else l_file.is_directory then
					create last_exception.make (errors_table.item (eif_exceptions_ace_file_does_not_exists), eif_exceptions_ace_file_does_not_exists)
					last_exception.raise
				else
					if not Eiffel_project.initialized then
						open_project_file (a_project_file_name)
						if not Eiffel_project.retrieval_error then
							create {PROJECT_PROPERTIES} project_properties_internal.make
							Valid_project_ref.set_item (True)
						end
					else
						create last_exception.make (errors_table.item (eif_exceptions_project_already_initialized), eif_exceptions_project_already_initialized)
						last_exception.raise
					end
				end
			end
		end

	create_eiffel_project (a_ace_file_name: STRING; a_project_directory_path: STRING) is
			-- Create new Eiffel project.
			-- `a_ace_file_name' [in].  
			-- `a_project_directory_path' [in].  
		require else
			non_void_ace_file_name: a_ace_file_name /= Void
			valid_ace_file_name: not a_ace_file_name.is_empty
			non_void_project_directory: a_project_directory_path /= Void
			valid_project_direction: not a_project_directory_path.is_empty
		local
			dir: DIRECTORY
			l_properties: PROJECT_PROPERTIES
		do
			-- clear last exception
			last_exception := Void
			
			if not valid_project then
				if not Eiffel_project.initialized then
					check_ace_file (a_ace_file_name)
					if valid_ace_file then
						Project_directory_name.wipe_out
						Project_directory_name.set_directory (a_project_directory_path)
						
						create dir.make (a_project_directory_path)
						if not dir.exists then
							dir.create_dir
						end
						
						create project_dir.make (a_project_directory_path, Void)
						Eiffel_project.make_new (project_dir, True, Void, Void)
						Eiffel_ace.set_file_name (a_ace_file_name)
						create {PROJECT_PROPERTIES} project_properties_internal.make
						l_properties ?= project_properties
						if not l_properties.msil_generation then
							Valid_project_ref.set_item (False)
							create last_exception.make (errors_table.item (Eif_exceptions_non_dotnet_project), Eif_exceptions_non_dotnet_project)
							last_exception.raise
						else
							Valid_project_ref.set_item (True)
						end
					else
						create last_exception.make (errors_table.item (eif_exceptions_invalid_ace_file), eif_exceptions_invalid_ace_file)
						last_exception.raise
					end
				else
					create last_exception.make (errors_table.item (eif_exceptions_project_already_initialized), eif_exceptions_project_already_initialized)
					last_exception.raise
				end
			end
		end

	retrieve_project (file_name: STRING) is
			-- Retrieve project.
		indexing
			obsolete "use retrieve_eiffel_project_instead"
		require else
			non_void_file_name: file_name /= Void
			valid_file_name: not file_name.is_empty
		local
			rescued: BOOLEAN
			file: RAW_FILE
			l_exception: EXCEPTION
			temp: INTEGER
		do
			-- clear last exception
			last_exception := Void
			
			-- FIXME Paul
			-- Need to added check for .NET project type
			-- use project_properties.msil_generation
			
			if not Valid_project_ref.item then
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
							create last_exception.make (errors_table.item (eif_exceptions_project_already_initialized), eif_exceptions_project_already_initialized)
							last_exception.raise
						end
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
		indexing
			obsolete "use create_eiffel_project instead"
		require else
			non_void_ace_name: ace_name /= Void
			valid_ace_name: not ace_name.is_empty
			non_void_project_directory: project_directory_path /= Void
			valid_project_direction: not project_directory_path.is_empty
		local
			dir: DIRECTORY
			pp: PROJECT_PROPERTIES
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
								Valid_project_ref.set_item (True)
								create {PROJECT_PROPERTIES} project_properties_internal.make
								pp ?= project_properties
								if not pp.msil_generation then
									Valid_project_ref.set_item (False)
									last_error_message := "Not a .NET ace file"
								end
								
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
			last_exception := Void
		
				-- Retrieve the project
			Eiffel_project.make (project_dir)

			if Eiffel_project.retrieval_error then
				if Eiffel_project.manager.is_created then
					Eiffel_project.manager.on_project_close
				end
				if Eiffel_project.is_incompatible then
					create last_exception.make (errors_table.item (eif_exceptions_project_incompatible), eif_exceptions_project_incompatible)
					last_exception.raise
				else
					if Eiffel_project.is_corrupted then
						create last_exception.make (errors_table.item (eif_exceptions_project_file_corrupted), eif_exceptions_project_file_corrupted)
						last_exception.raise
					elseif Eiffel_project.retrieval_interrupted then
						create last_exception.make ("Project retrieval interrupted", eif_exceptions_unspecified)
						last_exception.raise
					end
				end
			elseif Eiffel_project.incomplete_project then
				create last_exception.make (errors_table.item (eif_exceptions_project_incomplete), eif_exceptions_project_incomplete)
				last_exception.raise
			elseif Eiffel_project.read_write_error then
				create last_exception.make (errors_table.item (eif_exceptions_ioerror), eif_exceptions_ioerror)
				last_exception.raise
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
		
		
feature {NONE} -- New Implementation ENViSioN! 2.0

	project_successfully_loaded: BOOLEAN is
			-- has a project been loaded, and loaded succesfully
		do
			if eiffel_project /= Void and then eiffel_project.initialized and then not eiffel_project.retrieval_error then
				Result := True
			end
		end
		
		
end -- class PROJECT_MANAGER
