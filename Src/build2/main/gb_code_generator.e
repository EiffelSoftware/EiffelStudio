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
	
	GB_SHARED_OBJECT_HANDLER
	
	GB_SHARED_SYSTEM_STATUS
	
	GB_EVENT_UTILITIES
	
	INTERNAL
	
	EIFFEL_ENV

feature -- Basic operation

	generate is
			-- Generate a new Eiffel class in `a_file_name',
			-- named `a_class_name'. The rest is built from the
			-- current state of the display_window.
		local	
			directory: DIRECTORY
			directory_file_name: FILE_NAME
		do
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
			
				-- Generate the window implementation for the project.
			build_main_window_implementation
			
				-- Generate the window for the project.
			build_main_window

		end
		
	
	set_progress_bar (bar: EV_PROGRESS_BAR) is
			-- Assign `bar' to `progress_bar'
		do
			progress_bar := bar
		end
		
		
feature {NONE} -- Implementation

	generated_path: FILE_NAME is
			-- `Result' is generated directory for current project.
		do
			create Result.make_from_string (system_status.current_project_settings.project_location)
		end
		
	build_ace_file is
			-- Generate the ace file for the project
			-- dependent in information in `system_status'.
		local
			platform_ace_file_name: FILE_NAME
			project_location, ace_file_name: FILE_NAME
			ace_template_file, ace_output_file: RAW_FILE
			temp_string: STRING
			i, j: INTEGER
		do
			set_progress (0.1)
			if system_status.is_wizard_system then
				create platform_ace_file_name.make_from_string (visual_studio_information.wizard_installation_path + "\wizards\build")
				platform_ace_file_name.extend ("templates")
				platform_ace_file_name.extend ("windows")
				platform_ace_file_name.extend ("ace_template.ace")
			else
				if Eiffel_platform.is_equal ("windows") then
					platform_ace_file_name := clone (windows_ace_file_name)
				else
					platform_ace_file_name := clone (unix_ace_file_name)
				end
			end
			create project_location.make_from_string (system_status.current_project_settings.project_location)
			
			create ace_template_file.make_open_read (platform_ace_file_name)
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
				
			add_generated_string (ace_text, "%"" + project_settings.project_name + "%"", project_name_tag)				
			
				-- Now add the application class name.
			add_generated_string (ace_text, project_settings.application_class_name.as_upper, application_tag)
			
			ace_file_name := clone (generated_path)
			ace_file_name.extend ("build_ace.ace")
					-- Store `ace_text'.
			create ace_output_file.make (ace_file_name)
			if not ace_output_file.exists or project_settings.rebuild_ace_file then
				ace_output_file.open_write
				ace_output_file.start
				ace_output_file.putstring (ace_text)
				ace_output_file.close
			end
		end
		
		
		build_application_file is
				-- Generate an application class for the project.
			local
				application_template_file, application_output_file: RAW_FILE
				application_file_name, application_template: FILE_NAME
				application_class_name: STRING
				change_pos: INTEGER
			do
				set_progress (0.2)
				if system_status.is_wizard_system then
					create application_template.make_from_string (visual_studio_information.wizard_installation_path + "\wizards\build")
					application_template.extend ("templates")
					application_template.extend ("build_application_template.e")
				else
					application_template := application_template_file_name			
				end
					
				create application_template_file.make_open_read (application_template)
				create application_text.make (application_template_file.count)
				application_template_file.start
				application_template_file.read_stream (application_template_file.count)
				application_text := application_template_file.last_string
				application_template_file.close
			
					-- Now add the main window class type
				add_generated_string (application_text, project_settings.main_window_class_name.as_upper, main_window_tag)
				
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
			
		
		build_main_window_implementation is
				-- Generate a main window for the project.
			local
				window_template_file, window_output_file: RAW_FILE
				window_file_name, window_template: FILE_NAME
				store: GB_XML_STORE
				generation_settings: GB_GENERATION_SETTINGS
			do
				set_progress (0.3)
				create store
					-- Generate an XML representation of the current project.
					-- We will build our class text directly from this XML.
				create generation_settings
				generation_settings.enable_generate_names
				store.generate_document (generation_settings)
				current_document := store.document
				check
					current_document_not_void: current_document/= Void
				end
				
					-- We must now parse the generated file, and build a representation
					-- that is contained within. This is then used by the generator,
					-- to find paticular information regarding the structure.
				create document_info.make_root
				create all_ids.make (50)
				prepass_xml (current_document.root_element, document_info, 1)				
				
				
				set_progress (0.6)
					-- Retrieve the template for a class file to generate.
				if system_status.is_wizard_system then
					create window_template.make_from_string (visual_studio_information.wizard_installation_path + "\wizards\build")
					window_template.extend ("templates")
					window_template.extend ("build_class_template_imp.e")
				else
					window_template := window_template_imp_file_name		
				end
				create window_template_file.make_open_read (window_template)
				create class_text.make (window_template_file.count)
				window_template_file.start
				window_template_file.read_stream (window_template_file.count)
				class_text := window_template_file.last_string
				window_template_file.close

			
					-- We must now perform the generation into `class_text'.
					-- First replace the name of the class
				set_class_name (system_status.current_project_settings.main_window_class_name + class_implementation_extension)

				-- Add code which implements `show' if necessary, when using EV_WINDOW
				-- as client. Also export `initialize' as necessary. If client, then it
				-- must be exported to {ANY}.
				if project_settings.client_of_window then
					add_generated_string (class_text, "%Nfeature -- Basic operation%N" + show_feature, custom_feature_tag)
				else
					add_generated_string (class_text, Void, custom_feature_tag)
				end
	
				
				set_progress (0.7)
				
					-- Generate the widget declarations and creation lines.
				generate_declarations
				
					-- Create storage for all generated feature names.
				create all_generated_events.make (0)
				all_generated_events.compare_objects
				
				set_progress (0.8)
				
					-- Generate the widget building code.
				generate_structure
				
				set_progress (0.9)
					-- Generate the widget setting code.
				generate_setting
				
					-- Generate the event code.
				generate_events
				
				
					-- Now we must check the status of the prepass, and remove the
					-- "internal_pixmap" and `"internal_font" which is in the template,
					-- if they are not necessary
				if document_info.fonts_set.is_empty then
					remove_line_containing ("internal_font", class_text)
					remove_line_containing ("internal_font", class_text)
				end
				if document_info.pixmaps_set.is_empty then
					remove_line_containing ("internal_pixmap", class_text)
					remove_line_containing ("internal_pixmap", class_text)
				end
				
					-- Now remove the local declaration if necessary.
				if document_info.fonts_set.is_empty and document_info.pixmaps_set.is_empty and
				not project_settings.attributes_local then
					remove_line_containing (local_tag, class_text)
				end
				if not project_settings.attributes_local and (not document_info.fonts_set.is_empty
					or not document_info.pixmaps_set.is_empty) then
					add_generated_string (class_text, "local", local_tag)
				end
				
				
					-- Add code for widget attribute settings to `class_text'.
				add_generated_string (class_text, set_string, set_tag)

				if project_settings.attributes_local then
					add_generated_string (class_text, local_string, local_tag)
					class_text.replace_substring_all (attribute_tag + "%R%N", "")
				else
					add_generated_string (class_text, local_string, attribute_tag)
				end
				
					-- Add code for inheritance structure to `class_text'.
				if project_settings.client_of_window then
					add_generated_string (class_text, window_access, inheritance_tag)
				else
					add_generated_string (class_text, window_inheritance, inheritance_tag)
				end
				
					-- Add code for Precursor call in `intialize'.
				if project_settings.client_of_window then
					add_generated_string (class_text, Void, precursor_tag)
				else
					add_generated_string (class_text, "Precursor {EV_TITLED_WINDOW}", precursor_tag)
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
				window_file_name := clone (generated_path)
				window_file_name.extend (system_status.current_project_settings.main_window_class_name.as_lower + class_implementation_extension.as_lower + eiffel_class_extension)
				create window_output_file.make_open_write (window_file_name)
				window_output_file.start
				window_output_file.putstring (class_text)
				window_output_file.close
			end
			
	build_main_window is
			-- Generate interface of our window.
		local
			window_template_file, window_output_file: RAW_FILE
			window_file_name, window_template: FILE_NAME
			temp_string: STRING
		do
				-- Retrieve the template for a class file to generate.
			if system_status.is_wizard_system then
				create window_template.make_from_string (visual_studio_information.wizard_installation_path + "\wizards\build")
				window_template.extend ("templates")
				window_template.extend ("build_class_template.e")
			else
				window_template := window_template_file_name		
			end
			create window_template_file.make_open_read (window_template)
			create class_text.make (window_template_file.count)
			window_template_file.start
			window_template_file.read_stream (window_template_file.count)
			class_text := window_template_file.last_string
			window_template_file.close
		
				-- We must now perform the generation into `class_text'.
				-- First replace the name of the class
			set_class_name (system_status.current_project_settings.main_window_class_name)
			
			temp_string := system_status.current_project_settings.main_window_class_name.as_upper + class_implementation_extension
			if project_settings.client_of_window then
					-- Add redefinition of `default_create' if we are client.
				temp_string := temp_string + default_create_redefinition
			end
				-- Generate the inheritance from the window implementation.
			set_inherited_class_name (temp_string)
			
			if project_settings.client_of_window then
				add_generated_string (class_text, redefined_creation, creation_tag)
			else
				add_generated_string (class_text, Void, creation_tag)
			end
			
			add_generated_string (class_text, event_implementation_string, event_declaration_tag)
			
				-- Store `class_text'.				
			window_file_name := clone (generated_path)
			window_file_name.extend (system_status.current_project_settings.main_window_class_name.as_lower + eiffel_class_extension)
			create window_output_file.make (window_file_name)
			if not window_output_file.exists then
				window_output_file.open_write
				window_output_file.start
				window_output_file.putstring (class_text)
				window_output_file.close
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
				a_class_text.remove_substring (temp_index + 1, temp_index + 2)
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
		
	prepass_xml (element: XML_ELEMENT; info: GB_GENERATED_INFO; depth: INTEGER) is
			-- With information in element, build information into `info'.
		local
			current_element: XML_ELEMENT
			current_data_element: XML_CHARACTER_DATA
			current_name, current_type: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			action_sequence_info: GB_ACTION_SEQUENCE_INFO
		do
			info.set_element (element)
			if element.has_attribute_by_name (type_string) then
				current_type := element.attribute_by_name (type_string).value.to_utf8
				info.set_type (current_type)
			end
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name.to_utf8
					if current_name.is_equal (Item_string) then
						prepass_xml (current_element, info.new_child, depth + 1)
					else
						if current_name.is_equal (Internal_properties_string) and depth > 1 then
							full_information := get_unique_full_info (current_element)
							element_info := full_information @ (name_string)
							check
								name_exists: element_info /= Void
							end
								-- We must assign an empty string if we are a window,
								-- as the name is not required, as any settings are
								-- applied to the window without requiring the window to
								-- be named. Look at a generated code example.
							if current_type.is_equal (Ev_titled_window_string) then
								if System_status.current_project_settings.client_of_window then
									info.set_name (Client_window_string)
								else
									info.set_name ("")
								end
							else
								info.set_name (element_info.data)
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
									action_sequence_info := string_to_action_sequence_info (current_data_element.content.to_utf8)
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
				if generated_info.name /= Void and then not generated_info.name.is_empty then
					if generated_info.name /= Client_window_string then
						-- If the name is equal to `client_window_string' then we must be the window
						-- in a client based system. This has a special attribute clauses added in the
						-- file, so we do not add it in the same fashion as other attributes.
						if system_status.current_project_settings.grouped_locals then
							add_local_on_grouped_line (generated_info.type, generated_info.name)
						else
							add_local_on_single_line (generated_info.type, generated_info.name)
						end
					end
					create_local (generated_info.name)
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
				if generated_info.parent /= Void and then generated_info.parent.type /= Void and then generated_info.parent.type.is_equal (Ev_titled_window_string) then
					do_nothing
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
				elseif generated_info.name /= Void then
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
			supported_types: ARRAYED_LIST [STRING]
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
						
						add_set (gb_ev_any.generate_code (generated_info.supported_type_elements @ (supported_types.index), generated_info))
					supported_types.forth
				end

				all_ids.forth
			end
		end
		
	generate_events is
			-- Using `document_info' which was generated in `prepass_xml',
			-- generate source code corresponding to selected events.
		local
			gb_ev_any: GB_EV_ANY
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
						-- If we are generating an event for an window, then there is no attribute name
						-- generated.
					if generated_info.name.is_empty then --type.is_equal (Ev_titled_window_string) then
						local_name := ""
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
					events.forth
				end
				
				all_ids.forth
			end
			
				-- Now we must connect the close event of the window:
			add_event_connection ("%T-- Close the application when an interface close")
			add_event_connection ("%T-- request is recieved on `Current'. i.e. the cross is clicked.")
			if System_status.current_project_settings.client_of_window then
				add_event_connection (Client_window_string + ".close_request_actions.extend (agent ((create {EV_ENVIRONMENT}).application).destroy)")
			else
				add_event_connection ("close_request_actions.extend (agent ((create {EV_ENVIRONMENT}).application).destroy)")
			end
		end

	add_local_on_single_line (local_type, name: STRING) is
			-- Add code representation of new local named `name' of type
			-- `local_type' to `local_string'.
			-- Each new local is placed on an individual line. e.g.
			-- button1: EV_BUTTON
			-- button2: EV_BUTTON
		local	
			temp_string,local_string_start, indent_string: STRING
		do
				-- Need to generate slightly different code dependent
				-- on whether the atrributes are local or not.
			if project_settings.attributes_local then
				indent_string := indent
				local_string_start := "local " + indent
			else
				indent_string := indent_less_two
				local_string_start := "" + indent_less_two
			end
			
			if local_string = Void then
				local_string := local_string_start
				temp_string := name + ": " + local_type
			else
				temp_string := indent_string + name + ": " + local_type
			end
			
			local_string := local_string + temp_string
		end
		
	add_local_on_grouped_line (local_type, name: STRING) is
			-- Add code representation of new local named `name' of type
			-- `local_type' to `local_string'.
			-- Each new local will be grouped with other locals of same type. e.g.
			-- button1, button2: EV_BUTTON
		local
			temp_string, local_string_start, indent_string: STRING
			index_of_type, search_counter: INTEGER
			found_correctly: BOOLEAN
		do
				-- Need to generate slightly different code dependent
				-- on whether the atrributes are local or not.
			if project_settings.attributes_local then
				indent_string := indent
				local_string_start := "local " + indent
			else
				indent_string := indent_less_two
				local_string_start := "" + indent_less_two
			end
			
			if local_string = Void then
				local_string := local_string_start + name + ": " + local_type
			else
				from
					search_counter := 1
				until
					found_correctly or search_counter > local_string.count or search_counter = 0
				loop
					index_of_type := local_string.substring_index (local_type, search_counter)
					
						-- Notes on the first `if'.
						-- The first check checks that we have found the index, and that the folowing character is a new line character.
						-- This handles the case where the string contains EV_MENU_ITEM and we are searching for EV_MENU, as this will fail on
						-- the new line character check.
						-- The second check ignores the new line character if we are at the last position in `local_string'.
					if (index_of_type + local_type.count <= local_string.count and then local_string @ (index_of_type + local_type.count) = '%R') or
						(index_of_type + local_type.count - 1  = local_string.count) then
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
					local_string.insert_string (", " + name, index_of_type - 2)
					from
						search_counter := index_of_type
						found_correctly := False
					until
						search_counter = index_of_type - 80 or found_correctly or
						search_counter = 0
					loop
						if (local_string @ search_counter) = '%R' then
							found_correctly := True
						end
						search_counter := search_counter - 1
					end
					if not found_correctly then
						local_string.insert_string (indent_string, index_of_type)--"%R%N", index_of_type)
					end
				else
					temp_string := indent_string + name + ": " + local_type
					local_string := local_string + temp_string
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
			body.remove_substring (tab_index + 1, next_index)--index, next_index)
		end
		
		
		
	create_local (name: STRING) is
			-- Add code representation of the creation of local `name'
			-- to `create_string'.
		local
			temp_string: STRING
		do
			temp_string := indent + "create " + name
			if create_string = Void then
				create_string := create_widgets_comment + temp_string
			else
				create_string := create_string + temp_string
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
				event_connection_string := connect_events_comment-- Connect events."
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

	current_document: XML_DOCUMENT
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

end -- class GB_CODE_GENERATOR
