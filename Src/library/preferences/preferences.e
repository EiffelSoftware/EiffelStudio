note
	description: "[
			Preferences. This class should be used for creating a preference system for an application.
			Briefly, preferences and their related attributes and values are stored at run-time in an
			appropriate PREFERENCE object. They must be created through the helper class PREFERENCE_MANAGER.
			
			In between sessions the preference will be saved in an underlying data store. To such data
			store implementation are provided by default, one for saving to the Windows Registry and
			one for saving to an XML file on disk. To use a different store, such as a database one
			must create a new class which implements the methods in PREFERENCES_STORAGE_I.
			
			Regardless of the underlying data store used the preferences are managed in the same way.
			There are 5 levels of control provided for such management:
			
			1. Storage specified. Use `make_with_storage'. A storage for the underlying data store
			   is provided. Values are retrieved from this storage between sessions. You can specify
			   the location for this storage, when you create it. This storage's location must exist.
			
			2. Storage and defaults specified. The same as in option 1, but a location of one or more default
			   files is provided in addition to the data store location. Those files are XML files which
			   contain the default values to use in a preference if it is not already defined in the data
			   store. It is a convenient way to initialize your application with all the default values
			   required "out of the box" for correct or preferred functioning. This file also contains
			   additional attributes for preference configuration such a more detailed description of the
			   preference, or whether it should be hidden by default. If two files list the same preference,
			   the last one to mention it takes precedence.
			
			3. Development use. Use `make' to create preferences. No underlying datastore location is
			   provided. No default preference values are provided. A data store location is created
			   automatically and modified preference values are tranparently retrieved between sessions.
			
			4. Location specified. Use `make_with_location'. A location for the underlying data store
			   is provided. Values are retrieved from this location between sessions. This location must
			   exist.
			
			5. Location and defaults specified. The same as in option 2, but using a storage with specified
			   location.
			
			We recommend using 1. or 2.  since 3,4,5 might become obsolete in the future.
			
			Once preferences they may be modified programmatically or through an user interface conforming
			to PREFERENCE_VIEW. A default interface is provided in PREFERENCES_WINDOW. You may implement
			your own style interface by implementing PREFERENCE_VIEW.
			
			You may also add your own application specific preferences by implementing PREFERENCE, and may
			provide a graphical widget to view or edit this preference by implementing PREFERENCE_WIDGET
			and then registering this widget to the PREFERENCES through the
			`register_preference_widget' procedure.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES

inherit
	ANY

	PREFERENCES_VERSIONS

	XML_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

create
	make_with_storage,
	make_with_defaults_and_storage,
	make,
	make_with_location,
	make_with_location_and_version,
	make_with_defaults_and_location,
	make_with_defaults_and_location_and_version

