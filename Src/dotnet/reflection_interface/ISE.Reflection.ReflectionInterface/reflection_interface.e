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
			Result := support.errors_table.get_errors_table.get_count
		end

	Has_read_lock_code: INTEGER is
		indexing
			description: "Read lock error code"
			external_name: "HasReadLockCode"
		once
			Result := support.errors_table.get_errors_table.get_count
		end

	Read_lock_creation_failed_code: INTEGER is
		indexing
			description: "Read lock creation error code"
			external_name: "ReadLockCreationFailedCode"
		once
			Result := support.errors_table.get_errors_table.get_count
		end

	assembly_descriptor_from_type (a_type: SYSTEM_TYPE): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		indexing	
			description: "Retrieve assembly version, culture and public key from `a_type'."
			external_name: "AssemblyDescriptorFromType"
		require
			non_void_type: a_type /= Void
			non_void_assembly_qualified_name: a_type.get_Assembly_Qualified_Name /= Void
			not_empty_assembly_qualified_name: a_type.get_Assembly_Qualified_Name.get_length > 0
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
				assembly_qualified_name := a_type.get_Assembly_Qualified_Name
				comma_index := assembly_qualified_name.Index_Of_Char (',')
				if comma_index > -1 then
					assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
					comma_index := assembly_qualified_name.Index_Of_Char (',')
					if comma_index > -1 then
						name := assembly_qualified_name.Substring_Int32_Int32 (0, comma_index)
						assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
						comma_index := assembly_qualified_name.Index_Of_Char (',')
						if comma_index > -1 then
							full_version := assembly_qualified_name.Substring_Int32_Int32 (0, comma_index)
							equals_index := full_version.Index_Of_Char ('=')
							if equals_index > -1 then
								version := full_version.substring (equals_index + 1)
								assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
								comma_index := assembly_qualified_name.Index_Of_Char (',')
								if comma_index > -1 then
									full_culture := assembly_qualified_name.Substring_Int32_Int32 (0, comma_index)
									equals_index := full_culture.Index_Of_Char ('=')
									if equals_index > -1 then
										culture := full_culture.substring (equals_index + 1)
										assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1).Trim
										equals_index := assembly_qualified_name.Index_Of_Char ('=')
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
			support.create_error (error_messages.Invalid_assembly_qualified_name, error_messages.Invalid_assembly_qualified_name_message)
			last_error := support.get_last_error
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

feature -- Status Setting

	set_last_error (an_error: like last_error) is
		indexing
			description: "Set `last_error' with `an_error'."
			external_name: "SetLastError"
		do
			last_error := an_error
		ensure
			last_error_set: last_error = an_error
		end
		
