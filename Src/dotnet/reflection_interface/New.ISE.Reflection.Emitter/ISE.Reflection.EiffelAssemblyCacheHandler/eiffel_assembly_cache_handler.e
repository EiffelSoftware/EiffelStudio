indexing
	description: "Add and remove files from Eiffel/.NET assembly cache."
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	EIFFEL_ASSEMBLY_CACHE_HANDLER
	
inherit
	EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT
	XML_ELEMENTS
		export
			{NONE} all
		end
		
create
	make_cache_handler

feature {NONE} -- Initialization

	make_cache_handler is
		indexing
			description: "Initialize `error_messages'."
		do
			create error_messages
		ensure
			non_void_error_messages: error_messages /= Void
		end

feature -- Access

	last_error: ERROR_INFO
		indexing
			description: "Last error"
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

	Write_lock_creation_failed_code: INTEGER is
		indexing
			description: "Write lock creation error code"
		once
			Result := support.errors_table.errors_table.count
		end
		
	assembly_folder_path: STRING
		indexing
			description: "Folder path of assembly currently stored"
		end
		
feature -- Status Report

	last_write_successful: BOOLEAN
		indexing
			description: "Was last storage successful?"
		end

	last_removal_successful: BOOLEAN
		indexing
			description: "Was last removal successful?"
		end
	
	is_valid_filename (a_filename: STRING): BOOLEAN is
		indexing
			description: "Is `a_filename' a valid filename?"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.count > 0
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make (a_filename)
			Result := file.exists
		end
	
	is_valid_directory_path (a_folder_name: STRING): BOOLEAN is
		indexing
			description: "Is `a_folder_name' a valid directory path"
		require
			non_void_folder_name: a_folder_name /= Void
			not_empty_folder_name: a_folder_name.count > 0
		local
			dir: DIRECTORY
		do
			create dir.make (a_folder_name)
			Result := dir.exists
		end
		
