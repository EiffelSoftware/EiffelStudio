indexing
	description: "Kind of database where user can put xml files describing types and retrieve a more user-friendly type representation. Apply only for shared assemblies."
	external_name: "ISE.Reflection.ReflectionInterface"
	
class
	REFLECTION_INTERFACE
	
inherit
	ISE_REFLECTION_XMLELEMENTS
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
		do
		end

feature -- Access

	last_error: ISE_REFLECTION_ERRORINFO
			-- Last error (either during storage or retrieval)
		indexing
			external_name: "LastError"
		end
			
feature -- Status Report
		
	last_read_successful: BOOLEAN
			-- Was last retrieval successful?
		indexing
			external_name: "LastReadSuccessful"
		end
			
	exists_from_type (a_type: SYSTEM_TYPE): BOOLEAN is
			-- Is assembly defining `a_type' already in the database?
		indexing
			external_name: "ExistsFromType"
		require
			non_void_type: a_type /= Void
			non_void_assembly_qualified_name: a_type.AssemblyQualifiedName /= Void
			not_empty_assembly_qualified_name: a_type.AssemblyQualifiedName.Length > 0		
		local
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
		do
			a_descriptor := assembly_info_from_type (a_type)
			Result := exists_from_info (a_descriptor)		
		end
		
	exists_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): BOOLEAN is
			-- Is assembly corresponding to `a_descriptor' already in the database?
		indexing
			external_name: "ExistsFromInfo"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			support: ISE_REFLECTION_SUPPORT
			filename: STRING
			dir: SYSTEM_IO_DIRECTORY
		do
			create support.make_support
			support.Make
			filename := support.AssemblyFolderPathFromInfo (a_descriptor)
			Result := dir.Exists (filename)
		end
		
feature -- Status Setting

	set_last_error (error_info: like last_error) is
			-- Set `last_error' with `error_info'.
		indexing
			external_name: "SetLastError"
		require
			non_void_error: error_info /= Void
			non_void_code: error_info.code /= Void
		do
			last_error := error_info
		ensure
			last_error_set: last_error = error_info
		end
		