feature -- Basic Operations

	search (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		indexing
			description: "[
						Search for assembly corresponding to `a_descriptor' in the database.
						Make result available in `found.'
					  ]"
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
				filename := reflection_support.Eiffel_delivery_path
				filename := filename.concat_string_string (filename, reflection_support.Assembly_Folder_Path_From_Info (a_descriptor))
				found := dir.Exists (filename)
				if found then
					search_result := assembly (a_descriptor)
				end
			else
				found := False
				search_result := Void
			end
		rescue
			retried := True
			support.create_error (error_messages.File_access_failed, error_messages.File_access_failed_message)
			last_error := support.get_last_error
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
			white_space_handling: SYSTEM_XML_WHITESPACEHANDLING
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			dir: SYSTEM_IO_DIRECTORY
			read_lock_filename: STRING
		do
			if not retried then
				create Result.make
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				index_path := reflection_support.Eiffel_delivery_path
				index_path := index_path.Concat_String_String_String_String (index_path, reflection_support.Assemblies_Folder_Path, Index_Filename, Xml_Extension)

				if file.exists (index_path) then
					create xml_reader.make_xmltextreader_10 (index_path)
					xml_reader.set_Whitespace_Handling (white_space_handling.None)
					xml_reader.Read_Start_Element_String (Assemblies_Element)
					last_read_successful := True
					from					
					until
						not xml_reader.get_Name.Equals_String (Assembly_Filename_Element) 
					loop
						assembly_path := xml_reader.read_element_string_string (Assembly_Filename_Element)	
						assembly_path := assembly_path.replace (reflection_support.eiffel_key, reflection_support.Eiffel_delivery_path)
						if dir.exists (assembly_path) then
							if support.Has_Read_Lock (assembly_path) then
								support.create_error_from_info (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
								last_error := support.get_last_error
								last_read_successful := False
							else
								if support.Has_Write_Lock (assembly_path) then
									support.create_error_from_info (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
									last_error := support.get_last_error
									last_read_successful := False		
								else
									read_lock_filename ?= assembly_path.clone
									read_lock_filename := read_lock_filename.Concat_String_String_String (read_lock_filename, "\", support.Read_Lock_Filename)
									read_lock := file.Create_ (read_lock_filename)
									if read_lock = Void then
										support.create_error_from_info (Read_lock_creation_failed_code, error_messages.Read_lock_creation_failed, error_messages.Read_lock_creation_failed_message)
										last_error := support.get_last_error
										last_read_successful := False
									else
										read_lock.Close
										assembly_xml_filename ?= assembly_path.clone
										assembly_xml_filename := assembly_xml_filename.Concat_String_String_String_String (assembly_xml_filename, "\", Dtd_Assembly_Filename, Xml_Extension)
										if file.exists (assembly_xml_filename) then
											an_eiffel_assembly := eiffel_assembly (assembly_xml_filename)
											if an_eiffel_assembly /= Void then
												assembly_added := Result.extend (an_eiffel_assembly)
												last_read_successful := True
											else
												support.create_error (error_messages.No_such_assembly, error_messages.No_such_assembly_message)
												last_error := support.get_last_error
												last_read_successful := False
											end
										else
											support.create_error (error_messages.No_such_assembly, error_messages.No_such_assembly_message)
											last_error := support.get_last_error
											last_read_successful := False										
										end
										file.Delete (read_lock_filename)
									end
									if read_lock_filename /= Void and then file.exists (read_lock_filename) then
										file.Delete (read_lock_filename)
									end
								end
							end
						else
							support.create_error (error_messages.No_such_assembly, error_messages.No_such_assembly_message)
							last_error := support.get_last_error
							last_read_successful := False
						end
					end
					xml_reader.Read_End_Element
					xml_reader.Close
				else
					Result := Void 
					if reflection_support /= Void and then reflection_support.get_last_error /= Void and then reflection_support.get_last_error.get_name.equals_string (error_messages.Registry_key_not_registered) then
						support.create_error (error_messages.Registry_key_not_registered, error_messages.Registry_key_not_registered_message)
					else
						support.create_error (error_messages.No_index, error_messages.No_index_message)
					end
					last_error := support.get_last_error
					last_read_successful := False
				end
			else
				Result := Void
				if reflection_support /= Void and then reflection_support.get_last_error /= Void and then reflection_support.get_last_error.get_name.equals_string (error_messages.Registry_key_not_registered) then
					support.create_error (error_messages.Registry_key_not_registered, error_messages.Registry_key_not_registered_message)
				else
					support.create_error (error_messages.No_assembly, error_messages.No_assembly_message)
				end
				last_error := support.get_last_error
				last_read_successful := False		
				if read_lock_filename /= Void and then file.exists (read_lock_filename) then
					file.Delete (read_lock_filename)
				end
			end
		rescue
			retried := True
			retry
		end
		
	assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ISE_REFLECTION_EIFFELASSEMBLY is
			-- | Generate a `read_lock' file when user starts reading and remove it when reading is over.
			-- | If a read or write lock already exists in the folder access is requested, set `last_read_successful' to False,
			-- | else call `eiffel_assembly' with xml file name and set `last_read_successful' to True.
		indexing
			description: "[
						Retrieve assembly xml description (by using `a_descriptor' to find file location).
						Generate instance of `EIFFEL_ASSEMBLY' from the xml file.
					  ]"
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
			dir: SYSTEM_IO_DIRECTORY 
			read_lock_filename: STRING
		do
			if not retried then
				current_history.search_for_assembly (a_descriptor)
				if current_history.assembly_found then
					Result ?= current_history.search_for_assembly_result
				else				
					create reflection_support.make_reflectionsupport
					reflection_support.Make
					assembly_path := reflection_support.eiffel_delivery_path
					assembly_path := assembly_path.concat_string_string (assembly_path, reflection_support.Assembly_Folder_Path_From_Info (a_descriptor))
					if dir.exists (assembly_path) then				
						if support.Has_Read_Lock (assembly_path) then
							support.create_error_from_info (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
							last_error := support.get_last_error
							last_read_successful := False
						else
							if support.Has_Write_Lock (assembly_path) then
								support.create_error_from_info (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
								last_error := support.get_last_error
								last_read_successful := False		
							else
								read_lock_filename ?= assembly_path.clone
								read_lock_filename := read_lock_filename.Concat_String_String_String (read_lock_filename, "\", support.Read_Lock_Filename)
								read_lock := file.Create_ (read_lock_filename)
								if read_lock = Void then
									support.create_error_from_info (Read_lock_creation_failed_code, error_messages.Read_lock_creation_failed, error_messages.Read_lock_creation_failed_message)
									last_error := support.get_last_error
									last_read_successful := False					
								else
									read_lock.Close					
									assembly_xml_filename := assembly_path.Concat_String_String_String_String (assembly_path, "\", Dtd_Assembly_Filename, Xml_Extension)
									if file.exists (assembly_xml_filename) then
										Result := eiffel_assembly (assembly_xml_filename)
										if Result /= Void then
											current_history.add_assembly (a_descriptor, Result)
											last_read_successful := True
										else
											support.create_error (error_messages.No_such_assembly, error_messages.No_such_assembly_message)
											last_error := support.get_last_error
											last_read_successful := False
										end
									else
										Result := Void
										support.create_error (error_messages.No_such_assembly, error_messages.No_such_assembly_message)
										last_error := support.get_last_error
										last_read_successful := False									
									end
									file.Delete (read_lock_filename)
								end
								if read_lock_filename /= Void and then file.exists (read_lock_filename) then
									file.Delete (read_lock_filename)
								end
							end
						end
					else
						Result := Void
						support.create_error (error_messages.No_such_assembly, error_messages.No_such_assembly_message)
						last_error := support.get_last_error
						last_read_successful := False					
					end
				end
			else
				Result := Void
				if read_lock_filename /= Void and then file.exists (read_lock_filename) then
					file.Delete (read_lock_filename)
				end
				last_read_successful := False
			end
		rescue
			retried := True
			retry
		end
		
	type (a_type: SYSTEM_TYPE): ISE_REFLECTION_EIFFELCLASS is
			-- | Generate a `read_lock' file when user starts reading and remove it when reading is over.
			-- | If a read or write lock already exists in the folder access is requested, set `last_read_successful' to False,
			-- | else call `eiffel_type' with xml file name and set `last_read_successful' to True.
		indexing
			description: "[	
						Retrieve xml file corresponding to `a_type'.
						Generate instance of `EIFFEL_CLASS' from the xml file.
					  ]"
			external_name: "Type"
		require
			non_void_type: a_type /= Void
			non_void_assembly_qualified_name: a_type.get_Assembly_Qualified_Name /= Void
			not_empty_assembly_qualified_name: a_type.get_Assembly_Qualified_Name.get_length > 0
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
			dir: SYSTEM_IO_DIRECTORY
			read_lock_filename: STRING
			is_generic_type: BOOLEAN
			custom_attributes: ARRAY [ANY]
			generic_type_value: STRING
			i: INTEGER
--			a_custom_attribute: EIFFEL_GENERIC_CLASS_NAME_ATTRIBUTE
		do
			if not retried then
				current_history.search_for_type (a_type)
				if current_history.type_found then
					Result ?= current_history.search_for_type_result
				else	
					create reflection_support.make_reflectionsupport
					reflection_support.Make
					a_descriptor := assembly_descriptor_from_type (a_type)
					search (a_descriptor)
					if not found then
						Result := Void
					else
						create formatter.make
						assembly_path := reflection_support.Eiffel_delivery_path
						assembly_path := assembly_path.concat_string_string (assembly_path, reflection_support.Assembly_Folder_Path_From_Info (a_descriptor))
						if dir.exists (assembly_path) then
							if support.Has_Read_Lock (assembly_path) then
								support.create_error_from_info (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
								last_error := support.get_last_error
								last_read_successful := False
							else
								if support.Has_Write_Lock (assembly_path) then
									support.create_error_from_info (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
									last_error := support.get_last_error
									last_read_successful := False		
								else
									read_lock_filename ?= assembly_path.clone
									read_lock_filename := read_lock_filename.Concat_String_String_String (read_lock_filename, "\", support.Read_Lock_Filename)
									read_lock := file.Create_ (read_lock_filename)
									if read_lock = Void then
										support.create_error_from_info (Read_lock_creation_failed_code, error_messages.Read_lock_creation_failed, error_messages.Read_lock_creation_failed_message)
										last_error := support.get_last_error
										last_read_successful := False
									else
										read_lock.Close
										custom_attributes := a_type.get_custom_attributes (False) 
										from
										until
											i = custom_attributes.count or is_generic_type
										loop
										--	a_custom_attribute ?= custom_attributes.item (i)
										--	if a_custom_attribute /= Void then
										--		generic_type_value := a_custom_attribute.get_value
										--		is_generic_type := True
										--	end
											i := i + 1
										end
										if is_generic_type then
											xml_type_filename := assembly_path.Concat_String_String_String_String (assembly_path, "\", formatter.Format_Type_Name (generic_type_value).To_Lower, Xml_Extension)
										else
											xml_type_filename := assembly_path.Concat_String_String_String_String (assembly_path, "\", formatter.Format_Type_Name (a_type.get_Full_Name).To_Lower, Xml_Extension)
										end
										if file.exists (xml_type_filename) then
											Result := eiffel_type (xml_type_filename)
											if Result /= Void then
												current_history.add_type (a_type, Result)
											end
											last_read_successful := True
										else
											Result := Void
											support.create_error (error_messages.No_such_type, error_messages.No_such_type_message)
											last_error := support.get_last_error
											last_read_successful := False										
										end
										file.Delete (read_lock_filename)
									end
								end
							end	
						else
							Result := Void
							support.create_error (error_messages.No_such_type, error_messages.No_such_type_message)
							last_error := support.get_last_error
							last_read_successful := False
						end
					end
				end
			else
				Result := Void
				if read_lock_filename /= Void and then file.exists (read_lock_filename) then
					file.Delete (read_lock_filename)
				end
				last_read_successful := False
			end
		rescue
			retried := True
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
		local
			cache_handler: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER
			retried: BOOLEAN
		do	
			if not retried then
				create cache_handler.make_eiffelassemblycachehandler
				cache_handler.Make_Cache_Handler
				cache_handler.Remove_Assembly (a_descriptor)
			end
		rescue
			retried := True
			support.create_error (error_messages.Assembly_removal_failed, error_messages.Assembly_removal_failed_message)
			last_error := support.get_last_error
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
			not_emtpy_filename: xml_filename.get_length > 0
		local
			file: SYSTEM_IO_FILE
			retried: BOOLEAN
		do
			if not retried then
				if file.exists (xml_filename) then
					Result := support.Eiffel_Assembly_From_Xml (xml_filename)
				else
					Result := Void
				end
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
			not_emtpy_filename: xml_filename.get_length > 0
		local
			retried: BOOLEAN
			file: SYSTEM_IO_FILE
		do
			if not retried then
				if file.exists (xml_filename) then
					Result := support.Eiffel_Class_From_Xml (xml_filename)
				else
					create Result.make1
					Result.make				
				end
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

	current_history: HISTORY is
		indexing
			description: "Current history"
			external_name: "CurrentHistory"
		once
			create Result.make
		end
		
invariant
	found_implies_non_void_search_result: found implies search_result /= Void
	not_found_implies_void_search_result: not found implies search_result = Void

end -- class REFLECTION_INTERFACE
