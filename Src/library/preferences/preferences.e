indexing
	description: "[
			Preferences. This class should be used for creating a preference system for an application.
			Briefly, preferences and their related attributes and values are stored at run-time in an
			appropriate PREFERENCE object. They must be created through the helper class PREFERENCE_MANAGER.

			In between sessions the preference will be saved in an underlying data store. To such data
			store implementation are provided by default, one for saving to the Windows Registry and
			one for saving to an XML file on disk. To use a different store, such as a database one
			must create a new class which implements the methods in PREFERENCE_STRUCTURE_I.

			Regardless of the underlying data store used the preferences are managed in the same way.
			There are 3 levels of control provided for such management:

			1. Development use. Use `make' to create preferences. No underlying datastore location is
			   provided. No default preference values are provided. A data store location is created
			   automatically and modified preference values are tranparently retrieved between sessions.

			2. Location specified. Use `make_with_location'. A location for the underlying data store
			   is provided. Values are retrieved from this location between sessions. This location must
			   exist.

			3. Location and defaults specified. The same as in option 2, but a location of one or more default
			   files is provided in addition to the data store location. Those files are XML files which
			   contain the default values to use in a preference if it is not already defined in the data
			   store. It is a convenient way to initialize your application with all the default values
			   required "out of the box" for correct or preferred functioning. This file also contains
			   additional attributes for preference configuration such a more detailed description of the
			   preference, or whether it should be hidden by default. If two files list the same preference,
			   the last one to mention it takes precedence.

			Once preferences they may be modified programmatically or through an user interface conforming
			to PREFERENCE_VIEW. A default interface is provided in PREFERENCES_WINDOW. You may implement
			your own style interface by implementing PREFERENCE_VIEW.

			You may also add your own application specific resources by implementing PREFERENCE, and may
			provide a graphical widget to view or edit this resource by implementing PREFERENCE_WIDGET
			and then registering this widget to the PREFERENCES through the
			`register_resource_widget' procedure.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES

inherit
	ANY

	XM_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

create
	make,
	make_with_location,
	make_with_defaults_and_location

feature {NONE} -- Initialization

	make is
			-- This creation routine creates a location to store and retrieve preferences			
			-- between sessions.  The location will be either a registry location of an XML file (depending
			-- on the implementation chosen) and will be named based upon the name of the application.
			-- You should use this to create preferences during the development phase, or when you do not
			-- care exactly where the preferences are stored and have no file containing default values for the
			-- application preferences.
		do
			create resource_structure.make_empty (Current)
			session_values := resource_structure.session_values
			create managers.make (2)
			managers.compare_objects
			create resources.make (2)
			create default_values.make (2)
		ensure
			has_session_values: session_values /= Void
			has_resource_structure: resource_structure /= Void
			managers_not_void: managers /= Void
			resource_not_void: resources /= Void
			default_values_not_void: default_values /= Void
		end

	make_with_location (a_location: STRING) is
			-- Create preferences and store them in the location `a_location' between sessions.
			-- -- `a_location' is the path to either:
			--		* the root registry key where preferences will be stored,
			--		* or the file where preferences will be stored,
			-- depending on which implementation is chosen (registry or xml).
		require
			location_not_void: a_location /= Void
			location_not_empty: not a_location.is_empty
		do
			create resource_structure.make_with_location (Current, a_location)
			session_values := resource_structure.session_values
			create managers.make (2)
			managers.compare_objects
			create resources.make (2)
			create default_values.make (2)
		ensure
			has_session_values: session_values /= Void
			has_resource_structure: resource_structure /= Void
			managers_not_void: managers /= Void
			resource_not_void: resources /= Void
			default_values_not_void: default_values /= Void
		end

	make_with_defaults_and_location (a_defaults: ARRAY [STRING]; a_location: STRING) is
			-- Create preferences and initialize values from those in `a_defaults',
			-- which is the path of one or more files that contain the default values.
			-- Preferences will be stored in `a_location' between sessions, which is the
			-- path to either:
			--		* the root registry key where preferences are stored,
			--		* or the file where preferences are stored,
			-- depending on which implementation is chosen (registry or xml).
		require
			default_not_void: a_defaults /= Void
			location_not_void: a_location /= Void
			location_not_empty: not a_location.is_empty
		local
			i, nb: INTEGER
			l_default: STRING
		do
			create resource_structure.make_with_location (Current, a_location)
			session_values := resource_structure.session_values
			create managers.make (2)
			managers.compare_objects
			create resources.make (2)
			create default_values.make (2)
			from
				i := a_defaults.lower
				nb := a_defaults.upper + 1
			until
				i = nb
			loop
				l_default := a_defaults.item (i)
				if l_default /= Void and then not l_default.is_empty then
					extract_default_values (l_default)
				end
				i := i + 1
			end
		ensure
			has_session_values: session_values /= Void
			has_resource_structure: resource_structure /= Void
			managers_not_void: managers /= Void
			resource_not_void: resources /= Void
			default_values_not_void: default_values /= Void
		end

feature -- Access

	error_message: STRING
			-- Message explaining why `Current' could not be initialized.	

	save_defaults_to_store: BOOLEAN
			-- Should preferences with default values be saved to the underlying data store when saving?

