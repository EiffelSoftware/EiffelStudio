indexing
	description: "Kind of database where user can put xml files describing types and retrieve a more user-friendly type representation. Apply only for shared assemblies."
	external_name: "ISE.Reflection.ReflectionInterface"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end
	
class
	REFLECTION_INTERFACE
	
inherit
	ISE_REFLECTION_XMLELEMENTS
		export
			{NONE} all
		end
		
create
	make_reflection_interface
	
feature {NONE} -- Initialization

	make_reflection_interface is
		indexing
			description: "Creation routine"
			external_name: "MakeReflectionInterface"
		do
			create error_messages
		ensure
			non_void_error_messages: error_messages /= Void
		end

feature -- Access

	last_error: ISE_REFLECTION_ERRORINFO
		indexing
			description: "Last error (either during storage or retrieval)"
			external_name: "LastError"
		end

	search_result: ISE_REFLECTION_EIFFELASSEMBLY
		indexing
			description: "Assembly found: Result of `search'"
			external_name: "SearchResult"
		end
		
	Has_write_lock_code: INTEGER is
		indexing
			description: "Write lock error code"
			external_name: "HasWriteLockCode"
		once
			Result := support.errorstable.errorstable.count
		end

	Has_read_lock_code: INTEGER is
		indexing
			description: "Read lock error code"
			external_name: "HasReadLockCode"
		once
			Result := support.errorstable.errorstable.count
		end

	Read_lock_creation_failed_code: INTEGER is
		indexing
			description: "Read lock creation error code"
			external_name: "ReadLockCreationFailedCode"
		once
			Result := support.errorstable.errorstable.count
		end

	assembly_descriptor_from_type (a_type: SYSTEM_TYPE): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		indexing	
			description: "Retrieve assembly version, culture and public key from `a_type'."
			external_name: "AssemblyDescriptorFromType"
		require
			non_void_type: a_type /= Void
			non_void_assembly_qualified_name: a_type.AssemblyQualifiedName /= Void
			not_empty_assembly_qualified_name: a_type.AssemblyQualifiedName.Length > 0
		local
			assembly_qualified_name: STRING
			comma_index: INTEGER
			name: STRING
			full_version: STRING
			equals_index: INTEGER
			full_culture: STRING	
			version: STRING
			culture: STRING
			public_key: STRING
			error: ISE_REFLECTION_ERRORINFO
			retried: BOOLEAN
		do
			if not retried then
				assembly_qualified_name := a_type.AssemblyQualifiedName
				comma_index := assembly_qualified_name.IndexOf_Char (',')
				if comma_index > -1 then
					assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
					comma_index := assembly_qualified_name.IndexOf_Char (',')
					if comma_index > -1 then
						name := assembly_qualified_name.Substring_Int32_Int32 (0, comma_index)
						assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
						comma_index := assembly_qualified_name.IndexOf_Char (',')
						if comma_index > -1 then
							full_version := assembly_qualified_name.Substring_Int32_Int32 (0, comma_index)
							equals_index := full_version.IndexOf_Char ('=')
							if equals_index > -1 then
								version := full_version.substring (equals_index + 1)
								assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
								comma_index := assembly_qualified_name.IndexOf_Char (',')
								if comma_index > -1 then
									full_culture := assembly_qualified_name.Substring_Int32_Int32 (0, comma_index)
									equals_index := full_culture.IndexOf_Char ('=')
									if equals_index > -1 then
										culture := full_culture.substring (equals_index + 1)
										assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
										equals_index := assembly_qualified_name.IndexOf_Char ('=')
										if equals_index > -1 then
											public_key := assembly_qualified_name.substring (equals_index + 1)
											create Result.make1
											Result.Make (name, version, culture, public_key)										
										end
									end
								end
							end
						end
					end
				end
			else
				create Result.make1
			end
		ensure
			assembly_descriptor_created: Result /= Void
		rescue
			retried := True
			support.createerror (error_messages.Invalid_assembly_qualified_name, error_messages.Invalid_assembly_qualified_name_message)
			last_error := support.lasterror
			retry
		end
		
feature -- Status Report
		
	last_read_successful: BOOLEAN
		indexing
			description: "Was last retrieval successful?"
			external_name: "LastReadSuccessful"
		end
	
	found: BOOLEAN
		indexing
			description: "Has assembly been found? (Result of `search')"
			external_name: "Found"
		end

