indexing
	description: "Provide support for reflection."
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	REFLECTION_SUPPORT
	
inherit
	SUPPORT_SUPPORT
	SUPPORT
		
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `error_messages' and `dictionary'."
		do
			create error_messages
			create dictionary
		ensure
			error_messages_created: error_messages /= Void
			dictionary_created: dictionary /= Void
		end

feature -- Access				

	Eiffel_key: STRING is "$ISE_EIFFEL"
		indexing
			description: "Environment variable giving path to Eiffel delivery"
		end
	
	ISE_Eiffel_key_path: STRING is "Software\ISE\Eiffel52\ec"
		indexing
			description: "Path (in the registry key) to the `ISE_EIFFEL' key"
		end
		
	Eiffel_delivery_path: STRING is 
		indexing
			description: "Path to Eiffel delivery"
		local
			registry_key: REGISTRY_KEY
			registry: REGISTRY
			keys: ARRAY [STRING]
			a_key: STRING
			i: INTEGER
			retried: BOOLEAN
			key_value: SYSTEM_STRING
		do
			if not retried then
				registry_key := registry.current_user.open_sub_key (ISE_Eiffel_key_path.to_cil)
				if registry_key /= Void then
					key_value ?= registry_key.get_value (key.to_cil)
					if key_value /= Void then
						Result := from_system_string (key_value)
					end
					if Result /= Void then
						if Result.count > 0 then
							if Result.item (Result.Count).is_equal ('\') then
								Result := Result.substring (1, Result.count - 1)
							end
						else
							create_error (error_messages.Registry_key_not_registered, error_messages.Registry_key_not_registered_message)
						end
					else
						create_error (error_messages.Registry_key_not_registered, error_messages.Registry_key_not_registered_message)
					end	
				else
					create_error (error_messages.Registry_key_not_registered, error_messages.Registry_key_not_registered_message)				
				end
			end
		rescue
			retried := True
			create_error (error_messages.Registry_key_not_registered, error_messages.Registry_key_not_registered_message)
			retry
		end
		
	Assemblies_folder_path: STRING is "\dotnet\assemblies\"
		indexing
			description: "Path to `$EIFFEL\dotnet\assemblies' directory"
		end

	assembly_folder_path_from_info (a_descriptor: ASSEMBLY_DESCRIPTOR): STRING is
		indexing
			description: "Assembly folder name corresponding to `a_descriptor'."
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			name: STRING	
			version: STRING
			culture: STRING
			public_key: STRING
			string_to_code: STRING
			folder_name: STRING
			path:PATH
		do
			name := from_component_string (a_descriptor.name)
			version := from_component_string (a_descriptor.version)
			culture := from_component_string (a_descriptor.culture)
			public_key := from_component_string (a_descriptor.public_key)
			
			string_to_code := name.clone (name)
			string_to_code.append (dictionary.Dash)
			string_to_code.append (version)
			string_to_code.append (dictionary.Dash)
			string_to_code.append (culture)
			string_to_code.append (dictionary.Dash)
			string_to_code.append (public_key)
			Result := Assemblies_folder_path.clone (Assemblies_folder_path)
			Result.append (string_to_code)
		ensure
			assembly_folder_name_generated: Result /= Void
			valid_folder_name: Result.count > 0
		end			

	xml_assembly_filename (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR): STRING is
		indexing
			description: "Xml filename corresponding to `an_assembly_descriptor' "
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			assembly_folder_path: STRING
			retried: BOOLEAN
		do
			if not retried then
				assembly_folder_path := Eiffel_key.clone (Eiffel_key)
				Result := assembly_folder_path.clone (assembly_folder_path)
				Result.append (assembly_folder_path_from_info (an_assembly_descriptor))
				Result.append ("\")
				Result.append (Assembly_description_filename)
				Result.append (dictionary.Xml_extension)
			else
				Result := Assembly_description_filename.clone(Assembly_description_filename)
				Result.append (dictionary.Xml_extension)
			end
		ensure
			non_void_filename: Result /= Void
		rescue
			retried := True
			create_error (error_messages.No_assembly_description, error_messages.No_assembly_description_message)
			retry
		end
	
	Default_xml_type_filename: STRING is "type.xml"
		indexing
			description: "Default xml type filename"
		end
		
	xml_type_filename (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR; type_full_external_name: STRING): STRING is
		indexing
			description: "Xml filename corresponding to `type_full_external_name' in assembly corresponding to `an_assembly_descriptor'"
		require
			non_void_full_external_name: type_full_external_name /= Void
			not_empty_full_external_name: type_full_external_name.count > 0
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			formatter: FORMATTER
			assembly_folder_path: STRING
			retried: BOOLEAN
			conversion_support: CONVERSION_SUPPORT
		do
			if not retried then
				create formatter.make
				create conversion_support
				assembly_folder_path := Eiffel_key.clone (Eiffel_key)
				Result := assembly_folder_path.clone (assembly_folder_path)
				Result.append (assembly_folder_path_from_info (an_assembly_descriptor))
				Result.append ("\")
				
				--Result.append ( from_system_string (formatter.Format_Type_Name (type_full_external_name.to_cil).to_lower) )
				Result.append ( from_system_string (formatter.Format_Type_Name (conversion_support.type_from_assembly_descriptor (an_assembly_descriptor, type_full_external_name)).to_lower) )
				Result.append (dictionary.Xml_extension)
			else
				Result := Default_xml_type_filename
			end
		ensure
			non_void_filename: Result /= Void
		rescue
			retried := True
			create_error (error_messages.No_type_description, error_messages.No_type_description_message)
			retry
		end

feature -- Basic Operations

	clean_assemblies is
		indexing
			description: "Remove read and write locks from the `assemblies' folder."
		local
			xml_reader: SYSTEM_XML_XML_TEXT_READER
			index_path: STRING
			assembly_path: STRING
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN		
			white_space_handling: SYSTEM_XML_WHITESPACE_HANDLING
		do
			if not retried then
				index_path := Eiffel_delivery_path.clone (Eiffel_delivery_path)
				index_path.append (Assemblies_folder_path)
				index_path.append (dictionary.Index_filename)
				index_path.append (dictionary.Xml_extension)

				create file.make (index_path)

				if file.exists then
					create xml_reader.make_system_xml_xml_text_reader_10 (index_path.to_cil)
					xml_reader.set_Whitespace_Handling (white_space_handling.none)
					xml_reader.Read_Start_Element_String (xml_elements.Assemblies_element.to_cil)
					from
					until
						not xml_reader.get_Name.Equals (xml_elements.Assembly_filename_element.to_cil)
					loop
						assembly_path := from_system_string ( xml_reader.Read_Element_String_String (xml_elements.Assembly_filename_element.to_cil) )
						assembly_path.replace_substring_all (Eiffel_key, Eiffel_delivery_path)
						if support.has_read_lock (assembly_path) then
							assembly_path.append ("\")
							assembly_path.append (support.read_lock_filename)
							create file.make (assembly_path)
							file.delete
						elseif support.has_write_lock (assembly_path) then
							assembly_path.append ( "\")
							assembly_path.append (support.write_lock_filename)
							create file.make (assembly_path)
							file.delete	
						end
					end
					xml_reader.Read_End_Element
					xml_reader.Close
				end
			end
		rescue
			retried := True
			retry
		end
	
	clean_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		indexing
			description: "Remove read and write locks from folder corresponding to `a_descriptor'."
		require
			non_void_descriptor: a_descriptor /= Void
		local
			assembly_path: STRING
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN		
		do
			if not retried then
				assembly_path := Eiffel_delivery_path.clone (Eiffel_delivery_path)
				assembly_path.append (Assembly_folder_path_from_info (a_descriptor))
				if support.has_read_lock (assembly_path) then
					assembly_path.append ("\")
					assembly_path.append (support.read_lock_filename)
					create file.make (assembly_path)
					file.delete
				elseif support.has_write_lock (assembly_path) then
					assembly_path.append ("\")
					assembly_path.append (support.write_lock_filename)
					create file.make (assembly_path)
					file.delete
				end
			end
		rescue
			retried := True
			retry
		end
		
feature {NONE} -- Implementation

	support: CODE_GENERATION_SUPPORT is
		indexing
			description: "Support"
		once
			create Result.make
		ensure
			support_created: Result /= Void
		end
			
	Key: STRING is "ISE_EIFFEL"
		indexing
			description: "Environment variable for Eiffel delivery path"
		end
		
	error_messages: REFLECTION_SUPPORT_ERROR_MESSAGES
		indexing
			description: "Error messages"
		end
		
	dictionary: DICTIONARY
		indexing
			description: "Dictionary"
		end

	Assembly_description_filename: STRING is "assembly_description"
		indexing
			description: "Filename of XML file describing the assembly"
		end
	
	xml_elements: XML_ELEMENTS is
		indexing
			description: "XML elements"
		once
			create Result
		ensure
			elements_created: Result /= Void
		end
		
end -- class REFLECTION_SUPPPORT
