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
			external_name: "LastError"
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

	Write_lock_creation_failed_code: INTEGER is
		indexing
			description: "Write lock creation error code"
			external_name: "WriteLockCreationFailedCode"
		once
			Result := support.errorstable.errorstable.count
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
		
	store_assembly (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY): TYPE_STORER is
		indexing
			description: "[Store assembly corresponding to `an_eiffel_assembly': %
					%Create assembly folder from `an_eiffel_assembly' if it does not exist yet.]"
			external_name: "StoreAssembly"
		require
			non_void_assembly: an_eiffel_assembly /= Void
			non_void_assembly_name: an_eiffel_assembly.AssemblyName /= Void
			not_empty_assembly_name: an_eiffel_assembly.AssemblyName.Length > 0
		do
			eiffel_assembly := an_eiffel_assembly
			create assembly_descriptor.make1
			assembly_descriptor.Make (eiffel_assembly.AssemblyName, eiffel_assembly.AssemblyVersion, eiffel_assembly.AssemblyCulture, eiffel_assembly.AssemblyPublicKey)
			prepare_assembly_storage
			create Result.make_type_storer (assembly_folder_path)
			assembly_folder_path := Void
		ensure
			storer_created: Result /= Void
		end

	commit is
		indexing
			description: "[Create assembly description file.%
					%Set `eiffel_assembly' with Void.%
					%Set `assembly_descriptor' with Void.]"
			external_name: "Commit"
		local
			notifier_handle: ISE_REFLECTION_NOTIFIERHANDLE
			notifier: ISE_REFLECTION_NOTIFIER
		do
			check
				non_void_assembly: eiffel_assembly /= Void
				non_void_assembly_name: eiffel_assembly.AssemblyName /= Void
				not_empty_assembly_name: eiffel_assembly.AssemblyName.Length > 0
			end
			generate_assembly_xml_file
			create notifier_handle.make1
			notifier := notifier_handle.currentnotifier
			notifier.notifyadd (assembly_descriptor)
			assembly_descriptor := Void
			eiffel_assembly := Void
		ensure
			void_eiffel_assembly: eiffel_assembly = Void
			void_assembly_descriptor: assembly_descriptor = Void
		end
		
	remove_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
			-- | Check for write or read lock before removing the assembly.
		indexing
			description: "[Remove assembly corresponding to `a_descriptor' from the Eiffel assembly cache.%
					%Update `last_removal_successful'.]"
			external_name: "RemoveAssembly"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			non_void_assembly_name: a_descriptor.Name /= Void
			not_empty_assembly_name: a_descriptor.Name.Length > 0
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
			retried: BOOLEAN
			error_code: INTEGER
		--	reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			returned_value: INTEGER
--			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
		do	
			if not retried then
				create reflection_support.make_reflectionsupport
				reflection_support.make
				assembly_path := reflection_support.Eiffeldeliverypath
				assembly_path := assembly_path.concat_string_string (assembly_path, reflection_support.AssemblyFolderPathFromInfo (a_descriptor))
				if support.HasWriteLock (assembly_path) then
					support.createerrorfrominfo (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
					last_error := support.lasterror
					last_removal_successful := False
				else
					if support.HasReadLock (assembly_path) then
						support.createerrorfrominfo (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
						last_error := support.lasterror
						last_removal_successful := False			
					else
						write_lock := file.Create_ (assembly_path.Concat_String_String_String (assembly_path, "\", support.WriteLockFilename))	
						if write_lock = Void then
						 	support.createerrorfrominfo (Write_lock_creation_failed_code, error_messages.Write_lock_creation_failed, error_messages.Write_lock_creation_failed_message)
						 	last_error := support.lasterror
							last_removal_successful := False
						else
							write_lock.Close
								-- Delete Write lock
							file.Delete (assembly_path.Concat_String_String_String (assembly_path, "\", support.WriteLockFilename))

								-- Delete assembly folder.
							dir.Delete_String_Boolean (assembly_path, True)

								-- Remove assembly folder name from `index.xml'.
							index_path := reflection_support.Eiffeldeliverypath
							index_path := index_path.Concat_String_String_String_String (index_path, reflection_support.AssembliesFolderPath, IndexFilename, XmlExtension)
							create xml_reader.make_xmltextreader_10 (index_path)
								-- WhitespaceHandling = None
							xml_reader.set_WhitespaceHandling (2)
							xml_reader.ReadStartElement_String (AssembliesElement)
							from
								create assembly_folders_list.make
							until
								not xml_reader.Name.Equals_String (AssemblyFilenameElement)
							loop
								a_folder_name := xml_reader.ReadElementString_String (AssemblyFilenameElement)
								assembly_folder_name_added := assembly_folders_list.Add (a_folder_name)
							end
							xml_reader.ReadEndElement
							xml_reader.Close
							
							path_to_remove := assembly_path.replace (reflection_support.Eiffeldeliverypath, reflection_support.Eiffelkey)
							assembly_folders_list.Remove (path_to_remove)
							
							if assembly_folders_list.Count /= 0 then
								create text_writer.make_xmltextwriter_1 (index_path, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)
									-- Set generation options
									-- `1' for `Formatting.Indented'
								text_writer.set_Formatting (1)
								text_writer.set_Indentation (1)
								text_writer.set_IndentChar ('%T')
								text_writer.set_Namespaces (False)
								text_writer.set_QuoteChar ('%"')

									-- Write `<!DOCTYPE ...>
								text_writer.WriteDocType (IndexFilename, public_string, IndexFilename.Concat_String_String (IndexFilename, DtdExtension), subset)
									-- <assemblies>
								text_writer.writestartelement (AssembliesElement)			
								from
								until
									i = assembly_folders_list.Count
								loop
									a_folder_name ?= assembly_folders_list.item (i)
									if a_folder_name /= Void then
											-- <assembly_folder_name>
										text_writer.writeelementstring (AssemblyFilenameElement, a_folder_name)
									end
									i := i + 1
								end
									-- </assemblies>
								text_writer.WriteEndElement
								text_writer.Close
							else
								file.Delete (index_path)
							end

								-- Notify assembly removal
							create notifier_handle.make1
							notifier := notifier_handle.currentnotifier
							notifier.NotifyRemove (a_descriptor)
							last_removal_successful := True
						end
					end
				end
			end
		rescue
			retried := True
			support.createerror (error_messages.Assembly_removal_failed, error_messages.Assembly_removal_failed_message)
			last_error := support.lasterror
			retried := True
			support.createerror (error_messages.Assembly_storage_failed, error_messages.Assembly_storage_failed_message)
			last_error := support.lasterror
			if not last_removal_successful then
				error_code := last_error.code
				if error_code = Has_read_lock_code or error_code = Has_write_lock_code then
					--returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (Access_violation_error, Error_caption, Abort_retry_ignore_message_box_buttons, Error_icon)
					--if returned_value = Retry_result then
					--	retry
					--elseif returned_value = Ignore then
					--	create reflection_interface.make_reflectioninterface
					--	reflection_interface.makereflectioninterface
					--	reflection_interface.cleanassembly (a_descriptor)
					--	retry
					--end						
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
			not_empty_path: new_path.length > 0
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
		do
			if not retried then
				create reflection_support.make_reflectionsupport
				reflection_support.make
				a_filename := reflection_support.xmlassemblyfilename (an_eiffel_assembly.assemblydescriptor)
				a_filename := a_filename.replace (reflection_support.Eiffelkey, reflection_support.Eiffeldeliverypath)
				
				types_list := assembly_types_from_xml (a_filename)	
				file.delete (a_filename)
					-- Write new `assembly_description.xml' with `new_path' as new Eiffel cluster path.
				create text_writer.make_xmltextwriter_1 (a_filename, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)

					-- Set generation options
					-- `1' for `Formatting.Indented'
				text_writer.set_Formatting (1)
				text_writer.set_Indentation (1)
				text_writer.set_IndentChar ('%T')
				text_writer.set_Namespaces (False)
				text_writer.set_QuoteChar ('%"')

					-- Write `<?xml version="1.0">
				DTD_path := "..\"
				text_writer.WriteDocType (DtdAssemblyFilename, public_string, DTD_path.Concat_String_String_String (DTD_path, DtdAssemblyFilename, DtdExtension), subset)
					-- <assembly>
				text_writer.writestartelement (AssemblyElement)
				
					-- <assembly_name>
				text_writer.writeelementstring (AssemblyNameElement, an_eiffel_assembly.AssemblyDescriptor.Name)
					-- <assembly_version>
				if an_eiffel_assembly.AssemblyDescriptor.Version /= Void then
					if an_eiffel_assembly.AssemblyDescriptor.Version.Length > 0 then
						text_writer.writeelementstring (AssemblyVersionElement, an_eiffel_assembly.AssemblyDescriptor.Version)
					end
				end
					-- <assembly_culture>
				if an_eiffel_assembly.AssemblyDescriptor.Culture /= Void then
					if an_eiffel_assembly.AssemblyDescriptor.Culture.Length > 0 then
						text_writer.writeelementstring (AssemblyCultureElement, an_eiffel_assembly.AssemblyDescriptor.Culture)
					end
				end
					-- <assembly_public_key>
				if an_eiffel_assembly.AssemblyDescriptor.PublicKey /= Void then
					if an_eiffel_assembly.AssemblyDescriptor.PublicKey.Length > 0 then
						text_writer.writeelementstring (AssemblyPublicKeyElement, an_eiffel_assembly.AssemblyDescriptor.PublicKey)
					end
				end
					-- <eiffel_cluster_path>
				text_writer.writeelementstring (EiffelClusterPathElement, new_path)
					-- <emitter_version_number>
				if an_eiffel_assembly.EmitterVersionNumber /= Void then
					if an_eiffel_assembly.EmitterVersionNumber.Length > 0 then
						text_writer.writeelementstring (EmitterVersionNumberElement, an_eiffel_assembly.EmitterVersionNumber)
					end
				end
					-- <assembly_types>
				if types_list.Count > 0 then
					text_writer.writestartelement (AssemblyTypesElement)
					from
						i := 0
					until
						i = types_list.Count
					loop
						type_filename ?= types_list.Item (i)
						if type_filename /= Void and then type_filename.length > 0 then
							text_writer.writeelementstring (AssemblyTypeFilenameElement, type_filename)
						end
						i := i + 1
					end
				end
					-- </assembly>
				text_writer.WriteEndElement
				text_writer.Close	
			end
		rescue
			retried := True
			support.createerror (error_messages.Assembly_description_update_failed, error_messages.Assembly_description_update_failed_message)
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
	
	eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY
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
			description: "[Prepare type storage: %
					%Create assembly folder from `assembly_descriptor' if it does not exist yet.]"
			external_name: "PrepareTypeStorage"
		local
			dir: SYSTEM_IO_DIRECTORY
			file: SYSTEM_IO_FILE
			assembly_folder: SYSTEM_IO_DIRECTORYINFO
			write_lock: SYSTEM_IO_FILESTREAM
			retried: BOOLEAN
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			error_code: INTEGER
		--	reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			returned_value: INTEGER
		--	message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
		do
			if not retried then
				check
					non_void_descriptor: assembly_descriptor /= Void
					non_void_assembly_name: assembly_descriptor.Name /= Void
					not_empty_assembly_name: assembly_descriptor.Name.Length > 0
				end
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				assembly_folder_path := reflection_support.Eiffeldeliverypath
				assembly_folder_path := assembly_folder_path.concat_string_string (assembly_folder_path, reflection_support.AssemblyFolderPathFromInfo (assembly_descriptor))

					-- Check if there is `write_lock' or `a_read_lock' in `assembly_folder_name'.
					-- Set `last_write_successful' and `last_error_info' if needed.
				if dir.Exists (assembly_folder_path) then
					if support.HasWriteLock (assembly_folder_path) then
						support.createerrorfrominfo (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
						last_error := support.lasterror
						last_write_successful := False
					else
						if support.HasReadLock (assembly_folder_path) then
							support.createerrorfrominfo (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
							last_error := support.lasterror
							last_write_successful := False
						else
							write_lock := file.Create_ (assembly_folder_path.Concat_String_String_String (assembly_folder_path, "\", support.WriteLockFilename))	
							if write_lock = Void then
								support.createerrorfrominfo (Write_lock_creation_failed_code, error_messages.Write_lock_creation_failed, error_messages.Write_lock_creation_failed_message)
								last_error := support.lasterror
								last_write_successful := False
							else
								write_lock.Close
								update_index
								last_write_successful := True
							end
						end
					end				
				else
					assembly_folder := dir.CreateDirectory (assembly_folder_path)
					if assembly_folder /= Void then
						write_lock := file.Create_ (assembly_folder_path.Concat_String_String_String (assembly_folder_path, "\", support.WriteLockFilename))
						if write_lock = Void then
							support.createerrorfrominfo (Write_lock_creation_failed_code, error_messages.Write_lock_creation_failed, error_messages.Write_lock_creation_failed_message)
							last_error := support.lasterror
							last_write_successful := False
						else
							write_lock.Close
							update_index
							last_write_successful := True
						end
					else
						support.createerror (error_messages.Assembly_directory_creation_failed, error_messages.Assembly_directory_creation_failed_message)
						last_error := support.lasterror
						last_write_successful := False
					end
				end
			else
			end
		rescue
			retried := True
			support.createerror (error_messages.Assembly_storage_failed, error_messages.Assembly_storage_failed_message)
			last_error := support.lasterror
			if not last_write_successful then
				error_code := last_error.code
				--if error_code = Has_read_lock_code or error_code = Has_write_lock_code then
				--	returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (Access_violation_error, Error_caption, Abort_retry_ignore_message_box_buttons, Error_icon)
				--	if returned_value = Retry_result then
				--		retry
				--	elseif returned_value = Ignore then
				--		create reflection_interface.make_reflectioninterface
				--		reflection_interface.makereflectioninterface
				--		reflection_interface.cleanassemblies
				--		retry
				--	end						
				--end
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
		do
			if not retried then
				check
					non_void_assembly_folder_path: assembly_folder_path /= Void
					not_empty_assembly_folder_path: assembly_folder_path.Length > 0
				end
				create reflection_support.make_reflectionsupport
				reflection_support.make

					-- Add `assembly_folder_path' to `index.xml' located in `$EIFFEL\dotnet\assemblies'.
					-- Create `index.xml' if it doesn't already exist.
				index_path := reflection_support.Eiffeldeliverypath
				index_path := index_path.concat_string_string (index_path, reflection_support.AssembliesFolderPath)
				index_path := index_path.Concat_String_String_String_String (index_path, "\", IndexFilename, XmlExtension)
				if file.Exists (index_path) then
					create xml_reader.make_xmltextreader_10 (index_path)
						-- WhitespaceHandling = None
					xml_reader.set_WhitespaceHandling (2)
					xml_reader.ReadStartElement_String (AssembliesElement)
					from
						create assembly_folders_list.make
					until
						not xml_reader.Name.Equals_String (AssemblyFilenameElement)
					loop
						an_assembly_folder_name := xml_reader.ReadElementString_String (AssemblyFilenameElement)
						assembly_folder_name_added := assembly_folders_list.Add (an_assembly_folder_name)
					end
					xml_reader.ReadEndElement
					xml_reader.Close
					relative_folder_path := assembly_folder_path.replace (reflection_support.Eiffeldeliverypath, reflection_support.Eiffelkey)
					if not assembly_folders_list.Contains (relative_folder_path) then
						assembly_folder_name_added := assembly_folders_list.Add (relative_folder_path)				
						create text_writer.make_xmltextwriter_1 (index_path, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)
							-- Set generation options
							-- `1' for `Formatting.Indented'
						text_writer.set_Formatting (1)
						text_writer.set_Indentation (1)
						text_writer.set_IndentChar ('%T')
						text_writer.set_Namespaces (False)
						text_writer.set_QuoteChar ('%"')

							-- Write `<!DOCTYPE ...>
						text_writer.WriteDocType (IndexFilename, public_string, IndexFilename.Concat_String_String (IndexFilename, DtdExtension), subset)
							-- <assemblies>
						text_writer.writestartelement (AssembliesElement)			
						from
						until
							i = assembly_folders_list.Count
						loop
							an_assembly_folder_name ?= assembly_folders_list.item (i)
							if an_assembly_folder_name /= Void then
									-- <assembly_folder_name>
								text_writer.writeelementstring (AssemblyFilenameElement, an_assembly_folder_name)
							end
							i := i + 1
						end
							-- </assemblies>
						text_writer.WriteEndElement
						text_writer.Close
					end
				else
					create text_writer.make_xmltextwriter_1 (index_path, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)
						-- Set generation options
						-- `1' for `Formatting.Indented'
					text_writer.set_Formatting (1)
					text_writer.set_Indentation (1)
					text_writer.set_IndentChar ('%T')
					text_writer.set_Namespaces (False)
					text_writer.set_QuoteChar ('%"')

						-- Write `<!DOCTYPE ...>
					text_writer.WriteDocType (IndexFilename, public_string, IndexFilename.Concat_String_String (IndexFilename, DtdExtension), subset)
						-- <assemblies>
					text_writer.writestartelement (AssembliesElement)			
						-- <assembly_folder_name>
					text_writer.writeelementstring (AssemblyFilenameElement, assembly_folder_path.replace (reflection_support.Eiffeldeliverypath, reflection_support.EiffelKey))
						-- </assemblies>
					text_writer.WriteEndElement
					text_writer.Close
				end
			end
		rescue
			retried := True
			support.createerror (error_messages.Index_update_failed, error_messages.Index_update_failed_message)
			last_error := support.lasterror
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
		do
			if not retried then
				check
					non_void_assembly: eiffel_assembly /= Void
					non_void_assembly_name: eiffel_assembly.AssemblyName /= Void
					not_empty_assembly_name: eiffel_assembly.AssemblyName.Length > 0
				end
				create reflection_support.make_reflectionsupport
				reflection_support.Make

				filename := reflection_support.XmlAssemblyFilename (assembly_descriptor)
				filename := filename.replace (reflection_support.Eiffelkey, reflection_support.Eiffeldeliverypath)
				create text_writer.make_xmltextwriter_1 (filename, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)

					-- Set generation options
					-- `1' for `Formatting.Indented'
				text_writer.set_Formatting (1)
				text_writer.set_Indentation (1)
				text_writer.set_IndentChar ('%T')
				text_writer.set_Namespaces (False)
				text_writer.set_QuoteChar ('%"')

					-- XML generation

					-- Write `<?xml version="1.0">
				DTD_path := "..\"
				text_writer.WriteDocType (DtdAssemblyFilename, public_string, DTD_path.Concat_String_String_String (DTD_path, DtdAssemblyFilename, DtdExtension), subset)

					-- <assembly>
				text_writer.writestartelement (AssemblyElement)

					-- <assembly_name>
				text_writer.writeelementstring (AssemblyNameElement, eiffel_assembly.AssemblyName)

					-- <assembly_version>
				if eiffel_assembly.AssemblyVersion /= Void then
					if eiffel_assembly.AssemblyVersion.Length > 0 then
						text_writer.writeelementstring (AssemblyVersionElement, eiffel_assembly.AssemblyVersion)
					end
				end

					-- <assembly_culture>
				if eiffel_assembly.AssemblyCulture /= Void then
					if eiffel_assembly.AssemblyCulture.Length > 0 then
						text_writer.writeelementstring (AssemblyCultureElement, eiffel_assembly.AssemblyCulture)
					end
				end

					-- <assembly_public_key>
				if eiffel_assembly.AssemblyPublicKey /= Void then
					if eiffel_assembly.AssemblyPublicKey.Length > 0 then
						text_writer.writeelementstring (AssemblyPublicKeyElement, eiffel_assembly.AssemblyPublicKey)
					end
				end

					-- <eiffel_cluster_path>
				if eiffel_assembly.EiffelClusterPath /= Void then
					if eiffel_assembly.EiffelClusterPath.Length > 0 then
						text_writer.writeelementstring (EiffelClusterPathElement, eiffel_assembly.EiffelClusterPath)
					end
				end

					-- <emitter_version_number>
				if eiffel_assembly.EmitterVersionNumber /= Void then
					if eiffel_assembly.EmitterVersionNumber.Length > 0 then
						text_writer.writeelementstring (EmitterVersionNumberElement, eiffel_assembly.EmitterVersionNumber)
					end
				end

					-- <assembly_types>
				assembly_types := eiffel_assembly.Types
				if assembly_types /= Void then
					if assembly_types.Count > 0 then
						text_writer.writestartelement (AssemblyTypesElement)
						from
						until
							i = assembly_types.Count
						loop
							assembly_type ?= assembly_types.Item (i)
							if assembly_type /= Void then
								text_writer.writeelementstring (AssemblyTypeFilenameElement, reflection_support.XmlTypeFilename (assembly_type.assemblydescriptor, assembly_type.FullExternalName))
							end
							i := i + 1
						end
					end
				end

					-- </assembly>
				text_writer.WriteEndElement
				text_writer.Close
			end
		rescue
			retried := True
			support.createerror (error_messages.Assembly_description_generation_failed, error_messages.Assembly_description_generation_failed_message)
			last_error := support.lasterror
			retry
		end
	
	prepare_type_storage (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		indexing
			description: "[Prepare type storage:%
					%Create assembly folder from `assembly_descriptor' if it does not exist yet.]"
			external_name: "PrepareTypeStorage"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			dir: SYSTEM_IO_DIRECTORY
			file: SYSTEM_IO_FILE
			assembly_folder: SYSTEM_IO_DIRECTORYINFO
			write_lock: SYSTEM_IO_FILESTREAM
			retried: BOOLEAN
			error_code: INTEGER
		--	reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			returned_value: INTEGER
		--	message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
		do
			if not retried then
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				assembly_folder_path := reflection_support.Eiffeldeliverypath
				assembly_folder_path := assembly_folder_path.concat_string_string (assembly_folder_path, reflection_support.AssemblyFolderPathFromInfo (an_assembly_descriptor))
				
					-- Check if there is `write_lock' or `a_read_lock' in `assembly_folder_name'.
					-- Set `last_write_successful' and `last_error_info' if needed.
				if dir.Exists (assembly_folder_path) then
					if support.HasWriteLock (assembly_folder_path) then
						support.createerrorfrominfo (Has_write_lock_code, error_messages.Has_write_lock, error_messages.Has_write_lock_message)
						last_error := support.lasterror
						last_write_successful := False
					else
						if support.HasReadLock (assembly_folder_path) then
							support.createerrorfrominfo (Has_read_lock_code, error_messages.Has_read_lock, error_messages.Has_read_lock_message)
							last_error := support.lasterror
							last_write_successful := False
						else
							write_lock := file.Create_ (assembly_folder_path.Concat_String_String_String (assembly_folder_path, "\", support.WriteLockFilename))	
							if write_lock = Void then
								support.createerrorfrominfo (Write_lock_creation_failed_code, error_messages.Write_lock_creation_failed, error_messages.Write_lock_creation_failed_message)
								last_error := support.lasterror
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
			else
				last_write_successful := False
			end
		rescue
			retried := True
			support.createerror (error_messages.Type_storage_failed, error_messages.Type_storage_failed_message)
			last_error := support.lasterror
			retried := True
			support.createerror (error_messages.Assembly_storage_failed, error_messages.Assembly_storage_failed_message)
			last_error := support.lasterror
			if not last_write_successful then
				error_code := last_error.code
				if error_code = Has_read_lock_code or error_code = Has_write_lock_code then
				--	returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (Access_violation_error, Error_caption, Abort_retry_ignore_message_box_buttons, Error_icon)
				--	if returned_value = Retry_result then
				--		retry
				--	elseif returned_value = Ignore then
				--		create reflection_interface.make_reflectioninterface
				--		reflection_interface.makereflectioninterface
				--		reflection_interface.cleanassembly (an_assembly_descriptor)
				--		retry
				--	end						
				end
			end
		end

	assembly_types_from_xml (xml_filename: STRING): SYSTEM_COLLECTIONS_ARRAYLIST is
		indexing
			description: "Assembly types from XML file corresponding to `xml_filename'"
			external_name: "AssemblyTypesFromXml"
		require
			non_void_filename: xml_filename /= Void
			not_empty_filename: xml_filename.length > 0
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
		do
			if not retried then
				create xml_reader.make_xmltextreader_10 (xml_filename)	
					-- WhitespaceHandling = None
				xml_reader.set_WhitespaceHandling (2)

				xml_reader.ReadStartElement_String (AssemblyElement)
					-- Set `assembly_name'.
				if xml_reader.Name.Equals_String (AssemblyNameElement) then
					assembly_name := xml_reader.ReadElementString_String (AssemblyNameElement)
				end
					-- Set `assembly_version'.
				if xml_reader.Name.Equals_String (AssemblyVersionElement) then
					assembly_version := xml_reader.ReadElementString_String (AssemblyVersionElement)
				end
					-- Set `assembly_culture'.
				if xml_reader.Name.Equals_String (AssemblyCultureElement) then
					assembly_culture := xml_reader.ReadElementString_String (AssemblyCultureElement)
				end
					-- Set `assembly_public_key'.
				if xml_reader.Name.Equals_String (AssemblyPublicKeyElement) then
					assembly_public_key := xml_reader.ReadElementString_String (AssemblyPublicKeyElement)
				end
					-- Set `eiffel_cluster_path'.
				if xml_reader.Name.Equals_String (EiffelClusterPathElement) then
					eiffel_cluster_path := xml_reader.ReadElementString_String (EiffelClusterPathElement)
				end
					-- Set `emitter_version_number'.
				if xml_reader.Name.Equals_String (EmitterVersionNumberElement) then
					emitter_version_number := xml_reader.ReadElementString_String (EmitterVersionNumberElement)
				end
				if xml_reader.Name.Equals_String (AssemblyTypesElement) then
					xml_reader.ReadStartElement_String (AssemblyTypesElement)
					from
						create Result.make
					until
						not xml_reader.Name.Equals_String (AssemblyTypeFilenameElement)
					loop
						a_type_name := xml_reader.ReadElementString_String (AssemblyTypeFilenameElement)
						added := Result.Add (a_type_name)
					end
					xml_reader.ReadEndElement
				end
				xml_reader.Close
			else
				Result := Void
			end
		rescue
			retried := True
			support.createerror (error_messages.Assembly_description_reading_failed, error_messages.Assembly_description_reading_failed_message)
			last_error := support.lasterror
			retry
		end
	
	Retry_result: INTEGER is 4
		indexing
			description: "Returned value in case user clicked on `Retry'"
			external_name: "RetryResult"
		end

	Error_caption: STRING is "ERROR - ISE Assembly Manager"
		indexing
			description: "Caption for error message boxes"
			external_name: "ErrorCaption"
		end
	
	Error_icon: INTEGER is 16
		indexing
			description: "Icon for error message boxes"
			external_name: "ErrorIcon"
		end

	Abort_retry_ignore_message_box_buttons: INTEGER is 2
		indexing
			description: "Abort/Retry/Ignore message box buttons"
			external_name: "AbortRetryIgnoreMessageBoxButtons"
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