feature -- Basic Operations

	search (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		indexing
			description: "[Search for assembly corresponding to `a_descriptor' in the database.%
					%Make result available in `found.']"
			external_name: "Search"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			filename: STRING
			dir: SYSTEM_IO_DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				filename := reflection_support.Eiffeldeliverypath
				filename := filename.concat_string_string (filename, reflection_support.AssemblyFolderPathFromInfo (a_descriptor))
				found := dir.Exists (filename)
				search_result := assembly (a_descriptor)
			else
				found := False
				search_result := Void
			end
		rescue
			retried := True
			support.createerror (error_messages.File_access_failed, error_messages.File_access_failed_message)
			last_error := support.lasterror
			retry
		end
		
feature -- Retrieval

	assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_ASSEMBLY]
			-- | For each folder in `$EIFFEL\dotnet\assemblies', check if there is a write or read lock.
			-- | If a lock already exists, set `last_read_successful' to False, else
			-- | call `eiffel_assembly' with assembly description xml file as parameter.
			-- | If no lock has been found, set `last_read_successful' to True.
		indexing
			description: "Assemblies in the data base"
			external_name: "Assemblies"
		local
			xml_reader: SYSTEM_XML_XMLTEXTREADER
			index_path: STRING
			assembly_path: STRING
			assembly_xml_filename: STRING
			assembly_added: INTEGER
			read_lock: SYSTEM_IO_FILESTREAM
			file: SYSTEM_IO_FILE
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			error: ISE_REFLECTION_ERRORINFO
			retried: BOOLEAN
		do
			if not retried then
				create Result.make
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				index_path := reflection_support.Eiffeldeliverypath
				index_path := index_path.Concat_String_String_String_String (index_path, reflection_support.AssembliesFolderPath, IndexFilename, XmlExtension)

				create xml_reader.make_xmltextreader_10 (index_path)
					-- WhitespaceHandling = None
				xml_reader.set_WhitespaceHandling (2)
				xml_reader.ReadStartElement_String (AssembliesElement)
				from
				until
					not xml_reader.Name.Equals_String (AssemblyFilenameElement)
				loop
					assembly_path := xml_reader.ReadElementString_String (AssemblyFilenameElement)	
					assembly_path := assembly_path.replace (reflection_support.Eiffelkey, reflection_support.Eiffeldeliverypath)
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
								assembly_added := Result.Add (eiffel_assembly (assembly_xml_filename))
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
			assemblies_built: Result /= Void
		rescue
			retried := True
			support.createerror (error_messages.Assemblies_retrieval_failed, error_messages.Assemblies_retrieval_failed_message)
			last_error := support.lasterror
			retry
		end
		
	assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ISE_REFLECTION_EIFFELASSEMBLY is
			-- | Generate a `read_lock' file when user starts reading and remove it when reading is over.
			-- | If a read or write lock already exists in the folder access is requested, set `last_read_successful' to False,
			-- | else call `eiffel_assembly' with xml file name and set `last_read_successful' to True.
		indexing
			description: "[Retrieve assembly xml description (by using `a_descriptor' to find file location).%
					%Generate instance of `EIFFEL_ASSEMBLY' from the xml file.]"
			external_name: "Assembly"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			assembly_path: STRING
			assembly_xml_filename: STRING
			read_lock: SYSTEM_IO_FILESTREAM
			file: SYSTEM_IO_FILE
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			error: ISE_REFLECTION_ERRORINFO
			retried: BOOLEAN
		do
			if not retried then
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				assembly_path := reflection_support.Eiffeldeliverypath
				assembly_path := assembly_path.concat_string_string (assembly_path, reflection_support.AssemblyFolderPathFromInfo (a_descriptor))
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
							Result := eiffel_assembly (assembly_xml_filename)
							last_read_successful := True
							file.Delete (assembly_path.Concat_String_String_String (assembly_path, "\", support.ReadLockFilename))
						end
					end
				end
			else
				Result := Void
			end
		rescue
			retried := True
			support.createerror (error_messages.Assembly_retrieval_failed, error_messages.Assembly_retrieval_failed_message)
			last_error := support.lasterror
			retry
		end
		
	type (a_type: SYSTEM_TYPE): ISE_REFLECTION_EIFFELCLASS is
			-- | Generate a `read_lock' file when user starts reading and remove it when reading is over.
			-- | If a read or write lock already exists in the folder access is requested, set `last_read_successful' to False,
			-- | else call `eiffel_type' with xml file name and set `last_read_successful' to True.
		indexing
			description: "[Retrieve xml file corresponding to `a_type'.%
					%Generate instance of `EIFFEL_CLASS' from the xml file.]"
			external_name: "Type"
		require
			non_void_type: a_type /= Void
			non_void_assembly_qualified_name: a_type.AssemblyQualifiedName /= Void
			not_empty_assembly_qualified_name: a_type.AssemblyQualifiedName.Length > 0
		local
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			assembly_path: STRING
			xml_type_filename: STRING
			read_lock: SYSTEM_IO_FILESTREAM
			file: SYSTEM_IO_FILE
			formatter: FORMATTER
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			error: ISE_REFLECTION_ERRORINFO
			retried: BOOLEAN
		do
			if not retried then
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				a_descriptor := assembly_descriptor_from_type (a_type)
				search (a_descriptor)
				if not found then
					Result := Void
				else
					create formatter.make
					assembly_path := reflection_support.Eiffeldeliverypath
					assembly_path := assembly_path.concat_string_string (assembly_path, reflection_support.AssemblyFolderPathFromInfo (a_descriptor))
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
								xml_type_filename := assembly_path.Concat_String_String_String_String (assembly_path, "\", formatter.FormatTypeName (a_type.FullName).ToLower, XmlExtension)
								Result := eiffel_type (xml_type_filename)
								last_read_successful := True
								file.Delete (assembly_path.Concat_String_String_String (assembly_path, "\", support.ReadLockFilename))
							end
						end
					end	
				end
			else
				Result := Void
			end
		rescue
			retried := True
			support.createerror (error_messages.Type_retrieval_failed, error_messages.Type_retrieval_failed_message)
			last_error := support.lasterror
			retry
		end

feature -- Removal
	
	remove_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
			-- | Build a string from `a_descriptor'
			-- | and use hash value to retrieve assembly folder name where `assembly_description.xml' is.
			-- | Check for write or read lock before removing the assembly.
			-- | Update `last_removal_successful'.
		indexing
			description: "Remove assembly corresponding to `a_descriptor' from the database."
			external_name: "RemoveAssembly"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			non_void_assembly_name: a_descriptor.Name /= Void
			not_empty_assembly_name: a_descriptor.Name.Length > 0
		local
			cache_handler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER
			retried: BOOLEAN
		do	
			if not retried then
				create cache_handler.make_eiffelassemblycachehandler
				cache_handler.MakeCacheHandler
				cache_handler.RemoveAssembly (a_descriptor)
			end
		rescue
			retried := True
			support.createerror (error_messages.Assembly_removal_failed, error_messages.Assembly_removal_failed_message)
			last_error := support.lasterror
			retry
		end
	
feature {NONE} -- Implementation

	support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		indexing
			description: "Support"
			external_name: "Support"
		once
			create Result.make_codegenerationsupport
			Result.make
		ensure
			support_created: Result /= Void
		end
		
	error_messages: REFLECTION_INTERFACE_ERROR_MESSAGES
		indexing
			description: "Error messages"
			external_name: "ErrorMessages"
		end
					
	eiffel_assembly (xml_filename: STRING): ISE_REFLECTION_EIFFELASSEMBLY is
		indexing
			description: "Generate instance of `EIFFEL_ASSEMBLY' from `xml_filename'."
			external_name: "EiffelAssembly"
		require
			non_void_filename: xml_filename /= Void
			not_emtpy_filename: xml_filename.Length > 0
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := support.EiffelAssemblyFromXml (xml_filename)
			else
				Result := Void
			end	
		rescue
			retried := True
			retry
		end
	
	eiffel_type (xml_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
		indexing
			description: "Generate instance of `EIFFEL_CLASS' from `xml_filename'."
			external_name: "EiffelType"
		require
			non_void_filename: xml_filename /= Void
			not_emtpy_filename: xml_filename.Length > 0
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := support.EiffelClassFromXml (xml_filename)
			else
				create Result.make1
				Result.make
			end
		ensure
			eiffel_class_created: Result /= Void		
		rescue
			retried := True
			retry
		end

invariant
	found_implies_non_void_search_result: found implies search_result /= Void
	not_found_implies_void_search_result: not found implies search_result = Void

end -- class REFLECTION_INTERFACE
