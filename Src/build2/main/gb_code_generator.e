indexing
	description: "Objects that generate an Eiffel class text based on the%
		%current system built by the user."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CODE_GENERATOR
	
	-- We currently only support two or less project locations per ace file.
	
inherit
	
	GB_XML_UTILITIES
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
	
	GB_EVENT_UTILITIES
		export
			{NONE} all
		end
	
	INTERNAL
		export
			{NONE} all
		end
	
	EIFFEL_ENV
		export
			{NONE} all
		end
	
	GB_FILE_CONSTANTS
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		end
		
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
		
	GB_NAMING_UTILITIES
		export
			{NONE} all
		end

feature -- Basic operation

	generate is
			-- Generate the project as per settings in `project_settings'.
		local	
			directory: DIRECTORY
			root_element, current_element, window_element: XM_ELEMENT
			current_name, current_type: STRING
			name_counter: INTEGER
			window_file_name, directory_name, directory_file_name: FILE_NAME
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			warning_dialog: EV_WARNING_DIALOG
			error_message: STRING
		do
				-- We must build an XML file representing the project, and
				-- then for every window found in that file, generate a new window.
			generate_xml_for_project
			
			window_counter := 0	
			total_windows := window_selector.objects.count
		
				-- Note that the generation of the XML file used internally,
				-- is not performed until `build_main_window_implementation' is called.
			create directory_file_name.make_from_string (project_settings.project_location)
			create directory.make (directory_file_name)
				-- If the directory for the generated code does not already exist then
				-- we must create it.
			if not directory.exists then
				directory.create_dir
			end

			
				-- We only generate an ace file and an EV_APPLICATION if the user
				-- has selected to generate a complete project from the system settings.
			if project_settings.complete_project then
					-- Generate an ace file for the project.
				build_ace_file
					-- Generate an EV_APPLICATION for the project
				build_application_file
			end
			
			build_constants_file
			if project_settings.load_constants then
				build_constants_load_file
			end
			
			root_element ?= current_document.first
			from
				root_element.start
			until
				root_element.off
			loop
				current_element ?= root_element.item_for_iteration
				if current_element /= Void then
				
				current_name := current_element.name
					if current_name.is_equal (Item_string) then
						current_type := current_element.attribute_by_name (type_string).value
						if current_type.is_equal (directory_string) then
							from
								current_element.start
							until
								current_element.off
							loop
								window_element ?= current_element.item_for_iteration
								if window_element /= Void then
									current_name := window_element.name
									if current_name.is_equal (Internal_properties_string)  then
										full_information := get_unique_full_info (window_element)
										element_info := full_information @ (name_string)
										directory_name := clone (generated_path)
										directory_name.extend (element_info.data)
										create directory.make (directory_name)
										if not directory.exists then
											directory.create_dir
										end
									else
											-- We must now parse the generated file, and build a representation
											-- that is contained within. This is then used by the generator,
											-- to find paticular information regarding the structure.
										reset_generation_constants	
									
										prepass_xml (window_element, document_info, 1)
											-- Generate the window implementation for the project.
										name_counter := name_counter + 1
										build_main_window_implementation (directory_name)
										
										build_main_window (directory_name)
									end
								end
								current_element.forth
							end
						elseif current_type.is_equal (Constants_string) then
							
						else
							reset_generation_constants
							directory_name := clone (generated_path)
							prepass_xml (current_element, document_info, 1)
							window_file_name := clone (generated_path)
							build_main_window_implementation (directory_name)
							build_main_window (directory_name)
						end
					end
				
				end
				
				root_element.forth
			end
				-- Now display error dialog if one or more templates could not be found.
			if missing_files /= Void then
				error_message := "EiffelBuild was unable to locate the following files required for generation:%N%N"
				from
					missing_files.start
				until
					missing_files.off
				loop
					error_message := error_message + missing_files.item + "%N"
					missing_files.forth
				end
				error_message := error_message + "%NCode generation has failed.%NPlease ensure that your installation of EiffelBuild has not been corrupted."
				create warning_dialog.make_with_text (error_message)
				warning_dialog.show_modal_to_window (parent_window (progress_bar))
			end
		end
		
feature {WIZARD_FOURTH_STATE, WIZARD_FINAL_STATE, GB_CODE_GENERATION_DIALOG} -- Implementation

	set_progress_bar (bar: EV_PROGRESS_BAR) is
			-- Assign `bar' to `progress_bar'
		require
			progress_bar_not_void: bar /= Void
		do
			progress_bar := bar
		ensure
			progress_bar_set: progress_bar = bar
		end
		