feature {NONE} -- Initialization

	make_with_storage (a_storage: PREFERENCES_STORAGE_I)
			-- Create preferences based on underlying storage engine `a_storage'.
		require
			a_storage_not_void: a_storage /= Void
		do
			create managers.make (2)
			managers.compare_objects
			create preferences.make (2)
			create default_values.make (2)
			create session_values.make (0) -- Dummy object
			preferences_storage := a_storage
			session_values := a_storage.session_values
			a_storage.initialize_with_preferences (Current)
		ensure
			has_session_values: session_values /= Void
			has_preferences_storage: preferences_storage /= Void
			managers_not_void: managers /= Void
			preferences_not_void: preferences /= Void
			default_values_not_void: default_values /= Void
		end

	make_with_defaults_and_storage (a_defaults: ARRAY [READABLE_STRING_GENERAL]; a_storage: PREFERENCES_STORAGE_I)
			-- Create preferences and initialize values from those in `a_defaults',
			-- using `a_storage' as preferences underlying storage engine.
		require
			default_not_void: a_defaults /= Void
			a_storage_not_void: a_storage /= Void
		do
			make_with_storage (a_storage)
			load_defaults (a_defaults)
		ensure
			has_session_values: session_values /= Void
			has_preferences_storage: preferences_storage /= Void
			managers_not_void: managers /= Void
			preferences_not_void: preferences /= Void
			default_values_not_void: default_values /= Void
		end

	make
			-- This creation routine creates a location to store and retrieve preferences
			-- between sessions.  The location will be either a registry location of an XML file (depending
			-- on the implementation chosen) and will be named based upon the name of the application.
			-- You should use this to create preferences during the development phase, or when you do not
			-- care exactly where the preferences are stored and have no file containing default values for the
			-- application preferences.
		do
			make_with_storage (create {PREFERENCES_STORAGE_DEFAULT}.make_empty)
		end

	make_with_location (a_location: READABLE_STRING_32)
			-- Create preferences and store them in the location `a_location' between sessions.
			-- -- `a_location' is the path to either:
			--		* the root registry key where preferences will be stored,
			--		* or the file where preferences will be stored,
			-- depending on which implementation is chosen (registry or xml).
		require
			location_not_void: a_location /= Void
			location_not_empty: not a_location.is_empty
		do
			make_with_storage (create {PREFERENCES_STORAGE_DEFAULT}.make_with_location (a_location))
		end

	make_with_location_and_version (a_location: READABLE_STRING_32; a_version: like version)
			-- Create preferences and store them in the location `a_location' between sessions.
			-- -- `a_location' is the path to either:
			--		* the root registry key where preferences will be stored,
			--		* or the file where preferences will be stored,
			-- depending on which implementation is chosen (registry or xml).
		require
			location_not_void: a_location /= Void
			location_not_empty: not a_location.is_empty
			a_version_not_void: a_version /= Void
			a_version_valid: valid_version (a_version)
		local
			l_storage: PREFERENCES_STORAGE_DEFAULT
		do
			create l_storage.make_with_location_and_version (a_location, a_version)
			make_with_storage (l_storage)
		end

	make_with_defaults_and_location (a_defaults: ARRAY [READABLE_STRING_GENERAL]; a_location: READABLE_STRING_32)
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
		do
			make_with_location (a_location)
			load_defaults (a_defaults)
		end

	make_with_defaults_and_location_and_version (a_defaults: ARRAY [READABLE_STRING_GENERAL]; a_location: READABLE_STRING_32; a_version: like version)
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
			a_version_not_void: a_version /= Void
			a_version_valid: valid_version (a_version)
		do
			make_with_location_and_version (a_location, a_version)
			load_defaults (a_defaults)
		end

	load_defaults (a_defaults: ARRAY [READABLE_STRING_GENERAL])
			-- Initialize values from those in `a_defaults'.
		require
			default_not_void: a_defaults /= Void
		do
			across
				a_defaults as c
			loop
				if attached c as def and then not def.is_empty then
					extract_default_values (def)
				end
			end
		end

feature -- Importation

	import_from_storage_with_callback_and_exclusion (a_storage: PREFERENCES_STORAGE_I; a_ignore_hidden_preference: BOOLEAN;
			a_callback: detachable PROCEDURE [TUPLE [ith: INTEGER; total: INTEGER; name: READABLE_STRING_GENERAL; value: READABLE_STRING_GENERAL]];
			a_exclude_function: detachable FUNCTION [TUPLE [ith: INTEGER; total: INTEGER; name: READABLE_STRING_GENERAL; value: READABLE_STRING_GENERAL], BOOLEAN])
			-- Import preferences values from `a_storage', on import call `a_callback` if any.
			-- If `a_exclude_function` is set, import related preference only if return is False.
		require
			a_storage_not_void: a_storage /= Void
		local
			vals: like session_values
			k: READABLE_STRING_GENERAL
			v: READABLE_STRING_32
			p: detachable PREFERENCE
			i, n: INTEGER
		do
			a_storage.initialize_with_preferences (Current)
			vals := a_storage.session_values
			across
				vals as vs
			from
				i := 0
				n := vals.count
			loop
				i := i + 1
				k := @ vs.key
				v := vs
				p := preferences.item (k)
				if a_ignore_hidden_preference and (p = Void or else p.is_hidden) then
						-- Ignored
				elseif
					a_exclude_function /= Void and then
					a_exclude_function (i, n, k, v)
				then
						-- Excluded
				else
					if a_callback /= Void then
						a_callback (i, n, k, v)
					end
					session_values.force (v, k)
					if p /= Void then
						check preferences.has (k) end
						p.set_value_from_string (v)
					end
				end
			end
		end

	import_from_storage_with_callback (a_storage: PREFERENCES_STORAGE_I; a_callback: detachable PROCEDURE [TUPLE [ith: INTEGER; total: INTEGER; name: READABLE_STRING_GENERAL; value: READABLE_STRING_GENERAL]])
			-- Import preferences values from `a_storage'
		require
			a_storage_not_void: a_storage /= Void
		do
			import_from_storage_with_callback_and_exclusion (a_storage, False, a_callback, Void)
		end

	import_from_storage (a_storage: PREFERENCES_STORAGE_I)
			-- Import preferences values from `a_storage'
		require
			a_storage_not_void: a_storage /= Void
		do
			import_from_storage_with_callback (a_storage, Void)
		end

	export_to_storage (a_storage: PREFERENCES_STORAGE_I; a_save_modified_values_only: BOOLEAN)
			-- Import preferences values from `a_storage'
		require
			a_storage_not_void: a_storage /= Void
		do
			save_preferences_using_storage (a_storage, a_save_modified_values_only)
		end

