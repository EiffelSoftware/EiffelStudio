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
		export
			{NONE} all
			{ANY} True_string, False_string, Optimal_string
		end
		
	GB_FILE_CONSTANTS
		export
			{NONE} all
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end

create
	default_create,
	make_envision_with_default_values,
	make_stand_alone_with_default_values

feature {NONE} -- Initialization

	make_envision_with_default_values is
			-- Create `Current', mark as an Envision project,
			-- and initialize to default values.
		do
			set_default_values
			project_type := envision_project
		end
		
	make_stand_alone_with_default_values is
			-- Create `Current', mark as a stand alone Build project,
			-- and intiailize_to_default_values.
		do
			set_default_values
			project_type := stand_alone_project
		end
		
	set_default_values is
			-- Initialize default values.
		do
			main_window_class_name := "MAIN_WINDOW"
			application_class_name := "VISION2_APPLICATION"
			project_name := "VISION2_PROJECT"
			enable_complete_project
			enable_grouped_locals
			enable_rebuild_ace_file
			disable_constant_loading
		end

feature -- Access

	project_type: INTEGER
		-- Type of project that `Current' represents.
		
	is_stand_alone_project: BOOLEAN is
			-- Does `Current' represent a stand alone project?
			-- i.e. regular Build, not Envision.
		do
			Result := project_type = Stand_alone_project
		end
		
	is_envision_project: BOOLEAN is
			-- Does `Current' represent an Envision project?
		do
			Result := project_type = Envision_project
		end

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
		
	attributes_local: STRING
		-- Should attributes be generated as locals?
		
	project_name: STRING
		-- Name of project.
		
	client_of_window: BOOLEAN
		-- Should generated code use EV_WINDOW as client?
		-- If False, then we inherit EV_WINDOW.
		
	load_constants: BOOLEAN
		-- Should generated constants be loaded from a text file,
		-- or hard coded into the generated constants file?
		
	rebuild_ace_file: BOOLEAN
		-- Should we rebuild ace file every time?
		
	load_cancelled: BOOLEAN
		-- Was last call to `load' cancelled by user?
		-- This can only occur if the file was in an old format, and
		-- they selected not to update to current format.
	
feature -- Basic operation

	save is
			-- Save `Current' to `project_location'.
		local
			file_handler: GB_SIMPLE_XML_FILE_HANDLER
			file_name: FILE_NAME
			data: ARRAYED_LIST [TUPLE [STRING, STRING]]
		do
			create data.make (0)
			data.extend ([project_type_string, project_type.out])
			data.extend ([project_name_string, project_name.out])
			data.extend ([project_location_string, project_location])
			data.extend ([main_window_class_name_string, main_window_class_name])
			data.extend ([application_class_name_string, application_class_name])
			data.extend ([complete_project_string, complete_project.out])
			data.extend ([grouped_locals_string, grouped_locals.out])
			data.extend ([debugging_output_string, debugging_output.out])
			data.extend ([attributes_local_string, attributes_local.out])
			data.extend ([client_of_window_string, client_of_window.out])
			data.extend ([rebuild_ace_file_string, rebuild_ace_file.out])
			data.extend ([load_constants_string, load_constants.out])
			
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
			dialog: GB_TWO_BUTTON_ERROR_DIALOG
		do
			load_cancelled := False
				-- Reset in case this is the second attempt at loading.
			data := file_handler.load_file (a_file_name)
				-- We only retrieve the data if the
				-- loading completed succcessfully.
			if file_handler.last_load_successful then
				check
					data_not_void: data /= Void
				end
				if data.count = 11 or data.count = 12 then
					set_integer_attribute (data @ 1, agent set_project_type (?))
					set_string_attribute (data @ 2, agent set_project_name (?))
					set_string_attribute (data @ 3, agent set_project_location (?))
					set_string_attribute (data @ 4, agent set_main_window_class_name (?))
					set_string_attribute (data @ 5, agent set_application_class_name (?))
					set_boolean_attribute (data @ 6, agent enable_complete_project, agent disable_complete_project)
					set_boolean_attribute (data @ 7, agent enable_grouped_locals, agent disable_grouped_locals)
					set_boolean_attribute (data @ 8, agent enable_debugging_output, agent disable_debugging_output)
					set_string_attribute (data @ 9, agent set_attributes_locality (?))
					set_boolean_attribute (data @ 10, agent enable_client_of_window, agent disable_client_of_window)
					set_boolean_attribute (data @ 11, agent enable_rebuild_ace_file, agent disable_rebuild_ace_file)
				end
				if data.count = 12 then
					set_boolean_attribute (data @ 12, agent enable_constant_loading, agent disable_constant_loading)
				end
				if data.count /= 11 and data.count /= 12 then
					create dialog.make_with_text (invalid_bpr_file)
					dialog.button ((create {EV_DIALOG_CONSTANTS}).ev_abort).select_actions.extend (agent cancel_load)
					dialog.show_modal_to_window (main_window)
				end
			end
		end
		
	cancel_load is
			-- Assign `true' to `load_cancelled'.
		do
			load_cancelled := True
		end
		

