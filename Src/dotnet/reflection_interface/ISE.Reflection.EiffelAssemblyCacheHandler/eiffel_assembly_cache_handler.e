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
			-- Creation routine
		indexing
			external_name: "MakeCacheHandler"
		do
			create error_messages
		ensure
			non_void_error_messages: error_messages /= Void
		end

feature -- Access

	last_error: ISE_REFLECTION_ERRORINFO
			-- Last error
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

	Write_lock_creation_failed_code: INTEGER is
			-- Error code 
		indexing
			external_name: "WriteLockCreationFailedCode"
		once
			Result := support.errorstable.errorstable.count
		end
		
feature -- Status Report

	last_write_successful: BOOLEAN
			-- Was last storage successful?
		indexing
			external_name: "LastWriteSuccessful"
		end

	last_removal_successful: BOOLEAN
			-- Was last removal successful?
		indexing
			external_name: "LastRemovalSuccessful"
		end
				
feature -- Basic Operations
		
	store_assembly (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY): TYPE_STORER is
			-- Store assembly corresponding to `an_eiffel_assembly': 
			-- Create assembly folder from `an_eiffel_assembly' if it does not exist yet.
		indexing
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
			-- Create assembly description file.
			-- Set `eiffel_assembly' with Void.
			-- Set `assembly_descriptor' with Void.
		indexing
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
			-- Remove assembly corresponding to `a_descriptor' from Eiffel/.NET assembly cache.
			-- | Build a string from `a_name', `a_version', `a_culture' and `a_public_key'
			-- | and use hash value to retrieve assembly folder name where `assembly_description.xml' is.
			-- | Check for write or read lock before removing the assembly.
			-- | Update `last_removal_successful'.
		indexing
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
			retry
		end
	
	replace_type (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; an_eiffel_class: ISE_REFLECTION_EIFFELCLASS): TYPE_STORER is
			-- Replace type corresponding to `an_eiffel_class' in assembly corresponding to `an_assembly_descriptor'.
		indexing
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
		
	error_messages: EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES
			-- Error messages
		indexing
			external_name: "ErrorMessages"
		end
		
	assembly_folder_path: STRING
			-- Folder path of assembly currently stored
		indexing
			external_name: "AssemblyFolderPath"
		end
	
	eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY
			-- Assembly being stored
		indexing
			external_name: "EiffelAssembly"
		end
	
	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			-- Assembly descriptor of `eiffel_assembly'.
		indexing
			external_name: "AssemblyDescriptor"
		end
		
	prepare_assembly_storage is
			-- Prepare type storage: 
			-- Create assembly folder from `assembly_descriptor' if it does not exist yet.
		indexing
			external_name: "PrepareTypeStorage"
		local
			dir: SYSTEM_IO_DIRECTORY
			file: SYSTEM_IO_FILE
			assembly_folder: SYSTEM_IO_DIRECTORYINFO
			write_lock: SYSTEM_IO_FILESTREAM
			retried: BOOLEAN
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
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
			end
		rescue
			retried := True
			support.createerror (error_messages.Assembly_storage_failed, error_messages.Assembly_storage_failed_message)
			last_error := support.lasterror
			retry
		end			

	update_index is
			-- Add `assembly_folder_name' to `index' located in $EIFFEL\dotnet\assemblies.
		indexing
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
			-- Generate XML file from `eiffel_assembly'. 
		indexing
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
			-- Prepare type storage: 
			-- Create assembly folder from `assembly_descriptor' if it does not exist yet.
		indexing
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
			retry
		end
		
end -- EIFFEL_ASSEMBLY_CACHE_HANDLER