feature -- Status Setting

	set_save_defaults (a_flag: BOOLEAN) is
			-- Set `save_defaults_to_store' with `a_flag'.
		do
			save_defaults_to_store := a_flag
		ensure
			value_set: save_defaults_to_store = a_flag
		end

feature -- Manager

	new_manager (a_namespace: STRING): PREFERENCE_MANAGER is
			-- Create a new resource manager with namespace `a_namespace'.
		require
			namespace_not_void: a_namespace /= Void
			namespace_not_empty: not a_namespace.is_empty
			manager_unique: not has_manager (a_namespace)
		do
			create Result.make (Current, a_namespace)
			managers.put (Result, a_namespace)
		ensure
			result_not_void: Result /= Void
			manager_added: managers.has (a_namespace)
		end

	manager (a_namespace: STRING): PREFERENCE_MANAGER is
			-- Associated manager to `a_namespace'.
		require
			namespace_not_void: a_namespace /= Void
			namespace_not_empty: not a_namespace.is_empty
			has_manager: has_manager (a_namespace)
		do
			Result := managers.item (a_namespace)
		ensure
			result_not_void: Result /= Void
		end

	has_manager (a_namespace: STRING): BOOLEAN is
			-- Does Current contain manager with namespace `a_namespace'?
		require
			namespace_not_void: a_namespace /= Void
			namespace_not_empty: not a_namespace.is_empty
		do
			Result := managers.has (a_namespace)
		end

feature {PREFERENCE_MANAGER} -- Element change

	add_manager (a_manager: PREFERENCE_MANAGER) is
			-- Add manager.
		require
			manager_not_void: a_manager /= Void
			-- not has_manager (a_manager)
		do
			managers.put (a_manager, a_manager.namespace)
		ensure
			has_manager: managers.has (a_manager.namespace)
		end

feature -- Resource

	get_resource (a_name: STRING): PREFERENCE is
			-- Fetch the resource with `a_name'.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
			has_resource: has_resource (a_name)
		do
			Result := resources.item (a_name)
		ensure
			result_not_void: Result /= Void
		end

	get_resource_value_direct (a_name: STRING): STRING is
			-- Fetch the resource string value with `a_name' directly from the underlying datastore.
			-- Ignore values currently in `session_values' and `resources'.  Use this if the
			-- resource value has been changed externally and you need the updated value.
			-- If you are going to do this you must prepend the resource type name to the front of the resource
			-- since that is how it will have been saved.  Return Void if no resource found.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			Result := resource_structure.get_resource_value (a_name)
		end

	set_resource (a_name: STRING; a_resource: PREFERENCE) is
			-- Override current value of resource with `a_name' in `resources'?
		require
			name_not_void: a_name /= Void
			has_resource (a_name)
		do
			resources.replace (a_resource, a_name)
		end

	has_resource (a_name: STRING):BOOLEAN is
			-- Does Current contain a resource with `a_name'?
		require
			name_not_void: a_name /= Void
		do
			Result := resources.has (a_name)
		end

	save_resource (a_resource: PREFERENCE) is
			-- Save `a_resource' to underlying data store.
		require
			resource_not_void: a_resource /= Void
		do
			if save_defaults_to_store then
				resource_structure.save_resource (a_resource)
			else
				if not a_resource.is_default_value then
					resource_structure.save_resource (a_resource)
				else
					resource_structure.remove_resource (a_resource)
				end
			end
		end

	save_resources is
			-- Commit all changes by saving the underlying data store.  Only save resources
			-- which are not using the default value.
		do
			resource_structure.save_resources (resources.linear_representation, True)
		end

	restore_defaults is
			-- Restore all resources which have associated default values to their default values.
		local
			l_resource: PREFERENCE
		do
			from
				resources.start
			until
				resources.after
			loop
				l_resource := resources.item_for_iteration
				if l_resource.has_default_value and then not l_resource.is_default_value then
					l_resource.reset
				end
				resources.forth
			end
			save_resources
		ensure
			all_resources_default: True
		end

