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
			main_window_file_name := "main_window.e"
			enable_complete_project
			enable_grouped_locals
		end
		

feature -- Access

	project_location: STRING
		-- Project location.
		-- Maybe this should be assigned when loaded.
		
	main_window_class_name: STRING
		-- Class name to be given to the main window in the generated code.
		
	main_window_file_name: STRING
		-- File name to generate the main window class text into.
		
	complete_project: BOOLEAN
		-- Should we generate an ace file and an application class to
		-- complete a system involving the newly generated class.
		
	grouped_locals: BOOLEAN
		-- Should local variables be grouped by type, or declared on a separate line
		-- for each?
	
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
			data.extend ([main_window_file_name_string, main_window_file_name])
			data.extend ([complete_project_string, complete_project.out])
			data.extend ([grouped_locals_string, grouped_locals.out])
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
					data_count_is_5: data.count = 5
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
				set_main_window_file_name (temp_string)
				
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
		
	set_main_window_file_name (name: STRING) is
			-- Assign `name' to `main_window_file_name'.
		require
			name_not_void: name /= Void
		do
			main_window_file_name := name
		ensure
			main_window_file_name.is_equal (name)
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
		
feature {NONE} --Implementation

		-- Constants for saving to XML.
	project_location_string: STRING is "Project_location"

	main_window_class_name_string: STRING is "Main_window_class_name"
		
	main_window_file_name_string: STRING is "Main_window_file_name"
		
	complete_project_string: STRING is "Complete_project"
	
	grouped_locals_string: STRING is "Group_locals"
	
end -- class GB_PROJECT_SETTINGS