feature {NONE} -- Implementation
		
	generate_xml_for_project is
			-- Generate XML for the current project into `current_document'.
			-- This XML document will be used to generate the source code.
		local
			store: GB_XML_STORE
			generation_settings: GB_GENERATION_SETTINGS
		do
			create store
				-- Generate an XML representation of the current project.
				-- We will build our class text directly from this XML.
			create generation_settings
			generation_settings.enable_generate_names
			store.register_object_written_agent (agent report_progress_from_store)
			store.generate_document (generation_settings)
			current_document := store.document
			check
				current_document_not_void: current_document/= Void
			end
		end
		
	report_progress_from_store (total, stored: INTEGER) is
			-- Report progress from XML store, represented by percentage
			-- of `stored' against `total'.
		do
			set_progress (progress_switch * (stored / total))
		end

	reset_generation_constants is
			-- Reset all constants and attributes required before a generation.
			-- This will be called multiple times, once for each set of classes
			-- that is generated.
		do
			create document_info.make_root
			create all_ids.make (50)
			event_connection_string := ""
			create_string := ""
			local_string := Void
			attribute_string := Void
			build_string := ""
			set_string := ""
			event_implementation_string := ""
			event_declaration_string := ""
			Generated_names.wipe_out
		end
		

	generated_path: FILE_NAME is
			-- `Result' is generated directory for current project.
		do
			create Result.make_from_string (system_status.current_project_settings.project_location)
		ensure
			result_not_void: Result /= Void
		end
		
	build_ace_file is
			-- Generate the ace file for the project
			-- dependent in information in `system_status'.
			-- Note that For Visual Studio, we need to
			-- generate a debug and a release ace file.
		local
			debug_ace_file, release_ace_file: FILE_NAME
		do
			if system_status.is_wizard_system then
				create debug_ace_file.make_from_string (visual_studio_information.wizard_installation_path)
				debug_ace_file.extend ("templates")
				debug_ace_file.extend ("windows")
				release_ace_file := clone (debug_ace_file)
				debug_ace_file.extend ("debug.ace")
				release_ace_file.extend ("release.ace")
				generate_ace_file (release_ace_file, "release.ace")
				generate_ace_file (debug_ace_file, "debug.ace")
			else
					-- Now generate ace files on both platforms as standard.
				generate_ace_file (clone (windows_ace_file_name), windows_ace_name)
				generate_ace_file (clone (unix_ace_file_name), unix_ace_name)
			end	
		end
		
	generate_ace_file (template_file_name, file_name: STRING) is
			-- Generate a new ace file from template `template_file_name', and save it
			-- as `file_name'. `template_file_name' is full path, but `file_name' is
			-- just name of ace file.
		local
			project_location, temp_string: STRING
			ace_file_name: FILE_NAME
			ace_template_file, ace_output_file: PLAIN_TEXT_FILE
			i, j: INTEGER
		do
			create project_location.make_from_string (system_status.current_project_settings.project_location)
		
			ace_template_file := open_text_file_for_read (template_file_name)
			if ace_template_file /= Void then
					-- Only perform generation if the template file was readable.
				create ace_text.make (ace_template_file.count)
				ace_template_file.start
				ace_template_file.read_stream (ace_template_file.count)
				ace_text := ace_template_file.last_string
				ace_template_file.close
				
					-- | FIXME
					-- This code only supports two project location tags per ace file.
					-- This should be made more general.
				i := ace_text.substring_index (project_location_tag, 1)
				j := ace_text.substring_index (project_location_tag, i + 1)
				
				ace_text.replace_substring_all (project_location_tag, "")			
				ace_text.insert_string (project_location, i)
				temp_string := project_location
				if j >0 then
					ace_text.insert_string (project_location, j - project_location_tag.count + temp_string.count)
				end
				
					-- Now add the project_name. Note that we add double quotes around the name.
					-- This allows use to use project names that clash with ace file settings,
					-- for example, library is an invalid project name without double quotes
					
				add_generated_string (ace_text, "%"" + project_settings.project_name.as_lower + "%"", project_name_tag)				
				
					-- Now add the application class name.
				add_generated_string (ace_text, project_settings.application_class_name.as_upper, application_tag)
				
				ace_file_name := clone (generated_path)
				ace_file_name.extend (file_name)
						-- Store `ace_text'.
				create ace_output_file.make (ace_file_name)
				if not ace_output_file.exists or project_settings.rebuild_ace_file then
					ace_output_file.open_write
					ace_output_file.start
					ace_output_file.putstring (ace_text)
					ace_output_file.close
				end
			end
		end
		
		build_constants_file is
				-- Build class file containing all generated constants.
			local
				constants_file_name: FILE_NAME
				constants_file: PLAIN_TEXT_FILE
				constants_content: STRING
				generated_constants_string: STRING
				all_constants: HASH_TABLE [GB_CONSTANT, STRING]
				constant: GB_CONSTANT
				integer_constant: GB_INTEGER_CONSTANT
				string_constant: GB_STRING_CONSTANT
				pixmap_constant: GB_PIXMAP_CONSTANT
				directory_constant: GB_DIRECTORY_CONSTANT
				l_string: STRING
			do
				--| FIXME handle visual studio wizard.
				
					--Firstly read the contents of the file.
				constants_file := open_text_file_for_read (constants_template_file_name)
				if constants_file /= Void then
					constants_file.read_stream (constants_file.count)
					constants_file.close
					constants_content := constants_file.last_string
					
						-- Now generate string representing all constants.
					all_constants := constants.all_constants
					generated_constants_string := ""
					from
						all_constants.start
					until
						all_constants.off
					loop
						constant := all_constants.item_for_iteration
						integer_constant ?= constant
						if integer_constant /= Void then
							if project_settings.load_constants then
								l_string := "integer_constant_by_name (%"" + integer_constant.name + "%")"
							else
								l_string := integer_constant.value_as_string
							end
							generated_constants_string := generated_constants_string + Indent_less_two + integer_constant.name + ": INTEGER is " +
								indent +  "-- `Result' is INTEGER constant named " + integer_constant.name + "." + 
								indent_less_one + "once" + indent + "Result := " + l_string + Indent_less_one + "end" + "%N"
						end
						string_constant ?= constant
						if string_constant /= Void then
							if project_settings.load_constants then
								l_string := "string_constant_by_name (%"" + string_constant.name + "%")"
							else
								l_string := "%"" + string_constant.value_as_string + "%""
							end
							generated_constants_string := generated_constants_string + Indent_less_two + string_constant.name + ": STRING is" +
								indent + "-- `Result' is STRING constant named `" + string_constant.name + "'." + 
								indent_less_one + "once" + indent + "Result := " + l_string + Indent_less_one + "end" + "%N"
						end
						pixmap_constant ?= constant
						if pixmap_constant /= Void then
							if pixmap_constant.is_absolute then
								generated_constants_string := generated_constants_string + Indent_less_two + pixmap_constant.name + ": EV_PIXMAP is" + Indent_less_one +
								"Once" + Indent + "create Result" + Indent + "Result.set_with_named_file (%"" + pixmap_constant.value + "%")" + Indent_less_one + "end" + "%N"
							else
								generated_constants_string := generated_constants_string + Indent_less_two + pixmap_constant.name + ": EV_PIXMAP is" + Indent_less_one +
								"local" + indent + "a_file_name: FILE_NAME" + Indent_less_one + "Once" + Indent + "create Result" + Indent + 
								"create a_file_name.make_from_string (" + pixmap_constant.directory + ")" + Indent + "a_file_name.extend (%"" + pixmap_constant.filename +"%")" +
								indent + "Result.set_with_named_file (a_file_name)" + Indent_less_one + "end" + "%N"
							end
						end
						directory_constant ?= constant
						if directory_constant/= Void then
							generated_constants_string := generated_constants_string + Indent_less_two + directory_constant.name + ": STRING is" +
								indent + "-- `Result' is DIRECTORY constant named `" + directory_constant.name + "'." + 
								indent_less_one + "once" + indent + "Result := %"" + directory_constant.value_as_string + "%"" + Indent_less_one + "end" + "%N"
						end
						all_constants.forth
					end
	
					add_generated_string (constants_content, generated_constants_string, constants_tag)
					
						-- Now write the new constants file to disk.
					constants_file_name := clone (generated_path)
					constants_file_name.extend ("constants.e")
					create constants_file.make_open_write (constants_file_name)
					constants_file.start
					constants_file.putstring (constants_content)
					constants_file.close
				end
			end
			
		build_constants_load_file is
				-- Build text file containing constants to be loaded.
			local
				constants_file_name: FILE_NAME
				constants_file: PLAIN_TEXT_FILE
				generated_constants_string: STRING
				all_constants: HASH_TABLE [GB_CONSTANT, STRING]
				constant: GB_CONSTANT
				integer_constant: GB_INTEGER_CONSTANT
				string_constant: GB_STRING_CONSTANT
			do
				all_constants := constants.all_constants
				generated_constants_string := " -- Constants generated by EiffelBuild%N"
				from
					all_constants.start
				until
					all_constants.off
				loop
					constant := all_constants.item_for_iteration
					integer_constant ?= constant
					if integer_constant /= Void then
						generated_constants_string := generated_constants_string + Integer_constant_type + "        " + "%"" + integer_constant.name +
						"%"        %"" + integer_constant.value_as_string + "%"%N"
					end
					string_constant ?= constant
					if string_constant /= Void then
						generated_constants_string := generated_constants_string + String_constant_type + "        " + "%"" + string_constant.name +
						"%"        %"" + string_constant.value_as_string + "%"%N"
					end
					all_constants.forth
				end
					-- Now write the new constants file to disk.
				constants_file_name := clone (generated_path)
				constants_file_name.extend ("constants.txt")
				create constants_file.make_open_write (constants_file_name)
				constants_file.start
				constants_file.putstring (generated_constants_string)
				constants_file.close
			end

		build_application_file is
				-- Generate an application class for the project.
			local
				application_template_file, application_output_file: PLAIN_TEXT_FILE
				application_file_name, application_template: FILE_NAME
				application_class_name: STRING
				change_pos: INTEGER
			do
				if system_status.is_wizard_system then
					create application_template.make_from_string (visual_studio_information.wizard_installation_path)
					application_template.extend ("templates")
					application_template.extend ("build_application_template.e")
				else
					application_template := application_template_file_name			
				end
				application_template_file := open_text_file_for_read (application_template)
				if application_template_file /= Void then
					create application_text.make (application_template_file.count)
					application_template_file.start
					application_template_file.read_stream (application_template_file.count)
					application_text := application_template_file.last_string
					application_template_file.close
				
						-- Now add the main window class type
					add_generated_string (application_text, Object_handler.root_window_object.name.as_upper, main_window_tag)
					
						-- Now add the application class name. 0ne at start
						-- and one at end of file, so do this twice.
					application_class_name := project_settings.application_class_name.as_upper
					change_pos := application_text.substring_index (application_tag, 1)
					application_text.replace_substring (application_class_name, change_pos, change_pos + application_tag.count - 1)
					change_pos := application_text.substring_index (application_tag, 1)
					application_text.replace_substring (application_class_name, change_pos, change_pos + application_tag.count - 1)
					
					application_file_name := clone (generated_path)
					application_file_name.extend (application_class_name.as_lower + eiffel_class_extension)
	
					create application_output_file.make_open_write (application_file_name)
					application_output_file.start
					application_output_file.putstring (application_text)
					application_output_file.close
				end
			end

		build_main_window_implementation (directory_name: FILE_NAME) is
				-- Generate a main window for the project.
			local
				window_template_file, window_output_file: PLAIN_TEXT_FILE
				window_template, file_name: FILE_NAME
				a_class_name, temp_string: STRING
			do
				window_counter := window_counter + 1
				set_progress ((progress_switch + ((1 - progress_switch) * (window_counter / total_windows))).min (1))
					-- Build the file name for generation
				check
					document_info_not_void: document_info /= Void
					name_not_void: document_info.name /= Void
				end
				a_class_name := document_info.name.as_upper + Class_implementation_extension 
				file_name := clone (directory_name)
				file_name.extend (a_class_name.as_lower + ".e")
				
					-- Retrieve the template for a class file to generate.
				if system_status.is_wizard_system then
					create window_template.make_from_string (visual_studio_information.wizard_installation_path)
					window_template.extend ("templates")
					window_template.extend ("build_class_template_imp.e")
				else
					window_template := window_template_imp_file_name		
				end
				window_template_file := open_text_file_for_read (window_template)
				if window_template_file /= Void then
					create class_text.make (window_template_file.count)
					window_template_file.start
					window_template_file.read_stream (window_template_file.count)
					class_text := window_template_file.last_string
					window_template_file.close
					
						-- Now that we have loaded the class file template, we must
						-- replace all instances of EV_TITLED_WINDOW with EV_DIALOG
						-- if we are generating a dialog.
					if document_info.type.is_equal ("EV_DIALOG") then
						class_text.replace_substring_all ("EV_TITLED_WINDOW", "EV_DIALOG")
					end
	
						-- We must now perform the generation into `class_text'.
						-- First replace the name of the class
					set_class_name (a_class_name)
	
					-- Add code which implements `show' if necessary, when using EV_WINDOW
					-- as client. Also export `initialize' as necessary. If client, then it
					-- must be exported to {ANY}.
					if project_settings.client_of_window then
						add_generated_string (class_text, "%Nfeature -- Basic operation%N" + show_feature, custom_feature_tag)
					else
						add_generated_string (class_text, Void, custom_feature_tag)
					end
					
						-- Generate the widget declarations and creation lines.
					generate_declarations
					
						-- Create storage for all generated feature names.
					create all_generated_events.make (0)
					all_generated_events.compare_objects
					
						-- Generate the widget building code.
					generate_structure
	
						-- Generate the widget setting code.
					generate_setting
					
						-- Generate the event code.
					generate_events
					
					
						-- Now we must check the status of the prepass, and remove the
						-- "internal_pixmap" and `"internal_font" which is in the template,
						-- if they are not necessary
					if document_info.fonts_set.is_empty then
						remove_line_containing ("internal_font", class_text)
					end
					if document_info.pixmaps_set.is_empty then
						remove_line_containing ("internal_pixmap", class_text)
						remove_line_containing ("internal_pixmap", class_text)
					end
					
						-- Now remove the local declaration if necessary.
					if document_info.fonts_set.is_empty and document_info.pixmaps_set.is_empty and
					local_string = Void then
						remove_line_containing (local_tag, class_text)
					end
				
					if local_string = Void and (not document_info.fonts_set.is_empty
						or not document_info.pixmaps_set.is_empty) then
						add_generated_string (class_text, "local", local_tag)
					end
					
					
						-- Add code for widget attribute settings to `class_text'.
					add_generated_string (class_text, set_string, set_tag)
	
					if local_string /= Void then
						add_generated_string (class_text, local_string, local_tag)
					end
					if attribute_string /= Void then
						add_generated_string (class_text, attribute_string, attribute_tag)
					else
						class_text.replace_substring_all (attribute_tag + "%N", "")
					end

						-- Add code for inheritance structure to `class_text'.
					if project_settings.client_of_window then
						temp_string := clone (window_access)
						if not document_info.type.is_equal (Ev_titled_window_string)  then
								-- Ensure that the inheritance references the correct type.
							temp_string := clone (Window_access_as_dialog)
							temp_string.replace_substring_all (Ev_titled_window_string, document_info.type)
								-- Replace "window" from `window_access' with "dialog" only in comment.
								--| FIXME This is a hack and should probably be improved as the code generation
								--| is developed.
						end
						add_generated_string (class_text, temp_string,  inheritance_tag)
					else
						temp_string := clone (window_inheritance)
						if not document_info.type.is_equal (Ev_titled_window_string)  then
							temp_string.replace_substring_all (Ev_titled_window_string, document_info.type)
						end
						add_generated_string (class_text, temp_string, inheritance_tag)
					end
					
						-- Add code for Precursor call in `intialize'.
					if project_settings.client_of_window then
						add_generated_string (class_text, "initialize_constants", precursor_tag)
					else
						add_generated_string (class_text, "Precursor {" + document_info.type + "}" + Indent + "initialize_constants", precursor_tag)
					end
					
						-- Add code for creation of widgets to `class_text'.
					add_generated_string (class_text, create_string, create_tag)
					
						-- Add code for construction of widget hierarchy to `class_text'.
					add_generated_string (class_text, build_string, build_tag)	
		
						-- Add code connecting events to features to `class_text'.
					add_generated_string (class_text, event_connection_string, event_connection_tag)
	
						-- Add declaration of features as deferred to `class_text'.
					add_generated_string (class_text, event_declaration_string, event_declaration_tag)
					
					
						-- Tidy up `document_info' ready for next generation.
					document_info.reset_after_generation
	
						-- Store `class_text'.				
					create window_output_file.make_open_write (file_name)
					window_output_file.start
					window_output_file.putstring (class_text)
					window_output_file.close
				end
			end
			
	build_main_window (directory_name: FILE_NAME) is
			-- Generate interface of our window.
		local
			window_template_file, window_output_file: PLAIN_TEXT_FILE
			file_name, window_template: FILE_NAME
			temp_string, a_class_name: STRING
		do
			check
				document_info_not_void: document_info /= Void
				name_not_void: document_info.name /= Void
			end
			file_name := clone (directory_name)
			a_class_name := document_info.name.as_upper
			file_name.extend (a_class_name.as_lower + ".e")
			
				-- Retrieve the template for a class file to generate.
			if system_status.is_wizard_system then
				create window_template.make_from_string (visual_studio_information.wizard_installation_path)
				window_template.extend ("templates")
				window_template.extend ("build_class_template.e")
			else
				window_template := window_template_file_name		
			end
			window_template_file := open_text_file_for_read (window_template)
			if window_template_file /= Void then
				create class_text.make (window_template_file.count)
				window_template_file.start
				window_template_file.read_stream (window_template_file.count)
				class_text := window_template_file.last_string				
				window_template_file.close
				
					-- Now that we have loaded the class file template, we must
					-- replace all instances of EV_TITLED_WINDOW with EV_DIALOG
					-- if we are generating a dialog.
				if document_info.type.is_equal ("EV_DIALOG") then
					class_text.replace_substring_all ("EV_TITLED_WINDOW", "EV_DIALOG")
				end
			
					-- We must now perform the generation into `class_text'.
					-- First replace the name of the class
				set_class_name (a_class_name)
				
				temp_string := a_class_name + Class_implementation_extension
				if project_settings.client_of_window then
						-- Add redefinition of `default_create' if we are client.
					temp_string := temp_string + default_create_redefinition
				end
					-- Generate the inheritance from the window implementation.
				set_inherited_class_name (temp_string)
				
				if project_settings.client_of_window then
					temp_string := clone (redefined_creation)
						if not document_info.type.is_equal (Ev_titled_window_string)  then
							temp_string.replace_substring_all (Ev_titled_window_string, document_info.type)
						end
					add_generated_string (class_text, temp_string, creation_tag)
				else
					add_generated_string (class_text, Void, creation_tag)
				end
				
				add_generated_string (class_text, event_implementation_string, event_declaration_tag)
				
					-- Store `class_text'.				
				create window_output_file.make (file_name)
				if not window_output_file.exists then
					window_output_file.open_write
					window_output_file.start
					window_output_file.putstring (class_text)
					window_output_file.close
				end
			end
		end
		
	add_generated_string (a_class_text, new, tag: STRING) is
			-- Replace `tag' in `class_text' with `new'.
			-- If `new' is Void then add "".
		require
			tag_contained: a_class_text.has_substring (tag)
		local
			temp_index: INTEGER
		do
			if new /= Void and not new.is_equal ("") then
				temp_index := a_class_text.substring_index (tag, 1)
				a_class_text.replace_substring_all (tag, "")
				a_class_text.insert_string (new, temp_index)
			else
				temp_index := a_class_text.substring_index (tag, 1)
				a_class_text.replace_substring_all (tag, "")
					-- Prune the "%N" following the tag, as we do not want
					-- a new line added anymore.
				a_class_text.remove_substring (temp_index, temp_index + 1)
			end
		end
		
	set_class_name (a_name: STRING) is
			-- Replace all occurances of `class_name_tag' with
			-- `a_name' within `class_text'.
		do
			a_name.to_upper
			class_text.replace_substring_all (class_name_tag, a_name)
		end
		
	set_inherited_class_name (a_name: STRING) is
			-- Replace all occurances of `inherited_class_name_tag' with
			-- `a_name' within `class_text'.
		do
			class_text.replace_substring_all (inherited_class_name_tag, a_name)
		end
		
	prepass_xml (element: XM_ELEMENT; info: GB_GENERATED_INFO; depth: INTEGER) is
			-- With information in element, build information into `info'.
		local
			current_element: XM_ELEMENT
			current_name, current_type: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			current_data_element: XM_CHARACTER_DATA
			action_sequence_info: GB_ACTION_SEQUENCE_INFO
			new_name: STRING
		do
			info.set_element (element)
			if element.has_attribute_by_name (type_string) then
				current_type := element.attribute_by_name (type_string).value
				info.set_type (current_type)
			end
	
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Item_string) then
						prepass_xml (current_element, info.new_child, depth + 1)
					else
						if current_name.is_equal (Internal_properties_string) then
							full_information := get_unique_full_info (current_element)
							element_info := full_information @ (name_string)
							if element_info /= Void then
								info.set_name (element_info.data)
							else
								-- We must now assign a name, as the current object was not named.
								new_name := unique_name_from_array (generated_names, Local_object_name_prepend_string + info.type)
								info.set_name (new_name)
								info.enable_generated_name
								generated_names.force (new_name)					
							end	
							
							if current_type.is_equal (Ev_titled_window_string) or
								current_type.is_equal (Ev_dialog_string) then
								info.set_as_root_object	
							end
							element_info := full_information @ (id_string)
							info.set_id (element_info.data.to_integer)
							info.generated_info_by_id.put (info, info.id)
							info.names_by_id.put (info.name, info.id)
							all_ids.extend (info.id)
						elseif current_name.is_equal (Events_string) then
							prepass_xml (current_element, info, depth + 1)
								-- We must now loop through the element, and retrieve all the events.
						elseif current_name.is_equal (Event_string) then
								-- Now record all events for the current object.
							from
								current_element.start
							until
								current_element.off
							loop
								current_data_element ?= current_element.item_for_iteration
								if current_data_element /= Void then
									action_sequence_info := string_to_action_sequence_info (current_data_element.content)
									info.add_new_event (action_sequence_info)
								end
								current_element.forth
							end
						else
							info.supported_types.extend (current_name)
							info.supported_type_elements.extend (current_element)
						end
					end
				end
				element.forth
			end
		end

	generate_declarations is
			-- With information in `element', generate code which includes the
			-- attribute declarations and creation of all components in system.
		local
			generated_info: GB_GENERATED_INFO
		do
			from
				all_ids.start
			until
				all_ids.off
			loop
				generated_info := document_info.generated_info_by_id.item (all_ids.item)
				if generated_info.name /= Void and then not generated_info.name.is_empty and then
					generated_info.name /= Client_window_string then
					-- If the name is equal to `client_window_string' then we must be the window
					-- in a client based system. This has a special attribute clauses added in the
					-- file, so we do not add it in the same fashion as other attributes.
					if system_status.current_project_settings.grouped_locals then
						add_local_on_grouped_line (generated_info)
					else
						add_local_on_single_line (generated_info)
					end
					create_local (generated_info)
				end
				all_ids.forth
			end
		end

	generate_structure is
			-- With information in `document_info', generate code which will
			-- parent all objects.
		local
			new_object : GB_OBJECT
			menu_bar_object: GB_MENU_BAR_OBJECT
			generated_info: GB_GENERATED_INFO
		do
			from
				all_ids.start
			until
				all_ids.off
			loop
				generated_info := document_info.generated_info_by_id.item (all_ids.item)
					-- Fixme, why assign id here? Try generating, and then see new ids after...
				new_object := object_handler.build_object_from_string_and_assign_id (generated_info.type)
				if generated_info.parent /= Void and then generated_info.parent.type /= Void and then generated_info.parent.is_root_object then
					menu_bar_object ?= new_object
					if menu_bar_object /= Void then
						if project_settings.client_of_window then
							add_build ("window.set_menu_bar (" + generated_info.name + ")")
						else
							add_build ("set_menu_bar (" + generated_info.name + ")")
						end
					else
							if project_settings.client_of_window then
								add_build ("window." + new_object.extend_xml_representation (generated_info.name))
							else
								add_build (new_object.extend_xml_representation (generated_info.name))
							end
					end
						-- If name is Void, the we are at the root element of the info.
						-- This does not represent a widget at all, so do nothing
				elseif not generated_info.is_root_object then
					-- Tables need to use put, but this is done in conjunction with the placement.
					-- So here, we do not add the children of the table, as it will be done later.
					if generated_info.parent /= Void and then generated_info.parent.type /= Void and then not generated_info.parent.type.is_equal (Ev_table_string) then
						add_build (generated_info.parent.name + "." + new_object.extend_xml_representation (generated_info.name))
					end
				end
				all_ids.forth
			end
		end
		
	generate_setting is
			-- With information in `document_info', generate code which will
			-- set_all_objects.
		local
			gb_ev_any: GB_EV_ANY
			generated_info: GB_GENERATED_INFO
			supported_types, current_settings: ARRAYED_LIST [STRING]
			temp_set: STRING
		do
			from
				all_ids.start
			until
				all_ids.off
			loop
				generated_info := document_info.generated_info_by_id.item (all_ids.item)
				supported_types := generated_info.supported_types
				from
					supported_types.start
				until
					supported_types.off
				loop
					gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + supported_types.item))
								-- Call default_create on `gb_ev_any'
							gb_ev_any.default_create
							-- Ensure that the new class exists.
						check
							new_instance_exists: gb_ev_any /= Void
						end
					current_settings := gb_ev_any.generate_code (generated_info.supported_type_elements @ (supported_types.index), generated_info)
					from
						current_settings.start
					until
						current_settings.off
					loop
							-- We must handle a root object as a special case, as there
							-- is no need for a dot call, unless we are using the window as a client.
						temp_set := current_settings.item
						check
							temp_set_not_empty: not temp_set.is_empty
						end
						if generated_info.is_root_object then
							temp_set := temp_set.substring (temp_set.index_of ('.', 1) + 1, temp_set.count)
							if project_settings.client_of_window and not temp_set.is_empty then
								temp_set := Client_window_string + "." + temp_set
							end
						end
						add_set (temp_set)	
						current_settings.forth
					end					
					supported_types.forth
				end

				all_ids.forth
			end
		end
		
	generate_events is
			-- Using `document_info' which was generated in `prepass_xml',
			-- generate source code corresponding to selected events.
		local
			generated_info: GB_GENERATED_INFO
			events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
			action_sequence_info: GB_ACTION_SEQUENCE_INFO
			action_sequence: GB_EV_ACTION_SEQUENCE
			renamed_action_sequence_name: STRING
			local_name: STRING
			comment_object_name: STRING
			parameters: STRING
			feature_implementation: STRING
		do	
			from
				all_ids.start
			until
				all_ids.off
			loop
				generated_info := document_info.generated_info_by_id.item (all_ids.item)
				events := generated_info.events
				from
					events.start
				until
					events.off
				loop
					action_sequence_info := events.item
					action_sequence ?= new_instance_of (dynamic_type_from_string ("GB_" + action_sequence_info.type))
					check
						action_sequence_not_void: action_sequence /= Void
					end
							-- We must handle a root object as a special case, as there
						-- is no need for a dot call, unless we are using the window as a client.
					if generated_info.is_root_object then
						local_name := ""
						if project_settings.client_of_window then
							local_name := Client_window_string + "."
						end
					else
						local_name := generated_info.name + "."
					end

						-- Adjust event names that have been renamed in Vision2 interface
					renamed_action_sequence_name := modified_action_sequence_name (generated_info.type, action_sequence_info)
									
						-- If there are no arguments to the action sequence then generate no open arguments.
					if action_sequence.count = 0 then
						add_event_connection (local_name + renamed_action_sequence_name + ".extend (agent " + action_sequence_info.feature_name + ")")
					else
						add_event_connection (local_name + renamed_action_sequence_name + ".extend (agent " + action_sequence_info.feature_name + " (" + action_sequence.open_arguments + "))")
					end
										
						-- We must not generate the feature names again, if we have multiple events connected
						-- to a single action sequence and we have already generated the feature.
					if not all_generated_events.has (action_sequence_info.feature_name.as_lower) then
						all_generated_events.extend (action_sequence_info.feature_name.as_lower)
							-- Use `Current' in comment if the event is connected to the window.
						if generated_info.type.is_equal (Ev_titled_window_string) then
							comment_object_name := "Current"
						else
							comment_object_name := generated_info.name
						end
						
						
							-- No parameters if zero arguments.
						if action_sequence.count = 0 then
							parameters := " is"
						else
							parameters := " (" +action_sequence.parameter_list + ") is"
						end	
						
							-- If the user has selected that they wish to generate debugging output, 
							-- then we build a representation in `feature_implementation' otherwise,
							-- the feature implementation will be empty.
						if project_settings.debugging_output then
							if action_sequence.count = 0 then
								feature_implementation := indent + "io.putstring (%"" + action_sequence_info.feature_name + " executed%%N%%N%%N%")"
							else
								feature_implementation := indent + "io.putstring (%"" + action_sequence_info.feature_name + " executed%%N%")" + indent + action_sequence.debugging_info
							end
						else
							feature_implementation := ""
						end
						
							-- Now we must generate the event declarations.
						add_event_declaration (action_sequence_info.feature_name + parameters +
						indent + "-- Called by `" + action_sequence_info.name + "' of `" + comment_object_name + "'." +
						indent_less_one + "deferred" + indent_less_one + "end" + indent_less_two)
						
						add_event_implementation (action_sequence_info.feature_name + parameters +
						indent + "-- Called by `" + action_sequence_info.name + "' of `" + comment_object_name + "'." +
						indent_less_one + "do" + feature_implementation + indent_less_one + "end" + "%N%N")
					end
					events.forth
				end
				
				all_ids.forth
			end
			
				-- Now we must connect the close event of the window:
			add_event_connection ("%T-- Close the application when an interface close")
			add_event_connection ("%T-- request is recieved on `Current'. i.e. the cross is clicked.")
