indexing
	description: "Provide support for code generation."
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	CODE_GENERATION_SUPPORT
	
inherit
	SUPPORT
	SUPPORT_SUPPORT
	
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `error_messages' and `xml_elements'."
		do
			create error_messages
			create xml_elements
		ensure
			non_void_error_messages: error_messages /= Void
			non_void_xml_elements: xml_elements /= Void
		end

feature -- Access				
		
	Write_lock_filename: STRING is 
		indexing
			description: "Read lock filename"
		once
			Result := "write_lock.txt"
		end
		
	Read_lock_filename: STRING is 
		indexing
			description: "Read lock filename"
		once
			Result := "read_lock.txt"
		end

	eiffel_class_from_xml (a_filename: STRING): EIFFEL_CLASS is
		indexing
			description: "Instance of `eiffel_class' corresponding to Xml file with filename `a_filename'"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.count > 0
			valid_filename: is_valid_filename (a_filename)
		local
			retried: BOOLEAN
			white_space_handling: expanded SYSTEM_XML_WHITESPACE_HANDLING
			slash_index: INTEGER
			base_path: STRING
			read_lock: STRING
			file: PLAIN_TEXT_FILE
			filestream: FILE_STREAM
		do
			if not retried then
				create type_description.make_system_xml_xml_text_reader_10 (a_filename.to_cil)
				type_description.set_Whitespace_Handling (white_space_handling.none)
				
				--eiffel_class := create {IMPLEMENTATION_EIFFEL_CLASS}.make1
				--eiffel_class.make1
				create eiffel_class.Make
				type_description.Read_start_element_String (xml_elements.Class_element.to_cil)
				generate_class_header
				generate_class_body
				if type_description.get_Name.Equals (xml_elements.Footer_element.to_cil) then
					generate_class_footer
				end
				type_description.Close
				Result := eiffel_class
				eiffel_class := Void
				slash_index := a_filename.last_index_of ('\', a_filename.count)
				if slash_index /= 0 then
					base_path := a_filename.clone (a_filename)
					base_path.append_integer (0)
					base_path.append_integer (slash_index)
					base_path.prune_all_leading (' ')
					base_path.prune_all_trailing (' ')
					
					read_lock := clone (base_path)
					read_lock.append (Read_lock_filename)
					
					create file.make (read_lock)
					if file.exists then
						file.Delete
					end
				end
			else
				Result := Void
				slash_index := a_filename.last_index_of ('\', a_filename.count)
				if slash_index /= 0 then
					base_path := a_filename.clone (a_filename)
					base_path.append_integer (0)
					base_path.append_integer (slash_index)
					base_path.prune_all_leading (' ')
					base_path.prune_all_trailing (' ')
					
					read_lock := clone (base_path)
					read_lock.append (Read_lock_filename)
					
					create file.make (read_lock)
					if file.exists then
						file.Delete
					end
				end
			end
		rescue
			retried := True
			create_error (error_messages.Eiffel_class_generation_failed, error_messages.Eiffel_class_generation_failed_message)
			retry
		end	

	eiffel_assembly_from_xml (a_filename: STRING): EIFFEL_ASSEMBLY is
		indexing
			description: "Instance of `eiffel_assembly' corresponding to Xml file with filename `a_filename'"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.count > 0
			valid_filename: is_valid_filename (a_filename)
		local
			assembly_description: SYSTEM_XML_XML_TEXT_READER
			assembly_name: STRING
			assembly_version: STRING
			assembly_culture: STRING
			assembly_public_key: STRING
			eiffel_cluster_path: STRING
			emitter_version_number: STRING
			a_descriptor: ASSEMBLY_DESCRIPTOR
			retried: BOOLEAN
			reflection_support: REFLECTION_SUPPORT
			white_space_handling: expanded SYSTEM_XML_WHITESPACE_HANDLING
			slash_index: INTEGER
			base_path: STRING
			read_lock: STRING
			file: PLAIN_TEXT_FILE
			filestream: FILE_STREAM
		do
			if not retried then
				create reflection_support.make
				create assembly_description.make_system_xml_xml_text_reader_10 (a_filename.to_cil)	
				assembly_description.set_Whitespace_Handling (white_space_handling.none)
				
				assembly_description.Read_Start_Element_String (xml_elements.Assembly_element.to_cil)

					-- Set `assembly_name'.
				if assembly_description.get_name.Equals (xml_elements.Assembly_name_element.to_cil) then
					assembly_name := from_system_string (assembly_description.read_element_string_string (xml_elements.Assembly_name_element.to_cil))
				end

					-- Set `assembly_version'.
				if assembly_description.get_name.Equals (xml_elements.Assembly_version_element.to_cil) then
					assembly_version := from_system_string (assembly_description.read_element_string_string (xml_elements.Assembly_version_element.to_cil))
				end

					-- Set `assembly_culture'.
				if assembly_description.get_name.Equals (xml_elements.Assembly_culture_element.to_cil) then
					assembly_culture := from_system_string (assembly_description.read_element_string_string (xml_elements.Assembly_culture_element.to_cil))
				end

					-- Set `assembly_public_key'.
				if assembly_description.get_name.Equals (xml_elements.Assembly_public_key_element.to_cil) then
					assembly_public_key := from_system_string (assembly_description.read_element_string_string (xml_elements.Assembly_public_key_element.to_cil))
				end

					-- Set `eiffel_cluster_path'.
				if assembly_description.get_Name.Equals (xml_elements.Eiffel_cluster_path_element.to_cil) then
					eiffel_cluster_path := from_system_string (assembly_description.read_element_string_string (xml_elements.Eiffel_cluster_path_element.to_cil))
					if eiffel_cluster_path.substring_index (reflection_support.Eiffel_key, 1) > 0 then
						eiffel_cluster_path.replace_substring_all (reflection_support.Eiffel_key, reflection_support.Eiffel_delivery_path)
						--eiffel_cluster_path := eiffel_cluster_path
					end
				end

				-- Set `emitter_version_number'.
				if assembly_description.get_Name.Equals (xml_elements.Emitter_version_number_element.to_cil) then
					emitter_version_number := from_system_string (assembly_description.read_element_string_string (xml_elements.Emitter_version_number_element.to_cil))
				end
				
				if assembly_name /= Void and assembly_version /= Void and assembly_culture /= Void and assembly_public_key /= Void and then
					assembly_name.count > 0 and assembly_version.count > 0 and assembly_culture.count > 0 and assembly_public_key.count > 0 then
				
					--a_descriptor := create {IMPLEMENTATION_ASSEMBLY_DESCRIPTOR}.make1
					create a_descriptor.make (assembly_name, assembly_version, assembly_culture, assembly_public_key)
					create Result.make (a_descriptor, eiffel_cluster_path, emitter_version_number)
				else
					Result := Void
				end
				assembly_description.Close
				slash_index := a_filename.last_index_of ('\', a_filename.count)
				if slash_index /= 0 then
					base_path := clone (a_filename)
					base_path.append_integer (0)
					base_path.append_integer (slash_index)
					base_path.prune_all_leading (' ')
					base_path.prune_all_trailing (' ')
					
					read_lock := clone (base_path)
					read_lock.append (Read_lock_filename)
					
					create file.make (read_lock)
					if file.exists then
						file.delete
					end
				end
			else
				Result := Void
				slash_index := a_filename.last_index_of ('\', a_filename.count)
				if slash_index /= 0 then
					base_path := clone (a_filename)
					base_path.append_integer (0)
					base_path.append_integer (slash_index)
					base_path.prune_all_leading (' ')
					base_path.prune_all_trailing (' ')
					
					read_lock := clone (base_path)
					read_lock.append (Read_lock_filename)
					
					create file.make (read_lock)
					if file.exists then
						file.delete
					end
				end
			end
		rescue
			retried := True
			create_error (error_messages.Eiffel_assembly_generation_failed, error_messages.Eiffel_assembly_generation_failed_message)
			retry
		end

	generic_type_names: ARRAY [STRING]
		indexing
			description: "Generic type names of current Eiffel class"
		end
		
feature -- Status Report

	has_write_lock (a_folder_name: STRING): BOOLEAN is
		indexing
			description: "Does folder with name `a_folder_name' have a `write_lock' file?"
		require
			non_void_folder_name: a_folder_name /= Void
			not_empty_folder_name: a_folder_name.count > 0
		local
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN
			folder_name: STRING
		do
			if not retried then
				folder_name := clone (a_folder_name);
				folder_name.append ("\")
				folder_name.append (Write_lock_filename)
				
				create file.make (folder_name)
				Result := file.Exists
			else
				Result := False
			end
		rescue
			retried := True
			create_error (error_messages.Write_lock, error_messages.Write_lock_message)
			retry
		end

	has_read_lock (a_folder_name: STRING): BOOLEAN is
		indexing
			description: "Does folder with name `a_folder_name' have a `read_lock' file?"
		require
			non_void_folder_name: a_folder_name /= Void
			not_empty_folder_name: a_folder_name.count > 0
		local
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN
			folder_name: STRING
		do
			if not retried then
				folder_name := clone (a_folder_name)
				folder_name.append ("\")
				folder_name.append (Read_lock_filename)
				
				create file.make (folder_name)
				Result := file.Exists
			else
				Result := False
			end
		rescue
			retried := True
			create_error (error_messages.Read_lock, error_messages.Read_lock_message)
			retry
		end

	is_valid_directory_path (a_path: STRING): BOOLEAN is
		indexing
			description: "Is `a_path' valid?"
		require
			non_void_path: a_path /= Void
			not_empty_path: a_path.count > 0
		local
			dir: DIRECTORY
		do
			create dir.make (a_path)
			Result := dir.exists
		end

	is_valid_filename (a_filename: STRING): BOOLEAN is
		indexing
			description: "Is `a_filename' a valid file name?"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.count > 0
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make (a_filename)
			Result := file.exists
		end
		
feature -- Basic Operations

	create_folder (a_path: STRING) is
		indexing
			description: "Create folder with path `a_path' (recursively)."
		require
			non_void_path: a_path /= Void
			not_empty_path: a_path.count > 0		
		local
			i: INTEGER
			folder_names: LINKED_LIST [STRING]
			a_folder_name: STRING
			folder_path: STRING
			path: STRING
			slash_index: INTEGER
			dir: DIRECTORY		
			info: DIRECTORY_INFO
			path_exists: BOOLEAN
		do
			create folder_names.make
			path := a_path.clone (a_path)
			from
				slash_index := path.last_index_of ('\', path.count) 
			until
				path_exists or slash_index = 0
			loop
				folder_names.extend (path.substring (slash_index + 1, path.count))
				
				create dir.make (path.substring (1, slash_index))
				path_exists := dir.exists
				
				path := path.substring (1, slash_index - 1)
				slash_index := path.last_index_of ('\', path.count)
			end
			from
				folder_path := path
				folder_names.finish
			until
				folder_names.before
			loop
				a_folder_name ?= folder_names.item	
				if a_folder_name /= Void then
					folder_path.append ( "\")
					folder_path.append (a_folder_name)
					
					create dir.make (folder_path)
					dir.create_dir
				end
				folder_names.back
			end
		ensure
			valid_path: is_valid_directory_path (a_path)
		end
	
	compute_generic_names (a_count: INTEGER) is
		indexing
			description: "Compute `a_count' generic names and set `generic_type_names' with the computed value."
		local
			i, j: INTEGER
			a_generic_name: STRING
		do
			create generic_type_names.make (0, a_count - 1)
			if a_count <= generic_names_table.count then
				from
				until
					i = a_count
				loop
					generic_type_names.put (generic_names_table.item (i), i)
					i := i + 1
				end
			else
				from
				until
					i = generic_names_table.count
				loop
					generic_type_names.put (generic_names_table.item (i), i)
					i := i + 1
				end
				from
					j := 1
				until
					i = a_count
				loop
					a_generic_name := from_system_string (j.to_string)
					a_generic_name.prepend (generic_name_base) -- allows for not another variable to be used
					generic_type_names.put (a_generic_name, i)
					j := j + 1
					i := i + 1
				end
			end
		ensure
			non_void_generic_names: generic_type_names /= Void
			valid_generic_names: generic_type_names.count = a_count
		end
		
feature {NONE} -- Implementation

	generic_names_table: ARRAY [STRING] is
		indexing
			description: "Possible generic names"
		once
			create Result.make (0, 7)
			Result.put ("G", 0)
			Result.put ("H", 1)
			Result.put ("K", 2)
			Result.put ("L", 3)
			Result.put ("M", 4)
			Result.put ("N", 5)
			Result.put ("O", 6)
			Result.put ("P", 7)
		ensure
			non_void_table: Result /= Void
			valid_table: Result.count = 8
		end
	
	generic_name_base: STRING is "G__"
		indexing
			description: "Generic name base (when there are more than `generic_names_table.count' generic derivations)"
		end

	error_messages: CODE_GENERATION_SUPPORT_ERROR_MESSAGES
		indexing
			description: "Error messages"
		end
		
	xml_elements: XML_ELEMENTS
		indexing
			description: "XML elements"
		end
		
	type_description: SYSTEM_XML_XML_TEXT_READER
		indexing
			description: "Xml reader corresponding to type description XML file"
		end
		
	eiffel_class: EIFFEL_CLASS
		indexing
			description: "Eiffel class generated from `assembly_description' and `type_description'"
		end

	eiffel_feature: EIFFEL_FEATURE
		indexing
			description: "Eiffel feature built from `type_description'"
		end
		
	generate_class_header is
		indexing
			description: "Set `eiffel_class' attributes corresponding to the XML element `header'."
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void
		local
			is_modified, is_frozen, is_expanded, is_deferred, is_generic, create_none: STRING
			class_name: STRING
			simple_name: STRING
			namespace: STRING
			assembly_name: STRING
			assembly_version: STRING
			assembly_culture: STRING
			assembly_public_key: STRING
			enum_type: STRING
			descriptor: ASSEMBLY_DESCRIPTOR
			creation_routines_string: STRING
			comma_index: INTEGER
			retried: BOOLEAN
			
			ise_eiffel_component_string: STRING
		do
			if not retried then
				type_description.Read_Start_Element_String (xml_elements.Header_element.to_cil)

					-- Set `modified'.		
				if type_description.get_name.Equals (xml_elements.Modified_element.to_cil) then
					is_modified := from_system_string (type_description.Read_Element_String_String (xml_elements.Modified_element.to_cil))
					if is_modified.is_equal (xml_elements.True_string) then
						eiffel_class.set_modified (True)
					elseif is_modified.is_equal (xml_elements.False_string) then
						eiffel_class.set_modified (False)
					end
				end
				
					-- Set `is_frozen'.		
				is_frozen :=  from_system_string ( type_description.Read_Element_String_String (xml_elements.Frozen_element.to_cil) )
				if is_frozen.is_equal (xml_elements.True_string) then
					eiffel_class.Set_Frozen (True)
				elseif is_frozen.is_equal (xml_elements.False_string) then
					eiffel_class.Set_Frozen (False)
				end

					-- Set `is_expanded'.
				is_expanded := from_system_string ( type_description.Read_Element_String_String (xml_elements.Expanded_element.to_cil) )
				if is_expanded.is_equal (xml_elements.True_string) then
					eiffel_class.Set_Expanded (True)
				elseif is_expanded.is_equal (xml_elements.False_string) then
					eiffel_class.Set_Expanded (False)
				end

					-- Set `is_deferred'.
				is_deferred :=  from_system_string ( type_description.Read_Element_String_String (xml_elements.Deferred_element.to_cil) )
				if is_deferred.is_equal (xml_elements.True_string) then
					eiffel_class.Set_Deferred (True)
				elseif is_deferred.is_equal (xml_elements.False_string) then
					eiffel_class.Set_Deferred (False)
				end

					-- Set `is_generic'.
				is_generic := from_system_string ( type_description.Read_Element_String_String (xml_elements.Generic_element.to_cil) )
				if is_generic.is_equal (xml_elements.True_string) then
					eiffel_class.set_generic (True)
				elseif is_generic.is_equal (xml_elements.False_string) then
					eiffel_class.set_generic (False)
				end
				
				if type_description.get_name.Equals (xml_elements.Generic_derivations_element.to_cil) then
					generate_generic_derivations
				end
				
					-- Set `eiffel_name'.
				class_name := from_system_string ( type_description.Read_Element_String_String (xml_elements.Class_eiffel_name_element.to_cil) )
				if class_name /= Void and then class_name.count > 0 then
					eiffel_class.Set_eiffel_name ( to_component_string (class_name))
				end

					-- Set `external_name'.
				type_description.Read_Start_Element_String (xml_elements.Alias_element.to_cil)
				simple_name := from_system_string ( type_description.read_element_string_string (xml_elements.Simple_name_element.to_cil) )
				if simple_name /= Void and then simple_name.count > 0 then
					eiffel_class.Set_external_name ( to_component_string (simple_name) )
				end		
					-- Set `namespace'.
				if type_description.get_Name.Equals (xml_elements.Namespace_element.to_cil) then
					namespace := from_system_string ( type_description.read_element_string_string (xml_elements.Namespace_element.to_cil) )
					if namespace /= Void and then namespace.count > 0 then
						eiffel_class.Set_namespace ( to_component_string (namespace) )
					end	
				end
					-- Set `assembly_descriptor'.
				assembly_name := from_system_string (type_description.Read_Element_String_String (xml_elements.Assembly_name_element.to_cil))
				if type_description.get_Name.Equals (xml_elements.Assembly_version_element.to_cil) then
					assembly_version := from_system_string ( type_description.read_element_string_string (xml_elements.Assembly_version_element.to_cil) )
				else
					assembly_version :=  xml_elements.Empty_string.clone (xml_elements.Empty_string)
				end
				if type_description.get_Name.Equals (xml_elements.Assembly_culture_element.to_cil) then
					assembly_culture := from_system_string ( type_description.read_element_string_string (xml_elements.Assembly_culture_element.to_cil) )
				else
					assembly_culture := xml_elements.Empty_string.clone (xml_elements.Empty_string)
				end	
				if type_description.get_Name.Equals (xml_elements.Assembly_public_key_element.to_cil) then	
					assembly_public_key := from_system_string ( type_description.read_element_string_string (xml_elements.Assembly_public_key_element.to_cil) )
				else
					assembly_public_key := xml_elements.Empty_string.clone (xml_elements.Empty_string)
				end
					-- Set `enum_type'.
				if type_description.get_Name.Equals (xml_elements.Enum_type_element.to_cil) then
					enum_type := from_system_string (type_description.read_element_string_string (xml_elements.Enum_type_element.to_cil))
					if enum_type /= Void and then enum_type.count > 0 then
						eiffel_class.Set_External_Name (enum_type)
					end	
				end
				type_description.read_end_element
				--descriptor := create {IMPLEMENTATION_ASSEMBLY_DESCRIPTOR}.make1
				--create descriptor.make1
				create descriptor.make ( to_component_string (assembly_name), to_component_string (assembly_version), to_component_string (assembly_culture), to_component_string (assembly_public_key))
				eiffel_class.Set_Assembly_Descriptor (descriptor)

					-- Set `full_external_name'
				if eiffel_class.namespace /= Void then
					--ise_eiffel_component_string := create {IMPLEMENTATION_STRING}.make1
					--ise_eiffel_component_string := from_system_string (xml_elements.Dot_string.to_cil)
					
					--namespace.append (ise_eiffel_component_string)
					namespace := namespace.clone (namespace)
					namespace.append (xml_elements.Dot_string)
					namespace.append (simple_name)
					eiffel_class.set_full_external_name ( to_component_string (namespace))
				else
					eiffel_class.set_full_external_name ( to_component_string (simple_name))
				end

					-- Set `parents'.
				generate_parents

					-- Set `creation_routines'.
				if type_description.get_Name.Equals (xml_elements.Create_element.to_cil) then
					creation_routines_string := from_system_string ( type_description.read_element_string_string (xml_elements.Create_element.to_cil) )
				end

					-- Set `create_none'.
				create_none := from_system_string ( type_description.Read_Element_String_String (xml_elements.Create_none_element.to_cil) )
				if create_none.is_equal (xml_elements.True_string) then
					eiffel_class.Set_Create_None (True)
				elseif create_none.is_equal (xml_elements.False_string) then
					eiffel_class.Set_Create_None (False)
				end

				type_description.read_end_element
			end
		rescue
			retried := True
			create_error (error_messages.Class_header_generation_failed, error_messages.Class_header_generation_failed_message)
			retry
		end
	
	generate_generic_derivations is
		indexing
			description: "Add generic derivations to `eiffel_class' if it is a generic class."
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void
			generic_derivations_currently_read: type_description.get_name.Equals (xml_elements.Generic_derivations_element.to_cil)
			is_generic: eiffel_class.is_generic
		local
			generic_derivations: LINKED_LIST[GENERIC_DERIVATION] --[CLI_CELL[GENERIC_DERIVATION]]
			--generic_item: GENERIC_DERIVATION -- CLI_CELL[GENERIC_DERIVATION]
			
			generic_derivation: GENERIC_DERIVATION
			eiffel_name: STRING
			external_name: STRING
			a_type: SIGNATURE_TYPE
			convert: CONVERT
			
			derivations: ARRAY[GENERIC_DERIVATION] -- _ANY --[CLI_CELL[GENERIC_DERIVATION]]
			a_derivation: GENERIC_DERIVATION --CLI_CELL[GENERIC_DERIVATION]
			derivation_types_count: STRING
			i: INTEGER

			retried: BOOLEAN
			constraints: ARRAY [STRING]--_ANY
			a_constraint: STRING
		do
			if not retried then
				type_description.read_start_element_string (xml_elements.Generic_derivations_element.to_cil)
				from
					create generic_derivations.make
				until
					 not type_description.get_name.Equals (xml_elements.Generic_derivation_element.to_cil)
				loop
					type_description.read_start_element_string (xml_elements.Generic_derivation_element.to_cil)
					derivation_types_count := from_system_string ( type_description.read_element_string_string (xml_elements.Derivation_types_count_element.to_cil) )
					--generic_derivation := create {GENERIC_DERIVATION}.make1
					--create generic_derivation.make1
					create generic_derivation.make (convert.to_int32_string (derivation_types_count.to_cil))
					from
					until 
						not type_description.get_name.Equals (xml_elements.Generic_type_element.to_cil)
					loop
						type_description.read_start_element_string (xml_elements.Generic_type_element.to_cil)
						eiffel_name := from_system_string ( type_description.read_element_string_string (xml_elements.Generic_type_eiffel_name_element.to_cil) )
						external_name := from_system_string ( type_description.read_element_string_string (xml_elements.Generic_type_external_name_element.to_cil) )
						if eiffel_name /= Void and then eiffel_name.count > 0 
								and then external_name /= Void and then external_name.count > 0 then
							--a_type := create {SIGNATURE_TYPE}.make1
							--create a_type.make1
							create a_type.make
							a_type.set_type_eiffel_name ( to_component_string (eiffel_name))
							a_type.set_type_full_external_name ( to_component_string (external_name))
							generic_derivation.add_derivation_type (a_type)
						end
						type_description.read_end_element
					end
					--create generic_item.put (generic_derivation)
					generic_derivations.extend (generic_derivation)
					type_description.read_end_element
				end
				type_description.read_end_element
				if generic_derivations /= Void and then generic_derivations.count > 0 then
					from
						--derivations := create {IMPLEMENTATION_ARRAY_ANY}.make1
						--create derivations.make1
						create derivations.make (0, generic_derivations.count - 1)
					until 
						i = generic_derivations.count
					loop
						a_derivation ?= generic_derivations.i_th (i)
						if a_derivation /= Void then
							derivations.put (a_derivation, i) 
						end
						i := i + 1
					end
					eiffel_class.set_generic_derivations (derivations)
			
					type_description.read_start_element_string (xml_elements.Constraints_element.to_cil)
					from
						--constraints := create {IMPLEMENTATION_ARRAY_ANY}.make1
						--create constraints.make1
						create constraints.make (0, derivations.count - 1)
						i := 0
					until
						not type_description.get_name.Equals (xml_elements.Constraint_element.to_cil)
					loop
						a_constraint := from_system_string (type_description.read_element_string_string (xml_elements.Constraint_element.to_cil))
						if a_constraint /= Void then
							constraints.put (a_constraint, i)
							i := i + 1
						end
					end
					type_description.read_end_element
					eiffel_class.set_constraints (constraints)
				end
			end
		rescue
			retried := True
			create_error (error_messages.Generic_derivation_generation_failed, error_messages.Generic_derivation_generation_failed_message)
			retry
		end
	
	generate_parents is
		indexing
			description: "Add parents to `eiffel_class' (if any)."
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void		
		local
			parent_name: STRING
			comma_index: INTEGER
			rename_clauses: LINKED_LIST [RENAME_CLAUSE]
			undefine_clauses: LINKED_LIST [UNDEFINE_CLAUSE]
			redefine_clauses: LINKED_LIST [REDEFINE_CLAUSE]
			select_clauses: LINKED_LIST [SELECT_CLAUSE]
			export_clauses: LINKED_LIST [EXPORT_CLAUSE] -- LINKED_LIST_ANY
			undefine_clauses_string, redefine_clauses_string, select_clauses_string, rename_clauses_string, export_clauses_string: STRING
			rename_clause_text, export_text: STRING

			support: CONVERSION_SUPPORT
			undefine_clause: UNDEFINE_CLAUSE
			redefine_clause: REDEFINE_CLAUSE
			select_clause: SELECT_CLAUSE
			export_clause: EXPORT_CLAUSE
			retried: BOOLEAN
			a_parent: PARENT

		do
			if not retried then
				if type_description.get_Name.equals (xml_elements.Inherit_element.to_cil) then
					type_description.Read_Start_Element_String (xml_elements.Inherit_element.to_cil)
					create support
					from
					until
						not type_description.get_Name.equals (xml_elements.Parent_element.to_cil)
					loop
						type_description.Read_Start_Element_String (xml_elements.Parent_element.to_cil)
						parent_name := from_system_string ( type_description.Read_Element_String_String (xml_elements.Parent_name_element.to_cil) )
						
						--rename_clauses := create {IMPLEMENTATION_LINKED_LIST_ANY}.make1
						--create rename_clauses.make1
						create rename_clauses.make
						--undefine_clauses := create {IMPLEMENTATION_LINKED_LIST_ANY}.make1
						--create undefine_clauses.make1
						create undefine_clauses.make
						--redefine_clauses := create {IMPLEMENTATION_LINKED_LIST_ANY}.make1
						--create redefine_clauses.make1
						create redefine_clauses.make
						--select_clauses := create {IMPLEMENTATION_LINKED_LIST_ANY}.make1
						--create select_clauses.make1
						create select_clauses.make
						--export_clauses := create {IMPLEMENTATION_LINKED_LIST_ANY}.make1
						--create export_clauses.make1
						create export_clauses.make

						if type_description.get_name.equals (xml_elements.Rename_element.to_cil) then
							rename_clauses_string := from_system_string ( type_description.read_element_string_string (xml_elements.Rename_element.to_cil) )
							if rename_clauses_string.count > 0 then
								if rename_clauses_string.Index_of (',', 1) = -1 then
									rename_clauses.extend (support.rename_clause_from_text (rename_clauses_string))
								else					
									from
									until
										rename_clauses_string.Index_of (',', 1) = 0 
									loop
										comma_index := rename_clauses_string.Index_of (',', 1)
										if (comma_index > 0) then
											rename_clause_text := rename_clauses_string.substring (1, comma_index - 1)
											rename_clauses.extend (support.rename_clause_from_text (rename_clause_text))
											rename_clauses_string := rename_clauses_string.substring (comma_index + 1, rename_clauses_string.count)
											rename_clauses_string.right_adjust
											rename_clauses_string.left_adjust
										end
									end
									rename_clauses.extend (support.rename_clause_from_text (rename_clauses_string))
								end
							end					
						end
						if type_description.get_name.equals (xml_elements.Undefine_element.to_cil) then
							undefine_clauses_string := from_system_string ( type_description.read_element_string_string (xml_elements.Undefine_element.to_cil) )
							if undefine_clauses_string.count > 0 then
								if undefine_clauses_string.Index_of(',', 1) = 0 then
									create undefine_clause
									undefine_clause.set_source_name (undefine_clauses_string)
									undefine_clauses.extend (undefine_clause)
								else					
									from
									until
										undefine_clauses_string.Index_of (',', 1) = 0 
									loop
										comma_index := undefine_clauses_string.Index_of (',', 1)

										create undefine_clause
										undefine_clause.set_source_name (undefine_clauses_string.substring (1, comma_index - 1))
										undefine_clauses.extend (undefine_clause)
										undefine_clauses_string := undefine_clauses_string.substring (comma_index + 1, undefine_clauses_string.count)
										undefine_clauses_string.right_adjust
										undefine_clauses_string.left_adjust											
										
									end
								--	create undefine_clause
								--	undefine_clause.set_source_name (undefine_clauses_string)
								--	undefine_clauses.extend (undefine_clause)
								end
							end						
						end
						if type_description.get_Name.equals (xml_elements.Redefine_element.to_cil) then
							redefine_clauses_string := from_system_string ( type_description.read_element_string_string (xml_elements.Redefine_element.to_cil) )
							if redefine_clauses_string.count > 0 then
								if redefine_clauses_string.Index_of (',', 1) = 0 then
									create redefine_clause
									redefine_clause.set_source_name (redefine_clauses_string)
									redefine_clauses.extend (redefine_clause)
								else					
									from
									until
										redefine_clauses_string.Index_of (',', 1) = 0 
									loop
										comma_index := redefine_clauses_string.Index_of (',', 1)
										if (comma_index > 0) then
											create redefine_clause
											redefine_clause.set_source_name (redefine_clauses_string.substring (1, comma_index - 1))
											redefine_clauses.extend (redefine_clause)
											redefine_clauses_string := redefine_clauses_string.substring (comma_index + 1, redefine_clauses_string.count)
											redefine_clauses_string.right_adjust
											redefine_clauses_string.left_adjust
										end
									end
									create redefine_clause
									redefine_clause.set_source_name (redefine_clauses_string)
									redefine_clauses.extend (redefine_clause)
								end
							end						
						end
						if type_description.get_Name.equals (xml_elements.Select_element.to_cil) then
							select_clauses_string := from_system_string (type_description.Read_Element_String_String (xml_elements.Select_element.to_cil))
							if select_clauses_string.count > 0 then
								if select_clauses_string.Index_of (',',1) = 0 then
									create select_clause
									select_clause.set_source_name (select_clauses_string)
									select_clauses.extend (select_clause)
								else					
									from
									until
										select_clauses_string.Index_of (',', 1) = 0 
									loop
										comma_index := select_clauses_string.Index_of (',', 1)
										if (comma_index > 0) then
											create select_clause
											select_clause.set_source_name (select_clauses_string.substring (1, comma_index - 1))
											select_clauses.extend (select_clause)
											select_clauses_string := select_clauses_string.substring (comma_index + 1, select_clauses_string.count)
											select_clauses_string.right_adjust
											select_clauses_string.left_adjust
										end
									end
									create select_clause
									select_clause.set_source_name (select_clauses_string)
									select_clauses.extend (select_clause)
								end
							end						
						end
						if type_description.get_Name.equals (xml_elements.Export_element.to_cil) then
							export_clauses_string := from_system_string ( type_description.Read_Element_String_String (xml_elements.Export_element.to_cil) )
							if export_clauses_string.count > 0 then
								if export_clauses_string.Index_of (',', 1) = 0 then
									export_clauses.extend (support.export_clause_from_text (export_clauses_string))
								else					
									from
									until
										export_clauses_string.Index_of (',', 1) = 0 
									loop
										comma_index := export_clauses_string.Index_of (',', 1)
										if (comma_index > 0) then
											export_text := export_clauses_string.substring (1, comma_index - 1)
											export_clauses.extend (support.export_clause_from_text (export_text))
											export_clauses_string := export_clauses_string.substring (comma_index + 1, export_clauses_string.count)
											export_clauses_string.right_adjust
											export_clauses_string.left_adjust
										end
									end
									export_clauses.extend (support.export_clause_from_text (export_clauses_string))
								end
							end							
						end
						--a_parent := create {IMPLEMENTATION_PARENT}.make1
						create a_parent.make (parent_name)
						a_parent.set_rename_clauses (rename_clauses)
						a_parent.set_undefine_clauses (undefine_clauses)
						a_parent.set_redefine_clauses (redefine_clauses)
						a_parent.set_select_clauses (select_clauses)
						a_parent.set_export_clauses (export_clauses)
						eiffel_class.add_parent (a_parent)
						type_description.read_end_element
					end
					type_description.Read_End_Element
				end	
			end
		rescue
			retried := True
			create_error (error_messages.Class_parents_generation_failed, error_messages.Class_parents_generation_failed_message)
			retry
		end
	
	generate_class_body is
		indexing
			description: "Set `eiffel_class' attributes corresponding to the XML element `body'."
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void
		local
			retried: BOOLEAN
			bit_or_infix: STRING
			console: SYSTEM_CONSOLE
		do
			if not retried then
				type_description.read_start_element_string (xml_elements.Body_element.to_cil)
				
				if type_description.get_Name.equals (xml_elements.Initialization_element.to_cil) then				
					if not type_description.get_is_empty_element then
						type_description.read_start_element_string (xml_elements.Initialization_element.to_cil)
						generate_features (xml_elements.Initialization_element)
						type_description.read_end_element
					else
						type_description.skip
					end
				end
				if type_description.get_Name.equals (xml_elements.Access_element.to_cil) then
					if not type_description.get_is_empty_element then
						type_description.read_start_element_string (xml_elements.Access_element.to_cil)
						generate_features (xml_elements.Access_element)
						type_description.read_end_element				
					else
						type_description.skip
					end
				end
				if type_description.get_Name.equals (xml_elements.Element_change_element.to_cil) then
					if not type_description.get_is_empty_element then
						type_description.read_start_element_string (xml_elements.Element_change_element.to_cil)
						generate_features (xml_elements.Element_change_element)
						type_description.read_end_element				
					else
						type_description.skip
					end
				end
				if type_description.get_Name.equals (xml_elements.Basic_operations_element.to_cil) then
					if not type_description.get_is_empty_element then
						type_description.read_start_element_string (xml_elements.Basic_operations_element.to_cil)
						generate_features (xml_elements.Basic_operations_element)
						type_description.read_end_element
					else
						type_description.skip
					end
				end
				if type_description.get_Name.equals (xml_elements.Unary_operators_element.to_cil) then
					if not type_description.get_is_empty_element then
						type_description.read_start_element_string (xml_elements.Unary_operators_element.to_cil)
						generate_features (xml_elements.Unary_operators_element)
						type_description.read_end_element				
					else
						type_description.skip
					end
				end
				if type_description.get_Name.equals (xml_elements.Binary_operators_element.to_cil) then
					if not type_description.get_is_empty_element then
						type_description.read_start_element_string (xml_elements.Binary_operators_element.to_cil)
						generate_features (xml_elements.Binary_operators_element)
						type_description.read_end_element				
					else
						type_description.skip
					end
				end
				if type_description.get_Name.equals (xml_elements.Specials_element.to_cil) then
					if not type_description.get_is_empty_element then
						type_description.read_start_element_string (xml_elements.Specials_element.to_cil)
						generate_features (xml_elements.Specials_element)
						type_description.read_end_element				
					else
						type_description.skip
					end
				end
				if type_description.get_Name.equals (xml_elements.Implementation_element.to_cil) then
					if not type_description.get_is_empty_element then
						type_description.read_start_element_string (xml_elements.Implementation_element.to_cil)
						generate_features (xml_elements.Implementation_element)
						type_description.read_end_element	
					else
						type_description.skip
					end
				end	
				if type_description.get_name.equals (xml_elements.Bit_or_infix_element.to_cil) then
					bit_or_infix := from_system_string (type_description.read_element_string_string (xml_elements.Bit_or_infix_element.to_cil))
					if bit_or_infix.is_equal (xml_elements.True_string) then
						eiffel_class.set_bit_or_infix (True)
					elseif bit_or_infix.is_equal (xml_elements.False_string) then
						eiffel_class.set_bit_or_infix (False)
					end
				end
				type_description.read_end_element
			end
		rescue
			retried := True
			create_error (error_messages.Class_body_generation_failed, error_messages.Class_body_generation_failed_message)
			retry
		end

	generate_features (element_name: STRING) is
		indexing
			description: "Add features from xml element with name `element_name' to `eiffel_class'."
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void	
			non_void_element_name: element_name /= Void
			not_empty_element_name: element_name.count > 0
			valid_element_name: element_name.is_equal (xml_elements.Initialization_element) or element_name.is_equal (xml_elements.Access_element) or element_name.is_equal (xml_elements.Element_change_element) or element_name.is_equal (xml_elements.Basic_operations_element) or element_name.is_equal (xml_elements.Unary_operators_element) or element_name.is_equal (xml_elements.Binary_operators_element) or element_name.is_equal (xml_elements.Specials_element) or element_name.is_equal (xml_elements.Implementation_element)
		local
			eiffel_name: STRING
			external_name: STRING
			return_type: STRING
			return_type_full_name: STRING
			signature_type: SIGNATURE_TYPE
			formal_signature_type: FORMAL_SIGNATURE_TYPE
			convert: CONVERT
			literal_value: STRING
			retried: BOOLEAN
			generic_parameter_index: STRING
		do
			if not retried then
				from
				until
					not type_description.get_Name.equals (xml_elements.Feature_element.to_cil)
				loop
					signature_type := Void
					type_description.read_start_element_string (xml_elements.Feature_element.to_cil)
					--eiffel_feature := create {IMPLEMENTATION_EIFFEL_FEATURE}.make1
					create eiffel_feature.make
					--eiffel_feature.make

						-- Set `is_frozen', `is_static', `is_abstract', `is_method', `is_field', `is_creation_routine'...
					set_feature_info

						-- Set `eiffel_name'.
					eiffel_name := from_system_string ( type_description.read_element_string_string (xml_elements.Feature_eiffel_name_element.to_cil) )
					if eiffel_name /= Void and then eiffel_name.count > 0 then
						eiffel_feature.Set_Eiffel_Name (to_component_string (eiffel_name) )
					end	
		
						-- Set `external_name'.
					if type_description.get_Name.equals (xml_elements.Feature_external_name_element.to_cil) then
						external_name := from_system_string ( type_description.read_element_string_string (xml_elements.Feature_external_name_element.to_cil) )
						if external_name /= Void and then external_name.count > 0 then
							eiffel_feature.Set_External_Name ( to_component_string (external_name))
						end
					end

						-- Add `arguments' (if any).
					if type_description.get_Name.equals (xml_elements.Arguments_element.to_cil) then
						generate_arguments
					end

						-- Set `return_type'.
					if type_description.get_Name.equals (xml_elements.Return_type_element.to_cil) then
						return_type := from_system_string ( type_description.read_element_string_string (xml_elements.Return_type_element.to_cil) )
					end

						-- Set `return_type_full_name'.
					if type_description.get_Name.equals (xml_elements.Return_type_full_name_element.to_cil) then
						return_type_full_name := from_system_string ( type_description.read_element_string_string (xml_elements.Return_type_full_name_element.to_cil) )
					end
					
						-- Set `return_type_generic_parameter_index'.
					if type_description.get_name.equals (xml_elements.Return_type_generic_parameter_index_element.to_cil) then
						generic_parameter_index := from_system_string ( type_description.read_element_string_string (xml_elements.Return_type_generic_parameter_index_element.to_cil) )
						--formal_signature_type := create {IMPLEMENTATION_FORMAL_SIGNATURE_TYPE}.make1
						create formal_signature_type.make
						--formal_signature_type.make
						formal_signature_type.set_generic_parameter_index (convert.to_int32_string (generic_parameter_index.to_cil))
						if return_type /= Void and then return_type.count > 0 then
							formal_signature_type.set_type_eiffel_name ( to_component_string (return_type))
						end
						if return_type_full_name /= Void and then return_type_full_name.count > 0 then
							formal_signature_type.set_type_full_external_name ( to_component_string (return_type_full_name))
						end
						eiffel_feature.set_return_type (formal_signature_type)
					else
						--signature_type := create {IMPLEMENTATION_SIGNATURE_TYPE}.make1
						create signature_type.make
						if return_type /= Void and then return_type.count > 0 then
							signature_type.set_type_eiffel_name ( to_component_string (return_type) )
						end
						if return_type_full_name /= Void and then return_type_full_name.count > 0 then
							signature_type.set_type_full_external_name ( to_component_string (return_type_full_name) ) 
						end
						eiffel_feature.set_return_type (signature_type)
					end
					
						-- Add `comments' (if any).
					if type_description.get_Name.equals (xml_elements.Comments_element.to_cil) then
						generate_comments
					end

						-- Add `preconditions' (if any).
					if type_description.get_Name.equals (xml_elements.Preconditions_element.to_cil) then
						generate_feature_assertions (xml_elements.Precondition_element)
					end

						-- Add `postconditions' (if any).
					if type_description.get_Name.equals (xml_elements.Postconditions_element.to_cil) then
						generate_feature_assertions (xml_elements.Postcondition_element)
					end

						-- Set `literal_value' (if any).
					if type_description.get_name.equals (xml_elements.Literal_value_element.to_cil) then
						literal_value := from_system_string (type_description.read_element_string_string (xml_elements.Literal_value_element.to_cil))
						eiffel_feature.set_literal_value ( to_component_string (literal_value))
					end
					type_description.read_end_element

					if element_name.is_equal (xml_elements.Initialization_element) then
						eiffel_class.Add_Initialization_Feature (eiffel_feature)
					elseif element_name.is_equal (xml_elements.Access_element) then
						eiffel_class.Add_Access_Feature (eiffel_feature)
					elseif element_name.is_equal (xml_elements.Element_change_element) then
						eiffel_class.Add_Element_Change_Feature (eiffel_feature)
					elseif element_name.is_equal (xml_elements.Basic_operations_element) then
						eiffel_class.Add_Basic_Operation (eiffel_feature)
					elseif element_name.is_equal (xml_elements.Unary_operators_element) then
						eiffel_class.Add_Unary_Operator (eiffel_feature)
					elseif element_name.is_equal (xml_elements.Binary_operators_element) then
						eiffel_class.Add_Binary_Operator (eiffel_feature)
					elseif element_name.is_equal (xml_elements.Specials_element) then
						eiffel_class.Add_Special_Feature (eiffel_feature)
					elseif element_name.is_equal (xml_elements.Implementation_element) then
						eiffel_class.Add_Implementation_Feature (eiffel_feature)
					end
				end
			end
		rescue
			retried := True
			create_error (error_messages.Class_features_generation_failed, error_messages.Class_features_generation_failed_message)
			retry
		end
	
	set_feature_info is
		indexing
			description: "Set `is_frozen', `is_static', `is_abstract', `is_field', `is_creation_routine', `is_prefix', `is_infix' from `type_description' to `eiffel_feature'."
		require
			non_void_feature: eiffel_feature /= Void
			non_void_type_description: type_description /= Void
		local
			modified_feature, frozen_feature, static, abstract: STRING
			is_method, is_field, is_creation_routine: STRING
			is_prefix, is_infix: STRING
			is_new_slot: STRING
			is_enum_literal: STRING
			is_literal: STRING
			retried: BOOLEAN
		do
			if not retried then
					-- Set `modified'.
				if type_description.get_name.equals (xml_elements.Modified_feature_element.to_cil) then
					modified_feature := from_system_string ( type_description.read_element_string_string (xml_elements.Modified_feature_element.to_cil) )
					if modified_feature.is_equal (xml_elements.True_string) then
						eiffel_feature.Set_Modified (True)
					elseif modified_feature.is_equal (xml_elements.False_string) then
						eiffel_feature.set_modified (False)
					end
				end
				
					-- Set `is_frozen'.
				frozen_feature := from_system_string ( type_description.read_element_string_string (xml_elements.Frozen_feature_element.to_cil) )
				if frozen_feature.is_equal (xml_elements.True_string) then
					eiffel_feature.Set_Frozen (True)
				elseif frozen_feature.is_equal (xml_elements.False_string) then
					eiffel_feature.Set_Frozen (False)
				end

					-- Set `is_static'.
				static := from_system_string (type_description.read_element_string_string (xml_elements.Static_element.to_cil))
				if static.is_equal (xml_elements.True_string) then
					eiffel_feature.Set_Static (True)
				elseif static.is_equal (xml_elements.False_string) then
					eiffel_feature.Set_Static (False)
				end

					-- Set `is_abstract'.
				abstract := from_system_string (type_description.read_element_string_string (xml_elements.Abstract_element.to_cil))
				if abstract.is_equal (xml_elements.True_string) then
					eiffel_feature.Set_Abstract (True)
				elseif abstract.is_equal (xml_elements.False_string) then
					eiffel_feature.Set_Abstract (False)
				end

					-- Set `is_method'.
				is_method := from_system_string (type_description.read_element_string_string (xml_elements.Method_element.to_cil))
				if is_method.is_equal (xml_elements.True_string) then
					eiffel_feature.Set_Method (True)
				elseif is_method.is_equal (xml_elements.False_string) then
					eiffel_feature.Set_Method (False)
				end

					-- Set `is_field'.
				is_field := from_system_string (type_description.read_element_string_string (xml_elements.Field_element.to_cil))
				if is_field.is_equal (xml_elements.True_string) then
					eiffel_feature.Set_Field (True)
				elseif is_field.is_equal (xml_elements.False_string) then
					eiffel_feature.Set_Field (False)
				end				

					-- Set `is_creation_routine'.
				is_creation_routine := from_system_string (type_description.read_element_string_string (xml_elements.Creation_routine_element.to_cil))
				if is_creation_routine.is_equal (xml_elements.True_string) then
					eiffel_feature.Set_Creation_Routine (True)
				elseif is_creation_routine.is_equal (xml_elements.False_string) then
					eiffel_feature.Set_Creation_Routine (False)
				end

					-- Set `is_prefix'.
				is_prefix := from_system_string ( type_description.read_element_string_string (xml_elements.Prefix_element.to_cil) )
				if is_prefix.is_equal (xml_elements.True_string) then
					eiffel_feature.Set_Prefix (True)
				elseif is_prefix.is_equal (xml_elements.False_string) then
					eiffel_feature.Set_Prefix (False)
				end

					-- Set `is_infix'.
				is_infix := from_system_string (type_description.read_element_string_string (xml_elements.Infix_element.to_cil))
				if is_infix.is_equal (xml_elements.True_string) then
					eiffel_feature.Set_Infix (True)
				elseif is_infix.is_equal (xml_elements.False_string) then
					eiffel_feature.Set_Infix (False)
				end	
				
					-- Set `new_slot'.
				is_new_slot := from_system_string ( type_description.read_element_string_string (xml_elements.New_slot_element.to_cil) )
				if is_new_slot.is_equal (xml_elements.True_string) then
					eiffel_feature.Set_New_Slot (True)
				elseif is_new_slot.is_equal (xml_elements.False_string) then
					eiffel_feature.set_new_slot (False)
				end	
				
					-- Set `enum_literal'.
				is_enum_literal := from_system_string ( type_description.read_element_string_string (xml_elements.Enum_literal_element.to_cil) )
				if is_enum_literal.is_equal (xml_elements.True_string) then
					eiffel_feature.Set_Enum_Literal (True)
				elseif is_enum_literal.is_equal (xml_elements.False_string) then
					eiffel_feature.set_enum_literal (False)
				end	

					-- Set `is_literal'.
				is_literal := from_system_string ( type_description.read_element_string_string (xml_elements.Is_literal_element.to_cil) )
				if is_literal.is_equal (xml_elements.True_string) then
					eiffel_feature.set_literal (True)
				elseif is_literal.is_equal (xml_elements.False_string) then
					eiffel_feature.set_literal (False)
				end	
			end
		rescue
			retried := True
			create_error (error_messages.Class_feature_info_generation_failed, error_messages.Class_feature_info_generation_failed_message)
			retry
		end
	
	generate_arguments is
		indexing
			description: "Add arguments to `eiffel_feature'."
		require
			non_void_feature: eiffel_feature /= Void
			non_void_type_description: type_description /= Void
		local
			eiffel_name: STRING
			external_name: STRING
			type: STRING
			type_full_name: STRING
			formal_argument: FORMAL_NAMED_SIGNATURE_TYPE
			an_argument: NAMED_SIGNATURE_TYPE
			retried: BOOLEAN
			generic_parameter_index: STRING
			convert: CONVERT
		do
			if not retried then
				type_description.read_start_element_string (xml_elements.Arguments_element.to_cil)
				from
				until
					not type_description.get_Name.equals (xml_elements.Argument_element.to_cil) 
				loop
					type_description.read_start_element_string (xml_elements.Argument_element.to_cil)
					if type_description.get_name.equals (xml_elements.Argument_eiffel_name_element.to_cil) then
						eiffel_name := from_system_string ( type_description.read_element_string_string (xml_elements.Argument_eiffel_name_element.to_cil) )
					else
						eiffel_name := xml_elements.Empty_string
					end
					if type_description.get_name.equals (xml_elements.Argument_external_name_element.to_cil) then
						external_name := from_system_string ( type_description.read_element_string_string (xml_elements.Argument_external_name_element.to_cil) )
					else
						external_name := xml_elements.Empty_string
					end
					if type_description.get_name.equals (xml_elements.Argument_type_element.to_cil) then
						type := from_system_string ( type_description.read_element_string_string (xml_elements.Argument_type_element.to_cil) )
					else
						type := xml_elements.Empty_string
					end
					if type_description.get_name.equals (xml_elements.Argument_type_full_name_element.to_cil) then
						type_full_name := from_system_string ( type_description.read_element_string_string (xml_elements.Argument_type_full_name_element.to_cil) )
					else
						type_full_name := xml_elements.Empty_string
					end
					if type_description.get_name.equals (xml_elements.Generic_parameter_index_element.to_cil) then
						generic_parameter_index := from_system_string ( type_description.read_element_string_string (xml_elements.Generic_parameter_index_element.to_cil) )
						--formal_argument := create {IMPLEMENTATION_FORMAL_NAMED_SIGNATURE_TYPE}.make1
						create formal_argument.make
						formal_argument.set_generic_parameter_index (convert.to_int32_string (generic_parameter_index.to_cil))
						formal_argument.set_eiffel_name ( to_component_string (eiffel_name))
						formal_argument.set_external_name ( to_component_string (external_name))
						formal_argument.set_type_eiffel_name ( to_component_string (type) )
						formal_argument.set_type_full_external_name ( to_component_string (type_full_name) )
						eiffel_feature.add_argument (formal_argument)
					else
						--an_argument := create {IMPLEMENTATION_NAMED_SIGNATURE_TYPE}.make1
						create an_argument.make					
						an_argument.set_eiffel_name ( to_component_string (eiffel_name))
						an_argument.set_external_name ( to_component_string (external_name))
						an_argument.set_type_eiffel_name ( to_component_string (type))
						an_argument.set_type_full_external_name ( to_component_string (type_full_name))
						eiffel_feature.Add_Argument ( an_argument )
					end
					type_description.read_end_element
				end
				type_description.read_end_element
			end
		rescue
			retried := True
			create_error (error_messages.Class_feature_arguments_generation_failed, error_messages.Class_feature_arguments_generation_failed_message)
			retry
		end

	generate_comments is
		indexing
			description: "Add comments to `eiffel_feature'."
		require
			non_void_feature: eiffel_feature /= Void
			non_void_type_description: type_description /= Void
		local
			comments_string: STRING
			comma_index: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				comments_string := from_system_String ( type_description.read_element_string_string (xml_elements.Comments_element.to_cil) )
				if comments_string.count > 0 then
					if comments_string.Index_of (',', 1) = -1 then
						eiffel_feature.Add_Comment ( to_component_string (comments_string))
					else					
						from
						until
							comments_string.Index_of (',', 1) = -1 
						loop
							comma_index := comments_string.Index_of (',', 1)
							eiffel_feature.Add_Comment ( to_component_string (comments_string.substring (0, comma_index)) )
							comments_string := comments_string.substring (comma_index + 1, comments_string.count)
							comments_string .right_adjust
							comments_string .left_adjust
							
						end
						eiffel_feature.Add_Comment ( to_component_string (comments_string) )
					end
				end
			end
		rescue
			retried := True
			create_error (error_messages.Class_feature_comments_generation_failed, error_messages.Class_feature_comments_generation_failed_message)
			retry
		end		

	generate_feature_assertions (element_name: STRING) is
		indexing
			description: "Add preconditions or postconditions (depending on `element_name') to `eiffel_feature'."
		require
			non_void_feature: eiffel_feature /= Void
			non_void_type_description: type_description /= Void
			non_void_element_name: element_name /= Void
			not_empty_element_name: element_name.count > 0
			valid_element_name: element_name.is_equal (xml_elements.Precondition_element) or element_name.is_equal (xml_elements.Postcondition_element)
		local
			tag: STRING
			text: STRING
			retried: BOOLEAN
		do	
			if not retried then
				if element_name.is_equal (xml_elements.Precondition_element) then
					type_description.read_start_element_string (xml_elements.Preconditions_element.to_cil)
				elseif element_name.is_equal (xml_elements.Postcondition_element) then
					type_description.read_start_element_string (xml_elements.Postconditions_element.to_cil)
				end
				from
				until
					not type_description.get_Name.equals (element_name.to_cil) 
				loop
					type_description.read_start_element_string (element_name.to_cil)
					if element_name.is_equal (xml_elements.Precondition_element) then
						tag := from_system_string ( type_description.read_element_string_string (xml_elements.Precondition_tag_element.to_cil) )
						text := from_system_string ( type_description.read_element_string_string (xml_elements.Precondition_text_element.to_cil) )
					elseif element_name.is_equal (xml_elements.Postcondition_element) then
						tag := from_system_string ( type_description.read_element_string_string (xml_elements.Postcondition_tag_element.to_cil) )
						text := from_system_string ( type_description.read_element_string_string (xml_elements.Postcondition_text_element.to_cil) )
					end
					if tag /= Void and text /= Void then
						if text.count > 0 then
							if element_name.is_equal (xml_elements.Precondition_element) then
								eiffel_feature.Add_Precondition ( to_component_string ( tag ), to_component_string ( text ))
							elseif element_name.is_equal (xml_elements.Postcondition_element) then
								eiffel_feature.Add_Postcondition ( to_component_string ( tag ), to_component_string ( text ) )
							end
						end
					end
					type_description.read_end_element
				end
				type_description.read_end_element
			end
		rescue
			retried := True
			create_error (error_messages.Class_feature_assertions_generation_failed, error_messages.Class_feature_assertions_generation_failed_message)
			retry
		end
		
	generate_class_footer is
		indexing
			description: "Set `eiffel_class' attributes corresponding to the XML element `footer'."
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_type_description: type_description /= Void
		local
			tag: STRING
			text: STRING
			retried: BOOLEAN
		do
			if not retried then
				type_description.read_start_element_string (xml_elements.Footer_element.to_cil)
				if type_description.get_Name.equals (xml_elements.Invariants_element.to_cil) then
					type_description.read_start_element_string (xml_elements.Invariants_element.to_cil) 
					from
					until
						not type_description.get_Name.equals (xml_elements.Invariant_element.to_cil) 
					loop
						type_description.read_start_element_string (xml_elements.Invariant_element.to_cil)
						tag := from_system_string ( type_description.read_element_string_string (xml_elements.Invariant_tag_element.to_cil) )
						text := from_system_string ( type_description.read_element_string_string (xml_elements.Invariant_text_element.to_cil) )
						if tag /= Void and text /= Void then
							if text.count > 0 then
								eiffel_class.Add_Invariant ( to_component_string ( tag ), to_component_string ( text ) )
							end
						end
						type_description.read_end_element
					end
					type_description.read_end_element			
				end
				type_description.read_end_element
			end
		rescue
			retried := True
			create_error (error_messages.Class_footer_generation_failed, error_messages.Class_footer_generation_failed_message)
			retry
		end
		
end -- class CODE_GENERATION_SUPPPORT
