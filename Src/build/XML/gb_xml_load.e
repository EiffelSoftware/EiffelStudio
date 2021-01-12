note
	description: "Objects that retrieve an XML representation of the window that%
		% was built previsouly, and creates it in the system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_XML_LOAD

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

	ANY

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS)
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature -- Basic operation

	load
			-- Load the system.
		do
				-- Flag to the system that a load is now underway.
			components.system_status.enable_loading_project
			components.system_status.block

			initialize_load_output

		check
			display_window_hidden: not components.tools.display_window.is_show_requested
			builder_window_hidden: not components.tools.builder_window.is_show_requested
		end
				-- Load and parse file `filename'.
			load_and_parse_xml_file (system_interface_filename.utf_8_name)

			components.object_handler.update_all_associated_objects

				-- Build deferred parts.
			deferred_builder.build

				-- As we have just loaded the project, the
				-- system should know that it has not been modifified
				-- by the user.
			components.system_status.disable_project_modified

			remove_load_output

				-- Now mark one window as the main window of the system if it is
				-- `Void' which will occur when you load an old project that did not
				-- have a root window.
			if components.object_handler.root_window_object = Void and not components.tools.widget_selector.objects.is_empty then
				components.tools.widget_selector.mark_first_window_as_root
				components.system_status.disable_project_modified
			end

				-- Only select a main window if there is at least one window
				-- in the system. It is possible to save a project after having
				-- deleted all windows.
			if components.object_handler.root_window_object /= Void then
				components.tools.widget_selector.select_main_window
			end

				-- Flag to the system that a load is no longer underway.
			components.system_status.disable_loading_project
			components.system_status.resume
		end

	system_interface_filename: PATH
			-- File to be generated.
		do
			create Result.make_from_string (components.system_status.current_project_settings.project_location)
			Result := Result.extended ("system_interface.xml")
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	build_window (window: XM_ELEMENT; parent_common_item: GB_WIDGET_SELECTOR_COMMON_ITEM)
			-- Build a new window representing `window', represented in
			-- directory representation `parent_list'.
		require
			window_not_void: window /= Void
			parent_common_item_not_void: parent_common_item /= Void
		do
			internal_build_window (window, parent_common_item, Void)
		end

	internal_build_window (window: XM_ELEMENT; parent_common_item: GB_WIDGET_SELECTOR_COMMON_ITEM; object: GB_OBJECT)
			-- Build a window representing `window', represented in
			-- `window' to directory `parent_common_item' or `widget_selector' if `Void'.
			-- If `object' is Void we must create it.
		require
			window_not_void: window /= Void
			parent_common_item_not_void: parent_common_item /= Void
		local
			current_element: XM_ELEMENT
			gb_ev_any: GB_EV_ANY
			current_name: STRING
			an_object: GB_OBJECT
			a_display_object: GB_DISPLAY_OBJECT
		do
			if object = Void then
					-- As `object' = Void, it means that we are building a new object,
					-- and hence we must create it accordingly.
				an_object := components.object_handler.add_root_window (window.attribute_by_name (type_string).value)
			else
				an_object := object
			end
			from
				window.start
			until
				window.off
			loop
				current_element ?= window.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.same_string (Item_string) then
						if object = Void then
								-- As `titled_window_object' = Void it means we must rebuild all the children,
								-- as we are not updating an existing object, and the children must be created.
							build_new_object (current_element, an_object)
						end
					else
							-- We must check for internal properties, else set the properties of the component
						if current_name.same_string (Internal_properties_string) then
							an_object.modify_from_xml (current_element)
							components.object_handler.add_object_to_objects (an_object)
							an_object.widget_selector_item.unparent
							parent_common_item.add_alphabetically (an_object.widget_selector_item)
						elseif current_name.same_string (Events_string) then
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
		end

	retrieve_new_object (element: XM_ELEMENT; object: GB_OBJECT; pos: INTEGER): GB_OBJECT
			-- Build a new object from information in `element', into `object' at position `pos'.
			-- `Result' is the new object.
		require
			element_not_void: element /= Void
			element_type_is_item: element.name.same_string (Item_string)
		local
			new_object: GB_OBJECT
		do
			new_object := components.object_handler.build_object_from_string (element.attribute_by_name (type_string).value)
			Result := new_object
			components.object_handler.add_object (object, new_object, pos)
			modify_from_xml (element, new_object)
		end

