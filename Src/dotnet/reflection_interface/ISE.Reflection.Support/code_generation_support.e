indexing
	description: "Provide support for code generation."
	external_name: "ISE.Reflection.CodeGenerationSupport"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	CODE_GENERATION_SUPPORT
	
inherit
	SUPPORT
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		indexing
			external_name: "Make"
		do
			create error_messages
			create xml_elements
		ensure
			non_void_error_messages: error_messages /= Void
			non_void_xml_elements: xml_elements /= Void
		end

feature -- Access				
		
	Write_lock_filename: STRING is "write_lock.txt"
			-- Read lock filename
		indexing
			external_name: "WriteLockFilename"
		end
		
	Read_lock_filename: STRING is "read_lock.txt"
			-- Read lock filename
		indexing
			external_name: "ReadLockFilename"
		end

	eiffel_class_from_xml (a_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
			-- Instance of `eiffel_class' corresponding to Xml file with filename `a_filename'.
		indexing
			external_name: "EiffelClassFromXml"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.Length > 0
		local
			retried: BOOLEAN
		do
			if not retried then
				create type_description.make_xmltextreader_10 (a_filename)
					-- WhitespaceHandling = None
				type_description.set_WhitespaceHandling (2)

				create eiffel_class.make1
				eiffel_class.Make
				type_description.ReadStartElement_String (xml_elements.Class_element)
				generate_class_header
				generate_class_body
				if type_description.Name.Equals_String (xml_elements.Footer_element) then
					generate_class_footer
				end
				type_description.Close
				Result := eiffel_class
				eiffel_class := Void
			else
				create Result.make1
				Result.make
			end
		ensure
			non_void_eiffel_class: Result /= Void
		rescue
			retried := True
			create_error (error_messages.Eiffel_class_generation_failed, error_messages.Eiffel_class_generation_failed_message)
			retry
		end	

	eiffel_assembly_from_xml (a_filename: STRING): EIFFEL_ASSEMBLY is
			-- Instance of `eiffel_assembly' corresponding to Xml file with filename `a_filename'.
		indexing
			external_name: "EiffelAssemblyFromXml"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.Length > 0
		local
			assembly_description: SYSTEM_XML_XMLTEXTREADER
			assembly_name: STRING
			assembly_version: STRING
			assembly_culture: STRING
			assembly_public_key: STRING
			eiffel_cluster_path: STRING
			emitter_version_number: STRING
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			retried: BOOLEAN
		do
			if not retried then
				create assembly_description.make_xmltextreader_10 (a_filename)	
					-- WhitespaceHandling = None
				assembly_description.set_WhitespaceHandling (2)
				
				assembly_description.ReadStartElement_String (xml_elements.Assembly_element)

					-- Set `assembly_name'.
				if assembly_description.Name.Equals_String (xml_elements.Assembly_name_element) then
					assembly_name := assembly_description.ReadElementString_String (xml_elements.Assembly_name_element)
				end

					-- Set `assembly_version'.
				if assembly_description.Name.Equals_String (xml_elements.Assembly_version_element) then
					assembly_version := assembly_description.ReadElementString_String (xml_elements.Assembly_version_element)
				end

					-- Set `assembly_culture'.
				if assembly_description.Name.Equals_String (xml_elements.Assembly_culture_element) then
					assembly_culture := assembly_description.ReadElementString_String (xml_elements.Assembly_culture_element)
				end

					-- Set `assembly_public_key'.
				if assembly_description.Name.Equals_String (xml_elements.Assembly_public_key_element) then
					assembly_public_key := assembly_description.ReadElementString_String (xml_elements.Assembly_public_key_element)
				end

					-- Set `eiffel_cluster_path'.
				if assembly_description.Name.Equals_String (xml_elements.Eiffel_cluster_path_element) then
					eiffel_cluster_path := assembly_description.ReadElementString_String (xml_elements.Eiffel_cluster_path_element)
				end

				-- Set `emitter_version_number'.
				if assembly_description.Name.Equals_String (xml_elements.Emitter_version_number_element) then
					emitter_version_number := assembly_description.ReadElementString_String (xml_elements.Emitter_version_number_element)
				end
				create a_descriptor.make1
				a_descriptor.make (assembly_name, assembly_version, assembly_culture, assembly_public_key)
				create Result.make (a_descriptor, eiffel_cluster_path, emitter_version_number)
				assembly_description.Close
			else
				Result := Void
			end
		rescue
			retried := True
			create_error (error_messages.Eiffel_assembly_generation_failed, error_messages.Eiffel_assembly_generation_failed_message)
			retry
		end

feature -- Status Report

	has_write_lock (a_folder_name: STRING): BOOLEAN is
			-- Does folder with name `a_folder_name' have a `write_lock' file?
		indexing
			external_name: "HasWriteLock"
		require
			non_void_folder_name: a_folder_name /= Void
			not_empty_folder_name: a_folder_name.Length > 0
		local
			file: SYSTEM_IO_FILE
			retried: BOOLEAN
		do
			if not retried then
				Result := file.Exists (a_folder_name.Concat_String_String_String (a_folder_name, "\", Write_lock_filename))
			else
				Result := False
			end
		rescue
			retried := True
			create_error (error_messages.Write_lock, error_messages.Write_lock_message)
			retry
		end

	has_read_lock (a_folder_name: STRING): BOOLEAN is
			-- Does folder with name `a_folder_name' have a `read_lock' file?
		indexing
			external_name: "HasReadLock"
		require
			non_void_folder_name: a_folder_name /= Void
			not_empty_folder_name: a_folder_name.Length > 0
		local
			file: SYSTEM_IO_FILE
			retried: BOOLEAN
		do
			if not retried then
				Result := file.Exists (a_folder_name.Concat_String_String_String (a_folder_name, "\", Read_lock_filename))
			else
				Result := False
			end
		rescue
			retried := True
			create_error (error_messages.Read_lock, error_messages.Read_lock_message)
			retry
		end

	valid_path (a_path: STRING): BOOLEAN is
			-- Is `a_path' valid?
		indexing
			external_name: "ValidPath"
		require
			non_void_path: a_path /= Void
			not_empty_path: a_path.length > 0
		local
			dir: SYSTEM_IO_DIRECTORY
		do
			Result := dir.exists (a_path)
		end

feature -- Basic Operations

	create_folder (a_path: STRING) is
			-- Create folder with path `a_path' (recursively).
		indexing
			external_name: "CreateFolder"
		require
			non_void_path: a_path /= Void
			not_empty_path: a_path.length > 0		
		local
			i: INTEGER
			folder_names: SYSTEM_COLLECTIONS_ARRAYLIST
			a_folder_name: STRING
			folder_path: STRING
			path: STRING
			slash_index: INTEGER
			dir: SYSTEM_IO_DIRECTORY		
			info: SYSTEM_IO_DIRECTORYINFO
			path_exists: BOOLEAN
			added: INTEGER
		do
			create folder_names.make
			path := a_path.copy (a_path)
			from
				slash_index := path.lastindexof ("\") 
			until
				path_exists or slash_index = -1
			loop
				added := folder_names.add (path.substring (slash_index + 1))
				path_exists := dir.exists (path.substring_int32_int32 (0, slash_index))
				path := path.substring_int32_int32 (0, slash_index)
				slash_index := path.lastindexof ("\") 
			end
			from
				i := folder_names.count - 1
			until
				i = - 1
			loop
				a_folder_name ?= folder_names.item (i)	
				if a_folder_name /= Void then
					folder_path := path.concat_string_string_string (path, "\", a_folder_name)
					info := dir.createdirectory (folder_path)
				end
				i := i - 1
			end
		ensure
			valid_path: valid_path (a_path)
		end
		
feature {NONE} -- Implementation

	error_messages: CODE_GENERATION_SUPPORT_ERROR_MESSAGES
			-- Error messages
		indexing
			external_name: "ErrorMessages"
		end
		
	xml_elements: XML_ELEMENTS
			-- XML elements
		indexing
			external_name: "XmlElements"
		end
		
	type_description: SYSTEM_XML_XMLTEXTREADER
			-- Xml reader corresponding to type description XML file
		indexing
			external_name: "TypeDescription"
		end
		
	eiffel_class: ISE_REFLECTION_EIFFELCLASS
			-- Eiffel class generated from `assembly_description' and `type_description'
		indexing
			external_name: "EiffelClass"
		end

	eiffel_feature: ISE_REFLECTION_EIFFELFEATURE
			-- Eiffel feature built from `type_description'.
		indexing
			external_name: "EiffelFeature"
		end
		
	generate_class_header is
			-- Set `eiffel_class' attributes corresponding to the XML element `header'.
		indexing
			external_name: "GenerateClassHeader"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void
		local
			is_frozen, is_expanded, is_deferred, create_none: STRING
			class_name: STRING
			simple_name: STRING
			namespace: STRING
			assembly_name: STRING
			assembly_version: STRING
			assembly_culture: STRING
			assembly_public_key: STRING
			descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			creation_routines_string: STRING
			comma_index: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				type_description.ReadStartElement_String (xml_elements.Header_element)

					-- Set `is_frozen'.		
				is_frozen := type_description.ReadElementString_String (xml_elements.Frozen_element)
				if is_frozen.Equals_String (xml_elements.True_string) then
					eiffel_class.SetFrozen (True)
				elseif is_frozen.Equals_String (xml_elements.False_string) then
					eiffel_class.SetFrozen (False)
				end

					-- Set `is_expanded'.
				is_expanded := type_description.ReadElementString_String (xml_elements.Expanded_element)
				if is_expanded.Equals_String (xml_elements.True_string) then
					eiffel_class.SetExpanded (True)
				elseif is_expanded.Equals_String (xml_elements.False_string) then
					eiffel_class.SetExpanded (False)
				end

					-- Set `is_deferred'.
				is_deferred := type_description.ReadElementString_String (xml_elements.Deferred_element)
				if is_deferred.Equals_String (xml_elements.True_string) then
					eiffel_class.SetDeferred (True)
				elseif is_deferred.Equals_String (xml_elements.False_string) then
					eiffel_class.SetDeferred (False)
				end

					-- Set `eiffel_name'.
				class_name := type_description.ReadElementString_String (xml_elements.Class_eiffel_name_element)
				if class_name /= Void and then class_name.Length > 0 then
					eiffel_class.SetEiffelName (class_name)
				end

					-- Set `external_name'.
				type_description.ReadStartElement_String (xml_elements.Alias_element)
				simple_name := type_description.ReadElementString_String (xml_elements.Simple_name_element)
				if simple_name /= Void and then simple_name.Length > 0 then
					eiffel_class.SetExternalName (simple_name)
				end		
					-- Set `namespace'.
				if type_description.Name.Equals_String (xml_elements.Namespace_element) then
					namespace := type_description.ReadElementString_String (xml_elements.Namespace_element)
					if namespace /= Void and then namespace.Length > 0 then
						eiffel_class.SetNamespace (namespace)
					end	
				end
					-- Set `assembly_descriptor'.
				assembly_name := type_description.ReadElementString_String (xml_elements.Assembly_name_element)
				if type_description.Name.Equals_String (xml_elements.Assembly_version_element) then
					assembly_version := type_description.ReadElementString_String (xml_elements.Assembly_version_element)
				else
					assembly_version := xml_elements.Empty_string
				end
				if type_description.Name.Equals_String (xml_elements.Assembly_culture_element) then
					assembly_culture := type_description.ReadElementString_String (xml_elements.Assembly_culture_element)
				else
					assembly_culture := xml_elements.Empty_string
				end	
				if type_description.Name.Equals_String (xml_elements.Assembly_public_key_element) then	
					assembly_public_key := type_description.ReadElementString_String (xml_elements.Assembly_public_key_element)	
				else
					assembly_public_key := xml_elements.Empty_string
				end
				type_description.ReadEndElement
				create descriptor.make1
				descriptor.Make (assembly_name, assembly_version, assembly_culture, assembly_public_key)
				eiffel_class.SetAssemblyDescriptor (descriptor)

					-- Set `full_external_name'
				if eiffel_class.namespace /= Void then
					eiffel_class.SetFullExternalName (namespace.Concat_String_String_String (namespace, xml_elements.Dot_string, simple_name))
				else
					eiffel_class.SetFullExternalName (simple_name)
				end

					-- Set `parents'.
				generate_parents

					-- Set `creation_routines'.
				if type_description.Name.Equals_String (xml_elements.Create_element) then
					creation_routines_string := type_description.ReadElementString_String (xml_elements.Create_element)
					if creation_routines_string.Length > 0 then
						if creation_routines_string.IndexOf_Char (',') = -1 then
							eiffel_class.AddCreationRoutine (creation_routines_string)
						else					
							from
							until
								creation_routines_string.IndexOf_Char (',') = -1 
							loop
								comma_index := creation_routines_string.IndexOf_Char (',')
								eiffel_class.AddCreationRoutine (creation_routines_string.Substring_Int32_Int32 (0, comma_index))
								creation_routines_string := creation_routines_string.Substring (comma_index + 1).Trim
							end
							eiffel_class.AddCreationRoutine (creation_routines_string)
						end
					end
				end

					-- Set `create_none'.
				create_none := type_description.ReadElementString_String (xml_elements.Create_none_element)
				if create_none.Equals_String (xml_elements.True_string) then
					eiffel_class.SetCreateNone (True)
				elseif create_none.Equals_String (xml_elements.False_string) then
					eiffel_class.SetCreateNone (False)
				end

				type_description.ReadEndElement
			end
		rescue
			retried := True
			create_error (error_messages.Class_header_generation_failed, error_messages.Class_header_generation_failed_message)
			retry
		end
	
	generate_parents is
			-- Add parents to `eiffel_class' (if any).
		indexing
			external_name: "GenerateParents"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void		
		local
			parent_name: STRING
			comma_index: INTEGER
			rename_clauses_string, undefine_clauses_string, redefine_clauses_string: STRING
			rename_clause_text: STRING
			export_text: STRING
			support: CONVERSION_SUPPORT
			undefine_clause: ISE_REFLECTION_UNDEFINECLAUSE
			redefine_clause: ISE_REFLECTION_REDEFINECLAUSE
			select_clause: ISE_REFLECTION_SELECTCLAUSE
			export_clause: ISE_REFLECTION_EXPORTCLAUSE
			select_clauses_string, export_clauses_string: STRING
			clause_added: INTEGER
			rename_clauses, undefine_clauses, redefine_clauses, select_clauses, export_clauses: SYSTEM_COLLECTIONS_ARRAYLIST		
			retried: BOOLEAN
		do
			if not retried then
				if type_description.Name.Equals_String (xml_elements.Inherit_element) then
					type_description.ReadStartElement_String (xml_elements.Inherit_element)
					create support
					from
					until
						not type_description.Name.Equals_String (xml_elements.Parent_element)
					loop
						type_description.ReadStartElement_String (xml_elements.Parent_element)
						parent_name := type_description.ReadElementString_String (xml_elements.Parent_name_element)
						create rename_clauses.make
						create undefine_clauses.make
						create redefine_clauses.make
						create select_clauses.make
						create export_clauses.make

						if type_description.Name.Equals_String (xml_elements.Rename_element) then
							rename_clauses_string := type_description.ReadElementString_String (xml_elements.Rename_element)
							if rename_clauses_string.Length > 0 then
								if rename_clauses_string.IndexOf_Char (',') = -1 then
									clause_added := rename_clauses.Add (support.rename_clause_from_text (rename_clauses_string))
								else					
									from
									until
										rename_clauses_string.IndexOf_Char (',') = -1 
									loop
										comma_index := rename_clauses_string.IndexOf_Char (',')
										rename_clause_text := rename_clauses_string.Substring_Int32_Int32 (0, comma_index)
										clause_added := rename_clauses.Add (support.rename_clause_from_text (rename_clause_text))
										rename_clauses_string := rename_clauses_string.Substring (comma_index + 1).Trim
									end
									clause_added := rename_clauses.Add (support.rename_clause_from_text (rename_clauses_string))
								end
							end					
						end
						if type_description.Name.Equals_String (xml_elements.Undefine_element) then
							undefine_clauses_string := type_description.ReadElementString_String (xml_elements.Undefine_element)
							if undefine_clauses_string.Length > 0 then
								if undefine_clauses_string.IndexOf_Char (',') = -1 then
									create undefine_clause.make_undefineclause
									undefine_clause.make (undefine_clauses_string)
									clause_added := undefine_clauses.Add (undefine_clause)
								else					
									from
									until
										undefine_clauses_string.IndexOf_Char (',') = -1 
									loop
										comma_index := undefine_clauses_string.IndexOf_Char (',')
										create undefine_clause.make_undefineclause
										undefine_clause.make (undefine_clauses_string.Substring_Int32_Int32 (0, comma_index))
										clause_added := undefine_clauses.Add (undefine_clause)
										undefine_clauses_string := undefine_clauses_string.Substring (comma_index + 1).Trim
									end
									create undefine_clause.make_undefineclause
									undefine_clause.make (undefine_clauses_string)
									clause_added := undefine_clauses.Add (undefine_clause)
								end
							end						
						end
						if type_description.Name.Equals_String (xml_elements.Redefine_element) then
							redefine_clauses_string := type_description.ReadElementString_String (xml_elements.Redefine_element)
							if redefine_clauses_string.Length > 0 then
								if redefine_clauses_string.IndexOf_Char (',') = -1 then
									create redefine_clause.make_redefineclause
									redefine_clause.make (redefine_clauses_string)
									clause_added := redefine_clauses.Add (redefine_clause)
								else					
									from
									until
										redefine_clauses_string.IndexOf_Char (',') = -1 
									loop
										comma_index := redefine_clauses_string.IndexOf_Char (',')
										create redefine_clause.make_redefineclause
										redefine_clause.make (redefine_clauses_string.Substring_Int32_Int32 (0, comma_index))
										clause_added := redefine_clauses.Add (redefine_clause)
										redefine_clauses_string := redefine_clauses_string.Substring (comma_index + 1).Trim
									end
									create redefine_clause.make_redefineclause
									redefine_clause.make (redefine_clauses_string)
									clause_added := redefine_clauses.Add (redefine_clause)
								end
							end						
						end
						if type_description.Name.Equals_String (xml_elements.Select_element) then
							select_clauses_string := type_description.ReadElementString_String (xml_elements.Select_element)
							if select_clauses_string.Length > 0 then
								if select_clauses_string.IndexOf_Char (',') = -1 then
									create select_clause.make_selectclause
									select_clause.make (select_clauses_string)
									clause_added := select_clauses.Add (select_clause)
								else					
									from
									until
										select_clauses_string.IndexOf_Char (',') = -1 
									loop
										comma_index := select_clauses_string.IndexOf_Char (',')
										create select_clause.make_selectclause
										select_clause.make (select_clauses_string.Substring_Int32_Int32 (0, comma_index))
										clause_added := select_clauses.Add (select_clause)
										select_clauses_string := select_clauses_string.Substring (comma_index + 1).Trim
									end
									create select_clause.make_selectclause
									select_clause.make (select_clauses_string)
									clause_added := select_clauses.Add (select_clause)
								end
							end						
						end
						if type_description.Name.Equals_String (xml_elements.Export_element) then
							export_clauses_string := type_description.ReadElementString_String (xml_elements.Export_element)
							if export_clauses_string.Length > 0 then
								if export_clauses_string.IndexOf_Char (',') = -1 then
									clause_added := export_clauses.Add (support.export_clause_from_text (export_clauses_string))
								else					
									from
									until
										export_clauses_string.IndexOf_Char (',') = -1 
									loop
										comma_index := export_clauses_string.IndexOf_Char (',')
										export_text := export_clauses_string.Substring_Int32_Int32 (0, comma_index)
										clause_added := export_clauses.Add (support.export_clause_from_text (export_text))
										export_clauses_string := export_clauses_string.Substring (comma_index + 1).Trim
									end
									clause_added := export_clauses.Add (support.export_clause_from_text (export_clauses_string))
								end
							end							
						end
						eiffel_class.AddParent (parent_name, rename_clauses, undefine_clauses, redefine_clauses, select_clauses, export_clauses)
						type_description.ReadEndElement
					end
					type_description.ReadEndElement
				end	
			end
		rescue
			retried := True
			create_error (error_messages.Class_parents_generation_failed, error_messages.Class_parents_generation_failed_message)
			retry
		end
	
	generate_class_body is
			-- Set `eiffel_class' attributes corresponding to the XML element `body'.
		indexing
			external_name: "GenerateClassBody"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				type_description.ReadStartElement_String (xml_elements.Body_element)

				if type_description.Name.Equals_String (xml_elements.Initialization_element) then
					type_description.ReadStartElement_String (xml_elements.Initialization_element)
					generate_features (xml_elements.Initialization_element)
					type_description.ReadEndElement
				end
				if type_description.Name.Equals_String (xml_elements.Access_element) then
					type_description.ReadStartElement_String (xml_elements.Access_element)
					generate_features (xml_elements.Access_element)
					type_description.ReadEndElement				
				end
				if type_description.Name.Equals_String (xml_elements.Element_change_element) then
					type_description.ReadStartElement_String (xml_elements.Element_change_element)
					generate_features (xml_elements.Element_change_element)
					type_description.ReadEndElement				
				end
				if type_description.Name.Equals_String (xml_elements.Basic_operations_element) then
					type_description.ReadStartElement_String (xml_elements.Basic_operations_element)
					generate_features (xml_elements.Basic_operations_element)
					type_description.ReadEndElement
				end
				if type_description.Name.Equals_String (xml_elements.Unary_operators_element) then
					type_description.ReadStartElement_String (xml_elements.Unary_operators_element)
					generate_features (xml_elements.Unary_operators_element)
					type_description.ReadEndElement				
				end
				if type_description.Name.Equals_String (xml_elements.Binary_operators_element) then
					type_description.ReadStartElement_String (xml_elements.Binary_operators_element)
					generate_features (xml_elements.Binary_operators_element)
					type_description.ReadEndElement				
				end
				if type_description.Name.Equals_String (xml_elements.Specials_element) then
					type_description.ReadStartElement_String (xml_elements.Specials_element)
					generate_features (xml_elements.Specials_element)
					type_description.ReadEndElement				
				end
				if type_description.Name.Equals_String (xml_elements.Implementation_element) then
					type_description.ReadStartElement_String (xml_elements.Implementation_element)
					generate_features (xml_elements.Implementation_element)
					type_description.ReadEndElement				
				end			
				type_description.ReadEndElement
			end
		rescue
			retried := True
			create_error (error_messages.Class_body_generation_failed, error_messages.Class_body_generation_failed_message)
			retry
		end

	generate_features (element_name: STRING) is
			-- Add features from xml element with name `element_name' to `eiffel_class'.
		indexing
			external_name: "GenerateFeatures"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void	
			non_void_element_name: element_name /= Void
			not_empty_element_name: element_name.Length > 0
			valid_element_name: element_name.Equals_String (xml_elements.Initialization_element) or element_name.Equals_String (xml_elements.Access_element) or element_name.Equals_String (xml_elements.Element_change_element) or element_name.Equals_String (xml_elements.Basic_operations_element) or element_name.Equals_String (xml_elements.Unary_operators_element) or element_name.Equals_String (xml_elements.Binary_operators_element) or element_name.Equals_String (xml_elements.Specials_element) or element_name.Equals_String (xml_elements.Implementation_element)
		local
			eiffel_name: STRING
			external_name: STRING
			return_type: STRING
			return_type_full_name: STRING
			is_return_type_enum: STRING
			signature_type: ISE_REFLECTION_SIGNATURETYPE
			retried: BOOLEAN
		do
			if not retried then
				from
				until
					not type_description.Name.Equals_String (xml_elements.Feature_element)
				loop
					signature_type := Void
					type_description.ReadStartElement_String (xml_elements.Feature_element)
					create eiffel_feature.make1
					eiffel_feature.make

						-- Set `is_frozen', `is_static', `is_abstract', `is_method', `is_field', `is_creation_routine'.
					set_feature_info

						-- Set `eiffel_name'.
					eiffel_name := type_description.ReadElementString_String (xml_elements.Feature_eiffel_name_element)
					if eiffel_name /= Void and then eiffel_name.Length > 0 then
						eiffel_feature.SetEiffelName (eiffel_name)
					end	
		
						-- Set `external_name'.
					if type_description.Name.Equals_String (xml_elements.Feature_external_name_element) then
						external_name := type_description.ReadElementString_String (xml_elements.Feature_external_name_element)
						if external_name /= Void and then external_name.Length > 0 then
							eiffel_feature.SetExternalName (external_name)
						end
					end

						-- Add `arguments' (if any).
					if type_description.Name.Equals_String (xml_elements.Arguments_element) then
						generate_arguments
					end

						-- Set `return_type'.
					if type_description.Name.Equals_String (xml_elements.Return_type_element) then
						return_type := type_description.ReadElementString_String (xml_elements.Return_type_element)
						if return_type /= Void and then return_type.Length > 0 then
							create signature_type.make1
							signature_type.make
							signature_type.settypeeiffelname (return_type)
						end
					end

						-- Set `return_type_full_name'.
					if type_description.Name.Equals_String (xml_elements.Return_type_full_name_element) then
						return_type_full_name := type_description.ReadElementString_String (xml_elements.Return_type_full_name_element) 
						if return_type_full_name /= Void and then return_type_full_name.Length > 0 then
							if signature_type = Void then
								create signature_type.make1
								signature_type.make
							end
							signature_type.settypefullexternalname (return_type_full_name)
						end
					end

						-- Set `return_type_enum'.
					if type_description.Name.Equals_String (xml_elements.Return_type_enum_element) then
						is_return_type_enum := type_description.ReadElementString_String (xml_elements.Return_type_enum_element) 
						if is_return_type_enum /= Void and then is_return_type_enum.Length > 0 then
							if signature_type = Void then
								create signature_type.make1
								signature_type.make
							end
							if is_return_type_enum.equals_string (xml_elements.True_string) then
								signature_type.SetEnum (True)
							elseif is_return_type_enum.equals_string (xml_elements.False_string) then
								signature_type.SetEnum (False)
							end
							eiffel_feature.SetReturnType (signature_type)
						end
					end
					
						-- Add `comments' (if any).
					if type_description.Name.Equals_String (xml_elements.Comments_element) then
						generate_comments
					end

						-- Add `preconditions' (if any).
					if type_description.Name.Equals_String (xml_elements.Preconditions_element) then
						generate_feature_assertions (xml_elements.Precondition_element)
					end

						-- Add `postconditions' (if any).
					if type_description.Name.Equals_String (xml_elements.Postconditions_element) then
						generate_feature_assertions (xml_elements.Postcondition_element)
					end

					type_description.ReadEndElement

					if element_name.Equals_String (xml_elements.Initialization_element) then
						eiffel_class.AddInitializationFeature (eiffel_feature)
					elseif element_name.Equals_String (xml_elements.Access_element) then
						eiffel_class.AddAccessFeature (eiffel_feature)
					elseif element_name.Equals_String (xml_elements.Element_change_element) then
						eiffel_class.AddElementChangeFeature (eiffel_feature)
					elseif element_name.Equals_String (xml_elements.Basic_operations_element) then
						eiffel_class.AddBasicOperation (eiffel_feature)
					elseif element_name.Equals_String (xml_elements.Unary_operators_element) then
						eiffel_class.AddUnaryOperator (eiffel_feature)
					elseif element_name.Equals_String (xml_elements.Binary_operators_element) then
						eiffel_class.AddBinaryOperator (eiffel_feature)
					elseif element_name.Equals_String (xml_elements.Specials_element) then
						eiffel_class.AddSpecialFeature (eiffel_feature)
					elseif element_name.Equals_String (xml_elements.Implementation_element) then
						eiffel_class.AddImplementationFeature (eiffel_feature)
					end
				end
			end
		rescue
			retried := True
			create_error (error_messages.Class_features_generation_failed, error_messages.Class_features_generation_failed_message)
			retry
		end
	
	set_feature_info is
			-- Set `is_frozen', `is_static', `is_abstract', `is_field', `is_creation_routine', `is_prefix', `is_infix' from `type_description' to `eiffel_feature'.
		indexing
			external_name: "SetFeatureInfo"
		require
			non_void_feature: eiffel_feature /= Void
			non_void_type_description: type_description /= Void
		local
			frozen_feature, static, abstract: STRING
			is_method, is_field, is_creation_routine: STRING
			is_prefix, is_infix: STRING
			retried: BOOLEAN
		do
			if not retried then
					-- Set `is_frozen'.
				frozen_feature := type_description.ReadElementString_String (xml_elements.Frozen_feature_element)
				if frozen_feature.Equals_String (xml_elements.True_string) then
					eiffel_feature.SetFrozen (True)
				elseif frozen_feature.Equals_String (xml_elements.False_string) then
					eiffel_feature.SetFrozen (False)
				end

					-- Set `is_static'.
				static := type_description.ReadElementString_String (xml_elements.Static_element)
				if static.Equals_String (xml_elements.True_string) then
					eiffel_feature.SetStatic (True)
				elseif static.Equals_String (xml_elements.False_string) then
					eiffel_feature.SetStatic (False)
				end

					-- Set `is_abstract'.
				abstract := type_description.ReadElementString_String (xml_elements.Abstract_element)
				if abstract.Equals_String (xml_elements.True_string) then
					eiffel_feature.SetAbstract (True)
				elseif abstract.Equals_String (xml_elements.False_string) then
					eiffel_feature.SetAbstract (False)
				end

					-- Set `is_method'.
				is_method := type_description.ReadElementString_String (xml_elements.Method_element)
				if is_method.Equals_String (xml_elements.True_string) then
					eiffel_feature.SetMethod (True)
				elseif is_method.Equals_String (xml_elements.False_string) then
					eiffel_feature.SetMethod (False)
				end

					-- Set `is_field'.
				is_field := type_description.ReadElementString_String (xml_elements.Field_element)
				if is_field.Equals_String (xml_elements.True_string) then
					eiffel_feature.SetField (True)
				elseif is_field.Equals_String (xml_elements.False_string) then
					eiffel_feature.SetField (False)
				end				

					-- Set `is_creation_routine'.
				is_creation_routine := type_description.ReadElementString_String (xml_elements.Creation_routine_element)
				if is_creation_routine.Equals_String (xml_elements.True_string) then
					eiffel_feature.SetCreationRoutine (True)
				elseif is_creation_routine.Equals_String (xml_elements.False_string) then
					eiffel_feature.SetCreationRoutine (False)
				end

					-- Set `is_prefix'.
				is_prefix := type_description.ReadElementString_String (xml_elements.Prefix_element)
				if is_prefix.Equals_String (xml_elements.True_string) then
					eiffel_feature.SetPrefix (True)
				elseif is_prefix.Equals_String (xml_elements.False_string) then
					eiffel_feature.SetPrefix (False)
				end

					-- Set `is_infix'.
				is_infix := type_description.ReadElementString_String (xml_elements.Infix_element)
				if is_infix.Equals_String (xml_elements.True_string) then
					eiffel_feature.SetInfix (True)
				elseif is_infix.Equals_String (xml_elements.False_string) then
					eiffel_feature.SetInfix (False)
				end	
			end
		rescue
			retried := True
			create_error (error_messages.Class_feature_info_generation_failed, error_messages.Class_feature_info_generation_failed_message)
			retry
		end
	
	generate_arguments is
			-- Add arguments to `eiffel_feature'.
		indexing
			external_name: "GenerateArguments"
		require
			non_void_feature: eiffel_feature /= Void
			non_void_type_description: type_description /= Void
		local
			eiffel_name: STRING
			external_name: STRING
			type: STRING
			type_full_name: STRING
			is_enum: STRING
			an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE
			retried: BOOLEAN
		do
			if not retried then
				type_description.ReadStartElement_String (xml_elements.Arguments_element)
				from
				until
					not type_description.Name.Equals_String (xml_elements.Argument_element) 
				loop
					type_description.ReadStartElement_String (xml_elements.Argument_element)
					eiffel_name := type_description.ReadElementString_String (xml_elements.Argument_eiffel_name_element)
					external_name := type_description.ReadElementString_String (xml_elements.Argument_external_name_element)
					type := type_description.ReadElementString_String (xml_elements.Argument_type_element)
					type_full_name := type_description.ReadElementString_String (xml_elements.Argument_type_full_name_element)
					is_enum := type_description.ReadElementString_String (xml_elements.Argument_type_enum_element)						
					
					if eiffel_name /= Void and external_name /= Void and type /= Void and type_full_name /= Void then
						if eiffel_name.Length > 0 and external_name.Length > 0 and type.Length > 0 and type_full_name.Length > 0 then
							create an_argument.make_namedsignaturetype
							an_argument.seteiffelname (eiffel_name)
							an_argument.setexternalname (external_name)
							an_argument.settypeeiffelname (type)
							an_argument.settypefullexternalname (type_full_name)
							if is_enum.Equals_String (xml_elements.True_string) then
								an_argument.SetEnum (True)
							elseif is_enum.Equals_String (xml_elements.False_string) then
								an_argument.SetEnum (False)
							end
							eiffel_feature.AddArgument (an_argument)	
						end
					end
					type_description.ReadEndElement
				end
				type_description.ReadEndElement
			end
		rescue
			retried := True
			create_error (error_messages.Class_feature_arguments_generation_failed, error_messages.Class_feature_arguments_generation_failed_message)
			retry
		end

	generate_comments is
			-- Add comments to `eiffel_feature'.
		indexing
			external_name: "GenerateComments"
		require
			non_void_feature: eiffel_feature /= Void
			non_void_type_description: type_description /= Void
		local
			comments_string: STRING
			comma_index: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				comments_string := type_description.ReadElementString_String (xml_elements.Comments_element)
				if comments_string.Length > 0 then
					if comments_string.IndexOf_Char (',') = -1 then
						eiffel_feature.AddComment (comments_string)
					else					
						from
						until
							comments_string.IndexOf_Char (',') = -1 
						loop
							comma_index := comments_string.IndexOf_Char (',')
							eiffel_feature.AddComment (comments_string.Substring_Int32_Int32 (0, comma_index))
							comments_string := comments_string.Substring (comma_index + 1).Trim
						end
						eiffel_feature.AddComment (comments_string)
					end
				end
			end
		rescue
			retried := True
			create_error (error_messages.Class_feature_comments_generation_failed, error_messages.Class_feature_comments_generation_failed_message)
			retry
		end		

	generate_feature_assertions (element_name: STRING) is
			-- Add preconditions or postconditions (depending on `element_name') to `eiffel_feature'.
		indexing
			external_name: "GenerateFeatureAssertions"
		require
			non_void_feature: eiffel_feature /= Void
			non_void_type_description: type_description /= Void
			non_void_element_name: element_name /= Void
			not_empty_element_name: element_name.Length > 0
			valid_element_name: element_name.Equals_String (xml_elements.Precondition_element) or element_name.Equals_String (xml_elements.Postcondition_element)
		local
			tag: STRING
			text: STRING
			retried: BOOLEAN
		do	
			if not retried then
				if element_name.Equals_String (xml_elements.Precondition_element) then
					type_description.ReadStartElement_String (xml_elements.Preconditions_element)
				elseif element_name.Equals_String (xml_elements.Postcondition_element) then
					type_description.ReadStartElement_String (xml_elements.Postconditions_element)
				end
				from
				until
					not type_description.Name.Equals_String (element_name) 
				loop
					type_description.ReadStartElement_String (element_name)
					if element_name.Equals_String (xml_elements.Precondition_element) then
						tag := type_description.ReadElementString_String (xml_elements.Precondition_tag_element)
						text := type_description.ReadElementString_String (xml_elements.Precondition_text_element)
					elseif element_name.Equals_String (xml_elements.Postcondition_element) then
						tag := type_description.ReadElementString_String (xml_elements.Postcondition_tag_element)
						text := type_description.ReadElementString_String (xml_elements.Postcondition_text_element)
					end
					if tag /= Void and text /= Void then
						if text.Length > 0 then
							if element_name.Equals_String (xml_elements.Precondition_element) then
								eiffel_feature.AddPrecondition (tag, text)
							elseif element_name.Equals_String (xml_elements.Postcondition_element) then
								eiffel_feature.AddPostcondition (tag, text)
							end
						end
					end
					type_description.ReadEndElement
				end
				type_description.ReadEndElement
			end
		rescue
			retried := True
			create_error (error_messages.Class_feature_assertions_generation_failed, error_messages.Class_feature_assertions_generation_failed_message)
			retry
		end
		
	generate_class_footer is
			-- Set `eiffel_class' attributes corresponding to the XML element `footer'.
		indexing
			external_name: "GenerateClassFooter"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void
		local
			tag: STRING
			text: STRING
			retried: BOOLEAN
		do
			if not retried then
				type_description.ReadStartElement_String (xml_elements.Footer_element)
				if type_description.Name.Equals_String (xml_elements.Invariants_element) then
					type_description.ReadStartElement_String (xml_elements.Invariants_element) 
					from
					until
						not type_description.Name.Equals_String (xml_elements.Invariant_element) 
					loop
						type_description.ReadStartElement_String (xml_elements.Invariant_element)
						tag := type_description.ReadElementString_String (xml_elements.Invariant_tag_element)
						text := type_description.ReadElementString_String (xml_elements.Invariant_text_element)
						if tag /= Void and text /= Void then
							if text.Length > 0 then
								eiffel_class.AddInvariant (tag, text)
							end
						end
						type_description.ReadEndElement
					end
					type_description.ReadEndElement			
				end
				type_description.ReadEndElement
			end
		rescue
			retried := True
			create_error (error_messages.Class_footer_generation_failed, error_messages.Class_footer_generation_failed_message)
			retry
		end
		
end -- class CODE_GENERATION_SUPPPORT
