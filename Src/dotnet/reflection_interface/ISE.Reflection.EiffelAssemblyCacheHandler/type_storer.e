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
		ensure
			assembly_folder_name_set: assembly_folder_name.Equals_String (a_folder_name)
			non_void_error_messages: error_messages /= Void
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
			last_error := support.last_error
			retry
		end
		
feature -- Basic Operations

	add_type (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS; overwrite: BOOLEAN) is
		indexing
			description: "[Add type XML description corresponding to `an_eiffel_class' to the Eiffel assembly cache.%
					%If the xml file corresponding to `an_eiffel_class', it will overwrites it if `overwrite' is True.]"
			external_name: "AddType"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_eiffel_class_name: an_eiffel_class.eiffel_name /= Void
			not_empty_eiffel_class_name: an_eiffel_class.eiffel_name.get_length > 0	
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
		do
			if not retried then
				eiffel_class := an_eiffel_class
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				filename := reflection_support.Xml_Type_Filename (eiffel_class.assembly_descriptor, eiffel_class.Full_External_Name)
				filename := filename.replace (reflection_support.Eiffel_key, reflection_support.Eiffel_delivery_path)
				if overwrite or (not overwrite and not exists (filename)) then
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
					DTD_path := "..\"
					text_writer.Write_Doc_Type (Dtd_Type_Filename, public_string, DTD_path.Concat_String_String_String (DTD_path, Dtd_Type_Filename, Dtd_Extension), subset)

						-- <class>
					text_writer.write_start_element (Class_Element)

						-- <header>
					generate_xml_class_header 

						-- <body>
					generate_xml_class_body 

						-- <footer>
					invariants := eiffel_class.Invariants
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
				end
				eiffel_class := Void
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_type_generation_failed, error_messages.XML_type_generation_failed_message)
			last_error := support.last_error
			retry
		end

	commit is
			-- | Delete write lock.
		indexing
			description: "Commit changes."
			external_name: "Commit"
		require
			not_committed: not committed
		local
			file: SYSTEM_IO_FILE
			retried: BOOLEAN
		do
			if not retried then
				if support.Has_Write_Lock (assembly_folder_name) then
					file.Delete (assembly_folder_name.Concat_String_String_String (assembly_folder_name, "\", support.Write_Lock_Filename))
				end
			end
			committed := True
		ensure
			committed: committed
		rescue
			retried := True
			support.create_error (error_messages.Write_lock_removal_failed, error_messages.Write_lock_removal_failed_message)
			last_error := support.last_error
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
			non_void_class_name: eiffel_class.Eiffel_Name /= Void
			not_empty_class_name: eiffel_class.Eiffel_Name.get_length > 0
		local
			creation_routines: SYSTEM_COLLECTIONS_ARRAYLIST	
			retried: BOOLEAN
		do
			if not retried then
					-- <header>
				text_writer.write_start_element (Header_Element)
					
					-- <modified>
				if eiffel_class.modified then
					text_writer.write_element_string (Modified_Element, true_string)
				else
					text_writer.write_element_string (Modified_Element, false_string)				
				end
				
					-- <frozen>
				if eiffel_class.Is_Frozen then
					text_writer.write_element_string (Frozen_Element, true_string)
				else
					text_writer.write_element_string (Frozen_Element, false_string)
				end			

					-- <expanded>
				if eiffel_class.Is_Expanded then
					text_writer.write_element_string (Expanded_Element, true_string)
				else
					text_writer.write_element_string (Expanded_Element, false_string)
				end	

					-- <deferred>
				if eiffel_class.Is_Deferred then
					text_writer.write_element_string (Deferred_Element, true_string)
				else
					text_writer.write_element_string (Deferred_Element, false_string)
				end	

					-- <class_eiffel_name>
				text_writer.write_element_string (Class_Eiffel_Name_Element, eiffel_class.eiffel_name)

					-- <alias>
				generate_xml_alias_element 

					-- <inherit>
				parents := eiffel_class.Parents
				if parents.get_count > 0 then
					generate_xml_inherit_element
				end

					-- <create>
				creation_routines := eiffel_class.Creation_Routines
				if creation_routines.get_count > 0 then
					generate_xml_element_from_list (Create_Element, creation_routines)
				end

					-- <create_none>
				if eiffel_class.Create_None then
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
			last_error := support.last_error
			retry
		end
	
	generate_xml_alias_element is
		indexing
			description: "Generate XML alias element from `eiffel_class'."
			external_name: "GenerateXmlAliasElement"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_eiffel_class_name: eiffel_class.Eiffel_Name /= Void
			not_empty_eiffel_class_name: eiffel_class.Eiffel_Name.get_length > 0
		local
			retried: BOOLEAN
		do
			if not retried then
					-- <alias>
				text_writer.write_start_element (Alias_Element)

					-- <simple_name>
				text_writer.write_element_string (Simple_Name_Element, eiffel_class.External_Name)

					-- <namespace>
				if eiffel_class.Namespace /= Void and then eiffel_class.Namespace.get_length > 0 then
					text_writer.write_element_string (Namespace_Element, eiffel_class.Namespace)
				end

					-- <assembly_name>
				if eiffel_class.Assembly_Descriptor.name /= Void and then eiffel_class.Assembly_Descriptor.name.get_length > 0 then
					text_writer.write_element_string (Assembly_Name_Element, eiffel_class.Assembly_Descriptor.name)
				end

					-- <assembly_version>
				if eiffel_class.Assembly_Descriptor.Version /= Void and then eiffel_class.Assembly_Descriptor.Version.get_length > 0 then
					text_writer.write_element_string (Assembly_Version_Element, eiffel_class.Assembly_Descriptor.Version)
				end

					-- <assembly_culture>
				if eiffel_class.Assembly_Descriptor.Culture /= Void and then eiffel_class.Assembly_Descriptor.Culture.get_length > 0 then
					text_writer.write_element_string (Assembly_Culture_Element, eiffel_class.Assembly_Descriptor.Culture)
				end

					-- <assembly_public_key>
				if eiffel_class.Assembly_Descriptor.Public_Key /= Void and then eiffel_class.Assembly_Descriptor.Public_Key.get_length > 0 then
					text_writer.write_element_string (Assembly_Public_Key_Element, eiffel_class.Assembly_Descriptor.Public_Key)
				end
					--<enum_type>
				if eiffel_class.enum_type /= Void and then eiffel_class.enum_type.get_length > 0 then
					text_writer.write_element_string (Enum_Type_Element, eiffel_class.Enum_Type)
				end
				
					-- </alias>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_alias_element_generation_failed, error_messages.Xml_alias_element_generation_failed_message)
			last_error := support.last_error
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
			last_error := support.last_error
			retry
		end
			
	generate_xml_class_body is
		indexing
			description: "Generate XML class body from `eiffel_class'."
			external_name: "GenerateXmlClassBody"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_eiffel_class_name: eiffel_class.Eiffel_Name /= Void
			not_empty_eiffel_class_name: eiffel_class.Eiffel_Name.get_length > 0
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
				initialization_features := eiffel_class.Initialization_Features
				if initialization_features.get_count > 0 then
					text_writer.write_start_element (Initialization_Element)
					generate_xml_features_element (initialization_features)
					text_writer.write_end_element
				end

					-- <access>
				access_features := eiffel_class.Access_Features
				if access_features.get_count > 0 then
					text_writer.write_start_element (Access_Element)
					generate_xml_features_element (access_features)
					text_writer.write_end_element
				end

					-- <element_change>
				element_change_features := eiffel_class.Element_Change_Features
				if element_change_features.get_count > 0 then
					text_writer.write_start_element (Element_Change_Element)
					generate_xml_features_element (element_change_features)
					text_writer.write_end_element
				end

					-- <basic_operations>
				basic_operations_features := eiffel_class.Basic_Operations
				if basic_operations_features.get_count > 0 then
					text_writer.write_start_element (Basic_Operations_Element)
					generate_xml_features_element (basic_operations_features)
					text_writer.write_end_element
				end

					-- <unary_operators>
				unary_operators_features := eiffel_class.Unary_Operators_Features
				if unary_operators_features.get_count > 0 then
					text_writer.write_start_element (Unary_Operators_Element)
					generate_xml_features_element (unary_operators_features)
					text_writer.write_end_element
				end

					-- <binary_operators>
				binary_operators_features := eiffel_class.Binary_Operators_Features
				if binary_operators_features.get_count > 0 then
					text_writer.write_start_element (Binary_Operators_Element)
					generate_xml_features_element (binary_operators_features)
					text_writer.write_end_element
				end

					-- <specials_operators>
				specials_features := eiffel_class.Special_Features
				if specials_features.get_count > 0 then
					text_writer.write_start_element (Specials_Element)
					generate_xml_features_element (specials_features)
					text_writer.write_end_element
				end

					-- <implementation>
				implementation_features := eiffel_class.Implementation_Features
				if implementation_features.get_count > 0 then
					text_writer.write_start_element (Implementation_Element)
					generate_xml_features_element (implementation_features)
					text_writer.write_end_element
				end

					-- </body>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_class_body_generation_failed, error_messages.Xml_class_body_generation_failed_message)
			last_error := support.last_error
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
			last_error := support.last_error
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
			arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			preconditions: SYSTEM_COLLECTIONS_ARRAYLIST
			postconditions: SYSTEM_COLLECTIONS_ARRAYLIST
			comments: SYSTEM_COLLECTIONS_ARRAYLIST
			return_type: STRING
			retried: BOOLEAN
		do
			if not retried then
				from
				until
					i = features.get_count
				loop
					a_feature ?= features.get_item (i)
					if a_feature /= Void then
							-- < feature>
						text_writer.write_start_element (Feature_Element)

							-- <modified_feature>
						if a_feature.modified then
							text_writer.write_element_string (Modified_Feature_Element, True_String)
						else
							text_writer.write_element_string (Modified_Feature_Element, False_String)
						end	
						
							-- <frozen>
						if a_feature.Is_Frozen then
							text_writer.write_element_string (Frozen_Feature_Element, True_String)
						else
							text_writer.write_element_string (Frozen_Feature_Element, False_String)
						end	

							-- <static>
						if a_feature.Is_Static then
							text_writer.write_element_string (Static_Element, True_String)
						else
							text_writer.write_element_string (Static_Element, False_String)
						end	

							-- <abstract>
						if a_feature.Is_Abstract then
							text_writer.write_element_string (Abstract_Element, True_String)
						else
							text_writer.write_element_string (Abstract_Element, False_String)
						end

							-- <method>
						if a_feature.Is_Method then
							text_writer.write_element_string (Method_Element, True_String)
						else
							text_writer.write_element_string (Method_Element, False_String)
						end

							-- <field>
						if a_feature.Is_Field then
							text_writer.write_element_string (Field_Element, True_String)
						else
							text_writer.write_element_string (Field_Element, False_String)
						end

							-- <creation_routine>
						if a_feature.Is_Creation_Routine then
							text_writer.write_element_string (Creation_Routine_Element, True_String)
						else
							text_writer.write_element_string (Creation_Routine_Element, False_String)
						end

							-- <prefix>
						if a_feature.Is_Prefix then
							text_writer.write_element_string (Prefix_Element, True_String)
						else
							text_writer.write_element_string (Prefix_Element, False_String)
						end

							-- <infix>
						if a_feature.Is_Infix then
							text_writer.write_element_string (Infix_Element, True_String)
						else
							text_writer.write_element_string (Infix_Element, False_String)
						end

							-- <new_slot>
						if a_feature.New_Slot then
							text_writer.write_element_string (New_Slot_Element, True_String)
						else
							text_writer.write_element_string (New_Slot_Element, False_String)
						end

							-- <enum_literal>
						if a_feature.Is_Enum_Literal then
							text_writer.write_element_string (Enum_Literal_Element, True_String)
						else
							text_writer.write_element_string (Enum_Literal_Element, False_String)
						end

							-- <feature_eiffel_name>
						text_writer.write_element_string (Feature_Eiffel_Name_Element, a_feature.Eiffel_Name)

							-- <feature_external_name>
						if a_feature.External_Name /= Void and then a_feature.External_Name.get_length > 0 then
							text_writer.write_element_string (Feature_External_Name_Element, a_feature.External_Name)
						end

							-- <arguments>
						arguments := a_feature.Arguments
						if arguments /= Void and then arguments.get_count > 0 then
							generate_xml_elements_from_feature_arguments (arguments)
						end

						if a_feature.Return_Type /= Void then 
								-- <return_type>
							text_writer.write_element_string (Return_Type_Element, a_feature.Return_Type.Type_Eiffel_Name)
								-- <return_type_full_name>
							text_writer.write_element_string (Return_Type_Full_Name_Element, a_feature.Return_Type.Type_Full_External_Name)
						end

							-- <comments>
						comments := a_feature.Comments
						if comments /= Void and then comments.get_count > 0 then
							generate_xml_element_from_list (Comments_Element, comments)
						end

							-- <preconditions>
						preconditions := a_feature.Preconditions
						if preconditions.get_count > 0 then
							generate_xml_elements_from_assertions (preconditions, Precondition_Element)
						end

							-- <postconditions>
						postconditions := a_feature.Postconditions
						if postconditions.get_count > 0 then
							generate_xml_elements_from_assertions (postconditions, Postcondition_Element)
						end						

							-- </feature>
						text_writer.write_end_element 
					end
					i := i + 1
				end
			end
		rescue
			retried := True
			support.create_error (error_messages.Xml_class_features_generation_failed, error_messages.Xml_class_features_generation_failed_message)
			last_error := support.last_error
			retry
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
			an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE
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

						an_argument_name := an_argument.Eiffel_Name
						if an_argument_name /= Void and then an_argument_name.get_length > 0 then
								-- <argument_eiffel_name>
							text_writer.write_element_string (Argument_Eiffel_Name_Element, an_argument_name)
						end

						an_argument_external_name := an_argument.External_Name
						if an_argument_external_name /= Void and then an_argument_external_name.get_length > 0 then
								-- <argument_external_name>
							text_writer.write_element_string (Argument_External_Name_Element, an_argument_external_name)
						end

						an_argument_type := an_argument.Type_Eiffel_Name
						if an_argument_type /= Void and then an_argument_type.get_length > 0 then
								-- <argument_type>
							text_writer.write_element_string (Argument_Type_Element, an_argument_type)
						end

						an_argument_type_full_name := an_argument.Type_Full_External_Name
						if an_argument_type_full_name /= Void and then an_argument_type_full_name.get_length > 0 then
								-- <argument_type_full_name>
							text_writer.write_element_string (Argument_Type_Full_Name_Element, an_argument_type_full_name)	
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
			last_error := support.last_error
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
			last_error := support.last_error
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
		
end -- TYPE_STORER