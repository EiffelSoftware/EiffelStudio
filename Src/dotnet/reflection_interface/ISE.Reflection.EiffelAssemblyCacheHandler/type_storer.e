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
			not_empty_folder_name: a_folder_name.Length > 0
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
			description: "Assembly folder name in which type XML description will be added"
			external_name: "AssemblyFolderName"
		end
	
	last_error: ISE_REFLECTION_ERRORINFO
		indexing
			description: "Last error"
			external_name: "LastError"
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
			not_empty_filename: a_filename.Length > 0
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
			support.createerror (error_messages.File_access_failed, error_messages.File_access_failed_message)
			last_error := support.lasterror
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
			non_void_eiffel_class_name: an_eiffel_class.EiffelName /= Void
			not_empty_eiffel_class_name: an_eiffel_class.EiffelName.Length > 0	
			not_committed: not committed
		local
			public_string: STRING
			subset: STRING
			invariants: SYSTEM_COLLECTIONS_ARRAYLIST
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
			filename: STRING
			DTD_path: STRING
			retried: BOOLEAN
		do
			if not retried then
				eiffel_class := an_eiffel_class
				create reflection_support.make_reflectionsupport
				reflection_support.Make
				filename := reflection_support.XmlTypeFilename (eiffel_class.assemblydescriptor, eiffel_class.FullExternalName)
				filename := filename.replace (reflection_support.Eiffelkey, reflection_support.Eiffeldeliverypath)
				if overwrite or (not overwrite and not exists (filename)) then
					create text_writer.make_xmltextwriter_1 (filename, create {SYSTEM_TEXT_ASCIIENCODING}.make_asciiencoding)

						-- Set generation options
						-- `1' for `Formatting.Indented'
					text_writer.set_Formatting (1)
					text_writer.set_Indentation (1)
					text_writer.set_IndentChar ('%T')
					text_writer.set_Namespaces (False)
					text_writer.set_QuoteChar ('%"')

						-- XML generation

						-- Write <!DOCTYPE reflection_interface SYSTEM "reflection_interface.dtd">
					DTD_path := "..\"
					text_writer.WriteDocType (DtdTypeFilename, public_string, DTD_path.Concat_String_String_String (DTD_path, DtdTypeFilename, DtdExtension), subset)

						-- <class>
					text_writer.writestartelement (ClassElement)

						-- <header>
					generate_xml_class_header 

						-- <body>
					generate_xml_class_body 

						-- <footer>
					invariants := eiffel_class.Invariants
					if invariants.Count > 0 then
						generate_xml_class_footer (invariants)
					end

						-- </class>
					text_writer.WriteEndElement
					text_writer.Close
				end
				eiffel_class := Void
			end
		rescue
			retried := True
			support.createerror (error_messages.Xml_type_generation_failed, error_messages.XML_type_generation_failed_message)
			last_error := support.lasterror
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
				if support.HasWriteLock (assembly_folder_name) then
					file.Delete (assembly_folder_name.Concat_String_String_String (assembly_folder_name, "\", support.WriteLockFilename))
				end
			end
			committed := True
		ensure
			committed: committed
		rescue
			retried := True
			support.createerror (error_messages.Write_lock_removal_failed, error_messages.Write_lock_removal_failed_message)
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
			-- | Key: parent name
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
			non_void_class_name: eiffel_class.EiffelName /= Void
			not_empty_class_name: eiffel_class.EiffelName.Length > 0
		local
			creation_routines: SYSTEM_COLLECTIONS_ARRAYLIST	
			retried: BOOLEAN
		do
			if not retried then
					-- <header>
				text_writer.writestartelement (HeaderElement)

					-- <frozen>
				if eiffel_class.IsFrozen then
					text_writer.writeelementstring (FrozenElement, TrueString)
				else
					text_writer.writeelementstring (FrozenElement, FalseString)
				end			

					-- <expanded>
				if eiffel_class.IsExpanded then
					text_writer.writeelementstring (ExpandedElement, TrueString)
				else
					text_writer.writeelementstring (ExpandedElement, FalseString)
				end	

					-- <deferred>
				if eiffel_class.IsDeferred then
					text_writer.writeelementstring (DeferredElement, TrueString)
				else
					text_writer.writeelementstring (DeferredElement, FalseString)
				end	

					-- <class_eiffel_name>
				text_writer.writeelementstring (ClassEiffelNameElement, eiffel_class.EiffelName)

					-- <alias>
				generate_xml_alias_element 

					-- <inherit>
				parents := eiffel_class.Parents
				if parents.Count > 0 then
					generate_xml_inherit_element
				end

					-- <create>
				creation_routines := eiffel_class.CreationRoutines
				if creation_routines.Count > 0 then
					generate_xml_element_from_list (CreateElement, creation_routines)
				end

					-- <create_none>
				if eiffel_class.CreateNone then
					text_writer.writeelementstring (CreateNoneElement, TrueString)
				else
					text_writer.writeelementstring (CreateNoneElement, FalseString)
				end	

					-- </header>
				text_writer.WriteEndElement 
			end
		rescue
			retried := True
			support.createerror (error_messages.Xml_class_header_generation_failed, error_messages.Xml_class_header_generation_failed_message)
			last_error := support.lasterror
			retry
		end
	
	generate_xml_alias_element is
		indexing
			description: "Generate XML alias element from `eiffel_class'."
			external_name: "GenerateXmlAliasElement"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_eiffel_class_name: eiffel_class.EiffelName /= Void
			not_empty_eiffel_class_name: eiffel_class.EiffelName.Length > 0
		local
			retried: BOOLEAN
		do
			if not retried then
					-- <alias>
				text_writer.writestartelement (AliasElement)

					-- <simple_name>
				text_writer.writeelementstring (SimpleNameElement, eiffel_class.ExternalName)

					-- <namespace>
				if eiffel_class.Namespace /= Void and then eiffel_class.Namespace.Length > 0 then
					text_writer.writeelementstring (NamespaceElement, eiffel_class.Namespace)
				end

					-- <assembly_name>
				if eiffel_class.AssemblyDescriptor.Name /= Void and then eiffel_class.AssemblyDescriptor.Name.Length > 0 then
					text_writer.writeelementstring (AssemblyNameElement, eiffel_class.AssemblyDescriptor.Name)
				end

					-- <assembly_version>
				if eiffel_class.AssemblyDescriptor.Version /= Void and then eiffel_class.AssemblyDescriptor.Version.Length > 0 then
					text_writer.writeelementstring (AssemblyVersionElement, eiffel_class.AssemblyDescriptor.Version)
				end

					-- <assembly_culture>
				if eiffel_class.AssemblyDescriptor.Culture /= Void and then eiffel_class.AssemblyDescriptor.Culture.Length > 0 then
					text_writer.writeelementstring (AssemblyCultureElement, eiffel_class.AssemblyDescriptor.Culture)
				end

					-- <assembly_public_key>
				if eiffel_class.AssemblyDescriptor.PublicKey /= Void and then eiffel_class.AssemblyDescriptor.PublicKey.Length > 0 then
					text_writer.writeelementstring (AssemblyPublicKeyElement, eiffel_class.AssemblyDescriptor.PublicKey)
				end

					-- </alias>
				text_writer.WriteEndElement
			end
		rescue
			retried := True
			support.createerror (error_messages.Xml_alias_element_generation_failed, error_messages.Xml_alias_element_generation_failed_message)
			last_error := support.lasterror
			retry
		end
		
	generate_xml_inherit_element is
		indexing
			description: "Generate XML inherit element from `parents'."
			external_name: "GenerateXmlInheritElement"
		require
			non_void_parents: parents /= Void
			not_empty_parents: parents.Count > 0
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
				text_writer.writestartelement (InheritElement)

				keys := parents.Keys
				enumerator := keys.GetEnumerator
				from
				until
					not enumerator.MoveNext
				loop
						-- <parent>
					text_writer.writestartelement (ParentElement)

					parent_name ?= enumerator.Current_
					if parent_name /= Void and then parent_name.Length > 0 then
							-- <parent_name>
						text_writer.writeelementstring (ParentNameElement, parent_name)

						inheritance_clauses ?= parents.Item (parent_name)
						if inheritance_clauses /= Void and then inheritance_clauses.Count = 5 then
							rename_clauses := inheritance_clauses.Item (0)
							if rename_clauses.Count > 0 then
									-- <rename>
								generate_xml_element_from_inheritance_clauses (RenameElement, rename_clauses)
							end
							undefine_clauses := inheritance_clauses.Item (1)
							if undefine_clauses.Count > 0 then
									-- <undefine>
								generate_xml_element_from_inheritance_clauses (UndefineElement, undefine_clauses)
							end						
							redefine_clauses := inheritance_clauses.Item (2)
							if redefine_clauses.Count > 0 then
									-- <redefine>
								generate_xml_element_from_inheritance_clauses (RedefineElement, redefine_clauses)
							end						
							select_clauses := inheritance_clauses.Item (3)
							if select_clauses.Count > 0 then
									-- <select>
								generate_xml_element_from_inheritance_clauses (SelectElement, select_clauses)
							end						
							export_clauses := inheritance_clauses.Item (4)
							if export_clauses.Count > 0 then
									-- <export>
								generate_xml_element_from_inheritance_clauses (ExportElement, export_clauses)
							end						
						end
					end

						-- </parent>
					text_writer.WriteEndElement
				end

					-- </inherit>
				text_writer.WriteEndElement
			end
		rescue
			retried := True
			support.createerror (error_messages.Xml_inherit_element_generation_failed, error_messages.Xml_inherit_element_generation_failed_message)
			last_error := support.lasterror
			retry
		end
			
	generate_xml_class_body is
		indexing
			description: "Generate XML class body from `eiffel_class'."
			external_name: "GenerateXmlClassBody"
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_eiffel_class_name: eiffel_class.EiffelName /= Void
			not_empty_eiffel_class_name: eiffel_class.EiffelName.Length > 0
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
				text_writer.writestartelement (BodyElement)

					-- <initialization>
				initialization_features := eiffel_class.InitializationFeatures
				if initialization_features.Count > 0 then
					text_writer.writestartelement (InitializationElement)
					generate_xml_features_element (initialization_features)
					text_writer.WriteEndElement
				end

					-- <access>
				access_features := eiffel_class.AccessFeatures
				if access_features.Count > 0 then
					text_writer.writestartelement (AccessElement)
					generate_xml_features_element (access_features)
					text_writer.WriteEndElement
				end

					-- <element_change>
				element_change_features := eiffel_class.ElementChangeFeatures
				if element_change_features.Count > 0 then
					text_writer.writestartelement (ElementChangeElement)
					generate_xml_features_element (element_change_features)
					text_writer.WriteEndElement
				end

					-- <basic_operations>
				basic_operations_features := eiffel_class.BasicOperations
				if basic_operations_features.Count > 0 then
					text_writer.writestartelement (BasicOperationsElement)
					generate_xml_features_element (basic_operations_features)
					text_writer.WriteEndElement
				end

					-- <unary_operators>
				unary_operators_features := eiffel_class.UnaryOperatorsFeatures
				if unary_operators_features.Count > 0 then
					text_writer.writestartelement (UnaryOperatorsElement)
					generate_xml_features_element (unary_operators_features)
					text_writer.WriteEndElement
				end

					-- <binary_operators>
				binary_operators_features := eiffel_class.BinaryOperatorsFeatures
				if binary_operators_features.Count > 0 then
					text_writer.writestartelement (BinaryOperatorsElement)
					generate_xml_features_element (binary_operators_features)
					text_writer.WriteEndElement
				end

					-- <specials_operators>
				specials_features := eiffel_class.SpecialFeatures
				if specials_features.Count > 0 then
					text_writer.writestartelement (SpecialsElement)
					generate_xml_features_element (specials_features)
					text_writer.WriteEndElement
				end

					-- <implementation>
				implementation_features := eiffel_class.ImplementationFeatures
				if implementation_features.Count > 0 then
					text_writer.writestartelement (ImplementationElement)
					generate_xml_features_element (implementation_features)
					text_writer.WriteEndElement
				end

					-- </body>
				text_writer.WriteEndElement
			end
		rescue
			retried := True
			support.createerror (error_messages.Xml_class_body_generation_failed, error_messages.Xml_class_body_generation_failed_message)
			last_error := support.lasterror
			retry
		end
		
	generate_xml_class_footer (invariants: SYSTEM_COLLECTIONS_ARRAYLIST) is
		indexing
			description: "Generate XML class footer from `invariants'."
			external_name: "GenerateXmlClassFooter"
		require
			non_void_invariants: invariants /= Void
			not_empty_invariants: invariants.Count > 0
		local
			retried: BOOLEAN
		do
			if not retried then
					-- <footer>
				text_writer.writestartelement (FooterElement)
					-- <invariants>
				generate_xml_elements_from_assertions (invariants, InvariantElement)
					-- </footer>
				text_writer.WriteEndElement
			end
		rescue
			retried := True
			support.createerror (error_messages.Xml_class_footer_generation_failed, error_messages.Xml_class_footer_generation_failed_message)
			last_error := support.lasterror
			retry
		end
	
	generate_xml_element_from_list (xml_element: STRING; a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		indexing
			description: "Generate `xml_element' from `a_list'."
			external_name: "GenerateXmlElementFromList"
		require
			non_void_element: xml_element /= Void
			not_empty_element: xml_element.Length > 0
			non_void_list: a_list /= Void
			not_empty_list: a_list.Count > 0
		local
			names: STRING
			retried: BOOLEAN
		do
			if not retried then
				names := string_from_list (a_list)
				if names.Length > 0 then
						-- <xml_element>
					text_writer.writeelementstring (xml_element, names)
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
			not_empty_element: xml_element.Length > 0
			non_void_list: a_list /= Void
			not_empty_list: a_list.Count > 0
		local
			names: STRING
			retried: BOOLEAN
		do
			if not retried then
				names := string_from_inheritance_clauses (a_list)
				if names.Length > 0 then
						-- <xml_element>
					text_writer.writeelementstring (xml_element, names)
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
			not_empty_features: features.Count > 0
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
					i = features.Count
				loop
					a_feature ?= features.Item (i)
					if a_feature /= Void then
							-- < feature>
						text_writer.writestartelement (FeatureElement)

							-- <frozen>
						if a_feature.IsFrozen then
							text_writer.writeelementstring (FrozenFeatureElement, TrueString)
						else
							text_writer.writeelementstring (FrozenFeatureElement, FalseString)
						end	

							-- <static>
						if a_feature.IsStatic then
							text_writer.writeelementstring (StaticElement, TrueString)
						else
							text_writer.writeelementstring (StaticElement, FalseString)
						end	

							-- <abstract>
						if a_feature.IsAbstract then
							text_writer.writeelementstring (AbstractElement, TrueString)
						else
							text_writer.writeelementstring (AbstractElement, FalseString)
						end

							-- <method>
						if a_feature.IsMethod then
							text_writer.writeelementstring (MethodElement, TrueString)
						else
							text_writer.writeelementstring (MethodElement, FalseString)
						end

							-- <field>
						if a_feature.IsField then
							text_writer.writeelementstring (FieldElement, TrueString)
						else
							text_writer.writeelementstring (FieldElement, FalseString)
						end

							-- <creation_routine>
						if a_feature.IsCreationRoutine then
							text_writer.writeelementstring (CreationRoutineElement, TrueString)
						else
							text_writer.writeelementstring (CreationRoutineElement, FalseString)
						end

							-- <prefix>
						if a_feature.IsPrefix then
							text_writer.writeelementstring (PrefixElement, TrueString)
						else
							text_writer.writeelementstring (PrefixElement, FalseString)
						end

							-- <infix>
						if a_feature.IsInfix then
							text_writer.writeelementstring (InfixElement, TrueString)
						else
							text_writer.writeelementstring (InfixElement, FalseString)
						end

							-- <feature_eiffel_name>
						text_writer.writeelementstring (FeatureEiffelNameElement, a_feature.EiffelName)

							-- <feature_external_name>
						if a_feature.ExternalName /= Void and then a_feature.ExternalName.Length > 0 then
							text_writer.writeelementstring (FeatureExternalNameElement, a_feature.ExternalName)
						end

							-- <arguments>
						arguments := a_feature.Arguments
						if arguments /= Void and then arguments.Count > 0 then
							generate_xml_elements_from_feature_arguments (arguments)
						end

						if a_feature.ReturnType /= Void then 
								-- <return_type>
							text_writer.writeelementstring (ReturnTypeElement, a_feature.ReturnType.TypeEiffelName)
								-- <return_type_full_name>
							text_writer.writeelementstring (ReturnTypeFullNameElement, a_feature.ReturnType.TypeFullExternalName)
								-- <return_type_enum>
							if a_feature.ReturnType.IsEnum then
								text_writer.writeelementstring (ReturnTypeEnumElement, TrueString)
							else
								text_writer.writeelementstring (ReturnTypeEnumElement, FalseString)
							end
						end

							-- <comments>
						comments := a_feature.Comments
						if comments /= Void and then comments.Count > 0 then
							generate_xml_element_from_list (CommentsElement, comments)
						end

							-- <preconditions>
						preconditions := a_feature.Preconditions
						if preconditions.Count > 0 then
							generate_xml_elements_from_assertions (preconditions, PreconditionElement)
						end

							-- <postconditions>
						postconditions := a_feature.Postconditions
						if postconditions.Count > 0 then
							generate_xml_elements_from_assertions (postconditions, PostconditionElement)
						end						

							-- </feature>
						text_writer.WriteEndElement 
					end
					i := i + 1
				end
			end
		rescue
			retried := True
			support.createerror (error_messages.Xml_class_features_generation_failed, error_messages.Xml_class_features_generation_failed_message)
			last_error := support.lasterror
			retry
		end	
	
	generate_xml_elements_from_feature_arguments (arguments: SYSTEM_COLLECTIONS_ARRAYLIST) is
		indexing
			description: "Generate XML elements from `arguments'"
			external_name: "GenerateXmlElementsFromFeatureArguments"
		require
			non_void_arguments: arguments /= Void
			not_empty_arguments: arguments.Count > 0 
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
				text_writer.writestartelement (ArgumentsElement)

				from
				until
					i = arguments.Count
				loop
					an_argument ?= arguments.Item (i)
					if an_argument /= Void then
							-- <argument>
						text_writer.writestartelement (ArgumentElement)

						an_argument_name := an_argument.EiffelName
						if an_argument_name /= Void and then an_argument_name.Length > 0 then
								-- <argument_eiffel_name>
							text_writer.writeelementstring (ArgumentEiffelNameElement, an_argument_name)
						end

						an_argument_external_name := an_argument.ExternalName
						if an_argument_external_name /= Void and then an_argument_external_name.Length > 0 then
								-- <argument_external_name>
							text_writer.writeelementstring (ArgumentExternalNameElement, an_argument_external_name)
						end

						an_argument_type := an_argument.TypeEiffelName
						if an_argument_type /= Void and then an_argument_type.Length > 0 then
								-- <argument_type>
							text_writer.writeelementstring (ArgumentTypeElement, an_argument_type)
						end

						an_argument_type_full_name := an_argument.TypeFullExternalName
						if an_argument_type_full_name /= Void and then an_argument_type_full_name.Length > 0 then
								-- <argument_type_full_name>
							text_writer.writeelementstring (ArgumentTypeFullNameElement, an_argument_type_full_name)	
						end
							
							-- <is_argument_type_enum>
						if an_argument.IsEnum then
							text_writer.writeelementstring (ArgumentTypeEnumElement, TrueString)
						else
							text_writer.writeelementstring (ArgumentTypeEnumElement, FalseString)
						end
							-- </argument>
						text_writer.WriteEndElement
					end
					i := i + 1
				end

					-- </arguments>
				text_writer.WriteEndElement
			end
		rescue
			retried := True
			support.createerror (error_messages.Xml_feature_arguments_generation_failed, error_messages.Xml_feature_arguments_generation_failed_message)
			last_error := support.lasterror
			retry
		end
	
	generate_xml_elements_from_assertions (assertions: SYSTEM_COLLECTIONS_ARRAYLIST; assertion_type: STRING) is
		indexing
			description: "Generate XML elements from `assertions'."
			external_name: "GenerateXmlElementsFromAssertions"
		require
			non_void_assertion_type: assertion_type /= Void
			not_empty_assertion_type: assertion_type.Length > 0
			valid_assertion_type: assertion_type.Equals_String (PreconditionElement) or assertion_type.Equals_String (PostconditionElement) or assertion_type.Equals_String (InvariantElement)
			non_void_assertions: assertions /= Void
			not_empty_assertions: assertions.Count > 0
		local
			i: INTEGER
			an_assertion: ARRAY [STRING]
			assertion_tag: STRING
			assertion_text: STRING
			retried: BOOLEAN
		do
			if not retried then
					-- <assertions>
				if assertion_type.Equals_String (PreconditionElement) then
					text_writer.writestartelement (PreconditionsElement)
				elseif assertion_type.Equals_String (PostconditionElement) then
					text_writer.writestartelement (PostconditionsElement)
				elseif assertion_type.Equals_String (InvariantElement) then
					text_writer.writestartelement (InvariantsElement) 
				end

				from
				until
					i = assertions.Count
				loop
					an_assertion ?= assertions.Item (i)
					if an_assertion /= Void and then an_assertion.Count = 2 then
							-- <assertion>
						text_writer.writestartelement (assertion_type)

						assertion_tag := an_assertion.Item (0)
						if assertion_tag /= Void and then assertion_tag.Length > 0 then
								-- <assertion_tag>
							if assertion_type.Equals_String (PreconditionElement) then
								text_writer.writeelementstring (PreconditionTagElement, assertion_tag)
							elseif assertion_type.Equals_String (PostconditionElement) then
								text_writer.writeelementstring (PostconditionTagElement, assertion_tag)
							elseif assertion_type.Equals_String (InvariantElement) then
								text_writer.writeelementstring (InvariantTagElement, assertion_tag)
							end												
						end
						assertion_text := an_assertion.Item (1)
						if assertion_text /= Void and then assertion_text.Length > 0 then
								-- <assertion_text>
							if assertion_type.Equals_String (PreconditionElement) then
								text_writer.writeelementstring (PreconditionTextElement, assertion_text)
							elseif assertion_type.Equals_String (PostconditionElement) then
								text_writer.writeelementstring (PostconditionTextElement, assertion_text)
							elseif assertion_type.Equals_String (InvariantElement) then
								text_writer.writeelementstring (InvariantTextElement, assertion_text)
							end	
						end

							-- </assertion>
						text_writer.WriteEndElement
					end
					i := i + 1
				end	

					-- </assertions>
				text_writer.WriteEndElement
			end
		rescue
			retried := True
			support.createerror (error_messages.Xml_feature_assertions_generation_failed, error_messages.Xml_feature_assertions_generation_failed_message)
			last_error := support.lasterror
			retry
		end
		
	string_from_list (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): STRING is
		indexing
			description: "Generate string from `a_list'."
			external_name: "StringFromList"
		require
			non_void_list: a_list /= Void
			not_empty_list: a_list.Count > 0
		local
			i: INTEGER
			an_item: STRING 
		do
			from
				create Result.make_2 ('%U', 0)
			until
				i = a_list.Count
			loop
				an_item ?= a_list.Item (i)
				if an_item /= Void and then an_item.Length > 0 then
					Result := Result.Concat_String_String (Result, an_item)
					if i < a_list.Count - 1 then
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
			not_empty_list: a_list.Count > 0
		local
			i: INTEGER
			an_item: ISE_REFLECTION_INHERITANCECLAUSE
		do
			from
				create Result.make_2 ('%U', 0)
			until
				i = a_list.Count
			loop
				an_item ?= a_list.Item (i)
				if an_item /= Void then
					Result := Result.Concat_String_String (Result, an_item.tostring)
					if i < a_list.Count - 1 then
						Result := Result.Concat_String_String_String (Result, Comma, Space)
					end
				end
				i := i + 1
			end
		end	
		
end -- TYPE_STORER