indexing
	description: "XML file resource structure implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCE_STRUCTURE_IMP

inherit
	PREFERENCE_STRUCTURE_I

	XM_CALLBACKS_FILTER_FACTORY
		export 		
			{NONE} all 
		end
		
	REFACTORING_HELPER

create
	make_empty,
	make_with_location

feature {PREFERENCE_STRUCTURE} -- Initialization
	
	make_empty is
			-- Create resource structure in XML file.  File will be created based on name of application.
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

	make_with_location (a_location: STRING) is
			-- Create resource structure in the XML file at location `a_location'.
			-- If file does not exist create new one.
		local
			l_file: KL_TEXT_OUTPUT_FILE
		do			
			create session_values.make (5)
			create xml_structure.make_with_root_named ("EIFFEL_DOCUMENT", create {XM_NAMESPACE}.make_default)
			location := a_location
			extract_preferences_from_file
		ensure then
			location_set: location = a_location
		end

feature {PREFERENCE_STRUCTURE} -- Resource Management

	has_resource (a_name: STRING): BOOLEAN is
			-- Does the underlying store contain a resource with `a_name'?
		do			
			Result := session_values.has (a_name)
		end
		
	get_resource_value (a_name: STRING): STRING is
			-- Retrieve the resource string value from the underlying store.
		do
			Result := session_values.item (a_name)	
		end	

	save_resource (a_resource: PREFERENCE) is
			-- Save `a_resource' to the file on disk.
		do
			-- TODO: neilc
		end		

	save (resources: ARRAYED_LIST [PREFERENCE]) is
			-- Save contents of structure.
		local
			l_resource: PREFERENCE
			l_file: KL_TEXT_OUTPUT_FILE
		do
			create l_file.make (location)
			l_file.open_write
			if l_file.is_open_write then
				l_file.put_string ("<EIFFEL_DOCUMENT>")
				from
					resources.start
				until
					resources.after
				loop			
					l_resource := resources.item
					if not l_resource.is_default_value then
						l_file.put_string ("%N%T<PREFERENCE ")
						l_file.put_string ("NAME=%"" + l_resource.full_name + "%" ")
						l_file.put_string ("VALUE=%"" + l_resource.string_value + "%" ")
						l_file.put_string ("/>")
					end
					resources.forth
				end			
				l_file.put_string ("</EIFFEL_DOCUMENT>")
				l_file.close
			else
				fixme ("Add code to let callers that `resources' could not be saved")
			end
		end

feature {NONE} -- Implementation

	xml_structure: XM_DOCUMENT
			-- XML structure built from parsing of `file'.
			
	extract_preferences_from_file is
			-- Extract from the `file' the saved preference values.
		require
			location_not_void: location /= Void
		local
			parser: XM_EIFFEL_PARSER
			l_file: KL_TEXT_INPUT_FILE
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_concat_filter: XM_CONTENT_CONCATENATOR
			attribute: XM_ATTRIBUTE
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
								attribute := node.attribute_by_name ("NAME")
								if attribute /= Void then
									pref_name := attribute.value
									attribute := node.attribute_by_name ("VALUE")
									if attribute /= Void then
										pref_value := attribute.value
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
				fixme ("Add code to let callers that we could not open resource file")
			end
		end		

invariant
	has_session_values: session_values /= Void
	has_structure: xml_structure /= Void

end -- class PREFERENCE_STRUCTURE_IMP
