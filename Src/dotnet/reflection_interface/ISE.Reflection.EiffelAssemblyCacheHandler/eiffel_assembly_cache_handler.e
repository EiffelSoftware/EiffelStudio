indexing
	description: "Add and remove files from Eiffel/.NET assembly cache."
	external_name: "ISE.Reflection.EiffelAssemblyCacheHandler"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	EIFFEL_ASSEMBLY_CACHE_HANDLER
	
inherit
	ISE_REFLECTION_XMLELEMENTS
		export
			{NONE} all
		end
		
create
	make_cache_handler

feature {NONE} -- Initialization

	make_cache_handler is
		indexing
			description: "Initialize `error_messages'."
			external_name: "MakeCacheHandler"
		do
			create error_messages
		ensure
			non_void_error_messages: error_messages /= Void
		end

feature -- Access

	last_error: ISE_REFLECTION_ERRORINFO
		indexing
			description: "Last error"
			external_name: "last_error"
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

	Write_lock_creation_failed_code: INTEGER is
		indexing
			description: "Write lock creation error code"
			external_name: "WriteLockCreationFailedCode"
		once
			Result := support.errors_table.get_errors_table.get_count
		end
		
feature -- Status Report

	last_write_successful: BOOLEAN
		indexing
			description: "Was last storage successful?"
			external_name: "LastWriteSuccessful"
		end

	last_removal_successful: BOOLEAN
		indexing
			description: "Was last removal successful?"
			external_name: "LastRemovalSuccessful"
		end
				