--			if System_status.current_project_settings.client_of_window then
--				add_event_connection (Client_window_string + ".close_request_actions.extend (agent ((create {EV_ENVIRONMENT}).application).destroy)")
--			else
--				add_event_connection ("close_request_actions.extend (agent ((create {EV_ENVIRONMENT}).application).destroy)")
--			end
			--| FIXME only generate for main window.
		end

	add_local_on_single_line (generated_info: GB_GENERATED_INFO) is
			-- Add code representation of new local named `name' of type
			-- `local_type' to `local_string'.
			-- Each new local is placed on an individual line. e.g.
			-- button1: EV_BUTTON
			-- button2: EV_BUTTON
		local	
			temp_string,local_string_start, indent_string: STRING
			local_type, name: STRING
			add_local: BOOLEAN
			string_to_modify: STRING
		do
			if not generated_info.is_root_object then
				local_type := generated_info.type
				name := generated_info.name
					-- Need to generate slightly different code dependent
					-- on whether the atrributes are local or not.
				if project_settings.attributes_local.is_equal (True_string) or
					(project_settings.attributes_local.is_equal (Optimal_string) and generated_info.generated_name = True) then
					indent_string := indent
					local_string_start := "local " + indent
					add_local := True
				elseif project_settings.attributes_local.is_equal (False_string) or
					(project_settings.attributes_local.is_equal (Optimal_string) and generated_info.generated_name = False) then
					indent_string := indent_less_two
					local_string_start := "" + indent_less_two
					add_local := False
				else
					check
						invalid_logic: False
					end
				end
				
					-- Assign the string to be modified to `local_string'
					-- so that two identical sets of code do not need to be used.
				if add_local then
					string_to_modify := local_string
				else
					string_to_modify := attribute_string
				end

				if string_to_modify = Void then
					string_to_modify := local_string_start
					temp_string := name + ": " + local_type
				else
					temp_string := indent_string + name + ": " + local_type
				end
				
				string_to_modify := string_to_modify + temp_string
				
					-- Set the just modified string back to its original setter.
				if add_local then
					local_string := string_to_modify
				else
					attribute_string := string_to_modify
				end
			end
		end
		
	add_local_on_grouped_line (generated_info: GB_GENERATED_INFO) is
			-- Add code representation of new local named `name' of type
			-- `local_type' to `local_string'.
			-- Each new local will be grouped with other locals of same type. e.g.
			-- button1, button2: EV_BUTTON
		local
			temp_string, local_string_start, indent_string: STRING
			index_of_type, search_counter: INTEGER
			found_correctly: BOOLEAN
			local_type, name: STRING
			add_local: BOOLEAN
			string_to_modify: STRING
		do
			if not generated_info.is_root_object then
				local_type := generated_info.type
				name := generated_info.name
				
					-- Need to generate slightly different code dependent
					-- on whether the atrributes are local or not.
				if project_settings.attributes_local.is_equal (True_string) or
					(project_settings.attributes_local.is_equal (Optimal_string) and generated_info.generated_name = True) then
					indent_string := indent
					local_string_start := "local " + indent
					add_local := True
				elseif project_settings.attributes_local.is_equal (False_string) or
					(project_settings.attributes_local.is_equal (Optimal_string) and generated_info.generated_name = False) then
					indent_string := indent_less_two
					local_string_start := "feature -- Access%N" + indent_less_two
					add_local := False
				else
					check
						invalid_logic: False
					end
				end
				
					-- Assign the string to be modified to `local_string'
					-- so that two identical sets of code do not need to be used.
				if add_local then
					string_to_modify := local_string
				else
					string_to_modify := attribute_string
				end
				
				if string_to_modify = Void then
					string_to_modify := local_string_start + name + ": " + local_type
				else
					from
						search_counter := 1
					until
						found_correctly or search_counter > string_to_modify.count or search_counter = 0
					loop
						index_of_type := string_to_modify.substring_index (local_type, search_counter)
						
							-- Notes on the first `if'.
							-- The first check checks that we have found the index, and that the folowing character is a new line character.
							-- This handles the case where the string contains EV_MENU_ITEM and we are searching for EV_MENU, as this will fail on
							-- the new line character check.
							-- The second check ignores the new line character if we are at the last position in `string_to_modify'.
						if (index_of_type + local_type.count <= string_to_modify.count and then string_to_modify @ (index_of_type + local_type.count) = '%N') or
							(index_of_type + local_type.count - 1  = string_to_modify.count) then
							found_correctly := True
							-- Otherwise, continue searching.
						elseif index_of_type /= 0 then
							search_counter := index_of_type + 1
							-- The string was not found, so we set a condition to exit the loop.
						elseif index_of_type = 0 then
							search_counter := 0
						end
					end
					if index_of_type > 0 then
						string_to_modify.insert_string (", " + name, index_of_type - 2)
						from
							search_counter := index_of_type
							found_correctly := False
						until
							search_counter = index_of_type - 80 or found_correctly or
							search_counter = 0
						loop
							if (string_to_modify @ search_counter) = '%N' then
								found_correctly := True
							end
							search_counter := search_counter - 1
						end
						if not found_correctly then
							string_to_modify.insert_string (indent_string, index_of_type)
						end
					else
						temp_string := indent_string + name + ": " + local_type
						string_to_modify := string_to_modify + temp_string
					end
				end
					-- Set the just modified string back to its original setter.
				if add_local then
					local_string := string_to_modify
				else
					attribute_string := string_to_modify
				end
			end			
		end
		
	remove_line_containing (string: STRING; body: STRING) is
			-- Remove the line of text from `body' containing `string'.
			-- The "%N" following `string' is the one removed. The start of
			-- the line is determined by the previous "%N".
		local
			index: INTEGER
			next_index: INTEGER
			tab_index: INTEGER
			temp_string: STRING
		do
			index := body.substring_index (string, 1)
			next_index := body.substring_index ("%N", index)
			temp_string := body.substring (1, index)
			tab_index := temp_string.last_index_of ('%N', temp_string.count)
			body.remove_substring (tab_index + 1, next_index)
		end

	create_local (generated_info: GB_GENERATED_INFO) is
			-- Add code representation of the creation of local based on `generated_info'
			-- to `create_string'.
		local
			temp_string: STRING
		do
			if not generated_info.is_root_object then
				temp_string := indent + Create_command_string + generated_info.name
				if create_string = Void then
					create_string := create_widgets_comment + temp_string
				else
					create_string := create_string + temp_string
				end
			end
		end
		
	add_build (constructor: STRING) is
			-- Add `constructor' to `build_string'.
		local
			temp_string: STRING
		do
			temp_string := indent + constructor
			if build_string = Void then
				build_string := build_widgets_comment + temp_string
			else
				build_string := build_string + temp_string
			end
		end
		
	add_event_connection (event: STRING) is
			-- Add `indent' and `event' to `event_connection_string'.
			-- Create `event_connection_string' if empty.
		do
			if event_connection_string = Void then
				event_connection_string := connect_events_comment
			end
			event_connection_string := event_connection_string + indent + event
		end
		
	add_event_declaration (event: STRING) is
			-- Add `indent' and `event' to `event_declaration_string'.
			-- Create `event_declaration_string' if empty.
		do
			if event_declaration_string = Void then
				event_declaration_string := ""
			end
			event_declaration_string := event_declaration_string + indent_less_two + event
		end
		
	add_event_implementation (event: STRING) is
			-- Add `indent' and `event' to `event_implementation_string.
			-- Create `event_implementation_string' if empty.
		do
			if event_implementation_string = Void then
				event_implementation_string := ""
			end
			event_implementation_string := event_implementation_string + indent_less_two + event
		end
		
	add_set (set: STRING) is
			-- Add a setting represention, `set' to
			-- `set_string'.
		local
			temp_string: STRING
			non_void_set: STRING
		do		
			non_void_set := set
			if non_void_set = Void then
				non_void_set := ""
			end
			
				-- If we are working with an EV_TITLED_WINDOW, then
				-- we may have the . at the start which is uneeded in
				-- the code. Remove it.
			if not non_void_set.is_empty and then (non_void_set @ 1) = '.' then
				if project_settings.client_of_window then
					non_void_set := "window" + non_void_set
				else
					non_void_set := non_void_set.substring (2, non_void_set.count)
					non_void_set.replace_substring_all (indent + ".", indent)
				end
			end
			
			
			if set_string = Void then
				set_string := set_widgets_comment + indent
				temp_string := non_void_set
			else
				if not non_void_set.is_empty then
					temp_string := indent + non_void_set
				end
			end
			
			if temp_string /= Void then
				set_string := set_string + temp_string
			end
		end
		
	window_counter: INTEGER
		-- Counts the number of windows that have been generated
		
	total_windows: INTEGER
		-- The total number of windows that muat be generated.
		
	set_progress (value: REAL)	is
			-- Assign `value' to proportion of `progress_bar'
			-- if `progress_bar' /= Void
		require
			valid_range: value >=0 and value <= 1
		local
			env: EV_ENVIRONMENT
		do
			if progress_bar /= Void then
				create env
				progress_bar.set_proportion (value)
				if not system_status.is_wizard_system then
					env.application.process_events	
				end
			end
		end
		
	document_info: GB_GENERATED_INFO
		-- Representation of XML file after `prepass_xml'.
		
	project_settings: GB_PROJECT_SETTINGS is
			-- Short access to system_status.current_project_settings.
			-- Cannot be a once, as the settings may change.
		do
			Result := system_status.current_project_settings
		end
		
	all_ids: ARRAYED_LIST [INTEGER]
		-- All ids found during prepass. One for each object that is being generated.
	
	all_generated_events: ARRAYED_LIST [STRING]
		-- A list of all event feature names that have been generated. This is necessary, so
		-- that when there are multiple events connected to one feature, then we do not
		-- repeatedly generate the feature, just the connection of the feature to
		-- the action sequence.

	current_document: XM_DOCUMENT
		-- An XML document representing the current layout built
		-- by the user. We generate the class text from the information
		-- held within.
		
	class_text: STRING
		-- The current representation of the class we are generating.
		
	application_text: STRING
		-- The current representation of the application we are generating.
		
	ace_text: STRING
		-- The current representation of the ace file we are generating.
	
	local_string: STRING
		-- String representation of all local declarations built
		-- by `Current'. This is inserted into the template when complete.
		
	attribute_string: STRING
		-- String representation of all attribute declarations built by `Current'.
	
	create_string: STRING
		-- String representation of all creation statements built by
		-- `Current'. This is inserted into the template when complete.
	
	build_string: STRING
		-- String representation of all widget parenting statements built
		-- by `Current'. This is inserted into the template when complete.
	
	set_string: STRING
		-- String representation of all attribute setting statements built
		-- by `Current'. This is inserted into the template when complete.
		
	event_connection_string: STRING
		-- String representation of all event connection statements built by
		-- `Current'. This is inserted into the template when completed.
		
	event_declaration_string: STRING
		-- String representation of all event declaration statements built by
		-- `Current'. This is inserted into the template when completed.
		
	event_implementation_string: STRING
		-- String representation of all event implementation statements built by
		-- `Current'. This is inserted into the template when completed.
		
	progress_bar: EV_PROGRESS_BAR
		-- A progress bar that will be updated during generation.
		
	progress_switch: REAL is 0.6
		-- Progress level for end of xml storing, and start of generation.
		-- As they are performed independently, we need the progress of each to
		-- work as a whole
		
	missing_files: ARRAYED_LIST [STRING]
		-- All files that could not be located during generation.
		
	open_text_file_for_read (file_name: STRING): PLAIN_TEXT_FILE is
			-- Open file plain text file named `file_name',
			-- and return it if it exists, otherwise return Void.
		require
			file_name_not_void: file_name /= Void
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make (file_name)
			if file.exists then
				file.open_read
				Result := file
			else
				if missing_files = Void then
					create missing_files.make (1)
				end
				missing_files.extend (file_name)
			end
		end
		
	generated_names: ARRAYED_LIST [STRING] is
			-- All names generated automatically.
		once
			create Result.make (0)
		end

end -- class GB_CODE_GENERATOR
