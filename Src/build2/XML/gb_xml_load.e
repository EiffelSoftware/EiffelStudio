indexing
	description: "Objects that retrieve an XML representation of the window that%
		% was built previsouly, and creates it in the system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_XML_LOAD
	
inherit
	TOE_TREE_FACTORY
		export
			{NONE} all
		end	
	
	GB_XML_UTILITIES
		export
			{NONE} all
		end	
	
	GB_EVENT_UTILITIES
		export
			{NONE} all
		end	
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end	
	
	INTERNAL
		export
			{NONE} all
		end	
	
	GB_CONSTANTS
		export
			{NONE} all
		end	
	
	GB_FILE_CONSTANTS
		export
			{NONE} all
		end	
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end	
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end
		
	GB_SHARED_DEFERRED_BUILDER
		export
			{NONE} all
		end	
	
	GB_SHARED_STATUS_BAR
		export
			{NONE} all
		end	

	GB_POST_LOAD_OBJECT_EXPANDER
		export
			{NONE} all
		end	

feature -- Basic operation

	load is
			-- Load the system.
		do
			initialize_load_output
				-- Do initialization necessary
			parser := create_tree_parser

			--|FIXME this is a test to see whether either of these windows
			--| is shown while executing this code. I think that this is now impossible
			--| due to other changes, so have just removed the code that stored
			--| the state, and replaced it with these four lines. When sure that
			--| this check never fails, we can remove it.
		check
			display_window_hidden: not display_window.is_show_requested
			builder_window_hidden: not builder_window.is_show_requested
		end

				-- Load and parse file `filename'.
			load_and_parse_xml_file (filename)
			
				-- Build deferred parts.
			deferred_builder.build
			
			expand_all_registered_objects

				-- As we have just loaded the project, the
				-- system should know that it has not been modifified
				-- by the user.
			system_status.disable_project_modified
			
			remove_load_output
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	build_window (window: XML_ELEMENT; directory_name: STRING) is
			-- Build a window representing `window', represented in
			-- directory `directory_name'. if `directory_name' is
			-- empty, the window will be built int the root of the
			-- window selector.
		local
			current_element: XML_ELEMENT
			gb_ev_any: GB_EV_ANY
			current_name: STRING
			window_object: GB_TITLED_WINDOW_OBJECT
			layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			window_object := object_handler.add_root_window
			if not directory_name.is_empty then
				Window_selector.directory_object_from_name (directory_name).add_selector_item (window_object.window_selector_item)
			end
				--| FIXME we must now look at the current type of `window'
				--| which must be an EV_TITLED_WINDOW, and then add any attributes that
				--| are specific to EV_TITLED_WINDOW
			from
				window.start
			until
				window.off
			loop
				current_element ?= window.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name.to_utf8
					if current_name.is_equal (Item_string) then
						-- The element represents an item, so we must add new objects.
						build_new_object (current_element, window_object)
					else
							-- We must check for internal properties, else set the properties of the component
						if current_name.is_equal (Internal_properties_string) then
							layout_constructor_item ?= layout_constructor.first
							check
								layout_item_not_void: layout_constructor_item /= Void
							end
							window_object ?= layout_constructor_item.object
							check
								window_object_not_void: window_object /= Void
							end
							window_object.modify_from_xml (current_element)
						elseif current_name.is_equal (Events_string) then
								-- We now add the event information from `current_element'
								-- into `window_object'.
							extract_event_information (current_element, window_object)						
						else						
							-- Create the class.
						gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + current_name))
						
							-- Call default_create on `gb_ev_any'
						gb_ev_any.default_create
						
							-- Ensure that the new class exists.
						check
							new_instance_exists: gb_ev_any /= Void
						end
						
							-- Add the appropriate objects to `objects'.
						gb_ev_any.add_object (display_window)
						gb_ev_any.add_object (builder_window)
						
							-- Call `modify_from_xml' which should modify the objects.
						gb_ev_any.modify_from_xml (current_element)
						end
					end
				end
				window.forth
			end
		end

	retrieve_new_object (element: XML_ELEMENT; object: GB_OBJECT; pos: INTEGER): GB_OBJECT is
			-- Build a new object from information in `element', into `object' at position `pos'.
			-- `Result' is the new object.
		require
			element_not_void: element /= Void
			element_type_is_item: element.name.to_utf8.is_equal (Item_string)
		local
			new_object: GB_OBJECT
		do
			new_object := object_handler.build_object_from_string (element.attribute_by_name (type_string).value.to_utf8)
			Result := new_object
			object_handler.add_object (object, new_object, pos)
			modify_from_xml (element, new_object)
		end

feature {NONE} -- Implementation
		
	build_new_object (element: XML_ELEMENT; object: GB_OBJECT) is
			-- Build a new object from information in `element' into `object'.
		require
			element_not_void: element /= Void
			element_type_is_item: element.name.to_utf8.is_equal (Item_string)
		local
			new_object: GB_OBJECT
		do
			new_object := object_handler.build_object_from_string (element.attribute_by_name (type_string).value.to_utf8)
			object_handler.add_object (object, new_object, object.layout_item.count + 1)
			modify_from_xml (element, new_object)
		end
		
	modify_from_xml (element: XML_ELEMENT; object: GB_OBJECT) is
			-- Update properties of `object' based on information in `element'.
		local
			current_element: XML_ELEMENT
			gb_ev_any: GB_EV_ANY
			current_name: STRING
			display_object: GB_DISPLAY_OBJECT
		do
				from
				element.start
			until
				element.off
			loop
				Application.process_events
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name.to_utf8
					if current_name.is_equal (Item_string) then
							-- The element represents an item, so we must add new objects.
						build_new_object (current_element, object)
					elseif current_name.is_equal (Events_string) then
							-- We now add the event information from `current_element'
							-- into `object'.
						extract_event_information (current_element, object)
					else
							-- We must check for internal properties, else set the properties of the component
						if current_name.is_equal (Internal_properties_string) then
							object.modify_from_xml (current_element)
						else
						
							-- Create the class.
						gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + current_name))
						
							-- Call default_create on `gb_ev_any'
						gb_ev_any.default_create
						
							-- Ensure that the new class exists.
						check
							new_instance_exists: gb_ev_any /= Void
						end
						
							-- Add the appropriate objects to `objects'.
						gb_ev_any.add_object (object.object)
						display_object ?= object.display_object
						if display_object = Void then
							gb_ev_any.add_object (object.display_object)
						else
							gb_ev_any.add_object (display_object.child)
						end
						
							-- Call `modify_from_xml' which should modify the objects.
						gb_ev_any.modify_from_xml (current_element)
						end
					end
				end
				element.forth
			end
		end

	extract_event_information (element: XML_ELEMENT; object: GB_OBJECT) is
			-- Generate event information into `object', from `element'.
		require
			element_not_void: element /= Void
			element_type_is_events: element.name.to_utf8.is_equal (Events_string)
		local
			current_element: XML_ELEMENT
			current_name: STRING
			current_data_element: XML_CHARACTER_DATA
			data: STRING
		do
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name.to_utf8
					if current_name.is_equal (Event_string) then
						from
							current_element.start
						until
							current_element.off
						loop
							current_data_element ?= current_element.item_for_iteration
							if current_data_element /= Void then
								data := current_data_element.content.to_utf8
									-- Add data into `object'.
								object.events.extend (string_to_action_sequence_info (data))
							end
							current_element.forth
						end
					end
				end
				element.forth
			end
		end

	create_system is
			-- Create a system from the parsed XML file.
		local
			application_element: XML_ELEMENT
			window_element: XML_ELEMENT
			current_element: XML_ELEMENT
			current_name: STRING
			current_type: STRING
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			application_element := parser.document.root_element
			from
				application_element.start
			until
				application_element.off
			loop
				current_element ?= application_element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name.to_utf8
					if current_name.is_equal (Item_string) then
						current_type := current_element.attribute_by_name (type_string).value.to_utf8
						if current_type.is_equal (directory_string) then
							from
								current_element.start
							until
								current_element.off
							loop
								window_element ?= current_element.item_for_iteration
								if window_element /= Void then
									current_name := window_element.name.to_utf8
									if current_name.is_equal (Internal_properties_string)  then
										create directory_item.make_with_name ("")
										directory_item.modify_from_xml (window_element)
										window_selector.add_directory_item (directory_item)
									else
										build_window (window_element, directory_item.text)
									end
								end
								current_element.forth
							end
						else
							build_window (current_element, "")							
						end
					end
				end
				application_element.forth
			end
				-- Building the project causes the project to be marked as
				-- modified. We do not want this, as it should only
				-- be marked as so when the user does something.
			system_status.disable_project_modified
				-- Update all names in `window_selector' to ensure that
				-- they are current after the load.
			Window_selector.update_displayed_names
		end

	load_and_parse_xml_file (a_filename:STRING) is
			-- Load file `a_filename' and parse.
		local
			temp_window: EV_TITLED_WINDOW
			error_dialog:EV_ERROR_DIALOG
		do
			parse_file (a_filename)
			if not parser.is_correct then
				create temp_window
				create error_dialog.make_with_text ("Invalid XML Schema.")
				error_dialog.show_modal_to_window (temp_window)
				temp_window.destroy
			else
				create_system
			end
		end
		
	parse_file (a_filename: STRING) is
			-- Parse XML file `filename' with `parser'.
		local
			file: RAW_FILE
			buffer: STRING
		do
			create file.make_open_read (a_filename)
			create buffer.make (file.count) 
			file.start
			file.read_stream (file.count)
			buffer := file.last_string
			parser.parse_from_string (buffer)
			parser.set_end_of_document
		end
		
	initialize_load_output is
			-- Create `load_timer' and associate an
			-- action with it.
		do
			create load_timer.make_with_interval (250)
			load_timer.actions.extend (agent update_status_bar)
		 	set_status_text ("Loading    -")
		end
		
	update_status_bar is
			-- Refresh message displayed on status bar, to show
			-- that processing is still occurring.
		local
			last_character: CHARACTER
		do
			last_character := status_text.item (status_text.count)
			if last_character = '-' then
				set_status_text (status_text.substring (1, status_text.count - 2) + "\")
			elseif last_character.is_equal ('\') then
				set_status_text (status_text.substring (1, status_text.count - 1) + "|")
			elseif last_character.is_equal ('|') then
				set_status_text (status_text.substring (1, status_text.count - 1) + "/")
			elseif last_character.is_equal ('/') then
				set_status_text (status_text.substring (1, status_text.count - 1) + "--")
			end
		end
		
	remove_load_output is
			--  Destroy `load_timer' and display a final
			-- timed message on the status bar.
		do
			load_timer.destroy
			set_timed_status_text ("Load successful")			
		end

	load_timer: EV_TIMEOUT

	parser: XML_TREE_PARSER
		-- XML tree parser.
		
	document: XML_DOCUMENT
		-- XML document generated from created window.

end -- class GB_XML_LOAD
