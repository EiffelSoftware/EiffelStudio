indexing
	description: "Kind of database where user can put xml files describing types and retrieve a more user-friendly type representation. Apply only for shared assemblies."
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	REFLECTION_INTERFACE
	
inherit
	REFLECTION_INTERFACE_SUPPORT
	XML_ELEMENTS
		export
			{NONE} all
		end
		
create
	make_reflection_interface
	
feature {NONE} -- Initialization

	make_reflection_interface is
		indexing
			description: "Creation routine"
		do
			create error_messages
		ensure
			non_void_error_messages: error_messages /= Void
		end

feature -- Access

	last_error: ERROR_INFO
		indexing
			description: "Last error (either during storage or retrieval)"
		end

	search_result: EIFFEL_ASSEMBLY
		indexing
			description: "Assembly found: Result of `search'"
		end
		
	Has_write_lock_code: INTEGER is
		indexing
			description: "Write lock error code"
		once
			Result := support.errors_table.errors_table.count
		end

	Has_read_lock_code: INTEGER is
		indexing
			description: "Read lock error code"
		once
			Result := support.errors_table.errors_table.count
		end

	Read_lock_creation_failed_code: INTEGER is
		indexing
			description: "Read lock creation error code"
		once
			Result := support.errors_table.errors_table.count
		end

	assembly_descriptor_from_type (a_type: TYPE): ASSEMBLY_DESCRIPTOR is
		indexing	
			description: "Retrieve assembly version, culture and public key from `a_type'."
		require
			non_void_type: a_type /= Void
			non_void_assembly_qualified_name: a_type.get_assembly_qualified_name /= Void
			not_empty_assembly_qualified_name: a_type.get_assembly_qualified_name.get_length > 0
		local
			name: STRING
			version: STRING
			culture: STRING
			public_key: STRING
			assembly_qualified_name: STRING
			full_version: STRING
			full_culture: STRING	
			comma_index: INTEGER
			equals_index: INTEGER
			error: ERROR_INFO
			retried: BOOLEAN
		do
			if not retried then
				assembly_qualified_name := from_system_string ( a_type.get_Assembly_Qualified_Name )
				comma_index := assembly_qualified_name.Index_Of (',', 1)
				if comma_index > -1 then
					assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1, assembly_qualified_name.count)
					assembly_qualified_name.right_adjust
					assembly_qualified_name.left_adjust
					comma_index := assembly_qualified_name.Index_Of (',', 1)
					if comma_index > -1 then
						name := assembly_qualified_name.substring (1, comma_index - 1 )
						assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1, assembly_qualified_name.count)
						assembly_qualified_name.right_adjust
						assembly_qualified_name.left_adjust
						comma_index := assembly_qualified_name.Index_Of (',', 1)
						if comma_index > -1 then
							full_version := assembly_qualified_name.substring (1, comma_index - 1)
							equals_index := full_version.Index_Of ('=', 1)
							if equals_index > -1 then
								version := full_version.substring (equals_index + 1, full_version.count)
								assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1, assembly_qualified_name.count)
								assembly_qualified_name.right_adjust
								assembly_qualified_name.left_adjust
								comma_index := assembly_qualified_name.Index_Of (',', 1)
								if comma_index > -1 then
									full_culture := assembly_qualified_name.substring (1, comma_index - 1)
									equals_index := full_culture.Index_Of ('=', 1)
									if equals_index > -1 then
										culture := full_culture.substring (equals_index + 1, full_culture.count)
										assembly_qualified_name := assembly_qualified_name.substring (comma_index + 1, assembly_qualified_name.count)
										assembly_qualified_name.right_adjust
										assembly_qualified_name.left_adjust
										equals_index := assembly_qualified_name.Index_Of ('=', 1)
										if equals_index > -1 then
											public_key := assembly_qualified_name.substring (equals_index + 1, assembly_qualified_name.count)
											--Result := create {ISE_REFLECTION_EIFFEL_COMPONENTS_IMPLEMENTATION_ASSEMBLY_DESCRIPTOR}.make1
											create Result.make (to_component_string ( name ), to_component_string ( version ), to_component_string ( culture ), to_component_string ( public_key ))	
										end
									end
								end
							end
						end
					end
				end
			else
				create Result.make_empty
			end
		ensure
			assembly_descriptor_created: Result /= Void
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.Invalid_assembly_qualified_name), to_support_string (error_messages.Invalid_assembly_qualified_name_message))
			last_error := support.last_error
			retry
		end
		
