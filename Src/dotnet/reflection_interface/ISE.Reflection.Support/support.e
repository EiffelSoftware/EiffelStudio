indexing
	description: "Provide support for code generation and reflection."
	external_name: "ISE.Reflection.Support"

class
	SUPPORT
inherit
	XML_ELEMENTS
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

	last_error: ERROR_INFO
			-- Last error
		indexing
			external_name: "LastError"
		end

	Assemblies_folder_path: STRING is
			-- Path to `$EIFFEL\dotnet\assemblies' directory
		indexing
			external_name: "AssembliesFolderPath"
		once
			check
				non_void_eiffel_delivery_path: Eiffel_delivery_path /= Void
				not_emtpy_eiffel_delivery_path: Eiffel_delivery_path.Length > 0
			end
			Result := Eiffel_delivery_path.Concat_String_String (Eiffel_delivery_path, Assemblies_folder_relative_path)
		ensure
			path_created: Result /= Void 
			not_empty_path: Result.Length > 0
		end

	assembly_folder_path_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
			-- Assembly folder name corresponding to `a_descriptor'.
			-- | Code string built from `a_version', `a_culture' and `a_public_key' by using the MD5 hash algorithm.
		indexing
			external_name: "AssemblyFolderPathFromInfo"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			name: STRING	
			version: STRING
			culture: STRING
			public_key: STRING
			string_to_code: STRING
			folder_name: STRING
		do
			name := a_descriptor.Name
			version := a_descriptor.Version
			culture := a_descriptor.Culture
			public_key := a_descriptor.PublicKey
			string_to_code := name.Concat_String_String_String_String (name, Dash, version, Dash)
			string_to_code := string_to_code.Concat_String_String_String_String (string_to_code, culture, Dash, public_key)
			folder_name := hash_value (string_to_code)
			Result := Assemblies_folder_path
			Result := Result.Concat_String_String (Result, folder_name)
		ensure
			assembly_folder_name_generated: Result /= Void
			valid_folder_name: Result.Length > 0
		end			

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

	xml_assembly_filename (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY): STRING is
			-- Xml filename corresponding to `an_eiffel_assembly' 
		indexing
			external_name: "XmlAssemblyFilename"
		require
			non_void_eiffel_assembly: an_eiffel_assembly /= Void
			non_void_assembly_version: an_eiffel_assembly.AssemblyVersion /= Void
			non_void_assembly_culture: an_eiffel_assembly.AssemblyCulture /= Void
			non_void_assembly_public_key: an_eiffel_assembly.AssemblyPublicKey /= Void
		local
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			assembly_folder_path: STRING
		do
			create a_descriptor.make1
			a_descriptor.Make (an_eiffel_assembly.AssemblyName, an_eiffel_assembly.AssemblyVersion, an_eiffel_assembly.AssemblyCulture, an_eiffel_assembly.AssemblyPublicKey)
			assembly_folder_path := assembly_folder_path_from_info (a_descriptor)
			Result := assembly_folder_path.Concat_String_String_String_String (assembly_folder_path, "\", Assembly_description_filename, Xml_extension)
		ensure
			non_void_filename: Result /= Void
		end

	xml_type_filename (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS): STRING is
			-- Xml filename corresponding to `an_eiffel_class'
		indexing
			external_name: "XmlTypeFilename"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_dot_net_full_name: an_eiffel_class.DotNetFullName /= Void
			non_void_assembly_descriptor: an_eiffel_class.AssemblyDescriptor /= Void
		local
			formatter: FORMATTER
			assembly_folder_path: STRING
		do
			create formatter.make_formatter
			assembly_folder_path := assembly_folder_path_from_info (an_eiffel_class.AssemblyDescriptor)
			Result := assembly_folder_path.Concat_String_String_String_String (assembly_folder_path, "\", formatter.FormatTypeName (an_eiffel_class.DotNetFullName).ToLower, Xml_extension)
		ensure
			non_void_filename: Result /= Void
		end
			
	eiffel_class_from_xml (a_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
			-- Instance of `eiffel_class' corresponding to Xml file with filename `a_filename'.
		indexing
			external_name: "EiffelClassFromXml"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.Length > 0
		do
			create type_description.make_xmltextreader_10 (a_filename)
				-- WhitespaceHandling = None
			type_description.set_WhitespaceHandling (2)
			
			create eiffel_class.make1
			eiffel_class.Make
			type_description.ReadStartElement_String (Class_element)
			generate_class_header
			generate_class_body
			if type_description.Name.Equals_String (Footer_element) then
				generate_class_footer
			end
			--type_description.ReadEndElement
			type_description.Close
			Result := eiffel_class
			eiffel_class := Void
		ensure
			non_void_eiffel_class: Result /= Void
		end	

	eiffel_assembly_from_xml (a_filename: STRING): ISE_REFLECTION_EIFFELASSEMBLY is
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
			type_filename: STRING
		do
			create assembly_description.make_xmltextreader_10 (a_filename)	
				-- WhitespaceHandling = None
			assembly_description.set_WhitespaceHandling (2)
			
			create Result.make1
			Result.Make
			assembly_description.ReadStartElement_String (Assembly_element)
		
				-- Set `assembly_name'.
			if assembly_description.Name.Equals_String (Assembly_name_element) then
				assembly_name := assembly_description.ReadElementString_String (Assembly_name_element)
				if assembly_name /= Void and then assembly_name.Length > 0 then
					Result.SetAssemblyName (assembly_name)
				end
			end
			
				-- Set `assembly_version'.
			if assembly_description.Name.Equals_String (Assembly_version_element) then
				assembly_version := assembly_description.ReadElementString_String (Assembly_version_element)
				if assembly_version /= Void and then assembly_version.Length > 0 then
					Result.SetAssemblyVersion (assembly_version)
				end
			end
			
				-- Set `assembly_culture'.
			if assembly_description.Name.Equals_String (Assembly_culture_element) then
				assembly_culture := assembly_description.ReadElementString_String (Assembly_culture_element)
				if assembly_culture /= Void and then assembly_culture.Length > 0 then
					Result.SetAssemblyCulture (assembly_culture)
				end
			end
			
				-- Set `assembly_public_key'.
			if assembly_description.Name.Equals_String (Assembly_public_key_element) then
				assembly_public_key := assembly_description.ReadElementString_String (Assembly_public_key_element)
				if assembly_public_key /= Void and then assembly_public_key.Length > 0 then
					Result.SetAssemblyPublicKey (assembly_public_key)
				end
			end
			
				-- Set `eiffel_cluster_path'.
			if assembly_description.Name.Equals_String (Eiffel_cluster_path_element) then
				eiffel_cluster_path := assembly_description.ReadElementString_String (Eiffel_cluster_path_element)
				if eiffel_cluster_path /= Void and then eiffel_cluster_path.Length > 0 then
					Result.SetEiffelClusterPath (eiffel_cluster_path)
				end
			end
			
			-- Set `emitter_version_number'.
			if assembly_description.Name.Equals_String (Emitter_version_number_element) then
				emitter_version_number := assembly_description.ReadElementString_String (Emitter_version_number_element)
				if emitter_version_number.Length > 0 then
					Result.SetEmitterVersionNumber (emitter_version_number)
				end
			end
			
			-- Add `types'.
			if assembly_description.Name.Equals_String (Assembly_types_element) then
				assembly_description.ReadStartElement_String (Assembly_types_element)
				from
				until
					not assembly_description.Name.Equals_String (Assembly_type_filename_element)
				loop
					type_filename := assembly_description.ReadElementString_String (Assembly_type_filename_element)
					Result.AddType (eiffel_class_from_xml (type_filename))
				end
				assembly_description.ReadEndElement
			end
			assembly_description.ReadEndElement
			assembly_description.Close
		ensure
			non_void_eiffel_assembly: Result /= Void
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
		do
			Result := file.Exists (a_folder_name.Concat_String_String_String (a_folder_name, "\", Write_lock_filename))
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
		do
			Result := file.Exists (a_folder_name.Concat_String_String_String (a_folder_name, "\", Read_lock_filename))
		end
		
feature {NONE} -- Implementation
		
	Eiffel_key: STRING is "ISE_EIFFEL"
			-- Name of environment variable containing path to Eiffel delivery
		indexing
			external_name: "EiffelKey"
		end

	Eiffel_delivery_path: STRING is 
			-- Path to Eiffel delivery
		indexing
			external_name: "EiffelDeliveryPath"
		local
			env: SYSTEM_ENVIRONMENT
		once
			Result := env.GetEnvironmentVariable (Eiffel_key)
		ensure
			non_void_eiffel_delivery_path: Result /= Void
			not_emtpy_eiffel_delivery_path: Result.Length > 0
		end

	Assemblies_folder_relative_path: STRING is "\dotnet\assemblies\"
			-- Relative path to `assemblies' directory (in $EIFFEL\)
		indexing
			external_name: "AssembliesFolderRelativePath"
		end
		
	hash_value (a_string: STRING): STRING is
			-- Hash value of `a_string' (using MD5 algorithm)
		indexing
			external_name: "HashValue"
		require
			non_void_string: a_string /= Void
			not_empty_string: a_string.Length > 0
		local
			encoding: SYSTEM_TEXT_ASCIIENCODING
			data: ARRAY [INTEGER_8]
			crypto_service_provider: SYSTEM_SECURITY_CRYPTOGRAPHY_MD5CRYPTOSERVICEPROVIDER
			hash: ARRAY [INTEGER_8]	
			i: INTEGER
			convert: SYSTEM_CONVERT
			an_hash_value: INTEGER_8
			an_integer: INTEGER
			valid_string: STRING
		do
			create Result.make_2 ('%U', 0)
			create encoding.make_asciiencoding
			data := encoding.GetBytes (a_string)
			create crypto_service_provider.make_md5cryptoserviceprovider
			hash := crypto_service_provider.ComputeHash_array_Byte (data)
			from
			until
				i = hash.count
			loop
				an_hash_value := hash.item (i)
				an_integer := convert.ToInt32 (an_hash_value)
				valid_string := valid_characters.item (an_integer)	
				Result := Result.Concat_String_String (Result, valid_string)
				i := i + 1
			end
		ensure
			hash_value_compiled: Result /= Void
			not_empty_hash_value: Result.Length > 0
		end
		
	Assembly_description_filename: STRING is "assembly_description"
			-- Filename of XML file describing the assembly
		indexing
			external_name: "AssemblyDescriptionFilename"
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
		do
			type_description.ReadStartElement_String (Header_element)
			
				-- Set `is_frozen'.		
			is_frozen := type_description.ReadElementString_String (Frozen_element)
			if is_frozen.Equals_String (True_string) then
				eiffel_class.SetFrozen (True)
			elseif is_frozen.Equals_String (False_string) then
				eiffel_class.SetFrozen (False)
			end

				-- Set `is_expanded'.
			is_expanded := type_description.ReadElementString_String (Expanded_element)
			if is_expanded.Equals_String (True_string) then
				eiffel_class.SetExpanded (True)
			elseif is_expanded.Equals_String (False_string) then
				eiffel_class.SetExpanded (False)
			end
			
				-- Set `is_deferred'.
			is_deferred := type_description.ReadElementString_String (Deferred_element)
			if is_deferred.Equals_String (True_string) then
				eiffel_class.SetDeferred (True)
			elseif is_deferred.Equals_String (False_string) then
				eiffel_class.SetDeferred (False)
			end
			
				-- Set `eiffel_name'.
			class_name := type_description.ReadElementString_String (Class_name_element)
			if class_name /= Void and then class_name.Length > 0 then
				eiffel_class.SetEiffelName (class_name)
			end
			
				-- Set `dot_net_simple_name'.
			type_description.ReadStartElement_String (Alias_element)
			simple_name := type_description.ReadElementString_String (Simple_name_element)
			if simple_name /= Void and then simple_name.Length > 0 then
				eiffel_class.SetDotNetSimpleName (simple_name)
			end		
				-- Set `namespace'.
			if type_description.Name.Equals_String (Namespace_element) then
				namespace := type_description.ReadElementString_String (Namespace_element)
				if namespace /= Void and then namespace.Length > 0 then
					eiffel_class.SetNamespace (namespace)
				end	
			end
				-- Set `assembly_descriptor'.
			assembly_name := type_description.ReadElementString_String (Assembly_name_element)
			if type_description.Name.Equals_String (Assembly_version_element) then
				assembly_version := type_description.ReadElementString_String (Assembly_version_element)
			else
				assembly_version := Empty_string
			end
			if type_description.Name.Equals_String (Assembly_culture_element) then
				assembly_culture := type_description.ReadElementString_String (Assembly_culture_element)
			else
				assembly_culture := Empty_string
			end	
			if type_description.Name.Equals_String (Assembly_public_key_element) then	
				assembly_public_key := type_description.ReadElementString_String (Assembly_public_key_element)	
			else
				assembly_public_key := Empty_string
			end
			type_description.ReadEndElement
			create descriptor.make1
			descriptor.Make (assembly_name, assembly_version, assembly_culture, assembly_public_key)
			eiffel_class.SetAssemblyDescriptor (descriptor)
			
				-- Set `dot_net_full_name'
			if eiffel_class.namespace /= Void then
				eiffel_class.SetFullName (namespace.Concat_String_String_String (namespace, Dot_string, simple_name))
			else
				eiffel_class.SetFullName (simple_name)
			end

				-- Set `parents'.
			generate_parents

				-- Set `creation_routines'.
			if type_description.Name.Equals_String (Create_element) then
				creation_routines_string := type_description.ReadElementString_String (Create_element)
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
			create_none := type_description.ReadElementString_String (Create_none_element)
			if create_none.Equals_String (True_string) then
				eiffel_class.SetCreateNone (True)
			elseif create_none.Equals_String (False_string) then
				eiffel_class.SetCreateNone (False)
			end
			
			type_description.ReadEndElement
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
			select_clauses_string, export_clauses_string: STRING
			clause_added: INTEGER
			rename_clauses, undefine_clauses, redefine_clauses, select_clauses, export_clauses: SYSTEM_COLLECTIONS_ARRAYLIST		
		do
			if type_description.Name.Equals_String (Inherit_element) then
				type_description.ReadStartElement_String (Inherit_element)
				
				from
				until
					not type_description.Name.Equals_String (Parent_element)
				loop
					type_description.ReadStartElement_String (Parent_element)
					parent_name := type_description.ReadElementString_String (Parent_name_element)
					create rename_clauses.make
					create undefine_clauses.make
					create redefine_clauses.make
					create select_clauses.make
					create export_clauses.make

					if type_description.Name.Equals_String (Rename_element) then
						rename_clauses_string := type_description.ReadElementString_String (Rename_element)
						if rename_clauses_string.Length > 0 then
							if rename_clauses_string.IndexOf_Char (',') = -1 then
								clause_added := rename_clauses.Add (rename_clauses_string)
							else					
								from
								until
									rename_clauses_string.IndexOf_Char (',') = -1 
								loop
									comma_index := rename_clauses_string.IndexOf_Char (',')
									clause_added := rename_clauses.Add (rename_clauses_string.Substring_Int32_Int32 (0, comma_index))
									rename_clauses_string := rename_clauses_string.Substring (comma_index + 1).Trim
								end
								clause_added := rename_clauses.Add (rename_clauses_string)
							end
						end					
					end
					if type_description.Name.Equals_String (Undefine_element) then
						undefine_clauses_string := type_description.ReadElementString_String (Undefine_element)
						if undefine_clauses_string.Length > 0 then
							if undefine_clauses_string.IndexOf_Char (',') = -1 then
								clause_added := undefine_clauses.Add (undefine_clauses_string)
							else					
								from
								until
									undefine_clauses_string.IndexOf_Char (',') = -1 
								loop
									comma_index := undefine_clauses_string.IndexOf_Char (',')
									clause_added := undefine_clauses.Add (undefine_clauses_string.Substring_Int32_Int32 (0, comma_index))
									undefine_clauses_string := undefine_clauses_string.Substring (comma_index + 1).Trim
								end
								clause_added := undefine_clauses.Add (undefine_clauses_string)
							end
						end						
					end
					if type_description.Name.Equals_String (Redefine_element) then
						redefine_clauses_string := type_description.ReadElementString_String (Redefine_element)
						if redefine_clauses_string.Length > 0 then
							if redefine_clauses_string.IndexOf_Char (',') = -1 then
								clause_added := redefine_clauses.Add (redefine_clauses_string)
							else					
								from
								until
									redefine_clauses_string.IndexOf_Char (',') = -1 
								loop
									comma_index := redefine_clauses_string.IndexOf_Char (',')
									clause_added := redefine_clauses.Add (redefine_clauses_string.Substring_Int32_Int32 (0, comma_index))
									redefine_clauses_string := redefine_clauses_string.Substring (comma_index + 1).Trim
								end
								clause_added := redefine_clauses.Add (redefine_clauses_string)
							end
						end						
					end
					if type_description.Name.Equals_String (Select_element) then
						select_clauses_string := type_description.ReadElementString_String (Select_element)
						if select_clauses_string.Length > 0 then
							if select_clauses_string.IndexOf_Char (',') = -1 then
								clause_added := select_clauses.Add (select_clauses_string)
							else					
								from
								until
									select_clauses_string.IndexOf_Char (',') = -1 
								loop
									comma_index := select_clauses_string.IndexOf_Char (',')
									clause_added := select_clauses.Add (select_clauses_string.Substring_Int32_Int32 (0, comma_index))
									select_clauses_string := select_clauses_string.Substring (comma_index + 1).Trim
								end
								clause_added := select_clauses.Add (select_clauses_string)
							end
						end						
					end
					if type_description.Name.Equals_String (Export_element) then
						export_clauses_string := type_description.ReadElementString_String (Export_element)
						if export_clauses_string.Length > 0 then
							if export_clauses_string.IndexOf_Char (',') = -1 then
								clause_added := export_clauses.Add (export_clauses_string)
							else					
								from
								until
									export_clauses_string.IndexOf_Char (',') = -1 
								loop
									comma_index := export_clauses_string.IndexOf_Char (',')
									clause_added := export_clauses.Add (export_clauses_string.Substring_Int32_Int32 (0, comma_index))
									export_clauses_string := export_clauses_string.Substring (comma_index + 1).Trim
								end
								clause_added := export_clauses.Add (export_clauses_string)
							end
						end							
					end
					eiffel_class.AddParent (parent_name, rename_clauses, undefine_clauses, redefine_clauses, select_clauses, export_clauses)
					type_description.ReadEndElement
				end
				type_description.ReadEndElement
			end		
		end
	
	generate_class_body is
			-- Set `eiffel_class' attributes corresponding to the XML element `body'.
		indexing
			external_name: "GenerateClassBody"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void
		do
			type_description.ReadStartElement_String (Body_element)
			
			if type_description.Name.Equals_String (Initialization_element) then
				type_description.ReadStartElement_String (Initialization_element)
				generate_features (Initialization_element)
				type_description.ReadEndElement
			end
			if type_description.Name.Equals_String (Access_element) then
				type_description.ReadStartElement_String (Access_element)
				generate_features (Access_element)
				type_description.ReadEndElement				
			end
			if type_description.Name.Equals_String (Element_change_element) then
				type_description.ReadStartElement_String (Element_change_element)
				generate_features (Element_change_element)
				type_description.ReadEndElement				
			end
			if type_description.Name.Equals_String (Basic_operations_element) then
				type_description.ReadStartElement_String (Basic_operations_element)
				generate_features (Basic_operations_element)
				type_description.ReadEndElement
			end
			if type_description.Name.Equals_String (Unary_operators_element) then
				type_description.ReadStartElement_String (Unary_operators_element)
				generate_features (Unary_operators_element)
				type_description.ReadEndElement				
			end
			if type_description.Name.Equals_String (Binary_operators_element) then
				type_description.ReadStartElement_String (Binary_operators_element)
				generate_features (Binary_operators_element)
				type_description.ReadEndElement				
			end
			if type_description.Name.Equals_String (Specials_element) then
				type_description.ReadStartElement_String (Specials_element)
				generate_features (Specials_element)
				type_description.ReadEndElement				
			end
			if type_description.Name.Equals_String (Implementation_element) then
				type_description.ReadStartElement_String (Implementation_element)
				generate_features (Implementation_element)
				type_description.ReadEndElement				
			end			
			type_description.ReadEndElement
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
			valid_element_name: element_name.Equals_String (Initialization_element) or element_name.Equals_String (Access_element) or element_name.Equals_String (Element_change_element) or element_name.Equals_String (Basic_operations_element) or element_name.Equals_String (Unary_operators_element) or element_name.Equals_String (Binary_operators_element) or element_name.Equals_String (Specials_element) or element_name.Equals_String (Implementation_element)
		local
			eiffel_name, dot_net_name: STRING
			return_type, return_type_full_name: STRING			
		do
			from
			until
				not type_description.Name.Equals_String (Feature_element)
			loop
				type_description.ReadStartElement_String (Feature_element)
				create eiffel_feature.make1
				eiffel_feature.make
				
					-- Set `is_frozen', `is_static', `is_abstract', `is_method', `is_field', `is_creation_routine'.
				set_feature_info
				
					-- Set `eiffel_name'.
				eiffel_name := type_description.ReadElementString_String (Eiffel_name_element)
				if eiffel_name /= Void then
					if eiffel_name.Length > 0 then
						eiffel_feature.SetEiffelName (eiffel_name)
					end
				end	
				
					-- Set `dot_net_name'.
				if type_description.Name.Equals_String (Dot_net_name_element) then
					dot_net_name := type_description.ReadElementString_String (Dot_net_name_element)
					if dot_net_name /= Void then
						if dot_net_name.Length > 0 then
							eiffel_feature.SetDotNetName (dot_net_name)
						end
					end
				end
				
					-- Add `arguments' (if any).
				if type_description.Name.Equals_String (Arguments_element) then
					generate_arguments
				end
					
					-- Set `return_type'.
				if type_description.Name.Equals_String (Return_type_element) then
					return_type := type_description.ReadElementString_String (Return_type_element)
					if return_type /= Void then
						if return_type.Length > 0 then
							eiffel_feature.SetReturnType (return_type)
						end
					end
				end
				
					-- Set `return_type_full_name'.
				if type_description.Name.Equals_String (Return_type_full_name_element) then
					return_type_full_name := type_description.ReadElementString_String (Return_type_full_name_element) 
					if return_type_full_name /= Void then
						if return_type_full_name.Length > 0 then
							eiffel_feature.SetReturnTypeFullName (return_type_full_name)
						end
					end
				end
				
					-- Add `comments' (if any).
				if type_description.Name.Equals_String (Comments_element) then
					generate_comments
				end
				
					-- Add `preconditions' (if any).
				if type_description.Name.Equals_String (Preconditions_element) then
					generate_feature_assertions (Precondition_element)
				end
				
					-- Add `postconditions' (if any).
				if type_description.Name.Equals_String (Postconditions_element) then
					generate_feature_assertions (Postcondition_element)
				end
				
				type_description.ReadEndElement
				
				if element_name.Equals_String (Initialization_element) then
					eiffel_class.AddInitializationFeature (eiffel_feature)
				elseif element_name.Equals_String (Access_element) then
					eiffel_class.AddAccessFeature (eiffel_feature)
				elseif element_name.Equals_String (Element_change_element) then
					eiffel_class.AddElementChangeFeature (eiffel_feature)
				elseif element_name.Equals_String (Basic_operations_element) then
					eiffel_class.AddBasicOperation (eiffel_feature)
				elseif element_name.Equals_String (Unary_operators_element) then
					eiffel_class.AddUnaryOperator (eiffel_feature)
				elseif element_name.Equals_String (Binary_operators_element) then
					eiffel_class.AddBinaryOperator (eiffel_feature)
				elseif element_name.Equals_String (Specials_element) then
					eiffel_class.AddSpecialFeature (eiffel_feature)
				elseif element_name.Equals_String (Implementation_element) then
					eiffel_class.AddImplementationFeature (eiffel_feature)
				end
			end
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
		do
				-- Set `is_frozen'.
			frozen_feature := type_description.ReadElementString_String (Frozen_feature_element)
			if frozen_feature.Equals_String (True_string) then
				eiffel_feature.SetFrozen (True)
			elseif frozen_feature.Equals_String (False_string) then
				eiffel_feature.SetFrozen (False)
			end

				-- Set `is_static'.
			static := type_description.ReadElementString_String (Static_element)
			if static.Equals_String (True_string) then
				eiffel_feature.SetStatic (True)
			elseif static.Equals_String (False_string) then
				eiffel_feature.SetStatic (False)
			end

				-- Set `is_abstract'.
			abstract := type_description.ReadElementString_String (Abstract_element)
			if abstract.Equals_String (True_string) then
				eiffel_feature.SetAbstract (True)
			elseif abstract.Equals_String (False_string) then
				eiffel_feature.SetAbstract (False)
			end

				-- Set `is_method'.
			is_method := type_description.ReadElementString_String (Method_element)
			if is_method.Equals_String (True_string) then
				eiffel_feature.SetMethod (True)
			elseif is_method.Equals_String (False_string) then
				eiffel_feature.SetMethod (False)
			end

				-- Set `is_field'.
			is_field := type_description.ReadElementString_String (Field_element)
			if is_field.Equals_String (True_string) then
				eiffel_feature.SetField (True)
			elseif is_field.Equals_String (False_string) then
				eiffel_feature.SetField (False)
			end				

				-- Set `is_creation_routine'.
			is_creation_routine := type_description.ReadElementString_String (Creation_routine_element)
			if is_creation_routine.Equals_String (True_string) then
				eiffel_feature.SetCreationRoutine (True)
			elseif is_creation_routine.Equals_String (False_string) then
				eiffel_feature.SetCreationRoutine (False)
			end

				-- Set `is_prefix'.
			is_prefix := type_description.ReadElementString_String (Prefix_element)
			if is_prefix.Equals_String (True_string) then
				eiffel_feature.SetPrefix (True)
			elseif is_prefix.Equals_String (False_string) then
				eiffel_feature.SetPrefix (False)
			end

				-- Set `is_infix'.
			is_infix := type_description.ReadElementString_String (Infix_element)
			if is_infix.Equals_String (True_string) then
				eiffel_feature.SetInfix (True)
			elseif is_infix.Equals_String (False_string) then
				eiffel_feature.SetInfix (False)
			end	
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
			dot_net_name: STRING
			type: STRING
			type_full_name: STRING
		do
			type_description.ReadStartElement_String (Arguments_element)
			from
			until
				not type_description.Name.Equals_String (Argument_element) 
			loop
				type_description.ReadStartElement_String (Argument_element)
				eiffel_name := type_description.ReadElementString_String (Eiffel_argument_name_element)
				dot_net_name := type_description.ReadElementString_String (Dot_net_argument_name_element)
				type := type_description.ReadElementString_String (Argument_type_element)
				type_full_name := type_description.ReadElementString_String (Argument_type_full_name_element)
				if eiffel_name /= Void and dot_net_name /= Void and type /= Void and type_full_name /= Void then
					if eiffel_name.Length > 0 and dot_net_name.Length > 0 and type.Length > 0 and type_full_name.Length > 0 then
						eiffel_feature.AddArgument (eiffel_name, dot_net_name, type, type_full_name)	
					end
				end
				type_description.ReadEndElement
			end
			type_description.ReadEndElement
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
		do
			comments_string := type_description.ReadElementString_String (Comments_element)
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

	generate_feature_assertions (element_name: STRING) is
			-- Add preconditions or postconditions (depending on `element_name') to `eiffel_feature'.
		indexing
			external_name: "GenerateFeatureAssertions"
		require
			non_void_feature: eiffel_feature /= Void
			non_void_type_description: type_description /= Void
			non_void_element_name: element_name /= Void
			not_empty_element_name: element_name.Length > 0
			valid_element_name: element_name.Equals_String (Precondition_element) or element_name.Equals_String (Postcondition_element)
		local
			tag: STRING
			text: STRING			
		do	
			if element_name.Equals_String (Precondition_element) then
				type_description.ReadStartElement_String (Preconditions_element)
			elseif element_name.Equals_String (Postcondition_element) then
				type_description.ReadStartElement_String (Postconditions_element)
			end
			from
			until
				not type_description.Name.Equals_String (element_name) 
			loop
				type_description.ReadStartElement_String (element_name)
				if element_name.Equals_String (Precondition_element) then
					tag := type_description.ReadElementString_String (Precondition_tag_element)
					text := type_description.ReadElementString_String (Precondition_text_element)
				elseif element_name.Equals_String (Postcondition_element) then
					tag := type_description.ReadElementString_String (Postcondition_tag_element)
					text := type_description.ReadElementString_String (Postcondition_text_element)
				end
				if tag /= Void and text /= Void then
					if text.Length > 0 then
						if element_name.Equals_String (Precondition_element) then
							eiffel_feature.AddPrecondition (tag, text)
						elseif element_name.Equals_String (Postcondition_element) then
							eiffel_feature.AddPostcondition (tag, text)
						end
					end
				end
				type_description.ReadEndElement
			end
			type_description.ReadEndElement
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
		do
			type_description.ReadStartElement_String (Footer_element)
			if type_description.Name.Equals_String (Invariants_element) then
				type_description.ReadStartElement_String (Invariants_element) 
				from
				until
					not type_description.Name.Equals_String (Invariant_element) 
				loop
					type_description.ReadStartElement_String (Invariant_element)
					tag := type_description.ReadElementString_String (Invariant_tag_element)
					text := type_description.ReadElementString_String (Invariant_text_element)
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

	errors_table: ERRORS_TABLE is
			-- Errors table
		indexing
			external_name: "ErrorsTable"
		once
			create Result.make
		ensure
			table_created: Result /= Void
		end
		
	valid_characters: ARRAY [STRING] is 
			-- Valid characters for files and directories
		indexing
			external_name: "ValidCharacters"
		once
			create Result.make (256)
			Result.put (0, "a") 
			Result.put (1, "b") 
			Result.put (2, "c") 
			Result.put (3, "d") 
			Result.put (4, "e") 
			Result.put (5, "f") 
			Result.put (6, "g") 
			Result.put (7, "h") 
			Result.put (8, "i") 
			Result.put (9, "j") 
			Result.put (10, "k") 
			Result.put (11, "l") 
			Result.put (12, "m") 
			Result.put (13, "n") 
			Result.put (14, "o") 
			Result.put (15, "p") 
			Result.put (16, "q") 
			Result.put (17, "r") 
			Result.put (18, "s") 
			Result.put (19, "t")
			Result.put (20, "u") 
			Result.put (21, "v") 
			Result.put (22, "w") 
			Result.put (23, "x") 
			Result.put (24, "y") 
			Result.put (25, "z") 
			Result.put (26, "0") 
			Result.put (27, "1") 
			Result.put (28, "2") 
			Result.put (29, "3") 
			Result.put (30, "4") 
			Result.put (31, "5") 
			Result.put (32, "6") 
			Result.put (33, "7") 
			Result.put (34, "8") 
			Result.put (35, "9") 
			Result.put (36, "%%") 
			Result.put (37, "'") 
			Result.put (38, "`") 
			Result.put (39, "-") 
			Result.put (40, "{") 
			Result.put (41, "}") 
			Result.put (42, "!") 
			Result.put (43, "#") 
			Result.put (44, "(") 
			Result.put (45, ")") 
			Result.put (46, "&") 
			Result.put (47, "^") 
			Result.put (48, "@a") 
			Result.put (49, "@b") 
			Result.put (50, "@c") 
			Result.put (51, "@d") 
			Result.put (52, "@e") 
			Result.put (53, "@f") 
			Result.put (54, "@g") 
			Result.put (55, "@h") 
			Result.put (56, "@i") 
			Result.put (57, "@j") 
			Result.put (58, "@k") 
			Result.put (59, "@l") 
			Result.put (60, "@m") 
			Result.put (61, "@n") 
			Result.put (62, "@o") 
			Result.put (63, "@p") 
			Result.put (64, "@q") 
			Result.put (65, "@r") 
			Result.put (66, "@s") 
			Result.put (67, "@t") 
			Result.put (68, "@u") 
			Result.put (69, "@v") 
			Result.put (70, "@w") 
			Result.put (71, "@x") 
			Result.put (72, "@y") 
			Result.put (73, "@z") 
			Result.put (74, "@0") 
			Result.put (75, "@1") 
			Result.put (76, "@2") 
			Result.put (77, "@3") 
			Result.put (78, "@4") 
			Result.put (79, "@5") 
			Result.put (80, "@6") 
			Result.put (81, "@7") 
			Result.put (82, "@8") 
			Result.put (83, "@9") 
			Result.put (84, "@$") 
			Result.put (85, "@%%")
			Result.put (86, "@'") 
			Result.put (87, "@`") 
			Result.put (88, "@-") 
			Result.put (89, "@@") 
			Result.put (90, "@{") 
			Result.put (91, "@}") 
			Result.put (92, "@~") 
			Result.put (93, "@!") 
			Result.put (94, "@#") 
			Result.put (95, "@(") 
			Result.put (96, "@)") 
			Result.put (97, "@&") 
			Result.put (98, "@_") 
			Result.put (99, "@^") 
			Result.put (100, "_a") 
			Result.put (101, "_b") 
			Result.put (102, "_c") 
			Result.put (103, "_d") 
			Result.put (104, "_e") 
			Result.put (105, "_f") 
			Result.put (106, "_g") 
			Result.put (107, "_h") 
			Result.put (108, "_i") 
			Result.put (109, "_j") 
			Result.put (110, "_k") 
			Result.put (111, "_l") 
			Result.put (112, "_m") 
			Result.put (113, "_n") 
			Result.put (114, "_o") 
			Result.put (115, "_p") 
			Result.put (116, "_q") 
			Result.put (117, "_r") 
			Result.put (118, "_s") 
			Result.put (119, "_t") 
			Result.put (120, "_u") 
			Result.put (121, "_v") 
			Result.put (122, "_w") 
			Result.put (123, "_x") 
			Result.put (124, "_y") 
			Result.put (125, "_z") 
			Result.put (126, "_0") 
			Result.put (127, "_1") 
			Result.put (128, "_2") 
			Result.put (129, "_3") 
			Result.put (130, "_4") 
			Result.put (131, "_5") 
			Result.put (132, "_6") 
			Result.put (133, "_7") 
			Result.put (134, "_8") 
			Result.put (135, "_9") 
			Result.put (136, "_$") 
			Result.put (137, "_%%") 
			Result.put (138, "_'") 
			Result.put (139, "_`") 
			Result.put (140, "_-") 
			Result.put (141, "_@") 
			Result.put (142, "_{") 
			Result.put (143, "_}") 
			Result.put (144, "_~") 
			Result.put (145, "_!") 
			Result.put (146, "_#") 
			Result.put (147, "_(") 
			Result.put (148, "_)") 
			Result.put (149, "_&") 
			Result.put (150, "__") 
			Result.put (151, "_^") 
			Result.put (152, "~a") 
			Result.put (153, "~b") 
			Result.put (154, "~c") 
			Result.put (155, "~d") 
			Result.put (156, "~e") 
			Result.put (157, "~f") 
			Result.put (158, "~g") 
			Result.put (159, "~h") 
			Result.put (160, "~i") 
			Result.put (161, "~j") 
			Result.put (162, "~k") 
			Result.put (163, "~l") 
			Result.put (164, "~m") 
			Result.put (165, "~n") 
			Result.put (166, "~o") 
			Result.put (167, "~p") 
			Result.put (168, "~q") 
			Result.put (169, "~r") 
			Result.put (170, "~s") 
			Result.put (171, "~t") 
			Result.put (172, "~u") 
			Result.put (173, "~v") 
			Result.put (174, "~w") 
			Result.put (175, "~x") 
			Result.put (176, "~y") 
			Result.put (177, "~z") 
			Result.put (178, "~0") 
			Result.put (179, "~1") 
			Result.put (180, "~2") 
			Result.put (181, "~3") 
			Result.put (182, "~4") 
			Result.put (183, "~5") 
			Result.put (184, "~6") 
			Result.put (185, "~7") 
			Result.put (186, "~8") 
			Result.put (187, "~9") 
			Result.put (188, "~$") 
			Result.put (189, "~%%") 
			Result.put (190, "~'") 
			Result.put (191, "~`") 
			Result.put (192, "~-") 
			Result.put (193, "~@") 
			Result.put (194, "~{") 
			Result.put (195, "~}") 
			Result.put (196, "~~") 
			Result.put (197, "~!") 
			Result.put (198, "~#") 
			Result.put (199, "~(") 
			Result.put (200, "~)") 
			Result.put (201, "~&") 
			Result.put (202, "~_") 
			Result.put (203, "~^") 
			Result.put (204, "$a") 
			Result.put (205, "$b") 
			Result.put (206, "$c") 
			Result.put (207, "$d") 
			Result.put (208, "$e") 
			Result.put (209, "$f") 
			Result.put (210, "$g") 
			Result.put (211, "$h") 
			Result.put (212, "$i") 
			Result.put (213, "$j") 
			Result.put (214, "$k") 
			Result.put (215, "$l") 
			Result.put (216, "$m") 
			Result.put (217, "$n") 
			Result.put (218, "$o") 
			Result.put (219, "$p") 
			Result.put (220, "$q") 
			Result.put (221, "$r") 
			Result.put (222, "$s") 
			Result.put (223, "$t") 
			Result.put (224, "$u") 
			Result.put (225, "$v") 
			Result.put (226, "$w") 
			Result.put (227, "$x") 
			Result.put (228, "$y") 
			Result.put (229, "$z") 
			Result.put (230, "$0") 
			Result.put (231, "$1") 
			Result.put (232, "$2") 
			Result.put (233, "$3") 
			Result.put (234, "$4") 
			Result.put (235, "$5") 
			Result.put (236, "$6") 
			Result.put (237, "$7") 
			Result.put (238, "$8") 
			Result.put (239, "$9") 
			Result.put (240, "$$") 
			Result.put (241, "$%%") 
			Result.put (242, "$'") 
			Result.put (243, "$`") 
			Result.put (244, "$-") 
			Result.put (245, "$@") 
			Result.put (246, "${") 
			Result.put (247, "$}") 
			Result.put (248, "$~") 
			Result.put (249, "$!") 
			Result.put (250, "$#") 
			Result.put (251, "$(") 
			Result.put (252, "$)") 
			Result.put (253, "$&") 
			Result.put (254, "$_") 
			Result.put (255, "$^")
		ensure
			table_created: Result /= Void
			valid_table: Result.count = 256
		end
		
end -- class SUPPPORT
