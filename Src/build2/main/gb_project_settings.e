indexing
	description: "Objects that represent project settings."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PROJECT_SETTINGS
	
inherit
	
	ANY
	
	GB_CONSTANTS

create
	default_create,
	make_with_default_values

feature {NONE} -- Initialization

	make_with_default_values is
			-- Create `Current' and initialize to default values.
		do
			main_window_class_name := "MAIN_WINDOW"
			application_class_name := "VISION2_APPLICATION"
			project_name := "VISION2_PROJECT"
			enable_complete_project
			enable_grouped_locals
		end
		

feature -- Access

	project_location: STRING
		-- Project location.
		-- Maybe this should be assigned when loaded.
		
	main_window_class_name: STRING
		-- Class name to be given to the main window in the generated code.
		
	application_class_name: STRING
		-- Class name to be given to the application in the generated code.
		
	complete_project: BOOLEAN
		-- Should we generate an ace file and an application class to
		-- complete a system involving the newly generated class.
		
	grouped_locals: BOOLEAN
		-- Should local variables be grouped by type, or declared on a separate line
		-- for each?
		
	debugging_output: BOOLEAN
		-- Should debugging output be generated for each feature connected to an
		-- action sequence?
		
	attributes_local: BOOLEAN
		-- Should attributes be generated as locals?
		
	project_name: STRING
		-- Name of project.
	
feature -- Basic operation

	save is
			-- Save `Current' to `project_location'.
		local
			file_handler: GB_SIMPLE_XML_FILE_HANDLER
			file_name: FILE_NAME
			data: ARRAYED_LIST [TUPLE [STRING, STRING]]
		do
			create data.make (0)
			data.extend ([project_location_string, project_location])
			data.extend ([main_window_class_name_string, main_window_class_name])
			data.extend ([application_class_name_string, application_class_name])
			data.extend ([complete_project_string, complete_project.out])
			data.extend ([grouped_locals_string, grouped_locals.out])
			data.extend ([debugging_output_string, debugging_output.out])
			data.extend ([attributes_local_string, attributes_local.out])
			data.extend ([project_name_string, project_name.out])
			create file_name.make_from_string (project_location)
			file_name.extend (project_filename)
			create file_handler
			file_handler.create_file ("Project_settings", file_name, data)
		end
		
	load (a_file_name: STRING; file_handler: GB_SIMPLE_XML_FILE_HANDLER) is
			-- Load `Current' from file `a_file_name' in location `project_location'.
		require
			file_handler_not_void: file_handler /= Void
		local
			data: ARRAYED_LIST [TUPLE [STRING, STRING]]
			temp_tuple: TUPLE [STRING, STRING]
			temp_string :STRING
		do
			data := file_handler.load_file (a_file_name)
				-- We only retrieve the data if the
				-- loading completed succcessfully.
			if file_handler.last_load_successful then
				check
					data_not_void: data /= Void
					data_count_is_7: data.count = 7
				end
				temp_tuple := data @ 1
				temp_string ?= temp_tuple @ 2
				check
					data_was_string: temp_string /= Void
				end
				set_project_location (temp_string)
				
				temp_tuple := data @ 2
				temp_string ?= temp_tuple @ 2
				check
					data_was_string: temp_string /= Void
				end
				set_main_window_class_name (temp_string)
				
				temp_tuple := data @ 3
				temp_string ?= temp_tuple @ 2
				check
					data_was_string: temp_string /= Void
				end
				set_application_class_name (temp_string)
				
				temp_tuple := data @ 4
				temp_string ?= temp_tuple @ 2
				check
					data_was_string: temp_string /= Void
				end
				if temp_string.is_equal ("True") then
					complete_project := True
				else
					complete_project := False
				end
				
				temp_tuple := data @ 5
				temp_string ?= temp_tuple @ 2
				check
					data_was_string: temp_string /= Void
				end
				if temp_string.is_equal ("True") then
					grouped_locals := True
				else
					grouped_locals := False
				end
				
				temp_tuple := data @ 6
				temp_string ?= temp_tuple @ 2
				check
					data_was_string: temp_string /= Void
				end
				if temp_string.is_equal ("True") then
					debugging_output := True
				else
					debugging_output := False
				end
				
				temp_tuple := data @ 7
				temp_string ?= temp_tuple @ 2
				check
					data_was_string: temp_string /= Void
				end
				if temp_string.is_equal ("True") then
					attributes_local := True
				else
					attributes_local := False
				end
				
				temp_tuple := data @ 8
				temp_string ?= temp_tuple @ 2
				check
					data_was_string: temp_string /= Void
				end
				set_project_name (temp_string)
			end
		end

feature -- Status Setting

	set_project_location (location: STRING) is
			-- Assign `location' to `project_location'.
		require
			location_not_void: location /= Void
		do
			project_location := location
		ensure
			project_location.is_equal (location)
		end
		
	set_main_window_class_name (name: STRING) is
			-- Assign `name' to `main_window_class_name'.
		require
			name_not_void: name /= Void
		do
			main_window_class_name := name
		ensure
			main_window_class_name.is_equal (name)
		end
		
	set_application_class_name (name: STRING) is
			-- Assign `name' to `application_class_name'.
		require
			name_not_void: name /= Void
		do
			application_class_name := name
		ensure
			application_class_name.is_equal (name)
		end
		
	set_project_name (name: STRING) is
			--  Assign `name' to `project_name'.
		require
			name_not_void: name /= Void
		do
			project_name := name
		ensure
			project_name.is_equal (name)
		end
		
		
	enable_complete_project is
			-- Assign `True' to `complete_project'.
		do
			complete_project := True
		end
		
	disable_complete_project is
			-- Assign `False' to `complete_project'.
		do
			complete_project := False
		end
		
	enable_grouped_locals is
			-- Assign `True' to `grouped_locals'.
		do
			grouped_locals := True
		end
		
	disable_grouped_locals is
			-- Assign `False' to `grouped_locals'.
		do
			grouped_locals := False
		end
		
	enable_debugging_output is
			-- Assign `True' to `debugging_output'.
		do
			debugging_output := True
		end
		
	disable_debugging_output is
			-- Assign `False' to `debugging_output'.
		do
			debugging_output := False
		end
		
	enable_attributes_local is
			-- Assign `True' to `attributes_local'.
		do
			attributes_local := True
		end
		
	disable_attributes_local is
			-- Assign `False' to `attributes_local'.
		do
			attributes_local := False
		end


feature {NONE} --Implementation

		-- Constants for saving to XML.
	project_location_string: STRING is "Project_location"

	main_window_class_name_string: STRING is "Main_window_class_name"
		
	application_class_name_string: STRING is "Application_class_name"
		
	complete_project_string: STRING is "Complete_project"
	
	grouped_locals_string: STRING is "Group_locals"
	
	debugging_output_string: STRING is "Generate_debugging_output"
	
	attributes_local_string: STRING is "Attributes_local"
	
	project_name_string: STRING is "Project_name"
	
end -- class GB_PROJECT_SETTINGS
