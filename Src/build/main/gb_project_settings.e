indexing
	description: "Objects that represent project settings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			{ANY} True_string, False_string, False_optimal_string, False_non_exported_string
		end

	GB_FILE_CONSTANTS
		export
			{NONE} all
		end

	GB_NAMING_UTILITIES
		export
			{NONE} all
			{ANY} valid_class_name
		end

create
	make_with_components,
	make_with_default_values


feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

	make_with_default_values (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current', mark as a stand alone Build project,
			-- and intiailize_to_default_values. Assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			set_default_values
		ensure
			components_set: components = a_components
		end

	set_default_values is
			-- Initialize default values.
		do
			main_window_class_name := "MAIN_WINDOW"
			application_class_name := "VISION2_APPLICATION"
			project_name := "VISION2_PROJECT"
			attributes_local := False_optimal_string
			enable_complete_project
			enable_grouped_locals
			enable_rebuild_ace_file
			disable_constant_loading
			constants_class_name := "CONSTANTS"
			generation_location := ""
		end

feature -- Access

	project_type: INTEGER
		-- Type of project that `Current' represents.

	project_location: STRING
		-- Project location.
		-- Maybe this should be assigned when loaded.

	main_window_class_name: STRING
		-- Class name to be given to the main window in the generated code.

	application_class_name: STRING
		-- Class name to be given to the application in the generated code.

	constants_class_name: STRING
		-- Class name used for generated constants file.

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

	load_constants: BOOLEAN
		-- Should generated constants be loaded from a text file,
		-- or hard coded into the generated constants file?

	rebuild_ace_file: BOOLEAN
		-- Should we rebuild ace file every time?

	load_cancelled: BOOLEAN
		-- Was last call to `load' cancelled by user?
		-- This can only occur if the file was in an old format, and
		-- they selected not to update to current format.

	loaded_project_had_client_information: BOOLEAN
		-- Was client information for the project contained directly in the project file?
		-- This is only true for older projects. In this case, we must now set the client
		-- information for all windows to match the original setting from the file.

	generation_location: STRING
		-- Location for generation of all files and structure. If empty,
		-- generation is performed at the current project location.

	actual_generation_location: STRING is
			-- Actual location for generated files.
		do
			if generation_location.is_empty then
				Result := project_location
			else
				Result := generation_location
			end
		ensure
			result_not_void: Result /= Void
		end

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
			data.extend ([rebuild_ace_file_string, rebuild_ace_file.out])
			data.extend ([load_constants_string, load_constants.out])
			data.extend ([constants_class_name_string, constants_class_name])
			if not generation_location.is_empty then
				data.extend ([generation_location_string, generation_location])
			end

			create file_name.make_from_string (project_location)
			file_name.extend (project_filename)
			create file_handler.make_with_components (components)
			file_handler.create_file ("Project_settings", file_name, data)
		end

	load (a_file_name: STRING; file_handler: GB_SIMPLE_XML_FILE_HANDLER) is
			-- Load `Current' from file `a_file_name' in location `project_location'.
		require
			file_name_not_void: a_file_name /= Void
			file_handler_not_void: file_handler /= Void
		local
			data: HASH_TABLE [STRING, STRING]--ARRAYED_LIST [TUPLE [STRING, STRING]]
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
				set_integer_attribute (data @ project_type_string, agent set_project_type)
				set_string_attribute (data @ project_name_string, agent set_project_name)
				set_string_attribute (data @ project_location_string, agent set_project_location)
				set_string_attribute (data @ main_window_class_name_string, agent set_main_window_class_name)
				set_string_attribute (data @ application_class_name_string, agent set_application_class_name)
				set_boolean_attribute (data @ complete_project_string, agent enable_complete_project, agent disable_complete_project)
				set_boolean_attribute (data @ grouped_locals_string, agent enable_grouped_locals, agent disable_grouped_locals)
				set_boolean_attribute (data @ debugging_output_string, agent enable_debugging_output, agent disable_debugging_output)
				set_string_attribute (data @ attributes_local_string, agent set_attributes_locality)
				if data.has (client_of_window_string) then
					if data.item (client_of_window_string).is_equal (true_string) then
						loaded_project_had_client_information := True
					end
				end
				set_boolean_attribute (data @ rebuild_ace_file_string, agent enable_rebuild_ace_file, agent disable_rebuild_ace_file)

				if data.has (load_constants_string) then
					set_boolean_attribute (data @ load_constants_string, agent enable_constant_loading, agent disable_constant_loading)
				end
				if data.has (constants_class_name_string) then
					set_string_attribute (data @ constants_class_name_string, agent set_constants_class_name)
				else
					set_constants_class_name ("CONSTANTS")
				end
				if data.has (generation_location_string) then
					set_string_attribute (data @ generation_location_string, agent set_generation_location)
				else
					set_string_attribute ("", agent set_generation_location)
				end
				if data.count < 11 or data.count > 14 then
					create dialog.make_with_text (invalid_bpr_file)
					dialog.button ((create {EV_DIALOG_CONSTANTS}).ev_abort).select_actions.extend (agent cancel_load)
					dialog.show_modal_to_window (components.tools.main_window)
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
			valid_class_name: valid_class_name (name)
		do
			main_window_class_name := name.twin
		ensure
			main_window_class_name.is_equal (name)
		end

	set_application_class_name (name: STRING) is
			-- Assign `name' to `application_class_name'.
		require
			name_not_void: name /= Void
			valid_class_name: valid_class_name (name)
		do
			application_class_name := name.twin
		ensure
			application_class_name.is_equal (name)
		end

	set_constants_class_name (name: STRING) is
			-- Assign `name' to `constants_class_name'.
		require
			name_not_void: name /= Void
			valid_class_name: valid_class_name (name)
		do
			constants_class_name := name.twin
		ensure
			constants_class_name.is_equal (name)
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

	set_attributes_locality (locality: STRING) is
			-- Assign `locality' to `attributes_local'.
		require
			valid_locality: locality.is_equal (True_string) or locality.is_equal (False_string) or
				locality.is_equal (False_optimal_string) or locality.is_equal (false_non_exported_string)
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

	set_generation_location (location: STRING) is
			-- Assign `location' to `generation_location'.
		do
			generation_location := location.twin
		ensure
			location_set: generation_location.is_equal (location)
		end

feature {GB_FILE_OPEN_COMMAND}

	set_object_as_client (an_object: GB_OBJECT) is
			-- Ensure `an_object' is generated as a client.
		require
			an_object_not_void: an_object /= Void
		do
			an_object.enable_client_generation
		end

feature {NONE} --Implementation

		-- Constants for saving to XML.
	project_location_string: STRING is "Project_location"

	main_window_class_name_string: STRING is "Main_window_class_name"

	application_class_name_string: STRING is "Application_class_name"

	constants_class_name_string: STRING is "Constants_class_name"

	complete_project_string: STRING is "Complete_project"

	grouped_locals_string: STRING is "Group_locals"

	debugging_output_string: STRING is "Generate_debugging_output"

	attributes_local_string: STRING is "Attributes_local"

	project_name_string: STRING is "Project_name"

	client_of_window_string: STRING is "Client_of_window"

	rebuild_ace_file_string: STRING is "Rebuild_ace_file"

	load_constants_string: STRING is "Load_constants_from_file"

	project_type_string: STRING is "Project_type"

	generation_location_string: STRING is "Generation_location"

		-- Type of Current project. We must store this information
		-- in the save file, so we know what sort of processing to perform
		-- when we double click on the .bpr file.

	set_integer_attribute (a_string: STRING; an_agent: PROCEDURE [ANY, TUPLE [INTEGER]]) is
			-- Call `an_agent' with `a_string' converted to an INTEGER.
		require
			a_string_not_void: a_string /= Void
			an_agent_not_void: an_agent /= Void
			a_string_is_integer: a_string.is_integer
		do
			an_agent.call ([a_string.to_integer])
		end


	set_string_attribute (a_string: STRING; an_agent: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Call `an_agent' with `a_string'.
		require
			a_string_not_void: a_string /= Void
			an_agent_not_void: an_agent /= Void
		do
			an_agent.call ([a_string])
		end

	set_boolean_attribute (a_string: STRING; true_agent, false_agent: PROCEDURE [ANY, TUPLE]) is
			-- If `a_string' is `True_string' then call `true_agent', else call `false_agent'.
		require
			a_string_not_void: a_string /= Void
			a_string_valid: a_string.is_equal (true_string) or a_string.is_equal (false_string)
			true_agent_not_void: true_agent /= Void
			false_agent_not_void: false_agent /= Void
		do
			if a_string. is_equal (True_string) then
				true_agent.call ([])
			else
				false_agent.call ([])
			end
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


end -- class GB_PROJECT_SETTINGS
