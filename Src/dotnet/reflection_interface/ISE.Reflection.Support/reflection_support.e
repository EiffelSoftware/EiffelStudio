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
		
	Eiffel_delivery_path: STRING is 
		indexing
			description: "Path to Eiffel delivery"
			external_name: "EiffelDeliveryPath"
		local
			env: SYSTEM_ENVIRONMENT
		do
			Result := env.GetEnvironmentVariable (Key)
			if Result.EndsWith ("\") then
				Result := Result.Substring_int32_int32 (0, Result.Length - 1)
			end
		ensure
			non_void_eiffel_delivery_path: Result /= Void
			not_emtpy_eiffel_delivery_path: Result.Length > 0
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
			name := a_descriptor.Name
			version := a_descriptor.Version
			culture := a_descriptor.Culture
			public_key := a_descriptor.PublicKey
			string_to_code := name.Concat_String_String_String_String (name, dictionary.Dash, version, dictionary.Dash)
			string_to_code := string_to_code.Concat_String_String_String_String (string_to_code, culture, dictionary.Dash, public_key)
			Result := Assemblies_folder_path
			Result := Result.Concat_String_String (Result, string_to_code)
		ensure
			assembly_folder_name_generated: Result /= Void
			valid_folder_name: Result.Length > 0
		end			

	xml_assembly_filename (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
		indexing
			description: "Xml filename corresponding to `an_assembly_descriptor' "
			external_name: "XmlAssemblyFilename"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_version: an_assembly_descriptor.version /= Void
			non_void_assembly_culture: an_assembly_descriptor.culture /= Void
			non_void_assembly_public_key: an_assembly_descriptor.publickey /= Void
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
			not_empty_full_external_name: type_full_external_name.length > 0
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
				Result := Result.Concat_String_String_String_String (Result, "\", formatter.FormatTypeName (type_full_external_name).ToLower, dictionary.Xml_extension)
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
		
feature {NONE} -- Implementation

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
		
end -- class REFLECTION_SUPPPORT