feature -- Status report

	error_message_is_valid_as_string_8: BOOLEAN
			-- Is associated error message a valid string_8 value?
		do
			if attached error_message_32 as err then
				Result := err.is_valid_as_string_8
			end
		end

feature -- Access

	error_message_32: detachable STRING_32
			-- Message explaining why `Current' could not be initialized.

	save_defaults_to_store: BOOLEAN
			-- Should preferences with default values be saved to the underlying data store when saving?

	location: READABLE_STRING_GENERAL
			-- Storage's location
		do
			Result := preferences_storage.location
		end

	version: IMMUTABLE_STRING_32
			-- Version format used by storage.
		do
			if attached preferences_storage.version as l_version then
				Result := l_version
			else
				Result := version_1_0
			end
		end

feature -- Change

	report_error (m: READABLE_STRING_GENERAL)
		local
			err: like error_message_32
		do
			err := error_message_32
			if err = Void then
				create err.make (m.count)
				err.append_string_general (m)
				error_message_32 := err
			else
				err.append_character ('%N')
				err.append_string_general (m)
			end
		end

feature -- Status Setting

	set_save_defaults (a_flag: BOOLEAN)
			-- Set `save_defaults_to_store' with `a_flag'.
		do
			save_defaults_to_store := a_flag
		ensure
			value_set: save_defaults_to_store = a_flag
		end

