indexing
	description: "Objects that store the write an XML representation of%
		%the window that has been built."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_XML_STORE
	
inherit

	GB_XML_UTILITIES
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
	
	GB_EVENT_UTILITIES
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
	
	GB_NAMING_UTILITIES
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_STATUS_BAR
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		end
	
feature -- Basic operation

	store is
			-- Store `display_window' and contents in XML format in file `filename'.
		local
			formater: XM_FORMATTER
			generation_settings: GB_GENERATION_SETTINGS
			output_file: KL_TEXT_OUTPUT_FILE
			last_string: KL_STRING_OUTPUT_STREAM
			invalid_chars: HASH_TABLE [CHARACTER, CHARACTER]
			dialog: EV_MESSAGE_DIALOG
			warning_text: STRING
			abort_saving: BOOLEAN
			warning_dialog: EV_WARNING_DIALOG
		do
			create generation_settings
			generation_settings.enable_is_saving
				-- Generate an XML representation of the system in `document'.
			generate_document (generation_settings)
			
				-- Process XML to `last_string'.
			create last_string.make ("")
			create formater.make
			formater.set_output (last_string)
			formater.process_document (document)
			

				-- Check for invalid characters.
				-- It is only possible to perform this at this stage, as the save file must have been generated
				-- so that we have access to the text so we may search for invalid characters.
			invalid_chars := invalid_characters (last_string.string)
			if not invalid_chars.is_empty then
				clear_status_bar
				warning_text := invalid_characters1.twin
				from
					invalid_chars.start
				until
					invalid_chars.off
				loop
					warning_text.append_character ('%'')
					warning_text.append_character (invalid_chars.item_for_iteration)
					warning_text.append_character ('%'')
					invalid_chars.forth
					if not invalid_chars.off then
						warning_text.append (", ")
					end
				end
				warning_text.append (invalid_characters2)
				create {EV_CONFIRMATION_DIALOG} dialog.make_with_text (warning_text)
				dialog.show_modal_to_window (main_window)
				if dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					replace_invalid_characters (last_string.string)
				else
					abort_saving := True
					set_timed_status_text ("Project save cancelled")
				end
			end
			
			if not abort_saving then
					-- Nicely format `last_string.string' to have indentation.
				process_xml_string (last_string.string)
						
					-- Save nicely formatted XML ouput to disk in `filename'.
				create output_file.make (filename)
				output_file.open_write
				if output_file.is_open_write then
					output_file.put_string (xml_format)
					output_file.put_string (last_string.string)
					output_file.close
					set_timed_status_text ("Saved.")
				else
					create warning_dialog.make_with_text (unable_to_save_part1 + filename + unable_to_save_part2)
					warning_dialog.show_modal_to_window (main_window)
					clear_status_bar
				end
			end
		end
		
	register_object_written_agent (an_agent: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER]]) is
			-- Insert `an_agent' into `object_written_actions'.
		require
			agent_not_void: an_agent /= Void
		do
			object_written_action := an_agent
		end
		
	store_individual_object (object: GB_OBJECT) is
			-- Build a representation of `object' as root node within `last_stored_individual_object'
		require
			object_not_void: object /= Void
		local
			first_element, current_element: XM_ELEMENT
		do
			create last_stored_individual_object_document.make_with_root_named ("new_object", create {XM_NAMESPACE}.make_default)
			create first_element.make_root (last_stored_individual_object_document, item_string, create {XM_NAMESPACE}.make_default)
			
			
			current_element := new_child_element (first_element, item_string, "")
			add_attribute_to_element (current_element, "type", "", object.type)
			first_element.force_first (current_element)
			
			add_new_object_to_output (object, current_element, create {GB_GENERATION_SETTINGS})
		end
		
	last_stored_individual_object: XM_ELEMENT is
			-- `Result' is XML representation of last GB_OBJECT passed to
			-- `store_individual_object'.
		do
			if last_stored_individual_object_document /= Void then
				 Result := last_stored_individual_object_document.root_element
			end
		end