feature -- Status Report
		
	last_read_successful: BOOLEAN
		indexing
			description: "Was last retrieval successful?"
		end
	
	found: BOOLEAN
		indexing
			description: "Has assembly been found? (Result of `search')"
		end

feature -- Status Setting

	set_last_error (an_error: like last_error) is
		indexing
			description: "Set `last_error' with `an_error'."
		do
			last_error := an_error
		ensure
			last_error_set: last_error = an_error
		end
		
feature -- Basic Operations

	search (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		indexing
			description: "[
						Search for assembly corresponding to `a_descriptor' in the database.
						Make result available in `found.'
					  ]"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			reflection_support: REFLECTION_SUPPORT
			filename: STRING
			dir: DIRECTORY
			retried: BOOLEAN
			path: PATH
			i,j: INTEGER
			console: SYSTEM_CONSOLE
			
			found2 : BOOLEAN
		do
			if not retried then
				--reflection_support := create {ISE_REFLECTION_SUPPORT_IMPLEMENTATION_REFLECTION_SUPPORT}.make1
				create reflection_support.make
				filename := from_support_string (reflection_support.eiffel_delivery_path)
				filename.append ( from_support_string (reflection_support.assembly_folder_path_from_info ( a_descriptor ) ))
				
				create dir.make ( filename )
				found := dir.exists
				found2 := found
				if found then
					search_result := assembly (a_descriptor)
				end
			else
				found := False
				search_result := Void
			end
		rescue
			retried := True
			support.create_error (to_support_string (error_messages.file_access_failed), to_support_string(error_messages.file_access_failed_message))
			last_error := support.last_error
			retry
		end
		