feature {PREFERENCE_FACTORY, PREFERENCE_MANAGER, PREFERENCE_VIEW, PREFERENCE_STRUCTURE_IMP} -- Implementation

	default_values: HASH_TABLE [TUPLE [STRING, STRING, BOOLEAN, BOOLEAN], STRING]
			-- Hash table of known preference default values.  [[Description, Value, Hidden, Restart], Name].

	session_values: HASH_TABLE [STRING, STRING]
			-- Hash table of user-defined values retrieved from the underlying data store.
			-- Depending upon the chosen implementation this will be the Windows registry or an XML file.

	resources: HASH_TABLE [PREFERENCE, STRING]
			-- Resources part of Current.

feature {NONE} -- Implementation

	managers: HASH_TABLE [PREFERENCE_MANAGER, STRING]
			-- Managers.		

	resource_structure: PREFERENCE_STRUCTURE
			-- Underlying resource structure.

	extract_default_values (a_default_file_name: STRING) is
			-- Extract from the default file the default values.  If a resource however exists in `resources'
			-- (i.e. saved in a previous session), then take this one instead.  Therefore the resulting list of
			-- known resources is a combination of defaults and user defined values.
		require
			default_file_name_not_void: a_default_file_name /= Void
			default_file_name_not_empty: not a_default_file_name.is_empty
		local
			parser: XM_EIFFEL_PARSER
			l_file: KL_TEXT_INPUT_FILE
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_concat_filter: XM_CONTENT_CONCATENATOR
			xml_data: XM_ELEMENT
			has_error: BOOLEAN
		do
			create parser.make
			create l_tree_pipe.make
			create l_concat_filter.make_null
			parser.set_callbacks (standard_callbacks_pipe (<<l_concat_filter, l_tree_pipe.start>>))

			create l_file.make (a_default_file_name)
			l_file.open_read
			if l_file.is_open_read then
				parser.parse_from_stream (l_file)
				l_file.close
		  	else
		  		has_error := True
			end

    		if has_error then
    			error_message := "%"" + a_default_file_name + "%" does not exist."
    		elseif l_tree_pipe.error.has_error then
    			error_message := a_default_file_name + "is not a valid preference file%N"
    		else
    			xml_data := l_tree_pipe.document.root_element
    			load_default_attributes (xml_data)
    		end
		end

	load_default_attributes (xml_elem: XM_ELEMENT) is
			-- Load of data from `xml_elem'.
		require
			element_not_void: xml_elem /= Void
		local
			node, sub_node: XM_ELEMENT
			l_attribute: XM_ATTRIBUTE
			pref_name,
			pref_description,
			pref_value,
			att_pref_value: STRING
			pref_hidden,
			pref_restart,
			retried: BOOLEAN
		do
			if not retried then
				from
					xml_elem.start
				until
					xml_elem.after
				loop
					node ?= xml_elem.item_for_iteration
					if node /= Void then
						if node.name.is_equal (once "PREF") then
							if node.elements /= Void and then not node.elements.is_empty then
								sub_node := node.elements.item (1)
							end

								-- Found preference
							l_attribute := node.attribute_by_name (once "NAME")
							if l_attribute /= Void then
								pref_name := l_attribute.value
								l_attribute := node.attribute_by_name (once "DESCRIPTION")
								if l_attribute /= Void then
									pref_description := l_attribute.value
								else
										-- No description specified
									pref_description := ""
								end

								l_attribute := node.attribute_by_name (once "HIDDEN")
								if l_attribute /= Void then
									pref_hidden := l_attribute.value.as_lower.is_equal (once "true")
								else
									pref_hidden := False
								end

								l_attribute := node.attribute_by_name (once "RESTART")
								if l_attribute /= Void then
									pref_restart := l_attribute.value.as_lower.is_equal (once "true")
								else
									pref_restart := False
								end

								if sub_node /= Void then

									if sub_node.name.is_equal (once "SHORTCUT") then
										create att_pref_value.make_empty

											-- Check attributes for shortcut preferences
										l_attribute := sub_node.attribute_by_name (once "Alt")
										if l_attribute /= Void then
											att_pref_value.append (l_attribute.value.as_lower + "+")
										end

										l_attribute := sub_node.attribute_by_name (once "Ctrl")
										if l_attribute /= Void then
											att_pref_value.append (l_attribute.value.as_lower + "+")
										end

										l_attribute := sub_node.attribute_by_name (once "Shift")
										if l_attribute /= Void then
											att_pref_value.append (l_attribute.value.as_lower  + "+")
										end
									else
										att_pref_value := Void
									end

										-- Found preference default value
									pref_value := sub_node.text
									if att_pref_value /= Void and then not att_pref_value.is_empty then
										pref_value.prepend (att_pref_value)
									end
									default_values.force ([pref_description, pref_value, pref_hidden, pref_restart], pref_name)
								end
							end
						end
					end
					xml_elem.forth
				end
			end
		rescue
			retried := True
			retry
		end

invariant
	has_session_values: session_values /= Void
	has_resource_structure: resource_structure /= Void

end -- class PREFERENCES