feature -- Retrieval

	assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- Assemblies in the data base
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_ASSEMBLY]
			-- | For each folder in `$EIFFEL\dotnet\assemblies', check if there is a write or read lock.
			-- | If a lock already exists, set `last_read_successful' to False, else
			-- | call `eiffel_assembly' with assembly description xml file as parameter.
			-- | If no lock has been found, set `last_read_successful' to True.
		indexing
			external_name: "Assemblies"
		local
			xml_reader: SYSTEM_XML_XMLTEXTREADER
			index_path: STRING
			assembly_path: STRING
			assembly_xml_filename: STRING
			assembly_added: INTEGER
			read_lock: SYSTEM_IO_FILESTREAM
			file: SYSTEM_IO_FILE
			support: ISE_REFLECTION_SUPPORT
			error: ISE_REFLECTION_ERRORINFO
		do
			create Result.make
			create support.make_support
			support.Make
			index_path := support.AssembliesFolderPath
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
					create error.make1
					error.Make (9)
					set_last_error (error)
					last_read_successful := False
				else
					if support.HasWriteLock (assembly_path) then
						create error.make1
						error.Make (8)
						set_last_error (error)
						last_read_successful := False		
					else
						read_lock := file.Create_ (assembly_path.Concat_String_String_String (assembly_path, "\", support.ReadLockFilename))	
						if read_lock = Void then
							create error.make1
							error.Make (10)
							set_last_error (error)
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
		ensure
			assemblies_built: Result /= Void
		end
		
	assembly_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ISE_REFLECTION_EIFFELASSEMBLY is
			-- Retrieve assembly xml description (by using `a_descriptor' to find file location).
			-- Generate instance of `EIFFEL_ASSEMBLY' from the xml file.
			-- | Generate a `read_lock' file when user starts reading and remove it when reading is over.
			-- | If a read or write lock already exists in the folder access is requested, set `last_read_successful' to False,
			-- | else call `eiffel_assembly' with xml file name and set `last_read_successful' to True.
		indexing
			external_name: "AssemblyFromInfo"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			assembly_path: STRING
			assembly_xml_filename: STRING
			read_lock: SYSTEM_IO_FILESTREAM
			file: SYSTEM_IO_FILE
			support: ISE_REFLECTION_SUPPORT
			error: ISE_REFLECTION_ERRORINFO
		do
			create support.make_support
			support.Make
			assembly_path := support.AssemblyFolderPathFromInfo (a_descriptor)

			if support.HasReadLock (assembly_path) then
				create error.make1
				error.Make (9)
				set_last_error (error)
				last_read_successful := False
			else
				if support.HasWriteLock (assembly_path) then
					create error.make1
					error.Make (8)
					set_last_error (error)
					last_read_successful := False		
				else
					read_lock := file.Create_ (assembly_path.Concat_String_String_String (assembly_path, "\", support.ReadLockFilename))	
					if read_lock = Void then
						create error.make1
						error.Make (10)
						set_last_error (error)
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
		ensure
			eiffel_assembly_created: Result /= Void
		end

	assembly_from_type (a_type: SYSTEM_TYPE): ISE_REFLECTION_EIFFELASSEMBLY is
			-- Retrieve assembly xml description (by using `a_type' assembly qualified name to find file location).
			-- Generate instance of `EIFFEL_ASSEMBLY' from the xml file.
			-- | Generate a `read_lock' file when user starts reading and remove it when reading is over.
			-- | If a read or write lock already exists in the folder access is requested, set `last_read_successful' to False,
			-- | else call `eiffel_assembly' with xml file name and set `last_read_successful' to True.
		indexing
			external_name: "AssemblyFromType"
		require
			non_void_type: a_type /= Void
			non_void_assembly_qualified_name: a_type.AssemblyQualifiedName /= Void
			not_empty_assembly_qualified_name: a_type.AssemblyQualifiedName.Length > 0
		local
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
		do
			a_descriptor := assembly_info_from_type (a_type)
			Result := assembly_from_info (a_descriptor)
		ensure
			eiffel_assembly_created: Result /= Void
		end
		
	type (a_type: SYSTEM_TYPE): ISE_REFLECTION_EIFFELCLASS is
			-- Retrieve xml file corresponding to `a_type'.
			-- Generate instance of `EIFFEL_CLASS' from the xml file.
			-- | Generate a `read_lock' file when user starts reading and remove it when reading is over.
			-- | If a read or write lock already exists in the folder access is requested, set `last_read_successful' to False,
			-- | else call `eiffel_type' with xml file name and set `last_read_successful' to True.
		indexing
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
			support: ISE_REFLECTION_SUPPORT
			error: ISE_REFLECTION_ERRORINFO
		do
			create formatter.make_formatter
			create support.make_support
			support.Make
			a_descriptor := assembly_info_from_type (a_type)
			assembly_path := support.AssemblyFolderPathFromInfo (a_descriptor)
			if support.HasReadLock (assembly_path) then
				create error.make1
				error.Make (9)
				set_last_error (error)
				last_read_successful := False
			else
				if support.HasWriteLock (assembly_path) then
					create error.make1
					error.Make (8)
					set_last_error (error)
					last_read_successful := False		
				else
					read_lock := file.Create_ (assembly_path.Concat_String_String_String (assembly_path, "\", support.ReadLockFilename))
					if read_lock = Void then
						create error.make1
						error.Make (10)
						set_last_error (error)
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
		ensure
			eiffel_class_created: Result /= Void
		end

feature -- Removal

	remove_assembly_from_type (a_type: SYSTEM_TYPE) is
			-- Remove assembly defining `a_type' from the database.
			-- | Find location of xml assembly description file from `a_type': 
			-- | use `AssemblyQualifiedName' to retrieve assembly version, culture and public key
			-- | and use hash value to retrieve assembly folder name where `assembly_description.xml' is.
			-- | Check for write or read lock before removing the assembly.
		indexing
			external_name: "RemoveAssemblyFromType"
		require
			non_void_type: a_type /= Void
			non_void_assembly_qualified_name: a_type.AssemblyQualifiedName /= Void
			not_empty_assembly_qualified_name: a_type.AssemblyQualifiedName.Length > 0
		local
			assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
		do
			assembly_descriptor := assembly_info_from_type (a_type)
			remove_assembly_from_info (assembly_descriptor)
		end
	
	remove_assembly_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
			-- Remove assembly corresponding to `a_descriptor' from the database.
			-- | Build a string from `a_descriptor'
			-- | and use hash value to retrieve assembly folder name where `assembly_description.xml' is.
			-- | Check for write or read lock before removing the assembly.
			-- | Update `last_removal_successful'.
		indexing
			external_name: "RemoveAssemblyFromInfo"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			non_void_assembly_name: a_descriptor.Name /= Void
			not_empty_assembly_name: a_descriptor.Name.Length > 0
		local
			cache_handler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER
		do	
			create cache_handler.make_eiffelassemblycachehandler
			cache_handler.Make
			cache_handler.RemoveAssembly (a_descriptor)
		end
	
feature {NONE} -- Implementation
				
	assembly_info_from_type (a_type: SYSTEM_TYPE): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
			-- Retrieve assembly version, culture and public key from `a_type'.
		indexing	
			external_name: "AssemblyInfoFromType"
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
		do
			assembly_qualified_name := a_type.AssemblyQualifiedName
			comma_index := assembly_qualified_name.IndexOf_Char (',')
			if comma_index = -1 then
				create error.make1
				error.Make (13)
				set_last_error (error)
			else
				assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
				comma_index := assembly_qualified_name.IndexOf_Char (',')
				if comma_index = -1 then
					create error.make1
					error.Make (13)
					set_last_error (error)
				else
					name := assembly_qualified_name.Substring_Int32_Int32 (0, comma_index)
					
					assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
					comma_index := assembly_qualified_name.IndexOf_Char (',')
					if comma_index = -1 then
						create error.make1
						error.Make (13)
						set_last_error (error)
					else
						full_version := assembly_qualified_name.Substring_Int32_Int32 (0, comma_index)
						equals_index := full_version.IndexOf_Char ('=')
						if equals_index = -1 then
							create error.make1
							error.Make (13)
							set_last_error (error)
						else
							version := full_version.substring (equals_index + 1)

							assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
							comma_index := assembly_qualified_name.IndexOf_Char (',')
							if comma_index = -1 then
								create error.make1
								error.Make (13)
								set_last_error (error)
							else
								full_culture := assembly_qualified_name.Substring_Int32_Int32 (0, comma_index)
								equals_index := full_culture.IndexOf_Char ('=')
								if equals_index = -1 then
									create error.make1
									error.Make (13)
									set_last_error (error)
								else
									culture := full_culture.substring (equals_index + 1)

									assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
									equals_index := assembly_qualified_name.IndexOf_Char ('=')
									if equals_index = -1 then
										create error.make1
										error.Make (13)
										set_last_error (error)
									else
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
		ensure
			assembly_descriptor_created: Result /= Void
		end
					
	eiffel_assembly (xml_filename: STRING): ISE_REFLECTION_EIFFELASSEMBLY is
			-- Generate instance of `EIFFEL_ASSEMBLY' from `xml_filename'.
		indexing
			external_name: "EiffelAssembly"
		require
			non_void_filename: xml_filename /= Void
			not_emtpy_filename: xml_filename.Length > 0
		local
			support: ISE_REFLECTION_SUPPORT
		do
			create support.make_support
			support.Make
			Result := support.EiffelAssemblyFromXml (xml_filename)
		ensure
			eiffel_assembly_created: Result /= Void		
		end
	
	eiffel_type (xml_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
			-- Generate instance of `EIFFEL_CLASS' from `xml_filename'.
		indexing
			external_name: "EiffelType"
		require
			non_void_filename: xml_filename /= Void
			not_emtpy_filename: xml_filename.Length > 0
		local
			support: ISE_REFLECTION_SUPPORT
		do
			create support.make_support
			support.Make
			Result := support.EiffelClassFromXml (xml_filename)
		ensure
			eiffel_class_created: Result /= Void		
		end
			
end -- class REFLECTION_INTERFACE
