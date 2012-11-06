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

	XML_CALLBACKS_FILTER_FACTORY
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
			l_loc: detachable PATH
			l_exec: EXECUTION_ENVIRONMENT_32
			fn: FILE_NAME_32
		do
			create l_exec

			if operating_environment.home_directory_supported then
				l_loc := l_exec.home_directory_path
				check l_loc /= Void end -- implied by `home_directory_supported'
			else
				l_loc := l_exec.current_working_path
			end
			make_with_location (l_loc.extended ("stored_preferences.xml").string_representation)
		end

	make_with_location (a_location: READABLE_STRING_GENERAL)
			-- Create preference storage in the XML file at location `a_location'.
			-- If file does not exist create new one.
		do
			Precursor {PREFERENCES_STORAGE_I} (a_location)
			create xml_structure.make_with_root_named ("EIFFEL_DOCUMENT", create {XML_NAMESPACE}.make_default)
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
			u: FILE_UTILITIES
		do
			Result := u.file_exists (location)
		end

	has_preference (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Does the underlying store contain a preference with `a_name'?
		do
			-- FIXME: preference does not support unicode pref name			
			Result := session_values.has (a_name.as_string_8)
		end

	get_preference_value (a_name: READABLE_STRING_GENERAL): detachable STRING_32
			-- Retrieve the preference string value from the underlying store.
		do
			-- FIXME: preference does not support unicode pref name			
			Result := session_values.item (a_name.as_string_8)
		end

	save_preference (a_preference: PREFERENCE)
			-- Save `a_preference' to the file on disk.
		local
			l_preferences: like preferences
		do
				-- TODO: neilc.  How to save only a single preference to the file?
			l_preferences := preferences
			check attached l_preferences end -- implied by precondition `initialized'
			save_preferences (l_preferences.preferences.linear_representation, True)
		end

	save_preferences (a_preferences: ARRAYED_LIST [PREFERENCE]; a_save_modified_values_only: BOOLEAN)
			-- Save all preferences in `a_preferences' to storage device.
			-- If `a_save_modified_values_only' then only preferences whose value is different
			-- from the default one are saved, otherwise all preferences are saved.
		local
			l_preference: PREFERENCE
			l_file: PLAIN_TEXT_FILE
			pref_string1, pref_string2, pref_string3: STRING
			u: FILE_UTILITIES
		do
			pref_string1 := "%N%T<PREFERENCE NAME=%""
			pref_string2 := "%" VALUE=%""
			pref_string3 := "%"/>"
			l_file := u.make_text_file (location)
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
						l_file.put_string (escape_xml (l_preference.text_value))
						l_file.put_string (pref_string3)
					else
						-- nothing to do to remove them from file.
					end
					a_preferences.forth
				end
				l_file.put_string ("%N</EIFFEL_DOCUMENT>")
				l_file.close
			else
				debug ("refactor_fixme")
					fixme ("Add code to let callers that `preferences' could not be saved")
				end
			end
		end

	remove_preference (a_preference: PREFERENCE)
			-- Remove `preference' from storage device.
		do
		end

feature {NONE} -- Implementation

	xml_structure: detachable XML_DOCUMENT
			-- XML structure built from parsing of `file'.

	extract_preferences_from_file
			-- Extract from the `file' the saved preference values.
		require
			location_not_void: location /= Void
		local
			parser: XML_STOPPABLE_PARSER
			l_file: PLAIN_TEXT_FILE
			l_tree: XML_CALLBACKS_DOCUMENT
			l_attrib: detachable XML_ATTRIBUTE
			pref_name: detachable READABLE_STRING_32
			pref_value: detachable READABLE_STRING_32
			l_root_element: XML_ELEMENT
			t_preference, t_name, t_value: STRING
			u: FILE_UTILITIES
		do
			create parser.make
			create l_tree.make_null
			parser.set_callbacks (l_tree)

			l_file := u.make_text_file (location)
			if l_file.exists and then l_file.is_readable then
				safe_open_read (l_file)
				if l_file.is_open_read then
					parser.parse_from_file (l_file)
					l_file.close
		    		if not parser.error_occurred and then
		    			(attached l_tree.document as l_xml_structure) -- should be implied by `not has_error'
		    		then
		    			xml_structure := l_xml_structure
		    			from
		    				t_preference := "PREFERENCE"
		    				t_name := "NAME"
		    				t_value := "VALUE"

		    				l_root_element := l_xml_structure.root_element
							l_root_element.start
						until
							l_root_element.after
						loop
							if attached {XML_ELEMENT} l_root_element.item_for_iteration as node then
								if node.has_same_name (t_preference) then
										-- Found preference
									l_attrib := node.attribute_by_name (t_name)
									if l_attrib /= Void then
										-- FIXME: preference does not support unicode pref name
										pref_name := l_attrib.value
										if pref_name.is_valid_as_string_8 then

											l_attrib := node.attribute_by_name (t_value)
											if l_attrib /= Void then
												pref_value := l_attrib.value
											end
											if pref_value = Void then
												check xml_contain_value: False end
												create {STRING_32} pref_value.make_empty
											end
											session_values.put (pref_value, pref_name.to_string_8)
										else
											--| Entry ignored.
											pref_name := Void
										end
									end
								end
							end
							l_root_element.forth
						end
					else
						debug ("refactor_fixme")
							fixme ("Add code to let callers know that XML file was invalid")
						end
		    		end
				else
					debug ("refactor_fixme")
						fixme ("Add code to let callers that we could not open preference file")
					end
				end
			else
				debug ("refactor_fixme")
					fixme ("Add code to let callers that preference file can not be read")
				end
			end
		end

	escape_xml (a_string: READABLE_STRING_GENERAL): STRING
			-- Escape xml entities in `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			Result := xml_utilities.escaped_xml (a_string)
		ensure
			result_not_void: Result /= Void
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

	safe_open_read (a_file: FILE)
			-- Safely open `a_file' with read mode.
		require
			a_file_not_void: a_file /= Void
			a_file_closed: a_file.is_closed
		local
			retried: BOOLEAN
		do
			if not retried then
				a_file.open_read
			elseif not a_file.is_closed then
				a_file.close
			end
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	safe_open_write (a_file: FILE)
			-- Safely open `a_file' with write mode.
		require
			a_file_not_void: a_file /= Void
			a_file_closed: a_file.is_closed
		local
			retried: BOOLEAN
		do
			if not retried then
				a_file.open_write
			elseif not a_file.is_closed then
				a_file.close
			end
		rescue
			if not retried then
				retried := True
				retry
			end
		end

feature {NONE} -- XML markup and entities constants

	Lt_char: CHARACTER = '<'
	Gt_char: CHARACTER = '>'
	Amp_char: CHARACTER = '&'
	Quot_char: CHARACTER = '%"'

	Lt_entity: STRING = "&lt;"
	Gt_entity: STRING = "&gt;"
	Amp_entity: STRING = "&amp;"
	Quot_entity: STRING = "&quot;"

	xml_utilities: XML_UTILITIES
			-- XML utilities
		once
			create Result
		end

invariant
	has_session_values: session_values /= Void
	has_xml_structure: xml_structure /= Void

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
