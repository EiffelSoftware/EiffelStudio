indexing
	description: "Interface to retrieve modifications made by the user with the assembly manager"
	external_name: "ISE.AssemblyManager.AssemblyModificationsInterface"

class
	ASSEMBLY_MODIFICATIONS_INTERFACE

inherit 
	ASSEMBLY_MODIFICATIONS_INTERFACE_DICTIONARY
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		indexing
			external_name: "Make"
		end

feature -- Access

	last_error: ISE_REFLECTION_ERRORINFO
			-- Last error (either during storage or retrieval)
		indexing
			external_name: "LastError"
		end

	Has_write_lock_code: INTEGER is
			-- Error code 
		indexing
			external_name: "HasWriteLockCode"
		once
			Result := support.errorstable.errorstable.count
		end

	Has_read_lock_code: INTEGER is
			-- Error code 
		indexing
			external_name: "HasReadLockCode"
		once
			Result := support.errorstable.errorstable.count
		end

	Read_lock_creation_failed_code: INTEGER is
			-- Error code 
		indexing
			external_name: "ReadLockCreationFailedCode"
		once
			Result := support.errorstable.errorstable.count
		end
		
	assemblies_modifications: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- Assemblies modifications
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ASSEMBLY_MODIFICATIONS_DESCRIPTOR]
		indexing
			external_name: "AssembliesModifications"
		local
			xml_reader: SYSTEM_XML_XMLTEXTREADER
			index_path: STRING
			assembly_path: STRING
			assembly_xml_filename: STRING
			assembly_added: INTEGER
			read_lock: SYSTEM_IO_FILESTREAM
			file: SYSTEM_IO_FILE
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			retried: BOOLEAN
		do
			if not retried then
				create Result.make
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				index_path := reflection_support.AssembliesFolderPath
				index_path := index_path.Concat_String_String_String (index_path, IndexFilename, XmlExtension)

				create xml_reader.make_xmltextreader_10 (index_path)
					-- WhitespaceHandling = None
				xml_reader.set_WhitespaceHandling (2)
				xml_reader.ReadStartElement_String (AssembliesElement)
				from
				until
					not xml_reader.Name.Equals_String (AssemblyFilenameElement)
				loop
					assembly_path := xml_reader.ReadElementString_String (AssemblyFilenameElement)				
					if support.HasReadLock (assembly_path) then
						support.createerrorfrominfo (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
						last_error := support.lasterror
						last_read_successful := False
					else
						if support.HasWriteLock (assembly_path) then
							support.createerrorfrominfo (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
							last_error := support.lasterror
							last_read_successful := False		
						else
							read_lock := file.Create_ (assembly_path.Concat_String_String_String (assembly_path, "\", support.ReadLockFilename))	
							if read_lock = Void then
								support.createerrorfrominfo (Read_lock_creation_failed_code, error_messages.Read_lock_creation_failed, error_messages.Read_lock_creation_failed_message)
						 		last_error := support.lasterror
								last_read_successful := False
							else
								read_lock.Close
								assembly_xml_filename := assembly_path.Concat_String_String_String_String (assembly_path, "\", DtdAssemblyFilename, XmlExtension)
								if file.Exists (assembly_xml_filename) then
									assembly_added := Result.Add (assembly_modifications_descriptor (assembly_xml_filename))
								end
								last_read_successful := True
								file.Delete (assembly_path.Concat_String_String_String (assembly_path, "\", support.ReadLockFilename))
							end
						end
					end
				end
				xml_reader.ReadEndElement
				xml_reader.Close
			else
				create Result.make
			end
		ensure
			assemblies_modifications_built: Result /= Void
		rescue
			retried := True
			support.createerror (error_messages.Assemblies_modifications_retrieval_failed, error_messages.Assemblies_modifications_retrieval_failed_message)
			last_error := support.lasterror
			retry
		end

	assembly_modifications (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ASSEMBLY_MODIFICATIONS_DESCRIPTOR is
			-- Modifications in assembly corresponding to `an_assembly_descriptor'
		indexing
			external_name: "AssemblyModifications"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			assembly_path: STRING
			assembly_xml_filename: STRING
			read_lock: SYSTEM_IO_FILESTREAM
			file: SYSTEM_IO_FILE
			retried: BOOLEAN
		do
			if not retried then
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				assembly_path := reflection_support.AssemblyFolderPathFromInfo (a_descriptor)
				if support.HasReadLock (assembly_path) then
					support.createerrorfrominfo (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
					last_error := support.lasterror
					last_read_successful := False
				else
					if support.HasWriteLock (assembly_path) then
						support.createerrorfrominfo (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
						last_error := support.lasterror
						last_read_successful := False		
					else
						read_lock := file.Create_ (assembly_path.Concat_String_String_String (assembly_path, "\", support.ReadLockFilename))	
						if read_lock = Void then
							support.createerrorfrominfo (Read_lock_creation_failed_code, error_messages.Read_lock_creation_failed, error_messages.Read_lock_creation_failed_message)
						 	last_error := support.lasterror
							last_read_successful := False					
						else
							read_lock.Close					
							assembly_xml_filename := assembly_path.Concat_String_String_String_String (assembly_path, "\", DtdAssemblyFilename, XmlExtension)
							if file.Exists (assembly_xml_filename) then
								Result := assembly_modifications_descriptor (assembly_xml_filename)
							else
								create Result.make
							end
							last_read_successful := True
							file.Delete (assembly_path.Concat_String_String_String (assembly_path, "\", support.ReadLockFilename))
						end
					end
				end
			else
				create Result.make
			end
		ensure
			assembly_modification_descriptor_created: Result /= Void
		rescue
			retried := True
			support.createerror (error_messages.Assembly_modifications_descriptor_retrieval_failed, error_messages.Assembly_modifications_descriptor_retrieval_failed_message)
			last_error := support.lasterror
			retry		
		end

feature -- Status Report
		
	last_read_successful: BOOLEAN
			-- Was last retrieval successful?
		indexing
			external_name: "LastReadSuccessful"
		end

feature {NONE} -- Implementation

	support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
			-- Support
		indexing
			external_name: "Support"
		once
			create Result.make_codegenerationsupport
			Result.make
		ensure
			support_created: Result /= Void
		end
		
	error_messages: ASSEMBLY_MODIFICATIONS_INTERFACE_ERROR_MESSAGES
			-- Error messages
		indexing
			external_name: "ErrorMessages"
		end

	text_reader: SYSTEM_XML_XMLTEXTREADER
			-- XML text reader
		indexing
			external_name: "TextReader"
		end
	
	type_modification: TYPE_MODIFICATIONS_DESCRIPTOR
			-- Type modifications descriptor
		indexing
			external_name: "TypeModification"
		end

	member_info_builder: MEMBER_INFO_BUILDER
			-- Member info builder
		indexing
			external_name: "MemberInfoBuilder"
		end
		
	assembly_modifications_descriptor (a_filename: STRING): ASSEMBLY_MODIFICATIONS_DESCRIPTOR is
			-- Assembly modifications descriptor corresponding to `a_filename'.
		indexing
			external_name: "AssemblyModificationsDescriptor"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.length > 0
		local
			retried: BOOLEAN
			an_assembly_name: STRING
			an_assembly_version: STRING
			an_assembly_culture: STRING
			an_assembly_public_key: STRING
			an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			dot_net_full_name: STRING
			new_class_name: STRING
		do
			if not retried then
				create text_reader.make_xmltextreader_10 (a_filename)	
					-- WhitespaceHandling = None
				text_reader.set_WhitespaceHandling (2)
				create Result.make

					-- Set `assembly_descriptor'.		
				text_reader.readstartelement_string (Modified_assembly_element)
				text_reader.readstartelement_string (Assembly_descriptor_element)
				an_assembly_name := text_reader.readelementstring_string (Assembly_name_element)
				an_assembly_version := text_reader.readelementstring_string (Assembly_version_element)
				an_assembly_culture := text_reader.readelementstring_string (Assembly_culture_element)
				an_assembly_public_key := text_reader.readelementstring_string (Assembly_public_key_element)
				create an_assembly_descriptor.make1
				an_assembly_descriptor.make (an_assembly_name, an_assembly_version, an_assembly_culture, an_assembly_public_key)
				text_reader.readendelement
				Result.set_assembly_descriptor (an_assembly_descriptor)
				
					-- Set `types_modifications'.
				text_reader.readstartelement_string (Modifications_element)
				from
				until
					not text_reader.name.equals_string (Type_element)
				loop
					create type_modification.make
					text_reader.readstartelement (Type_element)
					
						-- Set `dot_net_full_name' and `new_class_name'.
					text_reader.readstartelement (Class_name_element)
					dot_net_full_name := text_reader.readelementstring_string (Dot_net_full_name_element)
					type_modification.set_dot_net_full_name (dot_net_full_name)
					new_class_name := text_reader.readelementstring_string (New_class_name_element)
					type_modification.set_new_class_name (new_class_name)
					text_reader.readendelement
					
						-- Add new feature names
					if text_reader.name.equals_string (Features_element) then
						text_reader.readstartelement (Features_element)
						create member_info_builder.make (an_assembly_descriptor)
						read_features 
						text_reader.readendelement
					end
					Result.add_type_modification (dot_net_full_name, type_modification)
					text_reader.readendelement
				end				
				text_reader.readendelement
				
				text_reader.readendelement
				text_reader.close
			else
				create Result.make
			end
		ensure
			non_void_assembly_modifications_descriptor: Result /= Void
		rescue
			retried := True
			create_error (error_messages.Assembly_modifications_descriptor_generation_failed, error_messages.Assembly_modifications_descriptor_generation_failed_message)
			retry
		end
		
	read_features  is
			-- Read feature modifications.
		indexing
			external_name: "ReadFeatures"
		local
			new_feature_name: STRING
			feature_external_name: STRING
			arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			added: BOOLEAN
			is_field: BOOLEAN
			a_feature_info: SYSTEM_REFLECTION_MEMBERINFO
		do
			check
				non_void_type_modification: type_modification /= Void
			end
			from
			until
				not text_reader.name.equals_string (Feature_element)
			loop
				text_reader.readstartelement (Feature_element)
				new_feature_name := text_reader.readelementstring_string (New_feature_name_element)
				feature_external_name := text_reader.readelementstring_string (Feature_external_name_element)
				
				member_info_builder.set_new_feature_name (new_feature_name)
				member_info_builder.set_feature_external_name (feature_external_name)
				
				is_field := text_reader.name.equals_string (Is_field_element)
				
				if text_reader.name.equals_string (Arguments_element) then
					text_reader.readstartelement (Arguments_element)
					from
						create arguments.make
					until
						not_text_reader.name.equals_string (Argument_type_external_name_element) 
					loop
						an_argument := text_reader.readelementstring_string (Argument_type_external_name_element)
						added := arguments.add (an_argument)
					end
					text_reader.readendelement 
					member_info_builder.set_arguments (arguments)	
				end
				if is_field then
					a_feature_info := member_info_builder.field_info
				else
					a_feature_info := member_info_builder.method_info
				end
				if a_feature_info /= Void then
					type_modification.add_feature_modification (a_feature_info, new_feature_name)
				end
				text_reader.readendelement
			end
		end
		
end -- class ASSEMBLY_MODIFICATIONS_INTERFACE