indexing
	description: "Type storer"
	external_name: "ISE.Reflection.TypeStorer"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	TYPE_STORER
	
inherit
	ISE_REFLECTION_XMLELEMENTS
		export
			{NONE} all
		end
		
create
	make_type_storer

feature {NONE} -- Initialization

	make_type_storer (a_folder_name: like assembly_folder_name) is
		indexing
			description: "Set `assembly_folder_name' with `a_folder_name'."
			external_name: "MakeTypeStorer"
		require
			non_void_folder_name: a_folder_name /= Void
			not_empty_folder_name: a_folder_name.get_length > 0
		do
			assembly_folder_name := a_folder_name
			create error_messages
			create types.make
		ensure
			assembly_folder_name_set: assembly_folder_name.Equals_String (a_folder_name)
			non_void_error_messages: error_messages /= Void
			non_void_types: types /= Void
		end

feature -- Access

	assembly_folder_name: STRING
		indexing
			description: "Assembly folder eiffel_name in which type XML description will be added"
			external_name: "AssemblyFolderName"
		end
	
	last_error: ISE_REFLECTION_ERRORINFO
		indexing
			description: "Last error"
			external_name: "last_error"
		end
		
feature -- Status Report

	committed: BOOLEAN 
		indexing
			description: "Was type committed? (i.e. Has `commit' been called?)"
			external_name: "Committed"
		end
		
	exists (a_filename: STRING): BOOLEAN is
		indexing
			description: "Does a file with filename `a_filename' already exist?"
			external_name: "Exists"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.get_length > 0
		local
			file: SYSTEM_IO_FILE
			retried: BOOLEAN			
		do
			if not retried then
				Result := file.Exists (a_filename)
			else
				Result := False
			end
		rescue
			retried := True
			support.create_error (error_messages.File_access_failed, error_messages.File_access_failed_message)
			last_error := support.get_last_error
			retry
		end
		