feature -- Status Setting

	set_project_type (a_type: INTEGER) is
			-- Assign `a_type' to `project_type'.
		do
			project_type := a_type
		ensure
			set: project_type.is_equal (a_type)
		end

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
		
	enable_client_of_window is
			-- Assign `True' to `client_of_window'.
		do
			client_of_window := True
		end
		
	disable_client_of_window is
			-- Assign `False' to `client_of_window'.
		do
			client_of_window := False
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
		
	set_attributes_locality (locality: STRING) is
			-- Assign `locality' to `attributes_local'.
		require
			valid_locality: locality.is_equal (True_string) or locality.is_equal (False_string) or
				locality.is_equal (Optimal_string)
		do
			attributes_local := locality
		end

	enable_rebuild_ace_file is
			-- Assign `True' to `rebuild_ace_file'.
		do
			rebuild_ace_file := True
		end
		
	disable_rebuild_ace_file is
			-- Assign `False' to `rebuild_ace_file'.
		do
			rebuild_ace_file := False
		end
		
	enable_constant_loading is
			-- Assign `True' to `load_constants'.
		do
			load_constants := True
		end
		
	disable_constant_loading is
			-- Assign `False' to `load_constants'.
		do
			load_constants := False
		end

feature {NONE} -- Constants

	stand_alone_project: INTEGER is 1
		-- Project was created in stand alone version of Build.
	
	envision_project: INTEGER is 2
		-- Project was created as an Envision project.
		

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
	
	client_of_window_string: STRING is "Client_of_window"
	
	rebuild_ace_file_string: STRING is "Rebuild_ace_file"
	
	load_constants_string: STRING is "Load_constants_from_file"
	
	project_type_string: STRING is "Project_type"
	
		-- Type of Current project. We must store this information
		-- in the save file, so we know what sort of processing to perform
		-- when we double click on the .bpr file.
		
	set_integer_attribute (temp_tuple: TUPLE [STRING, STRING]; an_agent: PROCEDURE [ANY, TUPLE [INTEGER]]) is
			-- Call `an_agent' with `temp_tuple' @ 2 string converted to an INTEGER.
		local
			temp_string: STRING
		do
			temp_string ?= temp_tuple @ 2
			check
				data_was_string: temp_string /= Void and temp_string.is_integer
			end
			an_agent.call ([temp_string.to_integer])
		end
		
	
	set_string_attribute (temp_tuple: TUPLE [STRING, STRING]; an_agent: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Call `an_agent' with `temp_tuple' @ 2 string.
		do
			an_agent.call ([(temp_tuple @ 2).out])
		end
		
	set_boolean_attribute (temp_tuple: TUPLE [STRING, STRING]; true_agent, false_agent: PROCEDURE [ANY, TUPLE]) is
			-- If `temp_tuple' @ 2 is `True_string' then call `true_agent', else call `false_agent'.
		local
			temp_string: STRING
		do
			temp_string ?= temp_tuple @ 2
			check
				data_was_string: temp_string /= Void
			end
			if temp_string. is_equal (True_string) then
				true_agent.call ([])
			else
				false_agent.call ([])
			end
		end
	
end -- class GB_PROJECT_SETTINGS