feature -- Basic Operations
		
	store_assembly (an_eiffel_assembly: EIFFEL_ASSEMBLY): TYPE_STORER is 
		indexing
			description: "[
						Store assembly corresponding to `an_eiffel_assembly': 
						Create assembly folder from `an_eiffel_assembly' if it does not exist yet.
					  ]"
		require
			non_void_assembly: an_eiffel_assembly /= Void
			non_void_assembly_descriptor: an_eiffel_assembly.assembly_descriptor /= Void
			non_void_assembly_folder_path: assembly_folder_path /= Void
		local
			dir: DIRECTORY
		do
			eiffel_assembly := an_eiffel_assembly
			assembly_descriptor := eiffel_assembly.assembly_descriptor
			prepare_assembly_storage
			
			create dir.make (assembly_folder_path)
			check
				valid_folder_path: dir.exists
			end
			create Result.make_type_storer (assembly_folder_path)
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
		local
			notifier_handle: NOTIFIER_HANDLE
			notifier:NOTIFIER
			retried: BOOLEAN
		do
			if not retried then
				check
					non_void_assembly: eiffel_assembly /= Void
					non_void_assembly_name: eiffel_assembly.assembly_descriptor /= Void
				end
				--notifier_handle := create {IMPLEMENTATION_NOTIFIER_HANDLE}.make1
				create notifier_handle.make
				notifier := notifier_handle.current_notifier
				notifier.notify_add (assembly_descriptor)

				assembly_folder_path := Void
				assembly_descriptor := Void
				eiffel_assembly := Void
			end
		ensure
			void_eiffel_assembly: eiffel_assembly = Void
			void_assembly_descriptor: assembly_descriptor = Void
			void_assembly_folder_path: assembly_folder_path = Void
		rescue
			retried := True
			retry
		end
		
	remove_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
			-- | Check for write or read lock before removing the assembly.
		indexing
			description: "[
						Remove assembly corresponding to `a_descriptor' from the Eiffel assembly cache.
						Update `last_removal_successful'.
					  ]"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			write_lock_filename:  STRING
			assembly_path:  STRING
			dir: DIRECTORY
			xml_reader: SYSTEM_XML_XML_TEXT_READER
			assembly_folders_list: LINKED_LIST [STRING]
			dtd_path: STRING
			a_folder_name: STRING
			text_writer: SYSTEM_XML_XML_TEXT_WRITER
			--i: INTEGER
			public_string: STRING
			subset: STRING
			file: PLAIN_TEXT_FILE
			index_path: STRING
			path_to_remove: STRING
			write_lock: FILE_STREAM
			notifier_handle: NOTIFIER_HANDLE
			notifier: NOTIFIER
			reflection_support: REFLECTION_SUPPORT
			error_code: INTEGER
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box: WINFORMS_MESSAGE_BOX
			white_space_handling: SYSTEM_XML_WHITESPACE_HANDLING
			formatting: SYSTEM_XML_FORMATTING
			file_mode: FILE_MODE
			ascii_encoding: ASCIIENCODING
		do	
			--reflection_support := create {IMPLEMENTATION_REFLECTION_SUPPORT}.make1
			create reflection_support.make
			
			assembly_path := from_support_string ( reflection_support.Eiffel_delivery_path )
			assembly_path.append ( from_support_string (reflection_support.Assembly_Folder_Path_From_Info ( a_descriptor ) ) )
			if support.has_write_lock ( to_support_string (assembly_path) ) then
				support.create_error_from_info (Has_write_lock_code, to_support_string (error_messages.Has_write_lock), to_support_string (error_messages.Has_write_lock_message) )
				last_error := support.last_error
				last_removal_successful := False
			else
				if support.has_read_lock (assembly_path) then
					support.create_error_from_info (has_read_lock_code, to_support_string (error_messages.has_read_lock), to_support_string (error_messages.has_read_lock_message))
					last_error := support.last_error
					last_removal_successful := False			
				else
					write_lock_filename := assembly_path.clone ( assembly_path )
					write_lock_filename.append ( "\" )
					write_lock_filename.append ( to_support_String (support.write_lock_filename) )
					create file.make (write_lock_filename)
					create write_lock.make_file_stream (write_lock_filename.to_cil, file_mode.open_or_create)
					--:= file.internal_stream
					if write_lock = Void then
						support.create_error_from_info (Write_lock_creation_failed_code, to_support_string (error_messages.Write_lock_creation_failed), to_support_string (error_messages.Write_lock_creation_failed_message))
						last_error := support.last_error
						last_removal_successful := False
					else
						write_lock.close
							-- Delete Write lock
						create file.make ( write_lock_filename )
						file.delete
						
							-- Delete assembly folder.
						create dir.make (assembly_path)
						dir.recursive_delete

							-- Remove assembly folder name from `index.xml'.
						index_path := from_support_string (reflection_support.Eiffel_delivery_path)
						index_path.append ( from_support_string (reflection_support.Assemblies_Folder_Path) )
						index_path.append ( from_support_string (Index_Filename) )
						index_path.append ( from_support_string (Xml_Extension) )
						create file.make (index_path)
						if file.exists then
							create xml_reader.make_system_xml_xml_text_reader_10 ( index_path.to_cil )
							xml_reader.set_whitespace_handling ( white_space_handling.none )
							xml_reader.read_start_element_string ( assemblies_element.to_cil )
							from
								create assembly_folders_list.make
							until
								not xml_reader.get_name.equals ( assembly_filename_element.to_cil )
							loop
								a_folder_name := from_system_string (xml_reader.read_element_string_string ( assembly_filename_element.to_cil ))
								assembly_folders_list.extend (a_folder_name)
							end
							xml_reader.read_end_element
							xml_reader.close

							path_to_remove := assembly_path.clone (assembly_path)
							path_to_remove.replace_substring_all ( from_support_string (reflection_support.Eiffel_delivery_path), from_support_string (reflection_support.Eiffel_key))
							from
								assembly_folders_list.start	
							until
								assembly_folders_list.after
							loop
								if assembly_folders_list.item.is_equal (path_to_remove) then
									assembly_folders_list.Remove
								end
								assembly_folders_list.forth
							end


							if assembly_folders_list.count /= 0 then
								create ascii_encoding.make_asciiencoding
								create text_writer.make_system_xml_xml_text_writer_1 (index_path.to_cil, ascii_encoding)
									-- Set generation options
								text_writer.set_formatting ( formatting.indented )
								text_writer.set_indentation ( 1 )
								text_writer.set_indent_Char ( '%T' )
								text_writer.set_namespaces ( False )
								text_writer.set_quote_char ( '%"' )

									-- Write `<!DOCTYPE ...>
								dtd_path := Index_Filename.clone (Index_Filename)
								dtd_path.append (Dtd_Extension)
								text_writer.write_doc_type ( index_filename.to_cil, Void, dtd_path.to_cil, Void)
									-- <assemblies>
								text_writer.write_start_element ( assemblies_element.to_cil)			
								from
									assembly_folders_list.start
								until
									assembly_folders_list.after
								loop
									a_folder_name ?= assembly_folders_list.item
									if a_folder_name /= Void then
											-- <assembly_folder_name>
										text_writer.write_element_string (assembly_filename_element.to_cil, a_folder_name.to_cil)
									end
									assembly_folders_list.forth
								end
									-- </assemblies>
								text_writer.write_end_element
								text_writer.Close
							else
								create file.make (index_path)
								file.delete
							end
						end
							-- Notify assembly removal
						--notifier_handle := create{IMPLEMENTATION_NOTIFIER_HANDLE}.make1
						create notifier_handle.make
						notifier := notifier_handle.current_notifier
						notifier.notify_remove ( a_descriptor )
						last_removal_successful := True
					end
				end
			end
		rescue
			support.create_error ( to_support_string (error_messages.assembly_removal_failed), to_support_string (error_messages.assembly_removal_failed_message))
			last_error := support.last_error
			if not last_removal_successful then
				error_code := last_error.code
				if error_code = Has_read_lock_code or error_code = Has_write_lock_code then
					returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (Access_violation_error.to_cil, Error_caption.to_cil, message_box_buttons.Abort_retry_ignore, message_box_icon.Error)
					if returned_value = returned_value.Retry_ then
						retry
					elseif returned_value = returned_value.Ignore then
						reflection_support.clean_assembly (a_descriptor)
						retry
					end						
				end
			end
		end
	
	type_storer_from_class (an_eiffel_class: EIFFEL_CLASS): TYPE_STORER is
		indexing
			description: "Type storer for class `an_eiffel_class' (First check there is no lock in assembly folder corresponding to `an_eiffel_class.get_assembly_descriptor'.)"
		require
			non_void_assembly_descriptor: an_eiffel_class.assembly_descriptor /= Void
			non_void_eiffel_class: an_eiffel_class /= Void
		do
			prepare_type_storage (an_eiffel_class.assembly_descriptor)
			check
				non_void_assembly_folder_path: assembly_folder_path /= Void
				not_empty_assembly_folder_path: assembly_folder_path.count > 0
			end
			create Result.make_type_storer (assembly_folder_path)
			assembly_folder_path := Void
		ensure
			type_storer_created: Result /= Void
		end

	update_assembly_description (an_eiffel_assembly: EIFFEL_ASSEMBLY; new_path: STRING) is
		indexing
			description: "Update `assembly_description.xml' by replacing the old Eiffel cluster path by `new_path'."
		require
			non_void_path: new_path /= Void
			not_empty_path: new_path.count > 0
			non_void_eiffel_assembly: an_eiffel_assembly /= Void
			valid_path: is_valid_directory_path (new_path)
		local
			reflection_support: REFLECTION_SUPPORT			
			a_filename: STRING
			types_list: LINKED_LIST [STRING]
			type_filename: STRING
			text_writer: SYSTEM_XML_XML_TEXT_WRITER
			retried: BOOLEAN
			DTD_path: STRING
			public_string: STRING
			subset: STRING
			i: INTEGER
			file: PLAIN_TEXT_FILE 
			formatting: SYSTEM_XML_FORMATTING
			assembly_version: STRING
			assembly_culture: STRING
			assembly_public_key: STRING
			emitter_version_number: STRING
			ascii_encoding: ASCIIENCODING
		do
			if not retried then
				--reflection_support := create {IMPLEMENTATION_REFLECTION_SUPPORT}.make1
				create reflection_support.make
				a_filename := from_support_string (reflection_support.xml_assembly_filename (an_eiffel_assembly.assembly_descriptor))
				a_filename.replace_substring_all (from_support_string (reflection_support.eiffel_key), from_support_string (reflection_support.eiffel_delivery_path))
				
				create file.make (a_filename)
				if file.exists then
					types_list := assembly_types_from_xml (a_filename)	
					file.delete
						-- Write new `assembly_description.xml' with `new_path' as new Eiffel cluster path.
					create ascii_encoding.make_asciiencoding
					create text_writer.make_system_xml_xml_text_writer_1 (a_filename.to_cil, ascii_encoding)

						-- Set generation options
					text_writer.set_formatting ( formatting.indented )
					text_writer.set_indentation ( 1 )
					text_writer.set_indent_Char ( '%T' )
					text_writer.set_namespaces ( False )
					text_writer.set_quote_char ( '%"' )

						-- Write `<?xml version="1.0">
					DTD_path := "../"
					DTD_path.append (Dtd_Assembly_Filename)
					DTD_path.append (Dtd_Extension)
					text_writer.Write_Doc_Type (Dtd_Assembly_Filename.to_cil, Void, DTD_path.to_cil, Void)
						-- <assembly>
					text_writer.write_start_element (assembly_element.to_cil)

						-- <assembly_name>
					text_writer.write_element_string (Assembly_Name_Element.to_cil, an_eiffel_assembly.assembly_descriptor.name.to_cil)
						-- <assembly_version>
					assembly_version := from_component_string (an_eiffel_assembly.assembly_descriptor.version)
					if assembly_version /= Void and then assembly_version.count > 0 then
						text_writer.write_element_string (Assembly_Version_Element.to_cil, assembly_version.to_cil)
					end
						-- <assembly_culture>
					assembly_culture := from_component_string (an_eiffel_assembly.assembly_descriptor.culture)
					if assembly_culture /= Void and then assembly_culture.count > 0 then
						text_writer.write_element_string (Assembly_Culture_Element.to_cil, assembly_culture.to_cil)
					end
						-- <assembly_public_key>
					assembly_public_key := from_component_string (an_eiffel_assembly.assembly_descriptor.public_key)
					if assembly_public_key /= Void and then assembly_public_key.count > 0 then
						text_writer.write_element_string (Assembly_Public_Key_Element.to_cil, assembly_public_key.to_cil)
					end
						-- <eiffel_cluster_path>
					text_writer.write_element_string (Eiffel_Cluster_Path_Element.to_cil, new_path.to_cil)
						-- <emitter_version_number>
					emitter_version_number := from_component_string (an_eiffel_assembly.emitter_version_number)
					if emitter_version_number /= Void and then emitter_version_number.count > 0 then
						text_writer.write_element_string (Emitter_Version_Number_Element.to_cil, emitter_version_number.to_cil)
					end
						-- <assembly_types>
					if types_list.count > 0 then
						text_writer.write_start_element (Assembly_Types_Element.to_cil)
						from
							types_list.start
						until
							types_list.after
						loop
							type_filename ?= types_list.item
							if type_filename /= Void and then type_filename.count > 0 then
								text_writer.write_element_string (assembly_type_filename_element.to_cil, type_filename.to_cil)
							end
							types_list.forth
						end
					end
						-- </assembly>
					text_writer.write_end_element
					text_writer.close	
				end
			end
		rescue
			retried := True
			support.create_error (to_support_string (error_messages.assembly_description_update_failed), to_support_string (error_messages.assembly_description_update_failed_message))
			last_error := support.last_error			
			retry
		end
			
feature {NONE} -- Implementation

	support: CODE_GENERATION_SUPPORT is
		indexing
			description: "Support"
		once
			--create Result.make_codegenerationsupport
			create Result.make
		ensure
			support_created: Result /= Void
		end
		
	error_messages: EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES
		indexing
			description: "Error messages"
		end
		

	eiffel_assembly: EIFFEL_ASSEMBLY--FACTORY
		indexing
			description: "Assembly being stored"
		end
	
	assembly_descriptor: ASSEMBLY_DESCRIPTOR
		indexing
			description: "Assembly descriptor of `eiffel_assembly'"
		end
		
	prepare_assembly_storage is
		indexing
			description: "[
						Prepare type storage: 
						Create assembly folder from `assembly_descriptor' if it does not exist yet,
						create a write lock in this folder, update `index.xml' and generate `assembly_description.xml'.
					  ]"
		local
			dir: DIRECTORY
			file: PLAIN_TEXT_FILE
			assembly_folder: DIRECTORY_INFO
			write_lock: FILE_STREAM
			write_lock_filename: STRING
			retried: BOOLEAN
			reflection_support: REFLECTION_SUPPORT
			error_code: INTEGER
			returned_value: WINFORMS_DIALOG_RESULT
			message_box: WINFORMS_MESSAGE_BOX
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			file_mode : FILE_MODE
		do
			check
				non_void_descriptor: assembly_descriptor /= Void
			end
			--create reflection_support.make_reflectionsupport
			create reflection_support.Make
			assembly_folder_path := from_support_string (reflection_support.eiffel_delivery_path)
			assembly_folder_path.append ( from_support_string (reflection_support.assembly_folder_path_from_info (assembly_descriptor)) )

				-- Check if there is `write_lock' or `a_read_lock' in `assembly_folder_name'.
				-- Set `last_write_successful' and `last_error_info' if needed.
			create dir.make (assembly_folder_path)
			if dir.exists then
				if support.has_write_lock ( to_support_string (assembly_folder_path)) then
					support.create_error_from_info (has_write_lock_code, to_support_string (error_messages.has_write_lock), to_support_string (error_messages.has_write_lock_message))
					last_error := support.last_error
					last_write_successful := False
				else
					if support.Has_Read_Lock ( to_support_string (assembly_folder_path)) then
						support.create_error_from_info (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
						last_error := support.last_error
						last_write_successful := False
					else
						write_lock_filename := assembly_folder_path.clone (assembly_folder_path)
						write_lock_filename.append ("\")
						write_lock_filename.append ( from_support_string (support.Write_Lock_Filename) )
						create file.make (write_lock_filename)
						create write_lock.make_file_stream (write_lock_filename.to_cil, file_mode.open_or_create)
						if write_lock = Void then
							support.create_error_from_info (Write_lock_creation_failed_code, to_support_string (error_messages.Write_lock_creation_failed), to_support_string (error_messages.Write_lock_creation_failed_message))
							last_error := support.last_error
							last_write_successful := False
						else
							write_lock.close
							update_index
							generate_assembly_xml_file
							last_write_successful := True
						end
					end
				end				
			else
				create dir.make (assembly_folder_path)
				dir.create_dir
				if dir.exists then
					write_lock_filename := assembly_folder_path.clone (assembly_folder_path)
					write_lock_filename.append ("\")
					write_lock_filename.append ( from_support_string (support.Write_Lock_Filename) )
					create file.make (write_lock_filename)
					create write_lock.make_file_stream (write_lock_filename.to_cil, file_mode.open_or_create)
					if write_lock = Void then
						support.create_error_from_info (Write_lock_creation_failed_code, from_support_string (error_messages.Write_lock_creation_failed), from_support_string (error_messages.Write_lock_creation_failed_message))
						last_error := support.last_error
						last_write_successful := False
					else
						write_lock.Close
						update_index
						generate_assembly_xml_file
						last_write_successful := True
					end
				else
					support.create_error ( to_support_string (error_messages.Assembly_directory_creation_failed), to_support_string (error_messages.Assembly_directory_creation_failed_message))
					last_error := support.last_error
					last_write_successful := False
				end
			end
		rescue
			support.create_error ( to_support_string (error_messages.Assembly_storage_failed), to_support_string (error_messages.Assembly_storage_failed_message))
			last_error := support.last_error
			if not last_write_successful then
				error_code := last_error.code
				if error_code = Has_read_lock_code or error_code = Has_write_lock_code then
					returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (Access_violation_error.to_cil, Error_caption.to_cil, message_box_buttons.Abort_retry_ignore, message_box_icon.Error)
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
		local
			file: PLAIN_TEXT_FILE
			xml_reader: SYSTEM_XML_XML_TEXT_READER
			assembly_folders_list: LINKED_LIST [STRING]
			an_assembly_folder_name: STRING
			assembly_folder_name_added: INTEGER
			i: INTEGER
			text_writer: SYSTEM_XML_XML_TEXT_WRITER
			public_string: STRING
			dtd_path: STRING
			subset: STRING
			reflection_support: REFLECTION_SUPPORT
			index_path: STRING
			relative_folder_path: STRING
			retried: BOOLEAN
			white_space_handling: expanded SYSTEM_XML_WHITESPACE_HANDLING
			formatting: expanded SYSTEM_XML_FORMATTING
			ascii_encoding: ASCIIENCODING
			test: STRING
			test2: SYSTEM_STRING
		do
			if not retried then
				check
					non_void_assembly_folder_path: assembly_folder_path /= Void
					not_empty_assembly_folder_path: assembly_folder_path.count > 0
				end
				--reflection_support := create {IMPLEMENTATION_REFLECTION_SUPPORT}.make1
				create reflection_support.make

					-- Add `assembly_folder_path' to `index.xml' located in `$EIFFEL\dotnet\assemblies'.
					-- Create `index.xml' if it doesn't already exist.
				index_path := from_support_string (reflection_support.Eiffel_delivery_path)
				index_path.append ( from_support_string (reflection_support.Assemblies_Folder_Path) )
				--index_path.append ( "\" )
				index_path.append ( from_support_string (Index_Filename) )
				index_path.append ( from_support_string (Xml_Extension) )
				create file.make (index_path)
				if file.exists then
					create xml_reader.make_system_xml_xml_text_reader_10 (index_path.to_cil)
					xml_reader.set_whitespace_handling (white_space_handling.none)
					
					xml_reader.read_start_element_String (Assemblies_Element.to_cil)
					from
						create assembly_folders_list.make
					until
						not xml_reader.get_name.equals (Assembly_Filename_Element.to_cil)
					loop
						an_assembly_folder_name := from_system_string ( xml_reader.read_element_string_string (Assembly_Filename_Element.to_cil))
						assembly_folders_list.extend (an_assembly_folder_name)
					end
					xml_reader.Read_End_Element
					xml_reader.Close
					relative_folder_path := assembly_folder_path.clone (assembly_folder_path)
					relative_folder_path.replace_substring_all ( from_support_string (reflection_support.Eiffel_delivery_path), from_support_string (reflection_support.Eiffel_key))
					
					if not assembly_folders_list.has (relative_folder_path) then
						assembly_folders_list.extend (relative_folder_path)				
						create ascii_encoding.make_asciiencoding
						create text_writer.make_system_xml_xml_text_writer_1 (index_path.to_cil, ascii_encoding)
							-- Set generation options
						text_writer.set_Formatting (formatting.indented)
						text_writer.set_Indentation (1)
						text_writer.set_Indent_Char ('%T')
						text_writer.set_Namespaces (False)
						text_writer.set_Quote_Char ('%"')

							-- Write `<!DOCTYPE ...>
						dtd_path := Index_Filename.clone (Index_Filename)
						dtd_path.append (Dtd_Extension)
						test := Index_Filename
						test2 := Index_Filename.to_cil
						text_writer.Write_Doc_Type (Index_Filename.to_cil, Void, dtd_path.to_cil, Void)
							-- <assemblies>
						text_writer.write_start_element (Assemblies_Element.to_cil)
						from
							assembly_folders_list.start
						until
							assembly_folders_list.after
						loop
							an_assembly_folder_name ?= assembly_folders_list.item
							if an_assembly_folder_name /= Void then
									-- <assembly_folder_name>
								text_writer.write_element_string (Assembly_Filename_Element.to_cil, an_assembly_folder_name.to_cil)
							end
							assembly_folders_list.forth
						end
							-- </assemblies>
						text_writer.write_end_element
						text_writer.Close
					end
				else
					create ascii_encoding.make_asciiencoding	
					create text_writer.make_system_xml_xml_text_writer_1 (index_path.to_cil, ascii_encoding)
						-- Set generation options
					text_writer.set_Formatting (formatting.indented)
					text_writer.set_Indentation (1)
					text_writer.set_Indent_Char ('%T')
					text_writer.set_Namespaces (False)
					text_writer.set_Quote_Char ('%"')

						-- Write `<!DOCTYPE ...>
					dtd_path := from_support_string (Index_Filename)
					dtd_path.append ( from_support_string (Dtd_Extension) )
					text_writer.Write_Doc_Type (Index_Filename.to_cil, Void, dtd_path.to_cil, Void)
						-- <assemblies>
					text_writer.write_start_element (Assemblies_Element.to_cil)			
						-- <assembly_folder_name>
					
					assembly_folder_path.replace_substring_all ( from_support_string (reflection_support.Eiffel_delivery_path), to_support_string (reflection_support.Eiffel_Key))
					text_writer.write_element_string (Assembly_Filename_Element.to_cil, assembly_folder_path.to_cil)
						-- </assemblies>
					text_writer.write_end_element
					text_writer.Close
				end
			end
		rescue
			retried := True
			support.create_error (to_support_string (error_messages.Index_update_failed), to_support_string (error_messages.Index_update_failed_message))
			last_error := support.last_error
			retry
		end

	generate_assembly_xml_file is
		indexing
			description: "Generate XML file from `eiffel_assembly'."
		local
			public_string: STRING
			subset: STRING
			reflection_support: REFLECTION_SUPPORT
			filename: STRING
			DTD_path: STRING
			i: INTEGER
			assembly_type: EIFFEL_CLASS
			text_writer: SYSTEM_XML_XML_TEXT_WRITER
			retried: BOOLEAN
			formatting:  SYSTEM_XML_FORMATTING
			ascii_encoding: ASCIIENCODING
			cluster_path: STRING
		do
			if not retried then
				check
					non_void_assembly: eiffel_assembly /= Void
					non_void_assembly_descriptor: eiffel_assembly.assembly_descriptor /= Void
				end
				--reflection_support := create {IMPEMENTATION_REFLECTION_SUPPORT}.make1
				create reflection_support.make

				filename := from_support_string (reflection_support.Xml_Assembly_Filename (assembly_descriptor))
				filename.replace_substring_all ( from_support_string (reflection_support.Eiffel_key), from_support_string (reflection_support.Eiffel_delivery_path))
				create ascii_encoding.make_asciiencoding
				create text_writer.make_system_xml_xml_text_writer_1 (filename.to_cil, ascii_encoding)

					-- Set generation options
				text_writer.set_Formatting (formatting.indented)
				text_writer.set_Indentation (1)
				text_writer.set_Indent_Char ('%T')
				text_writer.set_Namespaces (False)
				text_writer.set_Quote_Char ('%"')

					-- XML generation

					-- Write `<?xml version="1.0">
				DTD_path := "../"
				DTD_path.append ( Dtd_Assembly_Filename )
				DTD_path.append ( Dtd_Extension )
				text_writer.Write_Doc_Type (Dtd_Assembly_Filename.to_cil, Void, DTD_path.to_cil, Void)

					-- <assembly>
				text_writer.write_start_element (Assembly_Element.to_cil)

					-- <assembly_name>
				text_writer.write_element_string (Assembly_Name_Element.to_cil, eiffel_assembly.assembly_descriptor.name.to_cil)

					-- <assembly_version>
				if eiffel_assembly.assembly_descriptor.version /= Void and then eiffel_assembly.assembly_descriptor.version.count > 0 then
					text_writer.write_element_string (Assembly_Version_Element.to_cil, eiffel_assembly.assembly_descriptor.version.to_cil)
				end

					-- <assembly_culture>
				if eiffel_assembly.assembly_descriptor.culture /= Void and then eiffel_assembly.assembly_descriptor.culture.count > 0 then
					text_writer.write_element_string (Assembly_Culture_Element.to_cil, eiffel_assembly.assembly_descriptor.culture.to_cil)
				end

					-- <assembly_public_key>
				if eiffel_assembly.assembly_descriptor.public_key /= Void and then eiffel_assembly.assembly_descriptor.public_key.count > 0 then
					text_writer.write_element_string (Assembly_Public_Key_Element.to_cil, eiffel_assembly.assembly_descriptor.public_key.to_cil)
				end

					-- <eiffel_cluster_path>
				if eiffel_assembly.eiffel_cluster_path /= Void then
					if eiffel_assembly.eiffel_cluster_path.count > 0 then
						text_writer.write_element_string (Eiffel_Cluster_Path_Element.to_cil, eiffel_assembly.eiffel_cluster_path.to_cil)
					end
				end

					-- <emitter_version_number>
				if eiffel_assembly.emitter_version_number /= Void then
					if eiffel_assembly.emitter_version_number.count > 0 then
						text_writer.write_element_string (Emitter_Version_Number_Element.to_cil, eiffel_assembly.emitter_version_number.to_cil)
					end
				end

					-- </assembly>
				text_writer.write_end_element
				text_writer.Close
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.Assembly_description_generation_failed), to_support_string (error_messages.Assembly_description_generation_failed_message))
			last_error := support.last_error
			retry
		end
	
	prepare_type_storage (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		indexing
			description: "[
						Check that the assembly folder corresponding to `an_assembly_descriptor' exist and 
						that there is no sharing violation (no read or write lock).
					  ]"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			reflection_support: REFLECTION_SUPPORT
			dir: DIRECTORY
			file: PLAIN_TEXT_FILE
			assembly_folder: DIRECTORY_INFO
			write_lock: FILE_STREAM
			error_code: INTEGER
			returned_value: WINFORMS_DIALOG_RESULT
			message_box: WINFORMS_MESSAGE_BOX
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			file_mode : FILE_MODE
		do
			--create reflection_support.make_reflectionsupport
			create reflection_support.Make
			assembly_folder_path := from_support_string (reflection_support.Eiffel_delivery_path)
			assembly_folder_path.append ( from_support_String (reflection_support.Assembly_Folder_Path_From_Info (an_assembly_descriptor)) )

				-- Check if there is `write_lock' or `a_read_lock' in `assembly_folder_name'.
				-- Set `last_write_successful' and `last_error_info' if needed.
			create dir.make (assembly_folder_path)
			if dir.Exists then
				if support.Has_Write_Lock ( to_support_string (assembly_folder_path)) then
					support.create_error_from_info (Has_write_lock_code, to_support_string (error_messages.Has_write_lock), to_support_string (error_messages.Has_write_lock_message))
					last_error := support.last_error
					last_write_successful := False
				else
					if support.Has_Read_Lock ( to_support_string (assembly_folder_path)) then
						support.create_error_from_info (Has_read_lock_code, to_support_string (error_messages.Has_read_lock), to_support_string (error_messages.Has_read_lock_message))
						last_error := support.last_error
						last_write_successful := False
					else
						assembly_folder_path.append ("\")
						assembly_folder_path.append ( from_support_string (support.Write_Lock_Filename) )
						create file.make (assembly_folder_path)
						create write_lock.make_file_stream (assembly_folder_path.to_cil, file_mode.open_or_create)
						if write_lock = Void then
							support.create_error_from_info (Write_lock_creation_failed_code, to_support_string (error_messages.Write_lock_creation_failed), to_support_string (error_messages.Write_lock_creation_failed_message))
							last_error := support.last_error
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
			support.create_error (to_support_string (error_messages.Type_storage_failed), to_support_string (error_messages.Type_storage_failed_message))
			last_error := support.last_error
			support.create_error ( to_support_string (error_messages.Assembly_storage_failed), to_support_string (error_messages.Assembly_storage_failed_message))
			last_error := support.last_error
			if not last_write_successful then
				error_code := last_error.code
				if error_code = Has_read_lock_code or error_code = Has_write_lock_code then
					returned_value := message_box.show_string_string_message_box_buttons_message_box_icon (Access_violation_error.to_cil, Error_caption.to_cil, message_box_buttons.Abort_retry_ignore, message_box_icon.Error)
					if returned_value = returned_value.Retry_ then
						retry
					elseif returned_value = returned_value.Ignore then
						reflection_support.clean_assembly (an_assembly_descriptor)
						retry
					end						
				end
			end
		end

	assembly_types_from_xml (xml_filename: STRING): LINKED_LIST [STRING] is
		indexing
			description: "Assembly types from XML file corresponding to `xml_filename'"
		require
			non_void_filename: xml_filename /= Void
			not_empty_filename: xml_filename.count > 0
			valid_filename: is_valid_filename (xml_filename)
		local
			xml_reader: SYSTEM_XML_XML_TEXT_READER
			assembly_name: STRING
			assembly_version: STRING
			assembly_culture: STRING
			assembly_public_key: STRING
			eiffel_cluster_path: STRING
			emitter_version_number: STRING
			a_type_name: STRING
			retried: BOOLEAN
			white_space_handling: SYSTEM_XML_WHITESPACE_HANDLING
		do
			if not retried then
				create xml_reader.make_system_xml_xml_text_reader_10 (xml_filename.to_cil)	
				xml_reader.set_Whitespace_Handling (white_space_handling.none)

				xml_reader.Read_Start_Element_String (Assembly_Element.to_cil)
					-- Set `assembly_name'.
				if xml_reader.get_Name.equals (Assembly_Name_Element.to_cil) then
					assembly_name := from_system_string (xml_reader.Read_Element_String_String (Assembly_Name_Element.to_cil))
				end
					-- Set `assembly_version'.
				if xml_reader.get_Name.equals (Assembly_Version_Element.to_cil) then
					assembly_version := from_system_string (xml_reader.Read_Element_String_String (Assembly_Version_Element.to_cil))
				end
					-- Set `assembly_culture'.
				if xml_reader.get_Name.equals (Assembly_Culture_Element.to_cil) then
					assembly_culture := from_system_string (xml_reader.Read_Element_String_String (Assembly_Culture_Element.to_cil))
				end
					-- Set `assembly_public_key'.
				if xml_reader.get_Name.equals (Assembly_Public_Key_Element.to_cil) then
					assembly_public_key := from_system_string (xml_reader.Read_Element_String_String (Assembly_Public_Key_Element.to_cil))
				end
					-- Set `eiffel_cluster_path'.
				if xml_reader.get_Name.equals (Eiffel_Cluster_Path_Element.to_cil) then
					eiffel_cluster_path := from_system_string (xml_reader.Read_Element_String_String (Eiffel_Cluster_Path_Element.to_cil))
				end
					-- Set `emitter_version_number'.
				if xml_reader.get_Name.equals (Emitter_Version_Number_Element.to_cil) then
					emitter_version_number := from_system_string (xml_reader.Read_Element_String_String (Emitter_Version_Number_Element.to_cil))
				end
				if xml_reader.get_Name.equals (Assembly_Types_Element.to_cil) then
					xml_reader.Read_Start_Element_String (Assembly_Types_Element.to_cil)
					from
						create Result.make
					until
						not xml_reader.get_Name.equals (Assembly_Type_Filename_Element.to_cil)
					loop
						a_type_name := from_system_string ( xml_reader.Read_Element_String_String (Assembly_Type_Filename_Element.to_cil) )
						Result.extend (a_type_name)
					end
					xml_reader.Read_End_Element
				end
				xml_reader.Close
			else
				Result := Void
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.Assembly_description_reading_failed), to_support_string (error_messages.Assembly_description_reading_failed_message))
			last_error := support.last_error
			retry
		end
	
	Error_caption: STRING is "ERROR - ISE Assembly Manager"
		indexing
			description: "Caption for error message boxes"
		end

	Access_violation_error: STRING is "[The Eiffel Assembly Cache is currently accessed by another process. Do you want to force access anyway?%N%N%
						%- Abort: To close this dialog without doing anything.%N%
						%- Retry: To retry in case the other process has exited.%N%
						%- Ignore: To ignore the access violation and force access to the Eiffel Assembly Cache.]"
		indexing
			description: "Message to the user in case there is a write or read lock in the currently accessed assembly folder"
		end

end -- EIFFEL_ASSEMBLY_CACHE_HANDLER