feature {NONE} -- Implementation

	build_new_object (element: XM_ELEMENT; object: GB_OBJECT)
			-- Build a new object from information in `element' into `object'.
		require
			element_not_void: element /= Void
			element_type_is_item: element.name.same_string (Item_string)
		local
			new_object: GB_OBJECT
		do
			new_object := components.object_handler.build_object_from_string (element.attribute_by_name (type_string).value)
			components.object_handler.add_object (object, new_object, object.children.count + 1)
			modify_from_xml (element, new_object)
			components.object_handler.add_object_to_objects (new_object)
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	modify_from_xml (element: XM_ELEMENT; object: GB_OBJECT)
			-- Update properties of `object' based on information in `element'.
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
					if current_name.same_string (Item_string) then
							-- The element represents an item, so we must add new objects.
						build_new_object (current_element, object)
					elseif current_name.same_string (Events_string) then
							-- We now add the event information from `current_element'
							-- into `object'.
						extract_event_information (current_element, object)
					else
							-- We must check for internal properties, else set the properties of the component
						if current_name.same_string (Internal_properties_string) then
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

feature {NONE} -- Implementation

	extract_event_information (element: XM_ELEMENT; object: GB_OBJECT)
			-- Generate event information into `object', from `element'.
		require
			element_not_void: element /= Void
			element_type_is_events: element.name.same_string (Events_string)
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
					if current_name.same_string (Event_string) then
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

	create_system
			-- Create a system from the parsed XML file.
		local
			application_element: XM_ELEMENT
		do
			application_element := pipe_callback.document.root_element
			build_window_structure (application_element, components.tools.widget_selector)
				-- Building the project causes the project to be marked as
				-- modified. We do not want this, as it should only
				-- be marked as so when the user does something.
			components.system_status.disable_project_modified
				-- Update all names in `widget_selector' to ensure that
				-- they are current after the load.
				--| FIXME, why is this required?
			components.tools.widget_selector.update_displayed_names
				-- Now expand the layout selector item, so that the window is displayed as
				-- it was when last edited.
			components.tools.layout_constructor.update_expanded_state_from_root_object

			components.constants.build_deferred_elements
		end

	build_window_structure (an_element: XM_ELEMENT; parent_common_item: GB_WIDGET_SELECTOR_COMMON_ITEM)
			-- Build window represented by `an_element into `parent_common_item'.
			-- If `parent_common_item' is `Void', build directly into `widget_selector'.
		require
			an_element_not_void: an_element /= Void
			parent_common_item_not_void: parent_common_item /= Void
		local
			current_element, constant_item_element: XM_ELEMENT
			current_name, current_type: STRING
			window_element: XM_ELEMENT
			new_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			from
				an_element.start
			until
				an_element.off
			loop
				current_element ?= an_element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.same_string (Item_string) then
						current_type := current_element.attribute_by_name (type_string).value
						if current_type.same_string (directory_string) then
							from
								current_element.start
							until
								current_element.off
							loop
								window_element ?= current_element.item_for_iteration
								if window_element /= Void then
									current_name := window_element.name
									if current_name.same_string (Internal_properties_string)  then
										create new_directory_item.make_with_name ("", components)
										new_directory_item.modify_from_xml (window_element)
										parent_common_item.add_alphabetically (new_directory_item)
									end
								end
								current_element.forth
							end
							build_window_structure (current_element, new_directory_item)
						elseif current_type.same_string (Constants_string) then
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

	load_and_parse_xml_file (a_filename:STRING)
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

	parse_file (a_filename: STRING)
			-- Parse XML file `filename' with `parser'.
		local
			file: KL_BINARY_INPUT_FILE
			l_concat_filter: XM_CONTENT_CONCATENATOR
		do
			create file.make (a_filename)
			file.open_read
			if file.is_open_read then
				create l_concat_filter.make_null
				create parser.make
				parser.set_callbacks (standard_callbacks_pipe (<<l_concat_filter, pipe_callback.start>>))
				parser.parse_from_stream (file)
			end
		end

	pipe_callback: XM_TREE_CALLBACKS_PIPE
			-- Create unique callback pipe.
		once
			create Result.make
		end

	initialize_load_output
			-- Create `load_timer' and associate an
			-- action with it.
		do
			create load_timer.make_with_interval (250)
			load_timer.actions.extend (agent update_status_bar)
		 	components.status_bar.set_status_text ("Loading    -")
		 	environment.application.process_graphical_events
		end

	update_status_bar
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

	remove_load_output
			--  Destroy `load_timer' and display a final
			-- timed message on the status bar.
		do
			load_timer.destroy
			components.status_bar.set_timed_status_text ("Load successful")
		end

	load_timer: EV_TIMEOUT
		-- A timeout which times the animation for the status bar.

	parser: XM_EIFFEL_PARSER
		-- XML tree parser.

	document: XM_DOCUMENT;
		-- XML document generated from created window.

note
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


end -- class GB_XML_LOAD
