indexing
	description: "Objects that import an existing EiffelBuild project file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_XML_IMPORT

inherit
	GB_XML_UTILITIES
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

	GB_CONSTANTS
		export
			{NONE} all
			{ANY} item_string
		end

	GB_FILE_CONSTANTS
		export
			{NONE} all
		end

	GB_SHARED_DEFERRED_BUILDER
		export
			{NONE} all
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

	GB_POST_LOAD_OBJECT_EXPANDER
		export
			{NONE} all
		end

	XM_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

	GB_ID_COMPRESSOR
		export
			{NONE} all
		end

	GB_NAMING_UTILITIES
		export
			{NONE} all
		end

	ANY

create
	make_with_components

feature -- Basic operation

	import (file_name: STRING) is
			-- Import EiffelBuild ".bpr" file named `file_name'.
		require
			file_name_not_void: file_name /= Void
		local
			a_file_name: FILE_NAME
			initial_selection: GB_WIDGET_SELECTOR_ITEM
		do
			create import_dialog
			components.system_status.enable_loading_project
			components.system_status.block
			components.events.import_project_start_actions.call (Void)
			initial_selection := components.tools.widget_selector.selected_window
			application.process_graphical_events
			initialize_load_output
				-- Clear History, as it is no longer possible to go back
				-- after importing a system.
			components.object_handler.reset_deleted_objects
			components.history.wipe_out

				-- Update all ids, to avoid clashes between the two sets.
			shift_all_ids_upwards

			create a_file_name.make_from_string (file_name)
			load_and_parse_xml_file (a_file_name)
			if parser.is_correct then
				import_system
				components.object_handler.update_all_associated_objects
			end
				-- Build deferred parts.
			deferred_builder.build
			application.process_graphical_events
			if initial_selection /= Void then
				initial_selection.tree_item.enable_select
			end

			components.system_status.disable_loading_project
			components.system_status.resume
			components.system_status.mark_as_dirty
			components.events.import_project_finish_actions.call (Void)

			if import_dialog.change_list.text.is_empty then
				remove_load_output
			else
				load_timer.destroy
				components.status_bar.set_status_text ("")
				import_dialog.show_modal_to_window (components.tools.main_window)
			end
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	build_window (window: XM_ELEMENT; parent_common_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Build a new window representing `window', represented in
			-- directory `directory_name'. if `directory_name' is
			-- empty, the window will be built into the root of the
			-- widget selector.
		require
			window_not_void: window /= Void
			parent_common_item_not_void: parent_common_item /= Void
		do
			internal_build_window (window, parent_common_item)
		end

	internal_build_window (window: XM_ELEMENT; parent_common_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Build a window representing `window', represented in
			-- directory `directory_name'. if `directory_name' is
			-- empty, the window will be built into the root of the
			-- widget selector.
		require
			window_not_void: window /= Void
			parent_common_item_not_void: parent_common_item /= Void
			--parent_node_list_not_void: parent_node_list /= Void
		local
			current_element, root_window_element: XM_ELEMENT
			gb_ev_any: GB_EV_ANY
			current_name: STRING
			an_object: GB_OBJECT
			cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			a_display_object: GB_DISPLAY_OBJECT
		do
			an_object := components.object_handler.add_root_window (window.attribute_by_name (type_string).value)
			from
				window.start
			until
				window.off
			loop
				current_element ?= window.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Item_string) then
						build_new_object (current_element, an_object)
					else
							-- We must check for internal properties, else set the properties of the component
						if current_name.is_equal (Internal_properties_string) then
							is_processing_window := True
							process_names (current_element)
							is_processing_window := False

								-- Now strip the root window tag, as we do not want to
								-- change the root window while importing.
							cursor := current_element.new_cursor
							current_element.start
							root_window_element := current_element.element_by_name (Root_window_string)
							if root_window_element /= Void then
								current_element.delete (root_window_element)
								current_element.go_to (cursor)
							end
							an_object.modify_from_xml (current_element)
							components.object_handler.add_object_to_objects (an_object)
							an_object.widget_selector_item.unparent
							parent_common_item.add_alphabetically (an_object.widget_selector_item)
							parent_common_item.expand
						elseif current_name.is_equal (Events_string) then
								-- We now add the event information from `current_element'
								-- into `window_object'.
							extract_event_information (current_element, an_object)
						else
							-- Create the class.
						gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + current_name))

							-- Call default_create on `gb_ev_any'
						gb_ev_any.default_create
						gb_ev_any.set_components (components)
						gb_ev_any.set_object (an_object)

							-- Ensure that the new class exists.
						check
							new_instance_exists: gb_ev_any /= Void
						end

							-- Add the appropriate objects to `objects'.
						gb_ev_any.add_object (an_object.object)
							-- Now that we support widgets at the top level, we must
							-- check and support display objects correctly.
						a_display_object ?= an_object.display_object
						if a_display_object /= Void then
							gb_ev_any.add_object (a_display_object.child)
						else
							gb_ev_any.add_object (an_object.display_object)
						end

							-- Call `modify_from_xml' which should modify the objects.
						gb_ev_any.modify_from_xml (current_element)
						end
					end
				end
				window.forth
			end
			is_processing_window := False
		end

	retrieve_new_object (element: XM_ELEMENT; object: GB_OBJECT; pos: INTEGER): GB_OBJECT is
			-- Build a new object from information in `element', into `object' at position `pos'.
			-- `Result' is the new object.
		require
			element_not_void: element /= Void
			element_type_is_item: element.name.is_equal (Item_string)
		local
			new_object: GB_OBJECT
		do
			new_object := components.object_handler.build_object_from_string (element.attribute_by_name (type_string).value)
			Result := new_object
			components.object_handler.add_object (object, new_object, pos)
			modify_from_xml (element, new_object)
		end

	process_names (element: XM_ELEMENT) is
			-- Update name stored in `element', if any, and only if
			-- name has changed.
		require
			element_not_void: element /= Void
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			current_name: STRING
			info: ELEMENT_INFORMATION
			el: XM_ELEMENT
			new_name: STRING
		do
			if is_processing_window then
				full_information := get_unique_full_info (element)
				info := full_information @ Name_string
				if info /= Void then
					current_name := info.data
					if current_name /= Void then
						if is_processing_window and all_names_pre_import.has (current_name) or
						not is_processing_window and all_constant_names.has (current_name) then
							element.start
							el := element.element_by_name (Name_string)
							element.delete (el)
							new_name := unique_name_from_hash_table (all_names_pre_import, current_name)
							add_element_containing_string (element, Name_string, new_name)
							import_dialog.add_output ("Object '" + current_name + "' renamed to '" + new_name + "'")
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	build_new_object (element: XM_ELEMENT; object: GB_OBJECT) is
			-- Build a new object from information in `element' into `object'.
		require
			element_not_void: element /= Void
			element_type_is_item: element.name.is_equal (Item_string)
		local
			new_object: GB_OBJECT
		do
			new_object := components.object_handler.build_object_from_string (element.attribute_by_name (type_string).value)
			components.object_handler.add_object (object, new_object, object.children.count + 1)
			modify_from_xml (element, new_object)
			components.object_handler.add_object_to_objects (new_object)
		end

	modify_from_xml (element: XM_ELEMENT; object: GB_OBJECT) is
			-- Update properties of `object' based on information in `element'.
		require
			element_not_void: element /= Void
			object_not_void: object /= Void
		local
			current_element: XM_ELEMENT
			gb_ev_any: GB_EV_ANY
			current_name: STRING
			display_object: GB_DISPLAY_OBJECT
		do
			from
				element.start
			until
				element.off
			loop
				Application.process_graphical_events
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
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
							process_names (current_element)
							object.modify_from_xml (current_element)
						else

							-- Create the class.
						gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + current_name))

							-- Call default_create on `gb_ev_any'
						gb_ev_any.default_create
						gb_ev_any.set_components (components)
						gb_ev_any.set_object (object)

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

	extract_event_information (element: XM_ELEMENT; object: GB_OBJECT) is
			-- Generate event information into `object', from `element'.
		require
			element_not_void: element /= Void
			element_type_is_events: element.name.is_equal (Events_string)
		local
			current_element: XM_ELEMENT
			current_name: STRING
			current_data_element: XM_CHARACTER_DATA
			data: STRING
		do
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Event_string) then
						from
							current_element.start
						until
							current_element.off
						loop
							current_data_element ?= current_element.item_for_iteration
							if current_data_element /= Void then
								data := current_data_element.content
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

	all_names_pre_import: HASH_TABLE [STRING, STRING]
		-- All names in currently open project, all object and constant names.

	all_constant_names: HASH_TABLE [STRING, STRING]
		-- Names of all constants in open project.

	renamed_constants: HASH_TABLE [STRING, STRING]
		-- All constants in project that is being imported. The key is the
		-- original name, and the data starts as the original name, but if clashes
		-- occur, the data is changed to the new name. This permits easy lookup
		-- of constant names to be changed.

	all_names_post_import: HASH_TABLE [STRING, STRING]
		-- All constant names and object names in original project, plus the names of
		-- all objects in the merged system. Constants in the merged system are not included.

	import_system is
			-- Import a system from the parsed XML file.
		local
			application_element, current_element, constants_element, constant_item_element: XM_ELEMENT
			current_name, current_type: STRING
			objects: ARRAYED_LIST [GB_OBJECT]
			constant_names: ARRAYED_LIST [STRING]
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			all_constants: ARRAYED_LIST [STRING]
			an_element: XM_ELEMENT
			cursor, cursor1: DS_LINKED_LIST_CURSOR [XM_NODE]
			previous_directory: STRING
		do
				-- Initialize all data structures for recording names in both systems.
			create all_names_pre_import.make (100)
			create all_constant_names.make (100)
			create all_names_post_import.make (100)
			create renamed_constants.make (20)
			objects := components.object_handler.objects.linear_representation
			from
				objects.start
			until
				objects.off
			loop
				all_names_pre_import.put (objects.item.name, objects.item.name)
				objects.forth
			end
			constant_names := components.constants.all_constant_names
			from
				constant_names.start
			until
				constant_names.off
			loop
				all_names_pre_import.put (constant_names.item, constant_names.item)
				all_constant_names.put (constant_names.item, constant_names.item)
				constant_names.forth
			end

				-- Firstly must prepass all constants to determine for clashes.
				-- All clashes are stored in `renamed_constants'
			parse_for_names (pipe_callback.document.root_element)
			application_element := Pipe_callback.document.root_element
			from
				application_element.start
			until
				application_element.off
			loop
				current_element ?= application_element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Item_string) then
						current_type := current_element.attribute_by_name (type_string).value

						if current_type.is_equal (Constants_string) then
							constants_element := current_element
							from
								constants_element.start
							until
								constants_element.off
							loop
								constant_item_element ?= constants_element.item_for_iteration
								if constant_item_element /= Void then
									full_information := get_unique_full_info (constant_item_element)
									element_info := full_information @ (Constant_name_string)
									if element_info /= void then
										renamed_constants.put (element_info.data, element_info.data)
									end
								end
								constants_element.forth
							end
						end
					end
				end
				application_element.forth
			end

				-- Now insert all names of original project into `all_names_post_import'.
			all_names_pre_import.linear_representation.do_all (agent add_to_post_import_names)

				-- We now check for clashes between the constants in the imported project, and the original system.
				-- As constants are global, they may not clash with any object name at any level.
			all_constants := renamed_constants.linear_representation
			from
				all_constants.start
			until
				all_constants.off
			loop
				if all_names_post_import.has (all_constants.item) then
						-- Now force a new unique name into `renamed_constants', so that it does not clash.
					renamed_constants.force (unique_name_from_hash_table (all_names_post_import, all_constants.item), all_constants.item)
				end
				all_constants.forth
			end

				--  Now update all constant references in the imported XML file, to remove any clashes.
				-- `renamed_constants' holds a list of original names as keys, and the new names that must replace them.

			application_element := Pipe_callback.document.root_element
			from
				application_element.start
			until
				application_element.off
			loop
				current_element ?= application_element.item_for_iteration
				if current_element /= Void then
					cursor1 := current_element.new_cursor
					current_name := current_element.name
					if current_name.is_equal (Item_string) then
						current_type := current_element.attribute_by_name (type_string).value
						if current_type.is_equal (Constants_string) then
							constants_element := current_element
							from
								constants_element.start
							until
								constants_element.off
							loop
								constant_item_element ?= constants_element.item_for_iteration
								if constant_item_element /= Void then

									full_information := get_unique_full_info (constant_item_element)
									element_info := full_information @ (Constant_name_string)
										-- We check that the constant is included in `renamed_constants', and that the
										-- key does not match the data. If they match, then no remaming has been performed, and
										-- there is no need to update the element.
									if renamed_constants.has (element_info.data) and then renamed_constants.item (element_info.data) /= element_info.data then
										-- Now rename the constant directly in the XML.
										cursor := constant_item_element.new_cursor
										an_element := constant_item_element.element_by_name (Constant_name_string)
										constant_item_element.start
										constant_item_element.delete (an_element)
										add_element_containing_string (constant_item_element, Constant_name_string, renamed_constants.item (element_info.data))
										import_dialog.add_output ("Constant '" + element_info.data + "' renamed to '" + renamed_constants.item (element_info.data) + "'")


											-- Now update the pointed directory, if it is a pixmap constant,
											-- as the directory to which it points may have been renamed.
										element_info := full_information @ (Type_string)
										if element_info.data.is_equal ("PIXMAP") then
											if an_element /= Void then
												element_info := full_information @ Directory_string
												previous_directory := element_info.data
													-- Only perform the renamin if the directory name has changed.
												if renamed_constants.item (previous_directory) /= element_info.data then
													an_element := constant_item_element.element_by_name (Directory_string)
													constant_item_element.start
													constant_item_element.delete (an_element)
													add_element_containing_string (constant_item_element, Directory_string, renamed_constants.item (previous_directory))
												end
											end
										end
										constant_item_element.go_to (cursor)
									end
								end
								constants_element.forth
							end
						end
					end
					current_element.go_to (cursor1)
				end
				application_element.forth
			end

				-- Now iterate through all XML, and update all constant references to use the new names.
				-- For example, every property that uses a constant has the name of the constant
				-- listed in a constant element. For every one of these found in the complete system,
				-- the data in that element mut be updated to reflect the new named of the constant if any.
			from
				application_element.start
			until
				application_element.off
			loop
				current_element ?= application_element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Item_string) then
						current_type := current_element.attribute_by_name (type_string).value
						if not current_type.is_equal (Constants_string) then
							update_constant_references_in_xml (current_element)
						end
					end
				end
				application_element.forth
			end

				-- Now actually perform the building of the objects from the imported project file.
				-- At this point, all prepass stages of the XML have been completed, and the XML
				-- representation of the imported project has been updated to avoid any clashes.
			application_element := pipe_callback.document.root_element
			build_window_structure (application_element, components.tools.widget_selector)

				-- Update all names in `widget_selector' to ensure that
				-- they are current after the load.
				--| FIXME why is this needed?
			components.tools.widget_selector.update_displayed_names

				-- Build any constants that were deferred.
			components.constants.build_deferred_elements
		end

	build_window_structure (an_element: XM_ELEMENT; parent_common_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Create the directory and window structure represented by `an_element' into `parent_node_list'.
		require
			an_element_not_void: an_element /= Void
			parent_common_item_not_void: parent_common_item /= Void
		local
			current_element, constant_item_element: XM_ELEMENT
			current_name, current_type: STRING
			window_element: XM_ELEMENT
			temp_directory, directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			tree_node_path: ARRAYED_LIST [STRING]
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			from
				an_element.start
			until
				an_element.off
			loop
				current_element ?= an_element.item_for_iteration
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
										check
											element_info_not_void: element_info /= Void
										end
										temp_directory ?= parent_common_item
										if temp_directory /= Void then
											tree_node_path := temp_directory.path
										else
											create tree_node_path.make (1)
										end
										tree_node_path.extend (element_info.data)
											-- We now retrieve an existing directory item matching the path of the
											-- new directory. This ensures that if we are importing a project that has
											-- the same directory structure, these directories are used.
										directory_item := components.tools.widget_selector.directory_object_from_name (tree_node_path)
										if directory_item = Void then
											create directory_item.make_with_name ("", components)
											directory_item.modify_from_xml (window_element)
											parent_common_item.add_alphabetically (directory_item)
										end
									end
								end
								current_element.forth
							end
							build_window_structure (current_element, directory_item)
						elseif current_type.is_equal (Constants_string) then
							from
								current_element.start
							until
								current_element.off
							loop
								constant_item_element ?= current_element.item_for_iteration
								if constant_item_element /= Void then
									components.constants.build_constant_from_xml (constant_item_element)
								end
								current_element.forth
							end
						else
							build_window (current_element, parent_common_item)
						end
					end
				end
				an_element.forth
			end
		end

	update_constant_references_in_xml (element: XM_ELEMENT) is
			-- Recursively update all constant references (e.g. properties using
			-- a paticular constant) in `element'.
		require
			element_not_void: element /= Void
		local
			current_element, an_element: XM_ELEMENT
			current_name: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
		do
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
						cursor := current_element.new_cursor
						if child_element_by_name (current_element, constant_string) /= Void then
								-- Only process if there is a child named `constant_string'. Prevents us
								-- from executing `full_information' each time. Also prevents `full_information'
								-- from crashing if we attempt to process an object that has two or more events set.
							full_information := get_unique_full_info (current_element)
							element_info := full_information @ (Constant_string)
							if element_info /= Void then

									-- Only perform the modification of the XML, if the name has really changed.
								if renamed_constants.has (element_info.data) and renamed_constants.item (element_info.data) /= element_info.data then
									an_element := current_element.element_by_name (Constant_string)
									current_element.start
									current_element.delete (an_element)
									add_element_containing_string (current_element, Constant_string, renamed_constants.item (element_info.data))
								end
							end
						end
						current_element.go_to (cursor)

						-- perform recursion, as every element in the structure must be visited.
					update_constant_references_in_xml (current_element)
				end
				element.forth
			end
		end

	add_to_post_import_names (s: STRING) is
			-- Add `s' to `all_names_post_import'.
		require
			s_not_void: s /= Void
		do
			all_names_post_import.put (s, s)
		ensure
			all_names_post_import.has (s)
		end

	parse_for_names (element: XM_ELEMENT) is
			-- Parse `element' recursively to find all names which are inserted in `all_names_post_import'.
		require
			element_not_void: element /= Void
		local
			current_element: XM_ELEMENT
			current_name : STRING
			cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
		do
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Internal_properties_string) then
						cursor := current_element.new_cursor
						retrieve_names (current_element)
						current_element.go_to (cursor)
					end
					parse_for_names (current_element)
				end
				element.forth
			end
		end

	retrieve_names (element: XM_ELEMENT) is
			-- Retrieve name if any from `element' and insert in `all_names_post_import'.
		require
			element_not_void: element /= Void
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			current_name: STRING
			info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			info := full_information @ Name_string
			if info /= Void then
				current_name := info.data
				if current_name /= Void then
					all_names_post_import.put (current_name, current_name)
				end
			end
		end

	load_and_parse_xml_file (a_filename: STRING) is
			-- Load file `a_filename' and parse.
		require
			file_name_not_void: a_filename /= Void
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
			end
		end

	parse_file (a_filename: STRING) is
			-- Parse XML file `filename' with `parser'.
		require
			file_name_not_void: a_filename /= Void
		local
			file: KL_BINARY_INPUT_FILE
			l_concat_filter: XM_CONTENT_CONCATENATOR
		do
			create file.make (a_filename)
			file.open_read
			create l_concat_filter.make_null
			create parser.make
			parser.set_callbacks (standard_callbacks_pipe (<<l_concat_filter, pipe_callback.start>>))
			parser.parse_from_stream (file)
			file.close
		end

	pipe_callback: XM_TREE_CALLBACKS_PIPE is
			-- Create unique callback pipe.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	initialize_load_output is
			-- Create `load_timer' and associate an
			-- action with it.
		do
			create load_timer.make_with_interval (250)
			load_timer.actions.extend (agent update_status_bar)
		 	components.status_bar.set_status_text ("Importing    -")
		 	environment.application.process_graphical_events
		end

	update_status_bar is
			-- Refresh message displayed on status bar, to show
			-- that processing is still occurring.
		local
			last_character: CHARACTER
		do
			last_character := components.status_bar.status_text.item (components.status_bar.status_text.count)
			if last_character = '-' then
				components.status_bar.set_status_text (components.status_bar.status_text.substring (1, components.status_bar.status_text.count - 2) + "\")
			elseif last_character.is_equal ('\') then
				components.status_bar.set_status_text (components.status_bar.status_text.substring (1, components.status_bar.status_text.count - 1) + "|")
			elseif last_character.is_equal ('|') then
				components.status_bar.set_status_text (components.status_bar.status_text.substring (1, components.status_bar.status_text.count - 1) + "/")
			elseif last_character.is_equal ('/') then
				components.status_bar.set_status_text (components.status_bar.status_text.substring (1, components.status_bar.status_text.count - 1) + "--")
			end
		end

	remove_load_output is
			--  Destroy `load_timer' and display a final
			-- timed message on the status bar.
		do
			load_timer.destroy
			components.status_bar.set_timed_status_text ("Import successful")
		end

	is_processing_window: BOOLEAN
		-- Is the current processed element representing a window?

	import_dialog: GB_IMPORT_DIALOG
		-- A dialog to display results of recent import.

	load_timer: EV_TIMEOUT
		-- A timeout which times the animation for the status bar.

	parser: XM_EIFFEL_PARSER
		-- XML tree parser.

	document: XM_DOCUMENT;
		-- XML document generated from created window.

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


end -- class GB_XML_IMPORT