feature -- Manager

	new_manager (a_namespace: STRING): PREFERENCE_MANAGER
			-- Create a new preference manager with namespace `a_namespace'.
		require
			namespace_not_void: a_namespace /= Void
			namespace_not_empty: not a_namespace.is_empty
			manager_unique: not has_manager (a_namespace)
		do
			create Result.make (Current, a_namespace)
			check
				from_precondition_manager_unique_and_postcondition_of_make: managers [a_namespace] = Result
			end
		ensure
			result_not_void: Result /= Void
			manager_added: managers.has (a_namespace)
		end

	manager (a_namespace: STRING): detachable PREFERENCE_MANAGER
			-- Associated manager to `a_namespace'.
		require
			namespace_not_void: a_namespace /= Void
			namespace_not_empty: not a_namespace.is_empty
		do
			Result := managers.item (a_namespace)
		end

	has_manager (a_namespace: STRING): BOOLEAN
			-- Does Current contain manager with namespace `a_namespace'?
		require
			namespace_not_void: a_namespace /= Void
			namespace_not_empty: not a_namespace.is_empty
		do
			Result := managers.has (a_namespace)
		end

feature {PREFERENCE_MANAGER} -- Element change

	add_manager (a_manager: PREFERENCE_MANAGER)
			-- Add manager.
		require
			manager_not_void: a_manager /= Void
			-- not has_manager (a_manager)
		do
			managers.put (a_manager, a_manager.namespace)
		ensure
			has_manager: managers.has (a_manager.namespace)
		end

feature -- Preference

	get_preference (a_name: STRING): detachable PREFERENCE
			-- Fetch the preference with `a_name'.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			Result := preferences.item (a_name)
		end

	get_preference_value_direct (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Fetch the preference string value with `a_name' directly from the underlying datastore.
			-- Ignore values currently in `session_values' and `preferences'.  Use this if the
			-- preference value has been changed externally and you need the updated value.
			-- If you are going to do this you must prepend the preference type name to the front of the preference
			-- since that is how it will have been saved.  Return Void if no preference found.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			Result := preferences_storage.get_preference_value (a_name)
		end

	set_preference (a_name: STRING; a_preference: PREFERENCE)
			-- Override current value of preference with `a_name' in `preferences'?
		require
			name_not_void: a_name /= Void
			has_preference (a_name)
		do
			preferences.replace (a_preference, a_name)
		end

	has_preference (a_name: STRING): BOOLEAN
			-- Does Current contain a preference with `a_name'?
		require
			name_not_void: a_name /= Void
		do
			Result := preferences.has (a_name)
		end

	save_preference (a_preference: PREFERENCE)
			-- Save `a_preference' to underlying data store.
		require
			preference_not_void: a_preference /= Void
		do
			if save_defaults_to_store or else not a_preference.is_default_value then
				preferences_storage.save_preference (a_preference)
			else
				preferences_storage.remove_preference (a_preference)
			end
		end

	save_preferences
			-- Commit all changes by saving the underlying data store.  Only save preferences
			-- which are not using the default value.
		do
			save_preferences_using_storage (preferences_storage, True)
		end

	save_preferences_using_storage (a_storage: PREFERENCES_STORAGE_I; a_save_modified_values_only: BOOLEAN)
			-- Save all preferences value using `a_storage'.
		do
			a_storage.save_preferences (preferences.linear_representation, a_save_modified_values_only)
		end

	restore_defaults
			-- Restore all preferences which have associated default values to their default values.
		local
			p: PREFERENCE
		do
			across
				preferences as ps
			loop
				p := ps
				if p.has_default_value and then not p.is_default_value then
					p.reset
				end
			end
			save_preferences
		ensure
			all_preferences_default: True
		end

feature -- Storage access

	preferences_storage_exists: BOOLEAN
			-- Does preferences storage exists ?
		do
			Result := preferences_storage.exists
		end

feature {PREFERENCE_EXPORTER} -- Implementation

	default_values: STRING_TABLE [TUPLE [description: detachable READABLE_STRING_32; value: detachable READABLE_STRING_32; hidden: BOOLEAN; restart: BOOLEAN]]
			-- Hash table of known preference default values.  [[Description, Value, Hidden, Restart], Name].

	session_values: STRING_TABLE [READABLE_STRING_32]
			-- Hash table of user-defined values retrieved from the underlying data store.
			-- Depending upon the chosen implementation this will be the Windows registry or an XML file.

	preferences: STRING_TABLE [PREFERENCE]
			-- Preferences part of Current.

feature {NONE} -- Implementation

	managers: HASH_TABLE [PREFERENCE_MANAGER, STRING]
			-- Managers.

	preferences_storage: PREFERENCES_STORAGE_I
			-- Underlying preference storage.

	extract_default_values (a_default_file_name: READABLE_STRING_GENERAL)
			-- Extract from the default file the default values.  If a preference however exists in `preferences'
			-- (i.e. saved in a previous session), then take this one instead.  Therefore the resulting list of
			-- known preferences is a combination of defaults and user defined values.
		require
			default_file_name_not_void: a_default_file_name /= Void
			default_file_name_not_empty: not a_default_file_name.is_empty
		local
			parser: XML_STOPPABLE_PARSER
			l_file: PLAIN_TEXT_FILE
			l_tree: XML_CALLBACKS_DOCUMENT
			l_document: detachable XML_DOCUMENT
			has_error: BOOLEAN
		do
			create parser.make
			create l_tree.make_null
			parser.set_callbacks (create {XML_NAMESPACE_RESOLVER}.set_next (l_tree))

			create l_file.make_with_name (a_default_file_name)
			if l_file.exists and then l_file.is_readable then
				l_file.open_read
				if l_file.is_open_read then
					parser.parse_from_file (l_file)
					l_file.close
				else
					has_error := True
				end
			else
				has_error := True
			end

			if has_error then
				report_error ({STRING_32} "%"" + a_default_file_name.to_string_32 + {STRING_32} "%" does not exist.")
			elseif parser.error_occurred then
				report_error ({STRING_32} "%"" + a_default_file_name.to_string_32 + {STRING_32} "%" is not a valid preference file.")
			else
				l_document := l_tree.document
				check l_document /= Void end -- implied by `not parser.error_occurred'
				load_default_attributes (l_document.root_element)
			end
		end

	load_default_attributes (xml_elem: XML_ELEMENT)
			-- Load of data from `xml_elem'.
		require
			element_not_void: xml_elem /= Void
		local
			sub_node: detachable XML_ELEMENT
			l_attribute: detachable XML_ATTRIBUTE
			pref_name: detachable READABLE_STRING_32
			pref_description,
			pref_value,
			att_pref_value: detachable STRING_32
			pref_hidden,
			pref_restart,
			retried: BOOLEAN
		do
			if not retried then
				across
					xml_elem as es
				loop
					if
						attached {XML_ELEMENT} es as node and then
						node.has_same_name (once "PREF")
					then
						if attached node.elements as elts and then not elts.is_empty then
							sub_node := elts.i_th (1)
						else
							sub_node := Void
						end

							-- Found preference
						l_attribute := node.attribute_by_name (once "NAME")
						if l_attribute /= Void then
								-- TODO [2012-oct]: add Unicode support for preference name.
							pref_name := l_attribute.value
							if pref_name.is_valid_as_string_8 then

								l_attribute := node.attribute_by_name (once "DESCRIPTION")
								if l_attribute /= Void then
									pref_description := l_attribute.value.to_string_32
									pref_description.replace_substring_all ({STRING_32} "%%N", {STRING_32} "%N")
								else
										-- No description specified
									pref_description := ""
								end

								l_attribute := node.attribute_by_name (once "HIDDEN")
								if l_attribute /= Void then
									pref_hidden := l_attribute.value.is_case_insensitive_equal_general (once "true")
								else
									pref_hidden := False
								end

								l_attribute := node.attribute_by_name (once "RESTART")
								if l_attribute /= Void then
									pref_restart := l_attribute.value.is_case_insensitive_equal_general (once "true")
								else
									pref_restart := False
								end

								if sub_node /= Void then

									if sub_node.has_same_name (once "SHORTCUT") then
										create att_pref_value.make_empty

											-- Check attributes for shortcut preferences
										l_attribute := sub_node.attribute_by_name (once "Alt")
										if l_attribute /= Void then
											att_pref_value.append (l_attribute.value.as_lower + "+")
										else
											att_pref_value.append_string_general ("false+")
										end

										l_attribute := sub_node.attribute_by_name (once "Ctrl")
										if l_attribute /= Void then
											att_pref_value.append (l_attribute.value.as_lower + "+")
										else
											att_pref_value.append_string_general ("false+")
										end

										l_attribute := sub_node.attribute_by_name (once "Shift")
										if l_attribute /= Void then
											att_pref_value.append (l_attribute.value.as_lower + "+")
										else
											att_pref_value.append_string_general ("false+")
										end
									else
										att_pref_value := Void
									end

										-- Found preference default value
									pref_value := sub_node.text
									if pref_value = Void then
										create pref_value.make_empty
									end
									if att_pref_value /= Void and then not att_pref_value.is_empty then
										pref_value.prepend (att_pref_value)
									end
									default_values.force ([pref_description, pref_value, pref_hidden, pref_restart], pref_name)
								end
							else
								pref_name := Void
								report_error ({STRING_32} "ERROR: Non ascii preference name: %"" + l_attribute.value + {STRING_32} "%"")
							end
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

invariant
	has_session_values: session_values /= Void
	has_preferences_storage: preferences_storage /= Void

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