feature -- Basic Operations

	add_type (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS; overwrite: BOOLEAN) is
		indexing
			description: "[
						Add type XML description corresponding to `an_eiffel_class' to the Eiffel assembly cache.
						If the xml file corresponding to `an_eiffel_class', it will overwrites it if `overwrite' is True.
					  ]"
			external_name: "AddType"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_eiffel_class_name: an_eiffel_class.get_eiffel_name /= Void
			not_empty_eiffel_class_name: an_eiffel_class.get_eiffel_name.get_length > 0	
			not_committed: not committed
		local
			public_string: STRING
			subset: STRING
			invariants: SYSTEM_COLLECTIONS_ARRAYLIST
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			filename: STRING
			DTD_path: STRING
			retried: BOOLEAN
			notifier: ISE_REFLECTION_NOTIFIER
			notifier_handle: ISE_REFLECTION_NOTIFIERHANDLE
			formatting: SYSTEM_XML_FORMATTING	
			added: INTEGER
		do
			if not retried then
				eiffel_class := an_eiffel_class
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				filename := reflection_support.Xml_Type_Filename (eiffel_class.get_assembly_descriptor, eiffel_class.get_full_external_name)
				filename := filename.replace (reflection_support.Eiffel_key, reflection_support.Eiffel_delivery_path)
				if overwrite or (not overwrite and not exists (filename)) or eiffel_class.get_is_generic then
					create text_writer.make_xmltextwriter_1 (filename, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)

						-- Set generation options
						-- `1' for `Formatting.Indented'
					text_writer.set_Formatting (formatting.indented)
					text_writer.set_Indentation (1)
					text_writer.set_Indent_Char ('%T')
					text_writer.set_Namespaces (False)
					text_writer.set_Quote_Char ('%"')

						-- XML generation

						-- Write <!DOCTYPE reflection_interface SYSTEM "reflection_interface.dtd">
					DTD_path := "../"
					text_writer.Write_Doc_Type (Dtd_Type_Filename, public_string, DTD_path.Concat_String_String_String (DTD_path, Dtd_Type_Filename, Dtd_Extension), subset)

						-- <class>
					text_writer.write_start_element (Class_Element)

						-- <header>
					generate_xml_class_header 

						-- <body>
					generate_xml_class_body 

						-- <footer>
					invariants := eiffel_class.get_invariants
					if invariants.get_count > 0 then
						generate_xml_class_footer (invariants)
					end

						-- </class>
					text_writer.write_end_element
					text_writer.Close
					if overwrite then
						create notifier_handle.make1
						notifier := notifier_handle.current_notifier
						notifier.Notify_Replace		
					end
					added := types.extend (eiffel_class)
				end
				eiffel_class := Void
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_type_generation_failed, error_messages.XML_type_generation_failed_message)
			last_error := support.get_last_error
			retry
		end

	commit is
			-- | Update `assembly_description.xml'.
		indexing
			description: "Commit changes."
			external_name: "Commit"
		require
			not_committed: not committed
		local
			file: SYSTEM_IO_FILE
			write_lock_filename: STRING
			retried: BOOLEAN
		do
			if not retried then
				update_assembly_description		
				write_lock_filename ?= assembly_folder_name.clone
				write_lock_filename := write_lock_filename.Concat_String_String_String (write_lock_filename, "\", support.Write_Lock_Filename)
				if file.exists (write_lock_filename) then
					file.delete (write_lock_filename)
				end
				create types.make
				committed := True
			end
		ensure
			committed: committed
			empty_types: types.get_count = 0
		rescue
			retried := True
			support.create_error (error_messages.Write_lock_removal_failed, error_messages.Write_lock_removal_failed_message)
			last_error := support.get_last_error
			retry
		end
		
feature {NONE} -- Implementation

	types: SYSTEM_COLLECTIONS_ARRAYLIST
		indexing
			description: "List of types added to the Eiffel Assembly Cache before calling `commit'"
			external_name: "Types"
		end
		
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
	
	error_messages: TYPE_STORER_ERROR_MESSAGES
		indexing
			description: "Error messages"
			external_name: "ErrorMessages"
		end
		
	text_writer: SYSTEM_XML_XMLTEXTWRITER
		indexing
			description: "XML text writer"
			external_name: "TextWriter"
		end
		
	eiffel_class: ISE_REFLECTION_EIFFELCLASS
		indexing
			description: "Eiffel class generated by the emitter"
			external_name: "EiffelClass"
		end

	parents: SYSTEM_COLLECTIONS_HASHTABLE
			-- | Key: parent eiffel_name
			-- | Value: inheritance clauses (ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST [STRING]])
		indexing
			description: "Class parents"
			external_name: "Parents"
		end
		
	generate_xml_class_header is
		indexing
			description: "Generate XML class header from `eiffel_class'."
			external_name: "GenerateXmlClassHeader"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_class_name: eiffel_class.get_Eiffel_Name /= Void
			not_empty_class_name: eiffel_class.get_Eiffel_Name.get_length > 0
		local
			creation_routines: SYSTEM_COLLECTIONS_ARRAYLIST	
			retried: BOOLEAN
		do
			if not retried then
					-- <header>
				text_writer.write_start_element (Header_Element)
					
					-- <modified>
				if eiffel_class.get_modified then
					text_writer.write_element_string (Modified_Element, true_string)
				else
					text_writer.write_element_string (Modified_Element, false_string)				
				end
				
					-- <frozen>
				if eiffel_class.get_Is_Frozen then
					text_writer.write_element_string (Frozen_Element, true_string)
				else
					text_writer.write_element_string (Frozen_Element, false_string)
				end			

					-- <expanded>
				if eiffel_class.get_Is_Expanded then
					text_writer.write_element_string (Expanded_Element, true_string)
				else
					text_writer.write_element_string (Expanded_Element, false_string)
				end	

					-- <deferred>
				if eiffel_class.get_Is_Deferred then
					text_writer.write_element_string (Deferred_Element, true_string)
				else
					text_writer.write_element_string (Deferred_Element, false_string)
				end	

					-- <generic>
				if eiffel_class.get_is_generic then
					text_writer.write_element_string (Generic_element, True_string)
				else
					text_writer.write_element_string (Generic_element, False_string)
				end
				
					-- <generic_derivations>
				if eiffel_class.get_generic_derivations /= Void and then eiffel_class.get_generic_derivations.count > 0 then
					generate_generic_derivations
				end
					
					-- <class_eiffel_name>
				text_writer.write_element_string (Class_Eiffel_Name_Element, eiffel_class.get_eiffel_name)

					-- <alias>
				generate_xml_alias_element 

					-- <inherit>
				parents := eiffel_class.get_Parents
				if parents.get_count > 0 then
					generate_xml_inherit_element
				end

					-- <create_none>
				if eiffel_class.get_Create_None then
					text_writer.write_element_string (Create_None_Element, true_string)
				else
					text_writer.write_element_string (Create_None_Element, false_string)
				end	

					-- </header>
				text_writer.write_end_element 
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_class_header_generation_failed, error_messages.Xml_class_header_generation_failed_message)
			last_error := support.get_last_error
			retry
		end
	
	generate_generic_derivations is
		indexing
			description: "Generate XML <generic_derivations> element from `eiffel_class'."
			external_name: "GenerateGenericDerivations"
		require
			is_generic: eiffel_class.get_is_generic
			non_void_generic_derivations: eiffel_class.get_generic_derivations /= Void
			not_empty_generic_derivations: eiffel_class.get_generic_derivations.count > 0
			non_void_constraints: eiffel_class.get_constraints /= Void
			not_empty_constraints: eiffel_class.get_constraints.count > 0
		local
			generic_derivations: ARRAY [ANY]
			a_generic_derivation: ISE_REFLECTION_GENERICDERIVATION
			i: INTEGER
			generic_types: ARRAY [ANY]
			constraints: ARRAY [ANY]
			a_constraint: STRING
			j: INTEGER
			a_generic_type: ISE_REFLECTION_SIGNATURETYPE
			retried: BOOLEAN
		do
			if not retried then
				generic_derivations := eiffel_class.get_generic_derivations
					-- <generic_derivations>
				text_writer.write_start_element (Generic_derivations_element)
				from
				until
					i = generic_derivations.count
				loop
					a_generic_derivation ?= generic_derivations.item (i)
					if a_generic_derivation /= Void then
							-- <generic_derivation>
						text_writer.write_start_element (Generic_derivation_element)
						generic_types := a_generic_derivation.get_generic_types
						if generic_types /= Void then
								-- <derivation_types_count>
							text_writer.write_element_string (Derivation_types_count_element, generic_types.count.to_string)
							from
								j := 0
							until
								j = generic_types.count
							loop
								a_generic_type ?= generic_types.item (j)
								if a_generic_type /= Void then
										-- <generic_type>
									text_writer.write_start_element (Generic_type_element)
										-- <generic_type_eiffel_name>
									text_writer.write_element_string (Generic_type_eiffel_name_element, a_generic_type.type_eiffel_name)
										-- <generic_type_external_name>
									text_writer.write_element_string (Generic_type_external_name_element, a_generic_type.type_full_external_name)		
										-- </generic_type>
									text_writer.write_end_element
								end
								j := j + 1
							end
						end
							-- </generic_derivation>
						text_writer.write_end_element
					end
					i := i + 1
				end
					-- </generic_derivations>
				text_writer.write_end_element
				
				constraints := eiffel_class.get_constraints
					-- <constraints>
				text_writer.write_start_element (Constraints_element)
				from
					i := 0
				until				
					i = constraints.count
				loop
					a_constraint ?= constraints.item (i)
					if a_constraint /= Void then
							-- <constraint>
						text_writer.write_element_string (Constraint_element, a_constraint)
					end
					i := i + 1
				end
					-- </constraints>
				text_writer.write_end_element
			end
		rescue		
			retried := True
			retry
		end
		
	generate_xml_alias_element is
		indexing
			description: "Generate XML alias element from `eiffel_class'."
			external_name: "GenerateXmlAliasElement"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_eiffel_class_name: eiffel_class.get_Eiffel_Name /= Void
			not_empty_eiffel_class_name: eiffel_class.get_Eiffel_Name.get_length > 0
		local
			retried: BOOLEAN
		do
			if not retried then
					-- <alias>
				text_writer.write_start_element (Alias_Element)

					-- <simple_name>
				text_writer.write_element_string (Simple_Name_Element, eiffel_class.get_External_Name)

					-- <namespace>
				if eiffel_class.get_Namespace /= Void and then eiffel_class.get_Namespace.get_length > 0 then
					text_writer.write_element_string (Namespace_Element, eiffel_class.get_Namespace)
				end

					-- <assembly_name>
				if eiffel_class.get_Assembly_Descriptor.get_name /= Void and then eiffel_class.get_Assembly_Descriptor.get_name.get_length > 0 then
					text_writer.write_element_string (Assembly_Name_Element, eiffel_class.get_Assembly_Descriptor.get_name)
				end

					-- <assembly_version>
				if eiffel_class.get_Assembly_Descriptor.get_Version /= Void and then eiffel_class.get_Assembly_Descriptor.get_Version.get_length > 0 then
					text_writer.write_element_string (Assembly_Version_Element, eiffel_class.get_Assembly_Descriptor.get_Version)
				end

					-- <assembly_culture>
				if eiffel_class.get_Assembly_Descriptor.get_Culture /= Void and then eiffel_class.get_Assembly_Descriptor.get_Culture.get_length > 0 then
					text_writer.write_element_string (Assembly_Culture_Element, eiffel_class.get_Assembly_Descriptor.get_Culture)
				end

					-- <assembly_public_key>
				if eiffel_class.get_Assembly_Descriptor.get_Public_Key /= Void and then eiffel_class.get_Assembly_Descriptor.get_Public_Key.get_length > 0 then
					text_writer.write_element_string (Assembly_Public_Key_Element, eiffel_class.get_Assembly_Descriptor.get_Public_Key)
				end
					--<enum_type>
				if eiffel_class.get_enum_type /= Void and then eiffel_class.get_enum_type.get_length > 0 then
					text_writer.write_element_string (Enum_Type_Element, eiffel_class.get_Enum_Type)
				end
				
					-- </alias>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_alias_element_generation_failed, error_messages.Xml_alias_element_generation_failed_message)
			last_error := support.get_last_error
			retry
		end
		
	generate_xml_inherit_element is
		indexing
			description: "Generate XML inherit element from `parents'."
			external_name: "GenerateXmlInheritElement"
		require
			non_void_parents: parents /= Void
			not_empty_parents: parents.get_count > 0
		local
			keys: SYSTEM_COLLECTIONS_ICOLLECTION
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			parent_name: STRING
			inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
			rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			export_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			retried: BOOLEAN
		do
			if not retried then
					-- <inherit>
				text_writer.write_start_element (Inherit_Element)

				keys := parents.get_Keys
				enumerator := keys.get_enumerator
				from
				until
					not enumerator.move_next
				loop
						-- <parent>
					text_writer.write_start_element (Parent_Element)

					parent_name ?= enumerator.get_current
					if parent_name /= Void and then parent_name.get_length > 0 then
							-- <parent_name>
						text_writer.write_element_string (Parent_Name_Element, parent_name)

						inheritance_clauses ?= parents.get_item (parent_name)
						if inheritance_clauses /= Void and then inheritance_clauses.count = 5 then
							rename_clauses := inheritance_clauses.item (0)
							if rename_clauses.get_count > 0 then
									-- <rename>
								generate_xml_element_from_inheritance_clauses (Rename_Element, rename_clauses)
							end
							undefine_clauses := inheritance_clauses.item (1)
							if undefine_clauses.get_count > 0 then
									-- <undefine>
								generate_xml_element_from_inheritance_clauses (Undefine_Element, undefine_clauses)
							end						
							redefine_clauses := inheritance_clauses.item (2)
							if redefine_clauses.get_count > 0 then
									-- <redefine>
								generate_xml_element_from_inheritance_clauses (Redefine_Element, redefine_clauses)
							end						
							select_clauses := inheritance_clauses.item (3)
							if select_clauses.get_count > 0 then
									-- <select>
								generate_xml_element_from_inheritance_clauses (Select_Element, select_clauses)
							end						
							export_clauses := inheritance_clauses.item (4)
							if export_clauses.get_count > 0 then
									-- <export>
								generate_xml_element_from_inheritance_clauses (Export_Element, export_clauses)
							end						
						end
					end

						-- </parent>
					text_writer.write_end_element
				end

					-- </inherit>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_inherit_element_generation_failed, error_messages.Xml_inherit_element_generation_failed_message)
			last_error := support.get_last_error
			retry
		end
			
	generate_xml_class_body is
		indexing
			description: "Generate XML class body from `eiffel_class'."
			external_name: "GenerateXmlClassBody"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_eiffel_class_name: eiffel_class.get_eiffel_name /= Void
			not_empty_eiffel_class_name: eiffel_class.get_eiffel_name.get_length > 0
		local
			initialization_features: SYSTEM_COLLECTIONS_ARRAYLIST
			access_features: SYSTEM_COLLECTIONS_ARRAYLIST
			element_change_features: SYSTEM_COLLECTIONS_ARRAYLIST
			basic_operations_features: SYSTEM_COLLECTIONS_ARRAYLIST
			unary_operators_features: SYSTEM_COLLECTIONS_ARRAYLIST
			binary_operators_features: SYSTEM_COLLECTIONS_ARRAYLIST
			specials_features: SYSTEM_COLLECTIONS_ARRAYLIST
			implementation_features: SYSTEM_COLLECTIONS_ARRAYLIST
			retried: BOOLEAN
		do
			if not retried then
					-- </body>
				text_writer.write_start_element (Body_Element)

					-- <initialization>
				initialization_features := eiffel_class.get_initialization_features
				if initialization_features.get_count > 0 then
					text_writer.write_start_element (Initialization_Element)
					generate_xml_features_element (initialization_features)
					text_writer.write_end_element
				end

					-- <access>
				access_features := eiffel_class.get_access_features
				if access_features.get_count > 0 then
					text_writer.write_start_element (Access_Element)
					generate_xml_features_element (access_features)
					text_writer.write_end_element
				end

					-- <element_change>
				element_change_features := eiffel_class.get_element_change_features
				if element_change_features.get_count > 0 then
					text_writer.write_start_element (Element_Change_Element)
					generate_xml_features_element (element_change_features)
					text_writer.write_end_element
				end

					-- <basic_operations>
				basic_operations_features := eiffel_class.get_basic_operations
				if basic_operations_features.get_count > 0 then
					text_writer.write_start_element (Basic_Operations_Element)
					generate_xml_features_element (basic_operations_features)
					text_writer.write_end_element
				end

					-- <unary_operators>
				unary_operators_features := eiffel_class.get_unary_operators_features
				if unary_operators_features.get_count > 0 then
					text_writer.write_start_element (Unary_Operators_Element)
					generate_xml_features_element (unary_operators_features)
					text_writer.write_end_element
				end

					-- <binary_operators>
				binary_operators_features := eiffel_class.get_binary_operators_features
				if binary_operators_features.get_count > 0 then
					text_writer.write_start_element (Binary_Operators_Element)
					generate_xml_features_element (binary_operators_features)
					text_writer.write_end_element
				end

					-- <specials_operators>
				specials_features := eiffel_class.get_special_features
				if specials_features.get_count > 0 then
					text_writer.write_start_element (Specials_Element)
					generate_xml_features_element (specials_features)
					text_writer.write_end_element
				end

					-- <implementation>
				implementation_features := eiffel_class.get_implementation_features
				if implementation_features.get_count > 0 then
					text_writer.write_start_element (Implementation_Element)
					generate_xml_features_element (implementation_features)
					text_writer.write_end_element
				end
					
					-- <bit_or_infix>
				if eiffel_class.get_bit_or_infix then
					text_writer.write_element_string (Bit_or_infix_element, True_string)
				else
					text_writer.write_element_string (Bit_or_infix_element, False_string)
				end
				
					-- </body>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_class_body_generation_failed, error_messages.Xml_class_body_generation_failed_message)
			last_error := support.get_last_error
			retry
		end
		
	generate_xml_class_footer (invariants: SYSTEM_COLLECTIONS_ARRAYLIST) is
		indexing
			description: "Generate XML class footer from `invariants'."
			external_name: "GenerateXmlClassFooter"
		require
			non_void_invariants: invariants /= Void
			not_empty_invariants: invariants.get_count > 0
		local
			retried: BOOLEAN
		do
			if not retried then
					-- <footer>
				text_writer.write_start_element (Footer_Element)
					-- <invariants>
				generate_xml_elements_from_assertions (invariants, Invariant_Element)
					-- </footer>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_class_footer_generation_failed, error_messages.Xml_class_footer_generation_failed_message)
			last_error := support.get_last_error
			retry
		end
	
	generate_xml_element_from_list (xml_element: STRING; a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		indexing
			description: "Generate `xml_element' from `a_list'."
			external_name: "GenerateXmlElementFromList"
		require
			non_void_element: xml_element /= Void
			not_empty_element: xml_element.get_length > 0
			non_void_list: a_list /= Void
			not_empty_list: a_list.get_count > 0
		local
			names: STRING
			retried: BOOLEAN
		do
			if not retried then
				names := string_from_list (a_list)
				if names.get_length > 0 then
						-- <xml_element>
					text_writer.write_element_string (xml_element, names)
				end
			end
		rescue
			retried := True
			retry
		end

	generate_xml_element_from_inheritance_clauses (xml_element: STRING; a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		indexing
			description: "Generate `xml_element' from `a_list'."
			external_name: "GenerateXmlElementFromInheritanceClauses"
		require
			non_void_element: xml_element /= Void
			not_empty_element: xml_element.get_length > 0
			non_void_list: a_list /= Void
			not_empty_list: a_list.get_count > 0
		local
			names: STRING
			retried: BOOLEAN
		do
			if not retried then
				names := string_from_inheritance_clauses (a_list)
				if names.get_length > 0 then
						-- <xml_element>
					text_writer.write_element_string (xml_element, names)
				end
			end
		rescue
			retried := True
			retry
		end
		
	generate_xml_features_element (features: SYSTEM_COLLECTIONS_ARRAYLIST) is
		indexing
			description: "Generate XML features elements from `features'."
			external_name: "GenerateXmlFeaturesElement"
		require
			non_void_features: features /= Void
			not_empty_features: features.get_count > 0
		local
			i: INTEGER
			a_feature: ISE_REFLECTION_EIFFELFEATURE
			value: STRING
			retried: BOOLEAN
		do
			if not retried then
				from
				until
					i = features.get_count
				loop
					a_feature ?= features.get_item (i)
					if a_feature /= Void then
						if a_feature.get_is_field and a_feature.get_is_static and not a_feature.get_is_enum_literal and a_feature.get_is_literal then
							value := a_feature.get_literal_value
							if value /= Void and then value.get_length > 0 then
								generate_xml_feature_element (a_feature)
							end
						else
							generate_xml_feature_element (a_feature)
						end
					end
					i := i + 1
				end
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_class_features_generation_failed, error_messages.Xml_class_features_generation_failed_message)
			last_error := support.get_last_error
			retry
		end	
	
	generate_xml_feature_element (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		indexing
			description: "Generate XML feature element corresponding to `a_feature'."
			external_name: "GenerateXmlFeatureElement"
		local
			arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			preconditions: SYSTEM_COLLECTIONS_ARRAYLIST
			postconditions: SYSTEM_COLLECTIONS_ARRAYLIST
			comments: SYSTEM_COLLECTIONS_ARRAYLIST
			formal_signature_type: ISE_REFLECTION_FORMALSIGNATURETYPE
			retried: BOOLEAN
			literal_value: STRING		
		do
			if not retried then
					-- < feature>
				text_writer.write_start_element (Feature_Element)
	
					-- <modified_feature>
				if a_feature.get_modified then
					text_writer.write_element_string (Modified_Feature_Element, True_String)
				else
					text_writer.write_element_string (Modified_Feature_Element, False_String)
				end	
	
					-- <frozen>
				if a_feature.get_Is_Frozen then
					text_writer.write_element_string (Frozen_Feature_Element, True_String)
				else
					text_writer.write_element_string (Frozen_Feature_Element, False_String)
				end	
	
					-- <static>
				if a_feature.get_Is_Static then
					text_writer.write_element_string (Static_Element, True_String)
				else
					text_writer.write_element_string (Static_Element, False_String)
				end	
	
					-- <abstract>
				if a_feature.get_Is_Abstract then
					text_writer.write_element_string (Abstract_Element, True_String)
				else
					text_writer.write_element_string (Abstract_Element, False_String)
				end
	
					-- <method>
				if a_feature.get_Is_Method then
					text_writer.write_element_string (Method_Element, True_String)
				else
					text_writer.write_element_string (Method_Element, False_String)
				end
	
					-- <field>
				if a_feature.get_Is_Field then
					text_writer.write_element_string (Field_Element, True_String)
				else
					text_writer.write_element_string (Field_Element, False_String)
				end
	
					-- <creation_routine>
				if a_feature.get_Is_Creation_Routine then
					text_writer.write_element_string (Creation_Routine_Element, True_String)
				else
					text_writer.write_element_string (Creation_Routine_Element, False_String)
				end
	
					-- <prefix>
				if a_feature.get_Is_Prefix then
					text_writer.write_element_string (Prefix_Element, True_String)
				else
					text_writer.write_element_string (Prefix_Element, False_String)
				end
	
					-- <infix>
				if a_feature.get_Is_Infix then
					text_writer.write_element_string (Infix_Element, True_String)
				else
					text_writer.write_element_string (Infix_Element, False_String)
				end
	
					-- <new_slot>
				if a_feature.get_New_Slot then
					text_writer.write_element_string (New_Slot_Element, True_String)
				else
					text_writer.write_element_string (New_Slot_Element, False_String)
				end
	
					-- <enum_literal>
				if a_feature.get_Is_Enum_Literal then
					text_writer.write_element_string (Enum_Literal_Element, True_String)
				else
					text_writer.write_element_string (Enum_Literal_Element, False_String)
				end
	
					-- <is_literal>
				if a_feature.get_is_literal then
					text_writer.write_element_string (Is_Literal_Element, True_String)
				else
					text_writer.write_element_string (Is_Literal_Element, False_String)
				end
	
					-- <feature_eiffel_name>
				text_writer.write_element_string (Feature_Eiffel_Name_Element, a_feature.get_Eiffel_Name)
	
					-- <feature_external_name>
				if a_feature.get_External_Name /= Void and then a_feature.get_External_Name.get_length > 0 then
					text_writer.write_element_string (Feature_External_Name_Element, a_feature.get_External_Name)
				end
	
					-- <arguments>
				arguments := a_feature.get_Arguments
				if arguments /= Void and then arguments.get_count > 0 then
					generate_xml_elements_from_feature_arguments (arguments)
				end
	
				if a_feature.get_Return_Type /= Void then 
						-- <return_type>
					text_writer.write_element_string (Return_Type_Element, a_feature.get_Return_Type.type_Eiffel_Name)
						-- <return_type_full_name>
					text_writer.write_element_string (Return_Type_Full_Name_Element, a_feature.get_Return_Type.Type_Full_External_Name)
						-- <return_type_generic_parameter_index>
					formal_signature_type ?= a_feature.get_return_type
					if formal_signature_type /= Void then
						text_writer.write_element_string (Return_type_generic_parameter_index_element, formal_signature_type.get_generic_parameter_index.to_string)
					end
				end
	
					-- <comments>
				comments := a_feature.get_Comments
				if comments /= Void and then comments.get_count > 0 then
					generate_xml_element_from_list (Comments_Element, comments)
				end
	
					-- <preconditions>
				preconditions := a_feature.get_Preconditions
				if preconditions.get_count > 0 then
					generate_xml_elements_from_assertions (preconditions, Precondition_Element)
				end
	
					-- <postconditions>
				postconditions := a_feature.get_Postconditions
				if postconditions.get_count > 0 then
					generate_xml_elements_from_assertions (postconditions, Postcondition_Element)
				end						
	
					-- <literal_value>
				literal_value := a_feature.get_Literal_value
				if literal_value /= Void and then literal_value.get_length > 0 then
					text_writer.write_element_string (Literal_value_element, literal_value)
				end	
	
					-- </feature>
				text_writer.write_end_element 
			end
		end
		
	generate_xml_elements_from_feature_arguments (arguments: SYSTEM_COLLECTIONS_ARRAYLIST) is
		indexing
			description: "Generate XML elements from `arguments'"
			external_name: "GenerateXmlElementsFromFeatureArguments"
		require
			non_void_arguments: arguments /= Void
			not_empty_arguments: arguments.get_count > 0 
		local
			i: INTEGER
			an_argument: ISE_REFLECTION_INAMEDSIGNATURETYPE
			formal_argument: ISE_REFLECTION_FORMALNAMEDSIGNATURETYPE
			an_argument_name: STRING
			an_argument_external_name: STRING
			an_argument_type: STRING
			an_argument_type_full_name: STRING
			retried: BOOLEAN
		do
			if not retried then
					-- <arguments>
				text_writer.write_start_element (Arguments_Element)

				from
				until
					i = arguments.get_count
				loop
					an_argument ?= arguments.get_item (i)
					if an_argument /= Void then
							-- <argument>
						text_writer.write_start_element (Argument_Element)

						an_argument_name := an_argument.eiffel_name
						if an_argument_name /= Void and then an_argument_name.get_length > 0 then
								-- <argument_eiffel_name>
							text_writer.write_element_string (Argument_Eiffel_Name_Element, an_argument_name)
						end

						an_argument_external_name := an_argument.external_name
						if an_argument_external_name /= Void and then an_argument_external_name.get_length > 0 then
								-- <argument_external_name>
							text_writer.write_element_string (Argument_External_Name_Element, an_argument_external_name)
						end

						an_argument_type := an_argument.type_eiffel_name
						if an_argument_type /= Void and then an_argument_type.get_length > 0 then
								-- <argument_type>
							text_writer.write_element_string (Argument_Type_Element, an_argument_type)
						end

						an_argument_type_full_name := an_argument.type_full_external_name
						if an_argument_type_full_name /= Void and then an_argument_type_full_name.get_length > 0 then
								-- <argument_type_full_name>
							text_writer.write_element_string (Argument_Type_Full_Name_Element, an_argument_type_full_name)	
						end
						
						formal_argument ?= arguments.get_item (i)
						if formal_argument /= Void then
								-- <generic_parameter_index>
							text_writer.write_element_string (Generic_parameter_index_element, formal_argument.get_generic_parameter_index.to_string)
						end
						
							-- </argument>
						text_writer.write_end_element
					end
					i := i + 1
				end

					-- </arguments>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_feature_arguments_generation_failed, error_messages.Xml_feature_arguments_generation_failed_message)
			last_error := support.get_last_error
			retry
		end
	
	generate_xml_elements_from_assertions (assertions: SYSTEM_COLLECTIONS_ARRAYLIST; assertion_type: STRING) is
		indexing
			description: "Generate XML elements from `assertions'."
			external_name: "GenerateXmlElementsFromAssertions"
		require
			non_void_assertion_type: assertion_type /= Void
			not_empty_assertion_type: assertion_type.get_length > 0
			valid_assertion_type: assertion_type.Equals_String (Precondition_Element) or assertion_type.Equals_String (Postcondition_Element) or assertion_type.Equals_String (Invariant_Element)
			non_void_assertions: assertions /= Void
			not_empty_assertions: assertions.get_count > 0
		local
			i: INTEGER
			an_assertion: ARRAY [STRING]
			assertion_tag: STRING
			assertion_text: STRING
			retried: BOOLEAN
		do
			if not retried then
					-- <assertions>
				if assertion_type.Equals_String (Precondition_Element) then
					text_writer.write_start_element (Preconditions_Element)
				elseif assertion_type.Equals_String (Postcondition_Element) then
					text_writer.write_start_element (Postconditions_Element)
				elseif assertion_type.Equals_String (Invariant_Element) then
					text_writer.write_start_element (Invariants_Element) 
				end

				from
				until
					i = assertions.get_count
				loop
					an_assertion ?= assertions.get_item (i)
					if an_assertion /= Void and then an_assertion.count = 2 then
							-- <assertion>
						text_writer.write_start_element (assertion_type)

						assertion_tag := an_assertion.item (0)
						if assertion_tag /= Void and then assertion_tag.get_length > 0 then
								-- <assertion_tag>
							if assertion_type.Equals_String (Precondition_Element) then
								text_writer.write_element_string (Precondition_Tag_Element, assertion_tag)
							elseif assertion_type.Equals_String (Postcondition_Element) then
								text_writer.write_element_string (Postcondition_Tag_Element, assertion_tag)
							elseif assertion_type.Equals_String (Invariant_Element) then
								text_writer.write_element_string (Invariant_Tag_Element, assertion_tag)
							end												
						end
						assertion_text := an_assertion.item (1)
						if assertion_text /= Void and then assertion_text.get_length > 0 then
								-- <assertion_text>
							if assertion_type.Equals_String (Precondition_Element) then
								text_writer.write_element_string (Precondition_Text_Element, assertion_text)
							elseif assertion_type.Equals_String (Postcondition_Element) then
								text_writer.write_element_string (Postcondition_Text_Element, assertion_text)
							elseif assertion_type.Equals_String (Invariant_Element) then
								text_writer.write_element_string (Invariant_Text_Element, assertion_text)
							end	
						end

							-- </assertion>
						text_writer.write_end_element
					end
					i := i + 1
				end	

					-- </assertions>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_feature_assertions_generation_failed, error_messages.Xml_feature_assertions_generation_failed_message)
			last_error := support.get_last_error
			retry
		end
		
	string_from_list (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): STRING is
		indexing
			description: "Generate string from `a_list'."
			external_name: "StringFromList"
		require
			non_void_list: a_list /= Void
			not_empty_list: a_list.get_count > 0
		local
			i: INTEGER
			an_get_item: STRING 
		do
			from
				create Result.make_2 ('%U', 0)
			until
				i = a_list.get_count
			loop
				an_get_item ?= a_list.get_item (i)
				if an_get_item /= Void and then an_get_item.get_length > 0 then
					Result := Result.Concat_String_String (Result, an_get_item)
					if i < a_list.get_count - 1 then
						Result := Result.Concat_String_String_String (Result, Comma, Space)
					end
				end
				i := i + 1
			end
		end	

	string_from_inheritance_clauses (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): STRING is
			-- | a_list: SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_INHERITANCECLAUSE]
		indexing
			description: "Generate string from `a_list'."
			external_name: "StringFromInheritanceClauses"
		require
			non_void_list: a_list /= Void
			not_empty_list: a_list.get_count > 0
		local
			i: INTEGER
			an_get_item: ISE_REFLECTION_INHERITANCECLAUSE
		do
			from
				create Result.make_2 ('%U', 0)
			until
				i = a_list.get_count
			loop
				an_get_item ?= a_list.get_item (i)
				if an_get_item /= Void then
					Result := Result.Concat_String_String (Result, an_get_item.string_representation)
					if i < a_list.get_count - 1 then
						Result := Result.Concat_String_String_String (Result, Comma, Space)
					end
				end
				i := i + 1
			end
		end	
	
	update_assembly_description is
		indexing
			description: "Update `assembly_description.xml' located in $EIFFEL\dotnet\assemblies\assembly_folder_name with list of added `types'."
			external_name: "UpdateAssemblyDescription"	
		local
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			assembly_description_path: STRING
			file: SYSTEM_IO_FILE
			code_generation_support: ISE_REFLECTION_CODEGENERATIONSUPPORT
			old_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			a_text_writer: SYSTEM_XML_XMLTEXTWRITER
			public_string: STRING
			subset: STRING			
			dtd_path: STRING
			i: INTEGER
			assembly_types: SYSTEM_COLLECTIONS_ARRAYLIST
			assembly_type: ISE_REFLECTION_EIFFELCLASS
			retried: BOOLEAN
			white_space_handling: SYSTEM_XML_WHITESPACEHANDLING
			formatting: SYSTEM_XML_FORMATTING
			an_eiffel_cluster_path: STRING
		do
			if not retried then
				create reflection_support.make_reflectionsupport
				reflection_support.make
				
					-- Add type Xml filename to `assembly_description.xml' located in `$EIFFEL\dotnet\assemblies\assembly_folder_name'.
				assembly_description_path ?= assembly_folder_name.clone
				assembly_description_path := assembly_description_path.concat_string_string_string_string (assembly_description_path, "\", Assembly_description_filename, Xml_extension)
				
				if file.Exists (assembly_description_path) then
					create code_generation_support.make_codegenerationsupport
					code_generation_support.make
					old_eiffel_assembly := code_generation_support.eiffel_assembly_from_xml (assembly_description_path)
					file.delete (assembly_description_path)
					
					create a_text_writer.make_xmltextwriter_1 (assembly_description_path, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)
						-- Set generation options
					a_text_writer.set_Formatting (formatting.indented)
					a_text_writer.set_Indentation (1)
					a_text_writer.set_Indent_Char ('%T')
					a_text_writer.set_Namespaces (False)
					a_text_writer.set_Quote_Char ('%"')

						-- Write `<!DOCTYPE ...>
					Dtd_path := "../"
					a_text_writer.Write_Doc_Type (Dtd_assembly_filename, public_string, Dtd_path.Concat_String_String_string (Dtd_path, Dtd_assembly_filename, Dtd_Extension), subset)
					
						-- <assembly>
					a_text_writer.write_start_element (Assembly_Element)

						-- <assembly_name>
					a_text_writer.write_element_string (Assembly_Name_Element, old_eiffel_assembly.get_assembly_descriptor.get_name)

						-- <assembly_version>
					if old_eiffel_assembly.get_assembly_descriptor.get_version /= Void and then old_eiffel_assembly.get_assembly_descriptor.get_version.get_length > 0 then
						a_text_writer.write_element_string (Assembly_Version_Element, old_eiffel_assembly.get_assembly_descriptor.get_version)
					end

						-- <assembly_culture>
					if old_eiffel_assembly.get_assembly_descriptor.get_culture /= Void and then old_eiffel_assembly.get_assembly_descriptor.get_culture.get_length > 0 then
						a_text_writer.write_element_string (Assembly_Culture_Element, old_eiffel_assembly.get_assembly_descriptor.get_culture)
					end

						-- <assembly_public_key>
					if old_eiffel_assembly.get_assembly_descriptor.get_public_key /= Void and then old_eiffel_assembly.get_assembly_descriptor.get_public_key.get_length > 0 then
						a_text_writer.write_element_string (Assembly_Public_Key_Element, old_eiffel_assembly.get_assembly_descriptor.get_public_key)
					end

						-- <eiffel_cluster_path>
					an_eiffel_cluster_path := old_eiffel_assembly.get_eiffel_cluster_path
					if an_eiffel_cluster_path /= Void and then an_eiffel_cluster_path.get_length > 0 then
						an_eiffel_cluster_path := an_eiffel_cluster_path.replace (reflection_support.Eiffel_delivery_path, reflection_support.Eiffel_key)
						a_text_writer.write_element_string (Eiffel_Cluster_Path_Element, an_eiffel_cluster_path)
					end

						-- <emitter_version_number>
					if old_eiffel_assembly.get_emitter_version_number /= Void and then old_eiffel_assembly.get_emitter_version_number.get_length > 0 then
						a_text_writer.write_element_string (Emitter_Version_Number_Element, old_eiffel_assembly.get_emitter_version_number)
					end

						-- <assembly_types>					
					a_text_writer.write_start_element (Assembly_Types_Element)
					from
					until
						i = types.get_count
					loop
						assembly_type ?= types.get_item (i)
						if assembly_type /= Void then
							a_text_writer.write_element_string (Assembly_Type_Filename_Element, reflection_support.Xml_Type_Filename (assembly_type.get_assembly_descriptor, assembly_type.get_full_external_name))
						end
						i := i + 1
					end
						-- </assembly_types>
					a_text_writer.write_end_element
					
						-- </assembly>
					a_text_writer.write_end_element
					a_text_writer.Close
				end
			end
		rescue
			retried := True
			support.create_error (error_messages.Assembly_description_update_failed, error_messages.Assembly_description_update_failed_message)
			last_error := support.get_last_error
			retry
		end
	
	Assembly_description_filename: STRING is "assembly_description"
		indexing
			description: "Name of `assembly_description.xml"
			external_name: "AssemblyDescriptionFilename"
		end
		
end -- TYPE_STORER