feature {GB_XML_HANDLER, GB_OBJECT_HANDLER, GB_OBJECT} -- Implementation

	add_new_object_to_output (an_object: GB_OBJECT; element: XM_ELEMENT; generation_settings: GB_GENERATION_SETTINGS) is
			-- Add XML representation of `an_object' to `element'.
		local
			new_widget_element: XM_ELEMENT
			gb_parent_object: GB_PARENT_OBJECT
			current_object: GB_OBJECT
			children: ARRAYED_LIST [GB_OBJECT]
		do
			
			output_attributes (an_object, element, generation_settings)
			gb_parent_object ?= an_object
				-- We check that the object may have children.
			if gb_parent_object /= Void then
				if not gb_parent_object.children.is_empty then
					create children.make (gb_parent_object.children.count)
					from	
						gb_parent_object.children.start
					until
						gb_parent_object.children.off
					loop
						children.extend (gb_parent_object.children.item)
						gb_parent_object.children.forth
					end		
					from	
						children.start
					until
						children.off
					loop
						current_object := children.item
						new_widget_element := create_widget_instance (element, current_object.type)
						element.force_last (new_widget_element)
						add_new_object_to_output (current_object, new_widget_element, generation_settings)
						children.forth
					end
				end
			end
		end
		
	output_attributes (an_object: GB_OBJECT; element: XM_ELEMENT; generation_settings: GB_GENERATION_SETTINGS) is
			--Output attributes of `an_object' to `element'. If `add_names' then generate
			-- a unique name for each object that is not named.
		local
			handler: GB_EV_HANDLER
			supported_types: ARRAYED_LIST [STRING]
			current_type: STRING
			gb_ev_any: GB_EV_ANY
			new_type_element: XM_ELEMENT
			vision2_type: STRING
			events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
		do
			objects_written := objects_written + 1
			if object_written_action /= Void then
				Object_written_action.call ([object_count, objects_written])
			end
			create handler
				-- We must store the name and other attributes
				-- which are used internally. These are not in the
				-- interface of Vision2
			new_type_element := new_child_element (element, Internal_properties_string, "")
			element.force_last (new_type_element)
			an_object.generate_xml (new_type_element)
			
				-- Now store all attributes from interface of Vision2.
			supported_types := handler.supported_types.twin
			from
				supported_types.start
			until
				supported_types.off
			loop
				current_type := supported_types.item
				current_type.to_upper
				vision2_type := current_type.substring (4, current_type.count)
				if is_instance_of (an_object.object, dynamic_type_from_string (vision2_type)) then
					gb_ev_any ?= new_instance_of (dynamic_type_from_string (current_type))
					gb_ev_any.default_create
					check
						gb_ev_any_exists: gb_ev_any /= Void
					end
					gb_ev_any.set_object (an_object)
					gb_ev_any.add_object (an_object.object)
					new_type_element := new_child_element (element, vision2_type, "")
					element.force_last (new_type_element)	
					gb_ev_any.generate_xml (new_type_element)
				end
				supported_types.forth
			end
			
				-- We must now store the selected action sequences.
				events := an_object.events
				if events.count > 0 then
					new_type_element := new_child_element (element, Events_string, "")
					element.force_last (new_type_element)	
					from
						events.start
					until
						events.off
					loop
						add_element_containing_string (new_type_element, Event_string, action_sequence_info_to_string (events.item))
						events.forth
					end
				end
		end
		
feature {GB_CODE_GENERATOR} -- Implementation

	object_count: INTEGER
		-- Number of objects to be written.
		-- Used for calculating percentage of save.
	
	objects_written: INTEGER
		-- Number of objects currently written.
		-- Used for calculating percentage of save.
		
	generate_document (generation_settings: GB_GENERATION_SETTINGS) is
			-- Generate an XML representation of the
			-- current system in `document'.
			-- If `add_names' then generate a name
			-- automatically and insert for any object
			-- that was not named by the user.
		local
			application_element, window_element,
			new_type_element: XM_ELEMENT
			namespace: XM_NAMESPACE
			constants_list: HASH_TABLE [GB_CONSTANT, STRING]
		do
			object_count := object_handler.objects.count
			objects_written := 0
				-- If we are adding names, then we must ensure that the list of
				-- names is empty when we being generating.
			if generation_settings.generate_names then
				generated_names.wipe_out
			end
			
			create namespace.make_default
			create document.make_with_root_named ("application", namespace)
			application_element := document.root_element
			add_attribute_to_element (application_element, "xsi", "xmlns", Schema_instance)	

				-- Firstly store all constants.
			 constants_list := constants.all_constants
			 
			window_element := create_widget_instance (application_element, Constants_string)
			application_element.force_last (window_element)
			from
				constants_list.start
			until
				constants_list.off
			loop
				new_type_element := new_child_element (window_element, constant_string, "")
				window_element.force_last (new_type_element)
				constants_list.item (constants_list.key_for_iteration).generate_xml (new_type_element)
				constants_list.forth
			end

			store_windows (widget_selector, application_element, generation_settings)
				-- Store all directories and windows.
		end
		
	store_windows (children_holder: GB_WIDGET_SELECTOR_COMMON_ITEM; xml_element: XM_ELEMENT; generation_settings: GB_GENERATION_SETTINGS) is
			-- Store all windows and directoris contained within `children_list' into `xml_settings', using generation
			-- settings `generation_settings'.
		require
			children_list_not_void: children_holder /= Void
			xml_element_not_void: xml_element /= Void
			generation_settings_not_void: generation_settings /= Void
		local
			widget_selector_item: GB_WIDGET_SELECTOR_ITEM
			widget_selector_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			new_element, new_type_element: XM_ELEMENT
			children_list: ARRAYED_LIST [GB_WIDGET_SELECTOR_COMMON_ITEM]
		do
			children_list := children_holder.children
			from
				children_list.start
			until
				children_list.off
			loop
				widget_selector_item ?= children_list.item
				 if widget_selector_item /= Void then
				 		-- We ignore directories, although we should add them soon.
					new_element := create_widget_instance (xml_element, widget_selector_item.object.type)
					xml_element.force_last (new_element)
					add_new_object_to_output (widget_selector_item.object, new_element, generation_settings)		
				else
					widget_selector_directory_item ?= children_list.item
					if widget_selector_directory_item /= Void then
						new_element := create_widget_instance (xml_element, directory_string)	
						xml_element.force_last (new_element)
						new_type_element := new_child_element (new_element, Internal_properties_string, "")
						new_element.force_last (new_type_element)
						widget_selector_directory_item.generate_xml (new_type_element)
						store_windows (children_list.item, new_element, generation_settings)
					else
						check
							unsupported_type_found: False
						end
					end
				end
				children_list.forth
			end
		end
		
		
	document: XM_DOCUMENT
		-- Result of last call to `generate_document'.
		-- XML document generated from created window.

feature {NONE} -- Implementation

	generated_names: ARRAYED_LIST [STRING] is
			-- All names generated automatically.
		once
			create Result.make (0)
		end
		
	object_written_action: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER]]
			-- An agent to be fired when a new object is written to the XML.
			
	last_stored_individual_object_document: XM_DOCUMENT
		-- Document used by `store_individual_object'.

end -- class GB_XML_STORE
