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
	
	GB_CONSTANTS
	
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
			project_settings: GB_PROJECT_SETTINGS
			directory: DIRECTORY
			directory_file_name: FILE_NAME
		do
			project_settings := system_status.current_project_settings
			create directory_file_name.make_from_string (project_settings.project_location)
			directory_file_name.extend (generation_directory)
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
			
				-- generate the window of the project.
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
			Result.extend ("generated")
		end
		
	build_ace_file is
			-- Generate the ace file for the project
			-- dependent in information in `system_status'.
		local
			platform_ace_file_name: FILE_NAME
			project_location, ace_file_name: FILE_NAME
			project_settings: GB_PROJECT_SETTINGS
			ace_template_file, ace_output_file: RAW_FILE
			temp_string: STRING
			i, j: INTEGER
		do	
			set_progress (0.1)
			project_settings := system_status.current_project_settings
			if Eiffel_platform.is_equal ("windows") then
				platform_ace_file_name := clone (windows_ace_file_name)
			else
				platform_ace_file_name := clone (unix_ace_file_name)
			end
			
			create project_location.make_from_string (system_status.current_project_settings.project_location)
			project_location.extend ("generated")
			
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
			
			ace_file_name := clone (generated_path)
			ace_file_name.extend ("build_ace.ace")
					-- Store `ace_text'.
			create ace_output_file.make_open_write (ace_file_name)
			ace_output_file.start
			ace_output_file.putstring (ace_text)
			ace_output_file.close
		end
		
		
		build_application_file is
				-- Generate an application class for the project.
			local
				application_template_file, application_output_file: RAW_FILE
				application_file_name: FILE_NAME
				main_window_type: STRING
				main_window_tag_index: INTEGER
			do
				set_progress (0.2)
				create application_template_file.make_open_read (application_template_file_name)
				create application_text.make (application_template_file.count)
				application_template_file.start
				application_template_file.read_stream (application_template_file.count)
				application_text := application_template_file.last_string
				application_template_file.close
			
				main_window_type := system_status.current_project_settings.main_window_class_name
				main_window_type.to_upper
				
				main_window_tag_index := application_text.substring_index (main_window_tag, 1)
				application_text.replace_substring_all (main_window_tag, "")			
				application_text.insert_string (main_window_type, main_window_tag_index)
			
				application_file_name := clone (generated_path)
				application_file_name.extend ("build_application.e")

				create application_output_file.make_open_write (application_file_name)
				application_output_file.start
				application_output_file.putstring (application_text)
				application_output_file.close
			end
			
		
		build_main_window is
				-- Generate a main window for the project.
			local
				store: GB_XML_STORE
				window_template_file, window_output_file: RAW_FILE
				window_file_name: FILE_NAME
				temp_index, local_tag_index, create_tag_index: INTEGER
			do
				set_progress (0.3)
				create store
					-- Generate an XML representation of the current project.
					-- We will build our class text directly from this XML.
				store.generate_document (True)
				current_document := store.document
				check
					current_document_not_void: current_document/= Void
				end
				
				set_progress (0.6)
					-- Retrieve the template for a class file to generate.
				create window_template_file.make_open_read (window_template_file_name)
				create class_text.make (window_template_file.count)
				window_template_file.start
				window_template_file.read_stream (window_template_file.count)
				class_text := window_template_file.last_string
				window_template_file.close
			
					-- We must now perform the generation into `class_text'.
					-- First replace the name of the class
				set_class_name (system_status.current_project_settings.main_window_class_name)

				
				set_progress (0.7)
				-- Generate the widget declarations and creation lines.
				generate_declarations (current_document.root_element, 1)
				
					-- Create storage for all parent child name pairs.
				create parent_child.make (0)
				
				set_progress (0.8)
					-- Generate the widget building code.
				generate_structure (current_document.root_element, 1, "", "")
				
				set_progress (0.9)
					-- Generate the widget setting code.
				generate_setting (current_document.root_element, 1)
				
					-- Generate the event code.
				generate_events (current_document.root_element, 1)
	
				local_tag_index := class_text.substring_index (local_tag, 1)
				class_text.replace_substring_all (local_tag, "")			
				class_text.insert_string (local_string, local_tag_index)
				
				create_tag_index := class_text.substring_index (create_tag, 1)
				class_text.replace_substring_all (create_tag, "")			
				class_text.insert_string (create_string, create_tag_index)
				
				temp_index := class_text.substring_index (build_tag, 1)
				class_text.replace_substring_all (build_tag, "")			
				class_text.insert_string (build_string, temp_index)
				
				temp_index := class_text.substring_index (set_tag, 1)
				class_text.replace_substring_all (set_tag, "")			
				class_text.insert_string (set_string, temp_index)
				
				temp_index := class_text.substring_index (event_connection_tag, 1)				
				class_text.replace_substring_all (event_connection_tag, "")
				class_text.insert_string (event_connection_string, temp_index)
				
				temp_index := class_text.substring_index (event_declaration_tag, 1)				
				class_text.replace_substring_all (event_declaration_tag, "")
				class_text.insert_string (event_declaration_string, temp_index)

				
					-- Need to add pixmap initialization if `class_text' contains
					-- `pixmap'. If it does, this means that some pixmaps have been set,
					-- and we must add a pixmap to `class_text'. This really is somewhat of a hack. Julian.
				if class_text.substring_index (pixmap_name, 1) /= 0 then
					class_text.insert_string (pixmap_name + ": EV_PIXMAP" + indent, local_tag_index)
					class_text.insert_string ("create " + pixmap_name + indent, create_tag_index + pixmap_name.count +
						(": EV_PIXMAP").count + indent.count)
				end
					
					-- Store `class_text'.				
				window_file_name := clone (generated_path)
				window_file_name.extend (system_status.current_project_settings.main_window_file_name)
				create window_output_file.make_open_write (window_file_name)
				window_output_file.start
				window_output_file.putstring (class_text)
				window_output_file.close
			end

	set_class_name (a_name: STRING) is
			-- Replace all occurances of `class_name_tag' with
			-- `a_name' within `class_text'.
		do
			a_name.to_upper
			class_text.replace_substring_all (class_name_tag, a_name)
		end

	generate_declarations (element: XML_ELEMENT; depth: INTEGER) is
			-- With information in `element', generate code which includes the
			-- attribute declarations and creation of all components in system.
		local
			current_element: XML_ELEMENT
			current_name: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			current_type: STRING
		do
			if element.has_attribute_by_name (type_string) then
				current_type := element.attribute_by_name (type_string).value.to_utf8
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
						generate_declarations (current_element, depth + 1)
					else
						if current_name.is_equal (Internal_properties_string) and depth > 2 then
								full_information := get_unique_full_info (current_element)
								element_info := full_information @ (name_string)
									-- If `Grouped_locals' then group all locals together.
								if system_status.current_project_settings.grouped_locals then
									add_local_on_grouped_line (current_type, element_info.data)
								else
									add_local_on_single_line (current_type, element_info.data)
								end
								create_local (element_info.data)
						else
						end
					end
				end
				element.forth
			end
		end

	generate_structure (element: XML_ELEMENT; depth: INTEGER; parent_name, parent_type: STRING) is
			-- With information in `element', generate code which will
			-- parent all objects.
		local
			current_element: XML_ELEMENT
			current_name: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			current_type: STRING
			new_object : GB_OBJECT
			found_name: STRING
			menu_bar_object: GB_MENU_BAR_OBJECT
		do
				-- Retrieve the current type represented by `element'.
			if element.has_attribute_by_name (type_string) then
				current_type := element.attribute_by_name (type_string).value.to_utf8
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
						if found_name = Void then
							found_name := ""
						end
						generate_structure (current_element, depth + 1, found_name, current_type)
					else
						if current_name.is_equal (Internal_properties_string) and depth > 2 then
								full_information := get_unique_full_info (current_element)
								element_info := full_information @ (name_string)
								new_object := object_handler.build_object_from_string (current_type)
									--| FIXME we must use the extend from the parent type.
									
									-- Because at the top level we are a window, we do not need to include the
									-- windows name in the code generated. Checking the current depth tells us whether
									-- we are generating code for a window or not. i.e for the window code
									-- generated should be "extend (widget)" instead of "something.extend (widget)".
								if depth = 3 then
										--| FIXME this should be implemented in a less specific way,
										--| not in this class.
									menu_bar_object ?= new_object
									if menu_bar_object /= Void then
										add_build ("set_menu_bar (" + element_info.data + ")")
									else
										if not parent_type.is_equal ("EV_TABLE") then
											add_build (new_object.extend_xml_representation (element_info.data))						
										end
									end
								else
										-- Tables need to use put, but this is done in conjunction with the placement.
										-- So here, we do not add the children of the table, as it will be done later.
									if not parent_type.is_equal ("EV_TABLE") then
										add_build (parent_name + "." + new_object.extend_xml_representation (element_info.data))
									end
										-- Store the parent and child attribute names in `parent_child'.									
									parent_child.extend (parent_name)
									parent_child.extend (element_info.data)
								end
								found_name := element_info.data
						else
						end
					end
				end
				element.forth
			end
		end
		
	generate_setting (element: XML_ELEMENT; depth: INTEGER) is
			-- With information in `element', generate code which will
			-- set_all_objects.
		local
			current_element: XML_ELEMENT
			current_name: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			current_type: STRING
			gb_ev_any: GB_EV_ANY
			current_iterative_name: STRING
		do
			if element.has_attribute_by_name (type_string) then
				current_type := element.attribute_by_name (type_string).value.to_utf8
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
						generate_setting (current_element, depth + 1)
					else
						if current_name.is_equal (Internal_properties_string) then
							full_information := get_unique_full_info (current_element)
							element_info := full_information @ (name_string)
							current_iterative_name := element_info.data
						elseif current_name.is_equal (Events_string) then
							-- Do nothing if we have found events.
							-- There is no setting to be generated for these.
							-- This will be performed in `generate_events'.
						else
							gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + current_name))
						
								-- Call default_create on `gb_ev_any'
							gb_ev_any.default_create
						
							-- Ensure that the new class exists.
						check
							new_instance_exists: gb_ev_any /= Void
						end
							-- Add the appropriate objects to `objects'.
						if current_type.is_equal (Ev_titled_window_string) then
							add_set (gb_ev_any.generate_code (current_element, "", current_type,  Void))
						else
							add_set (gb_ev_any.generate_code (current_element, current_iterative_name, current_type, child_names (current_iterative_name)))
						end
						end
					end
				end
				element.forth
			end
		end
		
	generate_events (element: XML_ELEMENT; depth: INTEGER) is
			-- With information in `element', generate code which will
			-- set_all_objects.
		local
			current_element: XML_ELEMENT
			current_data_element: XML_CHARACTER_DATA
			current_name: STRING
			full_information, event_full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info, event_element_info: ELEMENT_INFORMATION
			current_type: STRING
			gb_ev_any: GB_EV_ANY
			current_iterative_name: STRING
			data: STRING
			char_data: STRING
			another_element: XML_ELEMENT
			action_sequence_info: GB_ACTION_SEQUENCE_INFO
			action_sequence: GB_EV_ACTION_SEQUENCE
			local_name: STRING
			comment_object_name: STRING
		do
			if element.has_attribute_by_name (type_string) then
				stored_current_type := element.attribute_by_name (type_string).value.to_utf8
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
						generate_events (current_element, depth + 1)
					else
						if current_name.is_equal (Internal_properties_string) then
							full_information := get_unique_full_info (current_element)
							element_info := full_information @ (name_string)
							current_iterative_name := element_info.data
							last_name := element_info.data
						elseif current_name.is_equal (Events_string) then
								-- We must now call `generate_events' again, the XML is in this format
								-- <Events>
								--		<Event>
								--		<Event>
								-- This allows us to iterate through all the Event data's.
							generate_events (current_element, depth)
						elseif current_name.is_equal (Event_string) then
							another_element := current_element
							from
								another_element.start
							until
								another_element.off
							loop
								current_data_element ?= another_element.item_for_iteration
								if current_data_element /= Void then
										-- Build `action_sequence_info' from the current data.
									action_sequence_info := string_to_action_sequence_info (current_data_element.content.to_utf8)
										-- Build `action_sequence' for generating additional information required.
									action_sequence ?= new_instance_of (dynamic_type_from_string ("GB_" + action_sequence_info.type))
									check
										action_sequence_not_void: action_sequence /= Void
									end
										-- If we are generating an event for an window, then there is no attribute name
										-- generated.
									if stored_current_type.is_equal (Ev_titled_window_string) then
										local_name := ""
									else
										local_name := last_name + "."
									end
										-- If there are no arguments to the action sequence then generate no open arguments.
									if action_sequence.count = 0 then
										add_event_connection (local_name + action_sequence_info.name + ".extend (agent " + action_sequence_info.feature_name + ")")
									else
										add_event_connection (local_name + action_sequence_info.name + ".extend (agent " + action_sequence_info.feature_name + " (" + action_sequence.open_arguments + "))") --current_iterative_name)
									end
									
										-- Use `Current' in comment if the event is connected to the window.
									if stored_current_type.is_equal (Ev_titled_window_string) then
										comment_object_name := "Current"
									else
										comment_object_name := last_name
									end
									
										-- Now we must generate the event declarations.
									add_event_declaration (action_sequence_info.feature_name + " is" +
									indent + "-- Called by `" + action_sequence_info.name + "' of `" + comment_object_name + "'." +
									indent_less_one + "do" + indent_less_one + "end" + indent_less_two)
									
									
								end
								another_element.forth
							end
						end
					end
				end
				element.forth
			end
		end
		
	last_name, stored_current_type: STRING
		-- Attributes used within `generate_events'.
		-- Cannot use locals as the recursion is more complicated in `generate_events'
		-- than in `generate_setting'.

	add_local_on_single_line (local_type, name: STRING) is
			-- Add code representation of new local named `name' of type
			-- `local_type' to `local_string'.
			-- Each new local is placed on an individual line. e.g.
			-- button1: EV_BUTTON
			-- button2: EV_BUTTON
		local
			temp_string: STRING
		do
			if local_string = Void then
				local_string := ""
				temp_string := name + ": " + local_type
			else
				temp_string := indent + name + ": " + local_type
			end
			
			local_string := local_string + temp_string
		end
		
	add_local_on_grouped_line (local_type, name: STRING) is
			-- Add code representation of new local named `name' of type
			-- `local_type' to `local_string'.
			-- Each new local will be grouped with other locals of same type. e.g.
			-- button1, button2: EV_BUTTON
		local
			temp_string: STRING
			index_of_type: INTEGER
			found_correctly: BOOLEAN
			search_counter: INTEGER
		do
			if local_string = Void then
				local_string := name + ": " + local_type
			else
				if name.is_equal ("l_tool_bar_button_2") then
					do_nothing	
				end
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
					if name.is_equal ("l_tool_bar_button_5") then
						do_nothing	
					end
					local_string.insert_string (", " + name, index_of_type - 2)
					from
						search_counter := index_of_type
						found_correctly := False
					until
						search_counter = index_of_type - 80 or found_correctly
					loop
						if (local_string @ search_counter) = '%R' then
							found_correctly := True
						end
						search_counter := search_counter - 1
					end
					if not found_correctly then
						local_string.insert_string (indent, index_of_type)--"%R%N", index_of_type)
					end
				else
					temp_string := indent + name + ": " + local_type
					local_string := local_string + temp_string
				end
			end
			
		end
		
		
	create_local (name: STRING) is
			-- Add code representation of the creation of local `name'
			-- to `create_string'.
		local
			temp_string: STRING
		do
			if create_string = Void then
				create_string := ""
				temp_string := "create " + name
			else
				temp_string := indent + "create " + name	
			end
			create_string := create_string + temp_string
		end
		
	add_build (constructor: STRING) is
			-- Add `constructor' to `build_string'.
		local
			temp_string: STRING
		do
			if build_string = Void then
				build_string := ""
				temp_string := constructor
			else
				temp_string := indent + constructor
			end
			build_string := build_string + temp_string
		end
		
	add_event_connection (event: STRING) is
			--
		do
			if event_connection_string = Void then
				event_connection_string := ""
			end
			event_connection_string := event_connection_string + indent + event
		end
		
	add_event_declaration (event: STRING) is
			--
		do
			if event_declaration_string = Void then
				event_declaration_string := ""
			end
			event_declaration_string := event_declaration_string + indent_less_two + event
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
				non_void_set := non_void_set.substring (2, non_void_set.count)
				non_void_set.replace_substring_all (indent + ".", indent)
			end
			
			
			if set_string = Void then
				set_string := ""
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
		
	child_names (current_name: STRING): ARRAYED_LIST [STRING]  is
			-- `Result' is attribute names for all children of attribute `current_name'.
			-- Queried from `parent_child'.
		require
			parent_child_not_void: parent_child /= Void
			parent_child_count_even: parent_child.count > 0 implies parent_child.count \\ 2 = 0
		do
			create Result.make (0)
			from
				parent_child.start
			until
				parent_child.off
			loop
				if parent_child.item.is_equal (current_name) then
				
						parent_child.forth

						Result.extend (parent_child.item)

						parent_child.forth
				else
					parent_child.go_i_th (parent_child.index + 2)
				end
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
				env.application.process_events
			end
		end
		
	
	parent_child: ARRAYED_LIST [STRING]
		-- A list of all parent attribute names and associated child names in the following format:
		-- parent, child, parent, child, parent, child.
		-- This is not the most efficient format, but can be changed as necessary.


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
		
	progress_bar: EV_PROGRESS_BAR
		-- A progress bar that will be updated during generation.

end -- class GB_CODE_GENERATOR