feature -- Retrieval

	assemblies: LINKED_LIST [EIFFEL_ASSEMBLY] is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_ASSEMBLY]
			-- | For each folder in `$EIFFEL\dotnet\assemblies', check if there is a write or read lock.
			-- | If a lock already exists, set `last_read_successful' to False, else
			-- | call `eiffel_assembly' with assembly description xml file as parameter.
			-- | If no lock has been found, set `last_read_successful' to True.
		indexing
			description: "Assemblies in the data base"
		local
			xml_reader: SYSTEM_XML_XML_TEXT_READER
			index_path: STRING
			assembly_path: STRING
			assembly_xml_filename: STRING
			read_lock: FILE_STREAM
			file: PLAIN_TEXT_FILE
			reflection_support: REFLECTION_SUPPORT
			error: ERROR_INFO
			retried: BOOLEAN
			white_space_handling: SYSTEM_XML_WHITESPACE_HANDLING
			an_eiffel_assembly: EIFFEL_ASSEMBLY
			dir: DIRECTORY
			read_lock_filename: STRING
			file_mode :FILE_MODE
		do
			if not retried then
				--Result := create {ISE_REFLECTION_EIFFEL_COMPONENTS_IMPLEMENTATION_LINKED_LIST_ANY}.make1
				create Result.make
				
				--reflection_support := create {ISE_REFLECTION_SUPPORT_IMPLEMENTATION_REFLECTION_SUPPORT}.make1
				create reflection_support.Make
				index_path := from_support_string ( reflection_support.eiffel_delivery_path )
				index_path.append ( from_support_string (reflection_support.assemblies_folder_path ) )
				index_path.append ( from_support_string (index_filename)  )
				index_path.append ( from_support_string (xml_extension)  )

				create file.make ( index_path )
				if file.exists then
					create xml_reader.make_system_xml_xml_text_reader_10 (index_path.to_cil)
					xml_reader.set_whitespace_handling (white_space_handling.none)
					xml_reader.read_start_element_string (assemblies_element.to_cil)
					last_read_successful := True
					from					
					until
						not xml_reader.get_name.equals(assembly_filename_element.to_cil) 
					loop
						assembly_path := from_system_string  ( xml_reader.read_element_string_string (assembly_filename_element.to_cil) )
						assembly_path.replace_substring_all ( from_support_string (reflection_support.eiffel_key), from_support_string (reflection_support.eiffel_delivery_path) )
						create dir.make ( assembly_path )
						if dir.exists then
							if support.has_read_lock ( to_support_string (assembly_path)) then
								support.create_error_from_info (has_read_lock_code, to_support_string (error_messages.has_read_lock), to_support_string (error_messages.has_read_lock_message))
								last_error := support.last_error
								last_read_successful := False
							else
								if support.has_write_lock (assembly_path) then
									support.create_error_from_info (has_write_lock_code, to_support_string (error_messages.has_write_lock), to_support_string (error_messages.has_write_lock_message))
									last_error := support.last_error
									last_read_successful := False		
								else
									read_lock_filename := assembly_path.clone (assembly_path)
									read_lock_filename.append ( "\" )
									read_lock_filename.append ( from_support_string (support.read_lock_filename) )
									
									create file.make ( read_lock_filename )
									create read_lock.make_file_stream (read_lock_filename.to_cil, file_mode.open_or_create)
									if read_lock = Void then
										support.create_error_from_info ( read_lock_creation_failed_code, to_support_string (error_messages.read_lock_creation_failed), to_support_string (error_messages.read_lock_creation_failed_message))
										last_error := support.last_error
										last_read_successful := False
									else
										read_lock.Close
										assembly_xml_filename := assembly_path.clone (assembly_path)
										assembly_xml_filename.append ( "\" )
										assembly_xml_filename.append ( from_support_string (dtd_assembly_filename) )
										assembly_xml_filename.append ( from_support_string (xml_extension) )
										create file.make ( assembly_xml_filename )
										if file.exists then
											an_eiffel_assembly := eiffel_assembly ( assembly_xml_filename)
											if an_eiffel_assembly /= Void then
												Result.extend (an_eiffel_assembly)
												last_read_successful := True
											else
												support.create_error (to_support_string (error_messages.no_such_assembly), to_support_string (error_messages.no_such_assembly_message))
												last_error := support.last_error
												last_read_successful := False
											end
										else
											support.create_error (to_support_string (error_messages.no_such_assembly), to_support_string (error_messages.no_such_assembly_message))
											last_error := support.last_error
											last_read_successful := False										
										end
										create file.make (read_lock_filename)
										file.delete 
									end
									create file.make ( from_support_string (read_lock_filename))
									if read_lock_filename /= Void and then file.exists then
										file.delete
									end
								end
							end
						else
							support.create_error ( to_support_string (error_messages.no_such_assembly), to_support_string (error_messages.no_such_assembly_message))
							last_error := support.last_error
							last_read_successful := False
						end
					end
					xml_reader.read_end_element
					xml_reader.close
				else
					Result := Void 
					if reflection_support /= Void and then reflection_support.last_error /= Void and then reflection_support.last_error.name.is_equal ( to_support_string (error_messages.registry_key_not_registered)) then
						support.create_error (to_support_string (error_messages.registry_key_not_registered), to_support_string(error_messages.registry_key_not_registered_message))
					else
						support.create_error (to_support_string(error_messages.no_index), to_support_string (error_messages.no_index_message))
					end
					last_error := support.last_error
					last_read_successful := False
				end
			else
				Result := Void
				if reflection_support /= Void and then reflection_support.last_error /= Void and then reflection_support.last_error.name.is_equal ( to_support_string (error_messages.registry_key_not_registered)) then
					support.create_error (to_support_string (error_messages.registry_key_not_registered), to_support_string(error_messages.registry_key_not_registered_message))
				else
					support.create_error (to_support_string (error_messages.no_assembly), to_support_string (error_messages.no_assembly_message))
				end
				last_error := support.last_error
				last_read_successful := False
				create file.make ( from_support_string (read_lock_filename))
				if read_lock_filename /= Void and then file.exists then
					file.delete
				end
			end
		rescue
			retried := True
			retry
		end
		
	assembly (a_descriptor: ASSEMBLY_DESCRIPTOR): EIFFEL_ASSEMBLY is
			-- | Generate a `read_lock' file when user starts reading and remove it when reading is over.
			-- | If a read or write lock already exists in the folder access is requested, set `last_read_successful' to False,
			-- | else call `eiffel_assembly' with xml file name and set `last_read_successful' to True.
		indexing
			description: "[
						Retrieve assembly xml description (by using `a_descriptor' to find file location).
						Generate instance of `EIFFEL_ASSEMBLY' from the xml file.
					  ]"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			assembly_path: STRING
			assembly_xml_filename: STRING
			read_lock: FILE_STREAM
			file: PLAIN_TEXT_FILE
			reflection_support: REFLECTION_SUPPORT
			error: ERROR_INFO
			retried: BOOLEAN
			dir: DIRECTORY 
			read_lock_filename: STRING
			file_mode : FILE_MODE
		do
			if not retried then
				current_history.search_for_assembly (a_descriptor)
				if current_history.assembly_found then
					Result ?= current_history.search_for_assembly_result
				else				
					--reflection_support := create {ISE_REFLECTION_SUPPORT_REFLECTION_SUPPORT}.make1
					create reflection_support.make
					
					assembly_path := reflection_support.eiffel_delivery_path
					assembly_path.append (reflection_support.assembly_folder_path_from_info (a_descriptor))
					create dir.make (assembly_path)
					if dir.exists then				
						if support.has_read_lock (assembly_path) then
							support.create_error_from_info (has_read_lock_code, error_messages.has_read_lock, error_messages.has_read_lock_message)
							last_error := support.last_error
							last_read_successful := False
						else
							if support.has_write_lock (assembly_path) then
								support.create_error_from_info (has_write_lock_code, error_messages.has_write_lock, error_messages.has_write_lock_message)
								last_error := support.last_error
								last_read_successful := False		
							else
								read_lock_filename := from_system_string (assembly_path.to_cil)
								read_lock_filename.append ( "\" )
								read_lock_filename.append ( create {STRING}.make_from_cil (support.read_lock_filename.to_cil ))
								create read_lock.make_file_stream (read_lock_filename.to_cil, file_mode.open_or_create)
								if read_lock = Void then
									support.create_error_from_info (read_lock_creation_failed_code, error_messages.read_lock_creation_failed, error_messages.read_lock_creation_failed_message)
									last_error := support.last_error
									last_read_successful := False					
								else
									read_lock.Close
									assembly_xml_filename := assembly_path.clone ( assembly_path )
									assembly_xml_filename.append ( "\" )
									assembly_xml_filename.append ( dtd_assembly_filename )
									assembly_xml_filename.append ( xml_extension )
									create file.make (assembly_xml_filename)
									if file.exists then
										Result := eiffel_assembly (assembly_xml_filename)
										if Result /= Void then
											current_history.add_assembly (a_descriptor, Result)
											last_read_successful := True
										else
											support.create_error (error_messages.no_such_assembly, error_messages.no_such_assembly_message)
											last_error := support.last_error
											last_read_successful := False
										end
									else
										Result := Void
										support.create_error (error_messages.no_such_assembly, error_messages.no_such_assembly_message)
										last_error := support.last_error
										last_read_successful := False									
									end
									create file.make (read_lock_filename)
									file.delete 
								end
								create file.make (read_lock_filename)
								if read_lock_filename /= Void and then file.exists then
									file.delete 
								end
							end
						end
					else
						Result := Void
						support.create_error (error_messages.no_such_assembly, error_messages.no_such_assembly_message)
						last_error := support.last_error
						last_read_successful := False					
					end
				end
			else
				Result := Void
				create file.make (read_lock_filename)
				if read_lock_filename /= Void and then file.exists then
					file.delete
				end
				last_read_successful := False
			end
		rescue
			retried := True
			retry
		end
		
	type (a_type: TYPE): EIFFEL_CLASS is
			-- | Generate a `read_lock' file when user starts reading and remove it when reading is over.
			-- | If a read or write lock already exists in the folder access is requested, set `last_read_successful' to False,
			-- | else call `eiffel_type' with xml file name and set `last_read_successful' to True.
		indexing
			description: "[	
						Retrieve xml file corresponding to `a_type'.
						Generate instance of `EIFFEL_CLASS' from the xml file.
					  ]"
		require
			non_void_type: a_type /= Void
			non_void_assembly_qualified_name: a_type.get_Assembly_Qualified_Name /= Void
			not_empty_assembly_qualified_name: a_type.get_Assembly_Qualified_Name.get_length > 0
		local
			a_descriptor: ASSEMBLY_DESCRIPTOR
			assembly_path: STRING
			xml_type_filename: STRING
			read_lock: FILE_STREAM
			file: PLAIN_TEXT_FILE
			formatter: FORMATTER
			reflection_support: REFLECTION_SUPPORT
			error: ERROR_INFO
			retried: BOOLEAN
			dir: DIRECTORY
			read_lock_filename: STRING
			is_generic_type: BOOLEAN
			custom_attributes: ARRAY [ANY]
			generic_type_value: STRING
			i: INTEGER
			file_mode : FILE_MODE
			console: SYSTEM_CONSOLE
--			a_custom_attribute: EIFFEL_GENERIC_CLASS_NAME_ATTRIBUTE
		do
			if not retried then
				current_history.search_for_type (a_type)
				if current_history.type_found then
					Result ?= current_history.search_for_type_result
				else	
					--reflection_support := create {ISE_REFLECTION_SUPPOT_REFLECTION_IMPLEMENTATION_SUPPORT}.make1
					create reflection_support.make
					a_descriptor := assembly_descriptor_from_type (a_type)
					search (a_descriptor)
					if not found then
						Result := Void
					else
						create formatter.make
						assembly_path := from_support_string (reflection_support.eiffel_delivery_path)
						assembly_path.append ( from_support_string (reflection_support.assembly_folder_path_from_info (a_descriptor)))
						create dir.make (assembly_path)
						if dir.exists then
							if support.has_read_lock ( to_support_string (assembly_path)) then
								support.create_error_from_info (has_read_lock_code, to_support_string (error_messages.has_read_lock), to_support_string (error_messages.has_read_lock_message))
								last_error := support.last_error
								last_read_successful := False
							else
								if support.Has_Write_Lock ( to_support_string (assembly_path)) then
									support.create_error_from_info (Has_write_lock_code, to_support_string (error_messages.Has_write_lock), to_support_string (error_messages.Has_write_lock_message))
									last_error := support.last_error
									last_read_successful := False		
								else
									read_lock_filename := assembly_path.clone (assembly_path)
									read_lock_filename.append ( "\" )
									read_lock_filename.append ( from_support_string (support.read_lock_filename))
									create file.make (read_lock_filename)
									create read_lock.make_file_stream (read_lock_filename.to_cil, file_mode.open_or_create)
									if read_lock = Void then
										support.create_error_from_info (read_lock_creation_failed_code, to_support_string (error_messages.read_lock_creation_failed), to_support_string (error_messages.read_lock_creation_failed_message))
										last_error := support.last_error
										last_read_successful := False
									else
										read_lock.close
										--custom_attributes := a_type.get_custom_attributes (False) 
										--from
										--until
										--	i = custom_attributes.count or is_generic_type
										--loop
										--	a_custom_attribute ?= custom_attributes.item (i)
										--	if a_custom_attribute /= Void then
										--		generic_type_value := a_custom_attribute.get_value
										--		is_generic_type := True
										--	end
										--	i := i + 1
										--end
										if is_generic_type then
											--assembly_path.append ( "\" )
											--assembly_path.append ( from_system_string ( formatter.Format_Type_Name (generic_type_value.to_cil).To_Lower) )
											--assembly_path.append ( from_support_string ( xml_extension ))
											--xml_type_filename := assembly_path.clone ( assembly_path )
										else
											assembly_path.append ( "\" )
											--assembly_path.append ( from_system_string ( formatter.Format_Type_Name (a_type.get_Full_Name).To_Lower) )
											assembly_path.append ( from_system_string ( formatter.Format_Type_Name (a_type).To_Lower) )
											assembly_path.append ( from_support_string ( xml_extension ))
											xml_type_filename := assembly_path.clone ( assembly_path )
										end
										
										create file.make (xml_type_filename)
										if file.exists then
											Result := eiffel_type (xml_type_filename)
											if Result /= Void then
												current_history.add_type (a_type, Result)
											end
											last_read_successful := True
										else
											Result := Void
											support.create_error ( to_support_string (error_messages.no_such_type), to_support_string (error_messages.no_such_type_message))
											last_error := support.last_error
											last_read_successful := False										
										end
										
										create file.make (read_lock_filename)
										file.delete 
									end
								end
							end	
						else
							Result := Void
							support.create_error (error_messages.no_such_type, error_messages.no_such_type_message)
							last_error := support.last_error
							last_read_successful := False
						end
					end
				end
			else
				Result := Void
				create file.make (read_lock_filename)
				if read_lock_filename /= Void and then file.exists  then
					file.delete 
				end
				last_read_successful := False
			end
		rescue
			retried := True
			retry
		end

feature -- Removal
	
	remove_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
			-- | Build a string from `a_descriptor'
			-- | and use hash value to retrieve assembly folder name where `assembly_description.xml' is.
			-- | Check for write or read lock before removing the assembly.
			-- | Update `last_removal_successful'.
		indexing
			description: "Remove assembly corresponding to `a_descriptor' from the database."
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			cache_handler: EIFFEL_ASSEMBLY_CACHE_HANDLER
			retried: BOOLEAN
		do	
			if not retried then
				--create cache_handler := {ISE_REFLECTION_ASSEMBLY_CACHE_HANDLER_IMPLEMENTATION_EIFFEL_ASSEMBLY_CACHE_HANDLER}.make1
				create cache_handler.make_cache_handler
				cache_handler.remove_assembly (a_descriptor)
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.Assembly_removal_failed), to_support_string (error_messages.Assembly_removal_failed_message))
			last_error := support.last_error
			retry
		end
	
feature {NONE} -- Implementation

	support: CODE_GENERATION_SUPPORT is
		indexing
			description: "Support"
		once
			--Result := {ISE_REFLECTION_SUPPORT_IMPLEMENTATION_CODE_GENERATION_SUPPORT}.make1
			create Result.make
		ensure
			support_created: Result /= Void
		end
		
	error_messages: REFLECTION_INTERFACE_ERROR_MESSAGES
		indexing
			description: "Error messages"
		end
					
	eiffel_assembly (xml_filename: STRING): EIFFEL_ASSEMBLY is
		indexing
			description: "Generate instance of `EIFFEL_ASSEMBLY' from `xml_filename'."
		require
			non_void_filename: xml_filename /= Void
			not_emtpy_filename: xml_filename.count > 0
		local
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create file.make ( xml_filename )
				if file.exists then
					Result := support.eiffel_assembly_from_xml ( to_support_string ( xml_filename ) )
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
	
	eiffel_type (xml_filename: STRING): EIFFEL_CLASS is
		indexing
			description: "Generate instance of `EIFFEL_CLASS' from `xml_filename'."
		require
			non_void_filename: xml_filename /= Void
			not_emtpy_filename: xml_filename.count > 0
		local
			retried: BOOLEAN
			file: PLAIN_TEXT_FILE
		do
			if not retried then
				create file.make ( xml_filename )
				if file.exists then
					Result := support.eiffel_class_from_xml ( to_support_string ( xml_filename ) )
				else
					--Result := create {ISE_REFLECTION_EIFFEL_COMPONENTS_IMPLEMENTATION_EIFFEL_CLASS}.make1
					create Result.make				
				end
			else
				--Result := create {ISE_REFLECTION_EIFFEL_COMPONENTS_IMPLEMENTATION_EIFFEL_CLASS}.make1
				create Result.make
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
		once
			create Result.make
		end
		
invariant
	found_implies_non_void_search_result: found implies search_result /= Void
	not_found_implies_void_search_result: not found implies search_result = Void

end -- class REFLECTION_INTERFACE