feature -- Basic Operations
		
	store_assembly (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY): TYPE_STORER is --FACTORY): TYPE_STORER is
		indexing
			description: "[
						Store assembly corresponding to `an_eiffel_assembly': 
						Create assembly folder from `an_eiffel_assembly' if it does not exist yet.
					  ]"
			external_name: "StoreAssembly"
		require
			non_void_assembly: an_eiffel_assembly /= Void
			non_void_assembly_name: an_eiffel_assembly.get_assembly_descriptor.get_name /= Void
			not_empty_assembly_name: an_eiffel_assembly.get_assembly_descriptor.get_name.get_length > 0
		do
			eiffel_assembly := an_eiffel_assembly
			assembly_descriptor := eiffel_assembly.get_assembly_descriptor
			prepare_assembly_storage
			create Result.make_type_storer (assembly_folder_path)
			assembly_folder_path := Void
		ensure
			storer_created: Result /= Void
		end

	commit is
		indexing
			description: "[
						Create assembly description file.
						Set `eiffel_assembly' with Void.
						Set `assembly_descriptor' with Void.
					  ]"
			external_name: "Commit"
		local
			notifier_handle: ISE_REFLECTION_NOTIFIERHANDLE
			notifier: ISE_REFLECTION_NOTIFIER
		do
			check
				non_void_assembly: eiffel_assembly /= Void
				non_void_assembly_name: eiffel_assembly.get_assembly_descriptor.get_name /= Void
				not_empty_assembly_name: eiffel_assembly.get_assembly_descriptor.get_name.get_length > 0
			end
			--generate_assembly_xml_file
			create notifier_handle.make1
			notifier := notifier_handle.current_notifier
			notifier.notify_add (assembly_descriptor)
			assembly_descriptor := Void
			eiffel_assembly := Void
		ensure
			void_eiffel_assembly: eiffel_assembly = Void
			void_assembly_descriptor: assembly_descriptor = Void
		end
		
	remove_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
			-- | Check for write or read lock before removing the assembly.
		indexing
			description: "[
						Remove assembly corresponding to `a_descriptor' from the Eiffel assembly cache.
						Update `last_removal_successful'.
					  ]"
			external_name: "RemoveAssembly"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			non_void_assembly_name: a_descriptor.get_name /= Void
			not_empty_assembly_name: a_descriptor.get_name.get_length > 0
		local
			assembly_path: STRING
			dir: SYSTEM_IO_DIRECTORY
			xml_reader: SYSTEM_XML_XMLTEXTREADER
			assembly_folders_list: SYSTEM_COLLECTIONS_ARRAYLIST
			assembly_folder_name_added: INTEGER
			a_folder_name: STRING
			text_writer: SYSTEM_XML_XMLTEXTWRITER
			i: INTEGER
			public_string: STRING
			subset: STRING
			file: SYSTEM_IO_FILE
			index_path: STRING
			path_to_remove: STRING
			write_lock: SYSTEM_IO_FILESTREAM
			notifier_handle: ISE_REFLECTION_NOTIFIERHANDLE
			notifier: ISE_REFLECTION_NOTIFIER
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			error_code: INTEGER
			returned_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
			message_box_icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON
			message_box_buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			white_space_handling: SYSTEM_XML_WHITESPACEHANDLING
			formatting: SYSTEM_XML_FORMATTING
		do	
			create reflection_support.make_reflectionsupport
			reflection_support.make
			assembly_path := reflection_support.Eiffel_delivery_path
			assembly_path := assembly_path.concat_string_string (assembly_path, reflection_support.Assembly_Folder_Path_From_Info (a_descriptor))
			if support.Has_Write_Lock (assembly_path) then
				support.create_error_from_info (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
				last_error := support.get_last_error
				last_removal_successful := False
			else
				if support.Has_Read_Lock (assembly_path) then
					support.create_error_from_info (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
					last_error := support.get_last_error
					last_removal_successful := False			
				else
					write_lock := file.Create_ (assembly_path.Concat_String_String_String (assembly_path, "\", support.Write_Lock_Filename))	
					if write_lock = Void then
						support.create_error_from_info (Write_lock_creation_failed_code, error_messages.Write_lock_creation_failed, error_messages.Write_lock_creation_failed_message)
						last_error := support.get_last_error
						last_removal_successful := False
					else
						write_lock.Close
							-- Delete Write lock
						file.Delete (assembly_path.Concat_String_String_String (assembly_path, "\", support.Write_Lock_Filename))

							-- Delete assembly folder.
						dir.Delete_String_Boolean (assembly_path, True)

							-- Remove assembly folder name from `index.xml'.
						index_path := reflection_support.Eiffel_delivery_path
						index_path := index_path.Concat_String_String_String_String (index_path, reflection_support.Assemblies_Folder_Path, Index_Filename, Xml_Extension)
						create xml_reader.make_xmltextreader_10 (index_path)
						xml_reader.set_Whitespace_Handling (white_space_handling.none)
						xml_reader.Read_Start_Element_String (Assemblies_Element)
						from
							create assembly_folders_list.make
						until
							not xml_reader.get_Name.Equals_String (Assembly_Filename_Element)
						loop
							a_folder_name := xml_reader.Read_Element_String_String (Assembly_Filename_Element)
							assembly_folder_name_added := assembly_folders_list.Add (a_folder_name)
						end
						xml_reader.Read_End_Element
						xml_reader.Close

						path_to_remove := assembly_path.replace (reflection_support.Eiffel_delivery_path, reflection_support.Eiffel_key)
						assembly_folders_list.Remove (path_to_remove)

						if assembly_folders_list.get_count /= 0 then
							create text_writer.make_xmltextwriter_1 (index_path, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)
								-- Set generation options
							text_writer.set_Formatting (formatting.indented)
							text_writer.set_Indentation (1)
							text_writer.set_Indent_Char ('%T')
							text_writer.set_Namespaces (False)
							text_writer.set_Quote_Char ('%"')

								-- Write `<!DOCTYPE ...>
							text_writer.Write_Doc_Type (Index_Filename, public_string, Index_Filename.Concat_String_String (Index_Filename, Dtd_Extension), subset)
								-- <assemblies>
							text_writer.write_start_element (Assemblies_Element)			
							from
							until
								i = assembly_folders_list.get_count
							loop
								a_folder_name ?= assembly_folders_list.get_item (i)
								if a_folder_name /= Void then
										-- <assembly_folder_name>
									text_writer.write_element_string (Assembly_Filename_Element, a_folder_name)
								end
								i := i + 1
							end
								-- </assemblies>
							text_writer.write_end_element
							text_writer.Close
						else
							file.Delete (index_path)
						end

							-- Notify assembly removal
						create notifier_handle.make1
						notifier := notifier_handle.current_notifier
						notifier.Notify_Remove (a_descriptor)
						last_removal_successful := True
					end
				end
			end
		rescue
			support.create_error (error_messages.Assembly_removal_failed, error_messages.Assembly_removal_failed_message)
			last_error := support.get_last_error
			if not last_removal_successful then
				error_code := last_error.get_code
				if error_code = Has_read_lock_code or error_code = Has_write_lock_code then
					returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (Access_violation_error, Error_caption, message_box_buttons.Abort_retry_ignore, message_box_icon.Error)
					if returned_value = returned_value.Retry_ then
						retry
					elseif returned_value = returned_value.Ignore then
						reflection_support.clean_assembly (a_descriptor)
						retry
					end						
				end
			end
		end
	
	replace_type (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; an_eiffel_class: ISE_REFLECTION_EIFFELCLASS): TYPE_STORER is
		indexing
			description: "Replace type corresponding to `an_eiffel_class' in assembly corresponding to `an_assembly_descriptor'."
			external_name: "ReplaceType"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_eiffel_class: an_eiffel_class /= Void
		do
			prepare_type_storage (an_assembly_descriptor)
			create Result.make_type_storer (assembly_folder_path)
			assembly_folder_path := Void
		ensure
			type_storer_created: Result /= Void
		end

	update_assembly_description (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY; new_path: STRING) is
		indexing
			description: "Update `assembly_description.xml' by replacing the old Eiffel cluster path by `new_path'."
			external_name: "UpdateAssemblyDescription"
		require
			non_void_path: new_path /= Void
			not_empty_path: new_path.get_length > 0
			non_void_eiffel_assembly: an_eiffel_assembly /= Void
		local
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT			
			a_filename: STRING
			types_list: SYSTEM_COLLECTIONS_ARRAYLIST
			type_filename: STRING
			text_writer: SYSTEM_XML_XMLTEXTWRITER
			retried: BOOLEAN
			DTD_path: STRING
			public_string: STRING
			subset: STRING
			i: INTEGER
			file: SYSTEM_IO_FILE 
			formatting: SYSTEM_XML_FORMATTING
			assembly_version: STRING
			assembly_culture: STRING
			assembly_public_key: STRING
			emitter_version_number: STRING
		do
			if not retried then
				create reflection_support.make_reflectionsupport
				reflection_support.make
				a_filename := reflection_support.xml_assembly_filename (an_eiffel_assembly.get_assembly_descriptor)
				a_filename := a_filename.replace (reflection_support.Eiffel_key, reflection_support.Eiffel_delivery_path)
				
				types_list := assembly_types_from_xml (a_filename)	
				file.delete (a_filename)
					-- Write new `assembly_description.xml' with `new_path' as new Eiffel cluster path.
				create text_writer.make_xmltextwriter_1 (a_filename, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)

					-- Set generation options
				text_writer.set_Formatting (formatting.indented)
				text_writer.set_Indentation (1)
				text_writer.set_Indent_Char ('%T')
				text_writer.set_Namespaces (False)
				text_writer.set_Quote_Char ('%"')

					-- Write `<?xml version="1.0">
				DTD_path := "..\"
				text_writer.Write_Doc_Type (Dtd_Assembly_Filename, public_string, DTD_path.Concat_String_String_String (DTD_path, Dtd_Assembly_Filename, Dtd_Extension), subset)
					-- <assembly>
				text_writer.write_start_element (Assembly_Element)
				
					-- <assembly_name>
				text_writer.write_element_string (Assembly_Name_Element, an_eiffel_assembly.get_assembly_descriptor.get_name)
					-- <assembly_version>
				assembly_version := an_eiffel_assembly.get_assembly_descriptor.get_version
				if assembly_version /= Void and then assembly_version.get_Length > 0 then
					text_writer.write_element_string (Assembly_Version_Element, assembly_version)
				end
					-- <assembly_culture>
				assembly_culture := an_eiffel_assembly.get_assembly_descriptor.get_culture
				if assembly_culture /= Void and then assembly_culture.get_length > 0 then
					text_writer.write_element_string (Assembly_Culture_Element, assembly_culture)
				end
					-- <assembly_public_key>
				assembly_public_key := an_eiffel_assembly.get_assembly_descriptor.get_public_key
				if assembly_public_key /= Void and then assembly_public_key.get_length > 0 then
					text_writer.write_element_string (Assembly_Public_Key_Element, assembly_public_key)
				end
					-- <eiffel_cluster_path>
				text_writer.write_element_string (Eiffel_Cluster_Path_Element, new_path)
					-- <emitter_version_number>
				emitter_version_number := an_eiffel_assembly.get_emitter_version_number
				if emitter_version_number /= Void and then emitter_version_number.get_length > 0 then
					text_writer.write_element_string (Emitter_Version_Number_Element, emitter_version_number)
				end
					-- <assembly_types>
				if types_list.get_count > 0 then
					text_writer.write_start_element (Assembly_Types_Element)
					from
						i := 0
					until
						i = types_list.get_count
					loop
						type_filename ?= types_list.get_item (i)
						if type_filename /= Void and then type_filename.get_length > 0 then
							text_writer.write_element_string (Assembly_Type_Filename_Element, type_filename)
						end
						i := i + 1
					end
				end
					-- </assembly>
				text_writer.write_end_element
				text_writer.Close	
			end
		rescue
			retried := True
			support.create_error (error_messages.Assembly_description_update_failed, error_messages.Assembly_description_update_failed_message)
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
		
	error_messages: EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES
		indexing
			description: "Error messages"
			external_name: "ErrorMessages"
		end
		
	assembly_folder_path: STRING
		indexing
			description: "Folder path of assembly currently stored"
			external_name: "AssemblyFolderPath"
		end
	
	eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY--FACTORY
		indexing
			description: "Assembly being stored"
			external_name: "EiffelAssembly"
		end
	
	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
		indexing
			description: "Assembly descriptor of `eiffel_assembly'"
			external_name: "AssemblyDescriptor"
		end
		
	prepare_assembly_storage is
		indexing
			description: "[
						Prepare type storage: 
						Create assembly folder from `assembly_descriptor' if it does not exist yet.
					  ]"
			external_name: "PrepareTypeStorage"
		local
			dir: SYSTEM_IO_DIRECTORY
			file: SYSTEM_IO_FILE
			assembly_folder: SYSTEM_IO_DIRECTORYINFO
			write_lock: SYSTEM_IO_FILESTREAM
			retried: BOOLEAN
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			error_code: INTEGER
			returned_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			message_box_icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON
			message_box_buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS
		do
			check
				non_void_descriptor: assembly_descriptor /= Void
				non_void_assembly_name: assembly_descriptor.get_name /= Void
				not_empty_assembly_name: assembly_descriptor.get_name.get_length > 0
			end
			create reflection_support.make_reflectionsupport
			reflection_support.Make
			assembly_folder_path := reflection_support.Eiffel_delivery_path
			assembly_folder_path := assembly_folder_path.concat_string_string (assembly_folder_path, reflection_support.Assembly_Folder_Path_From_Info (assembly_descriptor))

				-- Check if there is `write_lock' or `a_read_lock' in `assembly_folder_name'.
				-- Set `last_write_successful' and `last_error_info' if needed.
			if dir.Exists (assembly_folder_path) then
				if support.Has_Write_Lock (assembly_folder_path) then
					support.create_error_from_info (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
					last_error := support.get_last_error
					last_write_successful := False
				else
					if support.Has_Read_Lock (assembly_folder_path) then
						support.create_error_from_info (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
						last_error := support.get_last_error
						last_write_successful := False
					else
						write_lock := file.Create_ (assembly_folder_path.Concat_String_String_String (assembly_folder_path, "\", support.Write_Lock_Filename))	
						if write_lock = Void then
							support.create_error_from_info (Write_lock_creation_failed_code, error_messages.Write_lock_creation_failed, error_messages.Write_lock_creation_failed_message)
							last_error := support.get_last_error
							last_write_successful := False
						else
							write_lock.Close
							update_index
							generate_assembly_xml_file
							last_write_successful := True
						end
					end
				end				
			else
				assembly_folder := dir.Create_Directory (assembly_folder_path)
				if assembly_folder /= Void then
					write_lock := file.Create_ (assembly_folder_path.Concat_String_String_String (assembly_folder_path, "\", support.Write_Lock_Filename))
					if write_lock = Void then
						support.create_error_from_info (Write_lock_creation_failed_code, error_messages.Write_lock_creation_failed, error_messages.Write_lock_creation_failed_message)
						last_error := support.get_last_error
						last_write_successful := False
					else
						write_lock.Close
						update_index
						generate_assembly_xml_file
						last_write_successful := True
					end
				else
					support.create_error (error_messages.Assembly_directory_creation_failed, error_messages.Assembly_directory_creation_failed_message)
					last_error := support.get_last_error
					last_write_successful := False
				end
			end
		rescue
			support.create_error (error_messages.Assembly_storage_failed, error_messages.Assembly_storage_failed_message)
			last_error := support.get_last_error
			if not last_write_successful then
				error_code := last_error.get_code
				if error_code = Has_read_lock_code or error_code = Has_write_lock_code then
					returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (Access_violation_error, Error_caption, message_box_buttons.Abort_retry_ignore, message_box_icon.Error)
					if returned_value = returned_value.Retry_ then
						retry
					elseif returned_value = returned_value.Ignore then
						reflection_support.clean_assemblies
						retry
					end						
				end
			end
		end			

	update_index is
		indexing
			description: "Add `assembly_folder_name' to `index' located in $EIFFEL\dotnet\assemblies."
			external_name: "UpdateIndex"		
		local
			file: SYSTEM_IO_FILE
			xml_reader: SYSTEM_XML_XMLTEXTREADER
			assembly_folders_list: SYSTEM_COLLECTIONS_ARRAYLIST
			an_assembly_folder_name: STRING
			assembly_folder_name_added: INTEGER
			i: INTEGER
			text_writer: SYSTEM_XML_XMLTEXTWRITER
			public_string: STRING
			subset: STRING
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			index_path: STRING
			relative_folder_path: STRING
			retried: BOOLEAN
			white_space_handling: SYSTEM_XML_WHITESPACEHANDLING
			formatting: SYSTEM_XML_FORMATTING
		do
			if not retried then
				check
					non_void_assembly_folder_path: assembly_folder_path /= Void
					not_empty_assembly_folder_path: assembly_folder_path.get_Length > 0
				end
				create reflection_support.make_reflectionsupport
				reflection_support.make

					-- Add `assembly_folder_path' to `index.xml' located in `$EIFFEL\dotnet\assemblies'.
					-- Create `index.xml' if it doesn't already exist.
				index_path := reflection_support.Eiffel_delivery_path
				index_path := index_path.concat_string_string (index_path, reflection_support.Assemblies_Folder_Path)
				index_path := index_path.Concat_String_String_String_String (index_path, "\", Index_Filename, Xml_Extension)
				if file.Exists (index_path) then
					create xml_reader.make_xmltextreader_10 (index_path)
					xml_reader.set_Whitespace_Handling (white_space_handling.none)
					xml_reader.Read_Start_Element_String (Assemblies_Element)
					from
						create assembly_folders_list.make
					until
						not xml_reader.get_Name.Equals_String (Assembly_Filename_Element)
					loop
						an_assembly_folder_name := xml_reader.read_element_string_string (Assembly_Filename_Element)
						assembly_folder_name_added := assembly_folders_list.Add (an_assembly_folder_name)
					end
					xml_reader.Read_End_Element
					xml_reader.Close
					relative_folder_path := assembly_folder_path.replace (reflection_support.Eiffel_delivery_path, reflection_support.Eiffel_key)
					if not assembly_folders_list.Contains (relative_folder_path) then
						assembly_folder_name_added := assembly_folders_list.Add (relative_folder_path)				
						create text_writer.make_xmltextwriter_1 (index_path, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)
							-- Set generation options
						text_writer.set_Formatting (formatting.indented)
						text_writer.set_Indentation (1)
						text_writer.set_Indent_Char ('%T')
						text_writer.set_Namespaces (False)
						text_writer.set_Quote_Char ('%"')

							-- Write `<!DOCTYPE ...>
						text_writer.Write_Doc_Type (Index_Filename, public_string, Index_Filename.Concat_String_String (Index_Filename, Dtd_Extension), subset)
							-- <assemblies>
						text_writer.write_start_element (Assemblies_Element)			
						from
						until
							i = assembly_folders_list.get_count
						loop
							an_assembly_folder_name ?= assembly_folders_list.get_item (i)
							if an_assembly_folder_name /= Void then
									-- <assembly_folder_name>
								text_writer.write_element_string (Assembly_Filename_Element, an_assembly_folder_name)
							end
							i := i + 1
						end
							-- </assemblies>
						text_writer.write_end_element
						text_writer.Close
					end
				else
					create text_writer.make_xmltextwriter_1 (index_path, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)
						-- Set generation options
					text_writer.set_Formatting (formatting.indented)
					text_writer.set_Indentation (1)
					text_writer.set_Indent_Char ('%T')
					text_writer.set_Namespaces (False)
					text_writer.set_Quote_Char ('%"')

						-- Write `<!DOCTYPE ...>
					text_writer.Write_Doc_Type (Index_Filename, public_string, Index_Filename.Concat_String_String (Index_Filename, Dtd_Extension), subset)
						-- <assemblies>
					text_writer.write_start_element (Assemblies_Element)			
						-- <assembly_folder_name>
					text_writer.write_element_string (Assembly_Filename_Element, assembly_folder_path.replace (reflection_support.Eiffel_delivery_path, reflection_support.Eiffel_Key))
						-- </assemblies>
					text_writer.write_end_element
					text_writer.Close
				end
			end
		rescue
			retried := True
			support.create_error (error_messages.Index_update_failed, error_messages.Index_update_failed_message)
			last_error := support.get_last_error
			retry
		end

	generate_assembly_xml_file is
		indexing
			description: "Generate XML file from `eiffel_assembly'."
			external_name: "GenerateAssemblyXmlFile"
		local
			public_string: STRING
			subset: STRING
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			filename: STRING
			DTD_path: STRING
			assembly_types: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			assembly_type: ISE_REFLECTION_EIFFELCLASS
			text_writer: SYSTEM_XML_XMLTEXTWRITER
			retried: BOOLEAN
			formatting: SYSTEM_XML_FORMATTING
		do
			if not retried then
				check
					non_void_assembly: eiffel_assembly /= Void
					non_void_assembly_name: eiffel_assembly.get_assembly_descriptor.get_name /= Void
					not_empty_assembly_name: eiffel_assembly.get_assembly_descriptor.get_name.get_Length > 0
				end
				create reflection_support.make_reflectionsupport
				reflection_support.Make

				filename := reflection_support.Xml_Assembly_Filename (assembly_descriptor)
				filename := filename.replace (reflection_support.Eiffel_key, reflection_support.Eiffel_delivery_path)
				create text_writer.make_xmltextwriter_1 (filename, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)

					-- Set generation options
				text_writer.set_Formatting (formatting.indented)
				text_writer.set_Indentation (1)
				text_writer.set_Indent_Char ('%T')
				text_writer.set_Namespaces (False)
				text_writer.set_Quote_Char ('%"')

					-- XML generation

					-- Write `<?xml version="1.0">
				DTD_path := "..\"
				text_writer.Write_Doc_Type (Dtd_Assembly_Filename, public_string, DTD_path.Concat_String_String_String (DTD_path, Dtd_Assembly_Filename, Dtd_Extension), subset)

					-- <assembly>
				text_writer.write_start_element (Assembly_Element)

					-- <assembly_name>
				text_writer.write_element_string (Assembly_Name_Element, eiffel_assembly.get_assembly_descriptor.get_name)

					-- <assembly_version>
				if eiffel_assembly.get_assembly_descriptor.get_version /= Void and then eiffel_assembly.get_assembly_descriptor.get_version.get_length > 0 then
					text_writer.write_element_string (Assembly_Version_Element, eiffel_assembly.get_assembly_descriptor.get_version)
				end

					-- <assembly_culture>
				if eiffel_assembly.get_assembly_descriptor.get_culture /= Void and then eiffel_assembly.get_assembly_descriptor.get_culture.get_length > 0 then
					text_writer.write_element_string (Assembly_Culture_Element, eiffel_assembly.get_assembly_descriptor.get_culture)
				end

					-- <assembly_public_key>
				if eiffel_assembly.get_assembly_descriptor.get_public_key /= Void and then eiffel_assembly.get_assembly_descriptor.get_public_key.get_length > 0 then
					text_writer.write_element_string (Assembly_Public_Key_Element, eiffel_assembly.get_assembly_descriptor.get_public_key)
				end

					-- <eiffel_cluster_path>
				if eiffel_assembly.get_eiffel_cluster_path /= Void then
					if eiffel_assembly.get_eiffel_cluster_path.get_length > 0 then
						text_writer.write_element_string (Eiffel_Cluster_Path_Element, eiffel_assembly.get_eiffel_cluster_path)
					end
				end

					-- <emitter_version_number>
				if eiffel_assembly.get_emitter_version_number /= Void then
					if eiffel_assembly.get_emitter_version_number.get_length > 0 then
						text_writer.write_element_string (Emitter_Version_Number_Element, eiffel_assembly.get_emitter_version_number)
					end
				end

					-- <assembly_types>
	--			assembly_types := eiffel_assembly.get_types
	--			if assembly_types /= Void then
	--				if assembly_types.get_count > 0 then
	--					text_writer.write_start_element (Assembly_Types_Element)
	--					from
	--					until
	--						i = assembly_types.get_count
	--					loop
	--						assembly_type ?= assembly_types.get_item (i)
	--						if assembly_type /= Void then
	--							text_writer.write_element_string (Assembly_Type_Filename_Element, reflection_support.Xml_Type_Filename (assembly_type.get_assembly_descriptor, assembly_type.get_full_external_name))
	--						end
	--						i := i + 1
	--					end
	--				end
	--			end

					-- </assembly>
				text_writer.write_end_element
				text_writer.Close
			end
		rescue
			retried := True
			support.create_error (error_messages.Assembly_description_generation_failed, error_messages.Assembly_description_generation_failed_message)
			last_error := support.get_last_error
			retry
		end
	
	prepare_type_storage (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		indexing
			description: "[
						Prepare type storage:
						Create assembly folder from `assembly_descriptor' if it does not exist yet.
					  ]"
			external_name: "PrepareTypeStorage"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			dir: SYSTEM_IO_DIRECTORY
			file: SYSTEM_IO_FILE
			assembly_folder: SYSTEM_IO_DIRECTORYINFO
			write_lock: SYSTEM_IO_FILESTREAM
			error_code: INTEGER
			returned_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			message_box_icon: SYSTEM_WINDOWS_FORMS_MESSAGEBOXICON
			message_box_buttons: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS
		do
			create reflection_support.make_reflectionsupport
			reflection_support.Make
			assembly_folder_path := reflection_support.Eiffel_delivery_path
			assembly_folder_path := assembly_folder_path.concat_string_string (assembly_folder_path, reflection_support.Assembly_Folder_Path_From_Info (an_assembly_descriptor))

				-- Check if there is `write_lock' or `a_read_lock' in `assembly_folder_name'.
				-- Set `last_write_successful' and `last_error_info' if needed.
			if dir.Exists (assembly_folder_path) then
				if support.Has_Write_Lock (assembly_folder_path) then
					support.create_error_from_info (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
					last_error := support.get_last_error
					last_write_successful := False
				else
					if support.Has_Read_Lock (assembly_folder_path) then
						support.create_error_from_info (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
						last_error := support.get_last_error
						last_write_successful := False
					else
						write_lock := file.Create_ (assembly_folder_path.Concat_String_String_String (assembly_folder_path, "\", support.Write_Lock_Filename))	
						if write_lock = Void then
							support.create_error_from_info (Write_lock_creation_failed_code, error_messages.Write_lock_creation_failed, error_messages.Write_lock_creation_failed_message)
							last_error := support.get_last_error
							last_write_successful := False
						else
							write_lock.Close
							last_write_successful := True
						end
					end
				end	
			else
				last_write_successful := False
			end
		rescue
			support.create_error (error_messages.Type_storage_failed, error_messages.Type_storage_failed_message)
			last_error := support.get_last_error
			support.create_error (error_messages.Assembly_storage_failed, error_messages.Assembly_storage_failed_message)
			last_error := support.get_last_error
			if not last_write_successful then
				error_code := last_error.get_code
				if error_code = Has_read_lock_code or error_code = Has_write_lock_code then
					returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (Access_violation_error, Error_caption, message_box_buttons.Abort_retry_ignore, message_box_icon.Error)
					if returned_value = returned_value.Retry_ then
						retry
					elseif returned_value = returned_value.Ignore then
						reflection_support.clean_assembly (an_assembly_descriptor)
						retry
					end						
				end
			end
		end

	assembly_types_from_xml (xml_filename: STRING): SYSTEM_COLLECTIONS_ARRAYLIST is
		indexing
			description: "Assembly types from XML file corresponding to `xml_filename'"
			external_name: "AssemblyTypesFromXml"
		require
			non_void_filename: xml_filename /= Void
			not_empty_filename: xml_filename.get_length > 0
		local
			xml_reader: SYSTEM_XML_XMLTEXTREADER
			assembly_name: STRING
			assembly_version: STRING
			assembly_culture: STRING
			assembly_public_key: STRING
			eiffel_cluster_path: STRING
			emitter_version_number: STRING
			a_type_name: STRING
			added: INTEGER
			retried: BOOLEAN
			white_space_handling: SYSTEM_XML_WHITESPACEHANDLING
		do
			if not retried then
				create xml_reader.make_xmltextreader_10 (xml_filename)	
				xml_reader.set_Whitespace_Handling (white_space_handling.none)

				xml_reader.Read_Start_Element_String (Assembly_Element)
					-- Set `assembly_name'.
				if xml_reader.get_Name.Equals_String (Assembly_Name_Element) then
					assembly_name := xml_reader.Read_Element_String_String (Assembly_Name_Element)
				end
					-- Set `assembly_version'.
				if xml_reader.get_Name.Equals_String (Assembly_Version_Element) then
					assembly_version := xml_reader.Read_Element_String_String (Assembly_Version_Element)
				end
					-- Set `assembly_culture'.
				if xml_reader.get_Name.Equals_String (Assembly_Culture_Element) then
					assembly_culture := xml_reader.Read_Element_String_String (Assembly_Culture_Element)
				end
					-- Set `assembly_public_key'.
				if xml_reader.get_Name.Equals_String (Assembly_Public_Key_Element) then
					assembly_public_key := xml_reader.Read_Element_String_String (Assembly_Public_Key_Element)
				end
					-- Set `eiffel_cluster_path'.
				if xml_reader.get_Name.Equals_String (Eiffel_Cluster_Path_Element) then
					eiffel_cluster_path := xml_reader.Read_Element_String_String (Eiffel_Cluster_Path_Element)
				end
					-- Set `emitter_version_number'.
				if xml_reader.get_Name.Equals_String (Emitter_Version_Number_Element) then
					emitter_version_number := xml_reader.Read_Element_String_String (Emitter_Version_Number_Element)
				end
				if xml_reader.get_Name.Equals_String (Assembly_Types_Element) then
					xml_reader.Read_Start_Element_String (Assembly_Types_Element)
					from
						create Result.make
					until
						not xml_reader.get_Name.Equals_String (Assembly_Type_Filename_Element)
					loop
						a_type_name := xml_reader.Read_Element_String_String (Assembly_Type_Filename_Element)
						added := Result.Add (a_type_name)
					end
					xml_reader.Read_End_Element
				end
				xml_reader.Close
			else
				Result := Void
			end
		rescue
			retried := True
			support.create_error (error_messages.Assembly_description_reading_failed, error_messages.Assembly_description_reading_failed_message)
			last_error := support.get_last_error
			retry
		end
	
	Error_caption: STRING is "ERROR - ISE Assembly Manager"
		indexing
			description: "Caption for error message boxes"
			external_name: "ErrorCaption"
		end

	Access_violation_error: STRING is "[The Eiffel Assembly Cache is currently accessed by another process. Do you want to force access anyway?%N%N%
						%- Abort: To close this dialog without doing anything.%N%
						%- Retry: To retry in case the other process has exited.%N%
						%- Ignore: To ignore the access violation and force access to the Eiffel Assembly Cache.]"
		indexing
			description: "Message to the user in case there is a write or read lock in the currently accessed assembly folder"
			external_name: "AccessViolationError"
		end

end -- EIFFEL_ASSEMBLY_CACHE_HANDLER
