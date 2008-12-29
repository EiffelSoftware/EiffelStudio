note
	description: "XML file preference storage implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES_STORAGE_XML

inherit
	PREFERENCES_STORAGE_I
		redefine
			initialize_with_preferences,
			make_with_location,
			save_preferences
		end

	XM_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

	XM_MARKUP_CONSTANTS
		export
			{NONE} all
		end

	REFACTORING_HELPER

create
	make_empty,
	make_with_location

feature {NONE} -- Initialization

	make_empty
			-- Create preferences storage in XML file.  File will be created based on name of application.
			-- For operating systems which support it it will stored in the users home directory.  For operating
			-- systems that do not support home directories it will be stored in the current working directory.
		local
			l_loc: STRING
			l_exec: EXECUTION_ENVIRONMENT
			l_op: OPERATING_ENVIRONMENT
		do
			create l_exec
			l_op := l_exec.operating_environment

			if l_op.home_directory_supported then
				l_loc := l_exec.home_directory_name
			else
				l_loc := l_exec.current_working_directory
			end
			l_loc.append_character (l_op.directory_separator)
			l_loc.append ("stored_preferences.xml")
			make_with_location (l_loc)
		end

	make_with_location (a_location: STRING)
			-- Create preference storage in the XML file at location `a_location'.
			-- If file does not exist create new one.
		do
			Precursor {PREFERENCES_STORAGE_I} (a_location)
			create xml_structure.make_with_root_named ("EIFFEL_DOCUMENT", create {XM_NAMESPACE}.make_default)
		end

feature {PREFERENCES} -- Initialization

	initialize_with_preferences (a_preferences: PREFERENCES)
		do
			Precursor (a_preferences)
			extract_preferences_from_file
		end

feature {PREFERENCES} -- Resource Management

	exists: BOOLEAN
			-- Does storage exists ?
		local
			f: RAW_FILE
		do
			create f.make (location)
			Result := f.exists
		end

	has_preference (a_name: STRING): BOOLEAN
			-- Does the underlying store contain a preference with `a_name'?
		do
			Result := session_values.has (a_name)
		end

	get_preference_value (a_name: STRING): STRING
			-- Retrieve the preference string value from the underlying store.
		do
			Result := session_values.item (a_name)
		end

	save_preference (a_preference: PREFERENCE)
			-- Save `a_preference' to the file on disk.
		do
				-- TODO: neilc.  How to save only a single preference to the file?
			save_preferences (preferences.preferences.linear_representation, True)
		end

	save_preferences (a_preferences: ARRAYED_LIST [PREFERENCE]; a_save_modified_values_only: BOOLEAN)
			-- Save all preferences in `a_preferences' to storage device.
			-- If `a_save_modified_values_only' then only preferences whose value is different
			-- from the default one are saved, otherwise all preferences are saved.
		local
			l_preference: PREFERENCE
			l_file: PLAIN_TEXT_FILE
			pref_string1, pref_string2, pref_string3: STRING
		do
			pref_string1 := "%N%T<PREFERENCE NAME=%""
			pref_string2 := "%" VALUE=%""
			pref_string3 := "%"/>"
			create l_file.make (location)
			safe_open_write (l_file)
			if l_file.is_open_write then
				l_file.put_string ("<EIFFEL_DOCUMENT>")
				from
					a_preferences.start
				until
					a_preferences.after
				loop
					l_preference := a_preferences.item
					if not a_save_modified_values_only or else not l_preference.is_default_value then
						l_file.put_string (pref_string1)
						l_file.put_string (escape_xml (l_preference.name))
						l_file.put_string (pref_string2)
						l_file.put_string (escape_xml (l_preference.string_value))
						l_file.put_string (pref_string3)
					else
						-- nothing to do to remove them from file.
					end
					a_preferences.forth
				end
				l_file.put_string ("%N</EIFFEL_DOCUMENT>")
				l_file.close
			else
				fixme ("Add code to let callers that `preferences' could not be saved")
			end
		end

	remove_preference (a_preference: PREFERENCE)
			-- Remove `preference' from storage device.
		do
		end

feature {NONE} -- Implementation

	xml_structure: XM_DOCUMENT
			-- XML structure built from parsing of `file'.

	extract_preferences_from_file
			-- Extract from the `file' the saved preference values.
		require
			location_not_void: location /= Void
		local
			parser: XM_EIFFEL_PARSER
			l_file: KL_TEXT_INPUT_FILE
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_concat_filter: XM_CONTENT_CONCATENATOR
			l_attrib: XM_ATTRIBUTE
			pref_name,
			pref_value: STRING
			node: XM_ELEMENT
		do
			create parser.make
			create l_tree_pipe.make
			create l_concat_filter.make_null
			parser.set_callbacks (standard_callbacks_pipe (<<l_concat_filter, l_tree_pipe.start>>))

			create l_file.make (location)
			l_file.open_read
			if l_file.is_open_read then
				parser.parse_from_stream (l_file)
				l_file.close
	    		if not l_tree_pipe.error.has_error then
	    			xml_structure := l_tree_pipe.document
	    			from
						xml_structure.root_element.start
					until
						xml_structure.root_element.after
					loop
						node ?= xml_structure.root_element.item_for_iteration
						if node /= Void then
							if node.name.is_equal ("PREFERENCE") then
									-- Found preference
								l_attrib := node.attribute_by_name ("NAME")
								if l_attrib /= Void then
									pref_name := l_attrib.value
									l_attrib := node.attribute_by_name ("VALUE")
									if l_attrib /= Void then
										pref_value := l_attrib.value
									end
									session_values.put (pref_value, pref_name)
								end
							end
						end
						xml_structure.root_element.forth
					end
				else
					fixme ("Add code to let callers know that XML file was invalid")
	    		end
			else
				fixme ("Add code to let callers that we could not open preference file")
			end
		end

	escape_xml (a_string: STRING): STRING
			-- Escape xml entities in `a_string'.
		do
			if a_string /= Void then
				Result := a_string.twin
				Result.replace_substring_all (Amp_string, amp_entity)
				Result.replace_substring_all (Lt_string, Lt_entity)
				Result.replace_substring_all (Gt_string, Gt_entity)
				Result.replace_substring_all (Quot_string, quot_entity)
			end
		ensure
			result_void_iff_a_string_void: (Result = Void) = (a_string = Void)
		end

	Lt_string: STRING
		once
			create Result.make (1)
			Result.append_character (lt_char)
		end

	Gt_string: STRING
		once
			create Result.make (1)
			Result.append_character (gt_char)
		end

	Amp_string: STRING
		once
			create Result.make (1)
			Result.append_character (amp_char)
		end

	Quot_string: STRING
		once
			create Result.make (1)
			Result.append_character (quot_char)
		end

	safe_open_write (a_file: FILE)
			-- Safely open `a_file'.
		require
			a_file_not_void: a_file /= Void
			a_file_closed: a_file.is_closed
		local
			retried: BOOLEAN
		do
			if not retried then
				a_file.open_write
			end
		rescue
			retried := True
			retry
		end

invariant
	has_session_values: session_values /= Void
	has_xml_structure: xml_structure /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
