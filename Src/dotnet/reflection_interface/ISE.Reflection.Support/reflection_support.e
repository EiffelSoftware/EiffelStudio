indexing
	description: "Provide support for reflection."
	external_name: "ISE.Reflection.ReflectionSupport"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	REFLECTION_SUPPORT
	
inherit
	SUPPORT
		
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `error_messages' and `dictionary'."
			external_name: "Make"
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
			external_name: "EiffelKey"
		end
	
	ISE_Eiffel_key_path: STRING is "Software\ISE\Eiffel50\ec"
		indexing
			description: "Path (in the registry key) to the `ISE_EIFFEL' key"
			external_name: "IseEiffelKeyPath"
		end
		
	Eiffel_delivery_path: STRING is 
		indexing
			description: "Path to Eiffel delivery"
			external_name: "EiffelDeliveryPath"
		local
			registry_key: MICROSOFT_WIN32_REGISTRYKEY
			registry: MICROSOFT_WIN32_REGISTRY
			keys: ARRAY [STRING]
			a_key: STRING
			i: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				registry_key := registry.current_user.open_sub_key (ISE_Eiffel_key_path)
				if registry_key /= Void then
					Result ?= registry_key.get_value (Key)
					if Result /= Void then
						if Result.get_length > 0 then
							if Result.Ends_With ("\") then
								Result := Result.Substring_int32_int32 (0, Result.get_Length - 1)
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
			external_name: "AssembliesFolderPath"
		end

	assembly_folder_path_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
		indexing
			description: "Assembly folder name corresponding to `a_descriptor'."
			external_name: "AssemblyFolderPathFromInfo"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			name: STRING	
			version: STRING
			culture: STRING
			public_key: STRING
			string_to_code: STRING
			folder_name: STRING
		do
			name := a_descriptor.get_name
			version := a_descriptor.get_version
			culture := a_descriptor.get_culture
			public_key := a_descriptor.get_public_key
			string_to_code := name.Concat_String_String_String_String (name, dictionary.Dash, version, dictionary.Dash)
			string_to_code := string_to_code.Concat_String_String_String_String (string_to_code, culture, dictionary.Dash, public_key)
			Result := Assemblies_folder_path
			Result := Result.Concat_String_String (Result, string_to_code)
		ensure
			assembly_folder_name_generated: Result /= Void
			valid_folder_name: Result.get_Length > 0
		end			

	xml_assembly_filename (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
		indexing
			description: "Xml filename corresponding to `an_assembly_descriptor' "
			external_name: "XmlAssemblyFilename"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			assembly_folder_path: STRING
			retried: BOOLEAN
		do
			if not retried then
				assembly_folder_path := Eiffel_key
				Result := assembly_folder_path.concat_string_string (assembly_folder_path, assembly_folder_path_from_info (an_assembly_descriptor))
				Result := Result.Concat_String_String_String_String (Result, "\", Assembly_description_filename, dictionary.Xml_extension)
			else
				Result := Assembly_description_filename
				Result := Result.concat_string_string (Result, dictionary.Xml_extension)
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
			external_name: "DefaultXmlTypeFilename"
		end
		
	xml_type_filename (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; type_full_external_name: STRING): STRING is
		indexing
			description: "Xml filename corresponding to `type_full_external_name' in assembly corresponding to `an_assembly_descriptor'"
			external_name: "XmlTypeFilename"
		require
			non_void_full_external_name: type_full_external_name /= Void
			not_empty_full_external_name: type_full_external_name.get_length > 0
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			formatter: FORMATTER
			assembly_folder_path: STRING
			retried: BOOLEAN
		do
			if not retried then
				create formatter.make
				assembly_folder_path := Eiffel_key
				Result := assembly_folder_path.concat_string_string (assembly_folder_path, assembly_folder_path_from_info (an_assembly_descriptor))
				Result := Result.Concat_String_String_String_String (Result, "\", formatter.Format_Type_Name (type_full_external_name).to_lower, dictionary.Xml_extension)
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
			external_name: "CleanAssemblies"
		local
			xml_reader: SYSTEM_XML_XMLTEXTREADER
			index_path: STRING
			assembly_path: STRING
			file: SYSTEM_IO_FILE
			retried: BOOLEAN		
			white_space_handling: SYSTEM_XML_WHITESPACEHANDLING
		do
			if not retried then
				index_path := Eiffel_delivery_path
				index_path := index_path.Concat_String_String_String_String (index_path, Assemblies_folder_path, dictionary.Index_filename, dictionary.Xml_extension)

				if file.exists (index_path) then
					create xml_reader.make_xmltextreader_10 (index_path)
					xml_reader.set_Whitespace_Handling (white_space_handling.none)
					xml_reader.Read_Start_Element_String (xml_elements.Assemblies_element)
					from
					until
						not xml_reader.get_Name.Equals_String (xml_elements.Assembly_filename_element)
					loop
						assembly_path := xml_reader.Read_Element_String_String (xml_elements.Assembly_filename_element)	
						assembly_path := assembly_path.replace (Eiffel_key, Eiffel_delivery_path)
						if support.has_read_lock (assembly_path) then
							file.delete (assembly_path.Concat_String_String_String (assembly_path, "\", support.read_lock_filename))
						elseif support.has_write_lock (assembly_path) then
							file.delete (assembly_path.Concat_String_String_String (assembly_path, "\", support.write_lock_filename))	
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
	
	clean_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		indexing
			description: "Remove read and write locks from folder corresponding to `a_descriptor'."
			external_name: "CleanAssembly"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			assembly_path: STRING
			file: SYSTEM_IO_FILE
			retried: BOOLEAN		
		do
			if not retried then
				assembly_path := Eiffel_delivery_path
				assembly_path := assembly_path.concat_string_string (assembly_path, Assembly_folder_path_from_info (a_descriptor))
				if support.has_read_lock (assembly_path) then
					file.delete (assembly_path.Concat_String_String_String (assembly_path, "\", support.read_lock_filename))
				elseif support.has_write_lock (assembly_path) then
					file.delete (assembly_path.Concat_String_String_String (assembly_path, "\", support.write_lock_filename))	
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
			external_name: "Support"
		once
			create Result.make
		ensure
			support_created: Result /= Void
		end
			
	Key: STRING is "ISE_EIFFEL"
		indexing
			description: "Environment variable for Eiffel delivery path"
			external_name: "Key"
		end
		
	error_messages: REFLECTION_SUPPORT_ERROR_MESSAGES
		indexing
			description: "Error messages"
			external_name: "ErrorMessages"
		end
		
	dictionary: DICTIONARY
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		end

	Assembly_description_filename: STRING is "assembly_description"
		indexing
			description: "Filename of XML file describing the assembly"
			external_name: "AssemblyDescriptionFilename"
		end
	
	xml_elements: XML_ELEMENTS is
		indexing
			description: "XML elements"
			external_name: "XmlElements"
		once
			create Result
		ensure
			elements_created: Result /= Void
		end
		
end -- class REFLECTION_SUPPPORT
