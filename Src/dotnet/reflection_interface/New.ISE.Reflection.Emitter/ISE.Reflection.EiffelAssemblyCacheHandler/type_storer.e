indexing
	description: "Type storer"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	TYPE_STORER
	
inherit
	EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT
	XML_ELEMENTS
	
create
	make_type_storer

feature {NONE} -- Initialization

	make_type_storer (a_folder_name: like assembly_folder_name) is
		indexing
			description: "Set `assembly_folder_name' with `a_folder_name'."
		require
			non_void_folder_name: a_folder_name /= Void
			not_empty_folder_name: a_folder_name.count > 0
			valid_folder_name: is_valid_directory_path (a_folder_name)
		do
			assembly_folder_name := a_folder_name
			create error_messages
			create types.make
		ensure
			assembly_folder_name_set: assembly_folder_name.is_equal (a_folder_name)
			non_void_error_messages: error_messages /= Void
			non_void_types: types /= Void
		end

feature -- Access

	assembly_folder_name: STRING
		indexing
			description: "Assembly folder eiffel_name in which type XML description will be added"
		end
	
	last_error: ERROR_INFO
		indexing
			description: "Last error"
		end
		
feature -- Status Report

	committed: BOOLEAN 
		indexing
			description: "Was type committed? (i.e. Has `commit' been called?)"
		end
		
	exists (a_filename: STRING): BOOLEAN is
		indexing
			description: "Does a file with filename `a_filename' already exist?"
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: a_filename.count > 0
		local
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN			
		do
			if not retried then
				create file.make (a_filename)
				Result := file.exists
			else
				Result := False
			end
		rescue
			retried := True
			support.create_error (error_messages.File_access_failed, error_messages.File_access_failed_message)
			last_error := support.last_error
			retry
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

	add_type (an_eiffel_class: EIFFEL_CLASS; overwrite: BOOLEAN) is
		indexing
			description: "[
						Add type XML description corresponding to `an_eiffel_class' to the Eiffel assembly cache.
						If the xml file corresponding to `an_eiffel_class', it will overwrites it if `overwrite' is True.
					  ]"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_eiffel_class_name: an_eiffel_class.eiffel_name /= Void
			not_empty_eiffel_class_name: an_eiffel_class.eiffel_name.count > 0	
			non_void_assembly_descriptor: an_eiffel_class.assembly_descriptor /= Void
			non_void_full_external_name: an_eiffel_class.full_external_name /= Void
			not_empty_full_external_name: an_eiffel_class.full_external_name.count > 0
			non_void_external_name: an_eiffel_class.external_name /= Void
			not_empty_external_name: an_eiffel_class.external_name.count > 0
			not_committed: not committed
		local
			public_string: STRING
			subset: STRING
			invariants: LINKED_LIST [ARRAY [STRING]]
			reflection_support: REFLECTION_SUPPORT
			filename: STRING
			DTD_path: STRING
			retried: BOOLEAN
			notifier: NOTIFIER
			notifier_handle: NOTIFIER_HANDLE
			formatting:  SYSTEM_XML_FORMATTING
			ascii_encoding: ASCIIENCODING
		do
			if not retried then
				eiffel_class := an_eiffel_class
				-- may not require make1 -> make.
				--reflection_support := create {ISE_REFLECTION_SUPPORT_IMPLEMENTATION_REFLECTION_SUPPORT}.make1
				create reflection_support.make
				-- end
				filename := from_support_string ( reflection_support.xml_type_filename ( eiffel_class.assembly_descriptor, eiffel_class.full_external_name ) )
				filename.replace_substring_all ( from_support_string ( reflection_support.Eiffel_key ), from_support_string( reflection_support.Eiffel_delivery_path ) )
				if overwrite or ( not overwrite and not exists ( filename ) ) or eiffel_class.is_generic then
					create ascii_encoding.make_asciiencoding
					create text_writer.make_system_xml_xml_text_writer_1 ( filename.to_cil, ascii_encoding )

						-- Set generation options
						-- `1' for `Formatting.Indented'
					text_writer.set_formatting ( formatting.indented )
					text_writer.set_indentation ( 1 )
					text_writer.set_indent_char ( '%T' )
					text_writer.set_namespaces ( False )
					text_writer.set_quote_char ( '%"' )

						-- XML generation

						-- Write <!DOCTYPE reflection_interface SYSTEM "reflection_interface.dtd">
					DTD_path := "../"
					DTD_path.append ( dtd_type_filename )
					DTD_path.append ( dtd_extension )
					text_writer.write_doc_type ( dtd_type_filename.to_cil, Void, DTD_path.to_cil, Void )

						-- <class>
					text_writer.write_start_element ( class_element.to_cil )

						-- <header>
					generate_xml_class_header 

						-- <body>
					generate_xml_class_body 

						-- <footer>
					invariants := eiffel_class.invariants
					if invariants.count > 0 then
						generate_xml_class_footer ( invariants )
					end

						-- </class>
					text_writer.write_end_element
					text_writer.close
					if overwrite then
						--notifier_handle := create {ISE_REFLECTION_NOTIFIER_HANDLE_IMPLEMENTION_NOTIFIER_HANDLE}.make1
						create notifier_handle.make
						notifier := notifier_handle.current_notifier
						notifier.notify_replace		
					end
					types.extend ( eiffel_class )
				end
				eiffel_class := Void
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.xml_type_generation_failed), to_support_string (error_messages.xml_type_generation_failed_message))
			last_error := support.last_error
			retry
		end

	commit is
			-- | Update `assembly_description.xml'.
		indexing
			description: "Commit changes."
		require
			not_committed: not committed
		local
			file: PLAIN_TEXT_FILE
			write_lock_filename: STRING
			retried: BOOLEAN
			reflection_support: REFLECTION_SUPPORT
		do
			if not retried then
				create reflection_support.make
				update_assembly_description		
				write_lock_filename := assembly_folder_name.clone( assembly_folder_name )
				write_lock_filename.append ( "\" )
				write_lock_filename.append ( from_support_string ( support.write_lock_filename ) )
				write_lock_filename.replace_substring_all ( from_support_string ( reflection_support.Eiffel_key ), from_support_string( reflection_support.Eiffel_delivery_path ) )
				create file.make ( write_lock_filename )
				if file.exists then
					file.delete
				end
				create types.make
				committed := True
			end
		ensure
			committed: committed
			empty_types: types.count = 0
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.write_lock_removal_failed), to_support_string (error_messages.write_lock_removal_failed_message) )
			last_error := support.last_error
			retry
		end
		
feature {NONE} -- Implementation

	types: LINKED_LIST [EIFFEL_CLASS]
		-- | may need to change to ISE_REFLECTION_EIFFEL_COMPONENTS_LINKED_LIST_ANY for compatibility with
		-- | the ISE_REFLECTION_EIFFEL_COMPONENTS assembly
		indexing
			description: "List of types added to the Eiffel Assembly Cache before calling `commit'"
		end
		
	support: CODE_GENERATION_SUPPORT is
		indexing
			description: "Support"
		once 
			create Result.make
			--Result.make
		ensure
			support_created: Result /= Void
		end
	
	error_messages: TYPE_STORER_ERROR_MESSAGES
		indexing
			description: "Error messages"
		end
		
	text_writer: SYSTEM_XML_XML_TEXT_WRITER
		indexing
			description: "XML text writer"
		end
		
	eiffel_class: EIFFEL_CLASS
		indexing
			description: "Eiffel class generated by the emitter"
		end

	parents: HASH_TABLE [ARRAY[LINKED_LIST [INHERITANCE_CLAUSE]], STRING]
			-- | Key: parent eiffel_name
			-- | Value: inheritance clauses (ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST [STRING]])
		indexing
			description: "Class parents"
		end
		
	generate_xml_class_header is
		indexing
			description: "Generate XML class header from `eiffel_class'."
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_class_name: eiffel_class.eiffel_name /= Void
			not_empty_class_name: eiffel_class.eiffel_name.count > 0
			non_void_external_name: eiffel_class.external_name /= Void
			not_empty_external_name: eiffel_class.external_name.count > 0
			non_void_assembly_descriptor: eiffel_class.assembly_descriptor /= Void
		local
			--creation_routines: ISE_REFLECTION_EIFFEL_COMPONENTS_LINKED_LIST_ANY	
			retried: BOOLEAN
		do
			if not retried then
					-- <header>
				text_writer.write_start_element ( Header_Element.to_cil )
					
					-- <modified>
				if eiffel_class.modified then
					text_writer.write_element_string ( Modified_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Modified_Element.to_cil, false_string.to_cil )
				end
				
					-- <frozen>
				if eiffel_class.is_frozen then
					text_writer.write_element_string ( Frozen_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Frozen_Element.to_cil, false_string.to_cil )
				end			

					-- <expanded>
				if eiffel_class.is_expanded then
					text_writer.write_element_string ( Expanded_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Expanded_Element.to_cil, false_string.to_cil )
				end	

					-- <deferred>
				if eiffel_class.is_deferred then
					text_writer.write_element_string ( Deferred_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Deferred_Element.to_cil, false_string.to_cil )
				end	

					-- <generic>
				if eiffel_class.is_generic then
					text_writer.write_element_string ( Generic_element.to_cil, True_string.to_cil )
				else
					text_writer.write_element_string ( Generic_element.to_cil, False_string.to_cil )
				end
				
					-- <generic_derivations>
				if eiffel_class.generic_derivations /= Void and then eiffel_class.generic_derivations.count > 0 then
					generate_generic_derivations
				end
					
					-- <class_eiffel_name>
				text_writer.write_element_string ( Class_Eiffel_Name_Element.to_cil, eiffel_class.eiffel_name.to_cil )

					-- <alias>
				generate_xml_alias_element 

					-- <inherit>
				parents := eiffel_class.parents
				if parents.count > 0 then
					generate_xml_inherit_element
				end

					-- <create_none>
				if eiffel_class.create_none then
					text_writer.write_element_string ( Create_None_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Create_None_Element.to_cil, false_string.to_cil )
				end	

					-- </header>
				text_writer.write_end_element 
			end
		rescue
			retried := True
			support.create_error ( to_supPort_string (error_messages.Xml_class_header_generation_failed), to_support_string (error_messages.Xml_class_header_generation_failed_message))
			last_error := support.last_error
			retry
		end
	
	generate_generic_derivations is
		indexing
			description: "Generate XML <generic_derivations> element from `eiffel_class'."
		require
			is_generic: eiffel_class.is_generic
			non_void_generic_derivations: eiffel_class.generic_derivations /= Void
			not_empty_generic_derivations: eiffel_class.generic_derivations.count > 0
			non_void_constraints: eiffel_class.constraints /= Void
			not_empty_constraints: eiffel_class.constraints.count > 0
		local
			generic_derivations: ARRAY [GENERIC_DERIVATION]
			a_generic_derivation: GENERIC_DERIVATION
			i: INTEGER
			generic_types: ARRAY [SIGNATURE_TYPE]
			constraints: ARRAY [STRING]
			a_constraint: STRING
			j: INTEGER
			a_generic_type: SIGNATURE_TYPE
			retried: BOOLEAN
		do
			if not retried then
				generic_derivations := eiffel_class.generic_derivations
					-- <generic_derivations>
				text_writer.write_start_element  ( generic_derivations_element.to_cil )
				from
				until
					i = generic_derivations.count
				loop
					a_generic_derivation ?= generic_derivations.item (i)
					if a_generic_derivation /= Void then
							-- <generic_derivation>
						text_writer.write_start_element ( generic_derivation_element.to_cil )
						generic_types := a_generic_derivation.generic_types
						if generic_types /= Void then
								-- <derivation_types_count>
							text_writer.write_element_string ( derivation_types_count_element.to_cil, generic_types.count.to_string)
							from
								j := 0
							until
								j = generic_types.count
							loop
								a_generic_type ?= generic_types.item (j)
								if a_generic_type /= Void then
										-- <generic_type>
									text_writer.write_start_element ( generic_type_element.to_cil )
										-- <generic_type_eiffel_name>
									text_writer.write_element_string ( generic_type_eiffel_name_element.to_cil, a_generic_type.type_eiffel_name.to_cil )
										-- <generic_type_external_name>
									text_writer.write_element_string ( generic_type_external_name_element.to_cil, a_generic_type.type_full_external_name.to_cil )
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
				
				constraints := eiffel_class.constraints
					-- <constraints>
				text_writer.write_start_element ( constraints_element.to_cil )
				from
					i := 0
				until				
					i = constraints.count
				loop
					a_constraint ?= constraints.item (i)
					if a_constraint /= Void then
							-- <constraint>
						text_writer.write_element_string ( constraint_element.to_cil, a_constraint.to_cil )
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
		require
			non_void_eiffel_class: eiffel_class /= Void
			non_void_eiffel_class_name: eiffel_class.eiffel_name /= Void
			not_empty_eiffel_class_name: eiffel_class.eiffel_name.count > 0
			non_void_external_name: eiffel_class.external_name /= Void
			not_empty_external_name: eiffel_class.external_name.count > 0
			non_void_assembly_descriptor: eiffel_class.assembly_descriptor /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
					-- <alias>
				text_writer.write_start_element ( alias_element.to_cil )

					-- <simple_name>
				text_writer.write_element_string ( simple_name_element.to_cil, eiffel_class.external_name.to_cil )

					-- <namespace>
				if eiffel_class.namespace /= Void and then eiffel_class.namespace.count > 0 then
					text_writer.write_element_string ( namespace_element.to_cil, eiffel_class.namespace.to_cil )
				end

					-- <assembly_name>
				if eiffel_class.assembly_descriptor.name /= Void and then eiffel_class.assembly_descriptor.name.count> 0 then
					text_writer.write_element_string ( assembly_name_element.to_cil, eiffel_class.assembly_descriptor.name.to_cil )
				end

					-- <assembly_version>
				if eiffel_class.assembly_descriptor.version /= Void and then eiffel_class.assembly_descriptor.version.count > 0 then
					text_writer.write_element_string ( assembly_version_element.to_cil, eiffel_class.assembly_descriptor.version.to_cil )
				end

					-- <assembly_culture>
				if eiffel_class.assembly_descriptor.culture /= Void and then eiffel_class.assembly_descriptor.culture.count > 0 then
					text_writer.write_element_string ( assembly_culture_element.to_cil, eiffel_class.assembly_descriptor.culture.to_cil)
				end

					-- <assembly_public_key>
				if eiffel_class.assembly_descriptor.public_key /= Void and then eiffel_class.assembly_descriptor.public_key.count > 0 then
					text_writer.write_element_string ( assembly_public_key_element.to_cil, eiffel_class.assembly_descriptor.public_key.to_cil)
				end
					--<enum_type>
				if eiffel_class.enum_type /= Void and then eiffel_class.enum_type.count > 0 then
					text_writer.write_element_string ( enum_type_element.to_cil, eiffel_class.enum_type.to_cil)
				end
				
					-- </alias>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.Xml_alias_element_generation_failed), to_support_string (error_messages.Xml_alias_element_generation_failed_message ))
			last_error := support.last_error
			retry
		end
		
	generate_xml_inherit_element is
		indexing
			description: "Generate XML inherit element from `parents'."
		require
			non_void_parents: parents /= Void
			not_empty_parents: parents.count > 0
		local
			keys: ARRAY [STRING]
			parent_name: STRING
			inheritance_clauses: ARRAY[LINKED_LIST [INHERITANCE_CLAUSE]]
			rename_clauses: LINKED_LIST [INHERITANCE_CLAUSE]
			undefine_clauses: LINKED_LIST [INHERITANCE_CLAUSE]
			redefine_clauses: LINKED_LIST [INHERITANCE_CLAUSE]
			select_clauses: LINKED_LIST [INHERITANCE_CLAUSE]
			export_clauses: LINKED_LIST [INHERITANCE_CLAUSE]
			retried: BOOLEAN
		do
			if not retried then
					-- <inherit>
				text_writer.write_start_element (Inherit_Element.to_cil)

				keys := parents.current_keys
				from
					parents.start
				until
					parents.after
				loop
						-- <parent>
					text_writer.write_start_element ( parent_element.to_cil )

					parent_name ?= parents.key_for_iteration
					if parent_name /= Void and then parent_name.count > 0 then
							-- <parent_name>
						text_writer.write_element_string ( parent_name_element.to_cil, parent_name.to_cil)

						inheritance_clauses ?= parents.item_for_iteration
						if inheritance_clauses /= Void and then inheritance_clauses.count = 5 then
							rename_clauses := inheritance_clauses.item (0)
							if rename_clauses.count > 0 then
									-- <rename>
								generate_xml_element_from_inheritance_clauses ( from_support_string (rename_element), rename_clauses)
							end
							undefine_clauses := inheritance_clauses.item (1)
							if undefine_clauses.count > 0 then
									-- <undefine>
								generate_xml_element_from_inheritance_clauses ( from_support_string (undefine_element), undefine_clauses)
							end						
							redefine_clauses := inheritance_clauses.item (2)
							if redefine_clauses.count > 0 then
									-- <redefine>
								generate_xml_element_from_inheritance_clauses ( from_support_string (redefine_element), redefine_clauses)
							end						
							select_clauses := inheritance_clauses.item (3)
							if select_clauses.count > 0 then
									-- <select>
								generate_xml_element_from_inheritance_clauses ( from_support_string (select_element), select_clauses)
							end						
							export_clauses := inheritance_clauses.item (4)
							if export_clauses.count > 0 then
									-- <export>
								generate_xml_element_from_inheritance_clauses ( from_support_string (export_element), export_clauses)
							end						
						end
						parents.forth
					end

						-- </parent>
					text_writer.write_end_element
				end

					-- </inherit>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.xml_inherit_element_generation_failed), to_support_string (error_messages.xml_inherit_element_generation_failed_message))
			last_error := support.last_error
			retry
		end
			
	generate_xml_class_body is
		indexing
			description: "Generate XML class body from `eiffel_class'."
		require
			non_void_eiffel_class: eiffel_class /= Void
		local
			initialization_features, access_features, element_change_features, basic_operations_features: LINKED_LIST [EIFFEL_FEATURE]
			unary_operators_features, binary_operators_features, specials_features, implementation_features: LINKED_LIST [EIFFEL_FEATURE]
			retried: BOOLEAN
		do
			if not retried then
					-- </body>
				text_writer.write_start_element ( body_element.to_cil )

					-- <initialization>
				initialization_features := eiffel_class.initialization_features
				if initialization_features.count > 0 then
					text_writer.write_start_element ( initialization_element.to_cil )
					generate_xml_features_element ( initialization_features )
					text_writer.write_end_element
				end

					-- <access>
				access_features := eiffel_class.access_features
				if access_features.count > 0 then
					text_writer.write_start_element ( access_element.to_cil )
					generate_xml_features_element ( access_features )
					text_writer.write_end_element
				end

					-- <element_change>
				element_change_features := eiffel_class.element_change_features
				if element_change_features.count > 0 then
					text_writer.write_start_element ( element_change_element.to_cil )
					generate_xml_features_element ( element_change_features )
					text_writer.write_end_element
				end

					-- <basic_operations>
				basic_operations_features := eiffel_class.basic_operations
				if basic_operations_features.count > 0 then
					text_writer.write_start_element ( basic_operations_element.to_cil )
					generate_xml_features_element ( basic_operations_features )
					text_writer.write_end_element
				end

					-- <unary_operators>
				unary_operators_features := eiffel_class.unary_operators_features
				if unary_operators_features.count > 0 then
					text_writer.write_start_element ( unary_operators_element.to_cil )
					generate_xml_features_element ( unary_operators_features )
					text_writer.write_end_element
				end

					-- <binary_operators>
				binary_operators_features := eiffel_class.binary_operators_features
				if binary_operators_features.count > 0 then
					text_writer.write_start_element ( binary_operators_element.to_cil )
					generate_xml_features_element ( binary_operators_features )
					text_writer.write_end_element
				end

					-- <specials_operators>
				specials_features := eiffel_class.special_features
				if specials_features.count > 0 then
					text_writer.write_start_element ( specials_element.to_cil )
					generate_xml_features_element ( specials_features )
					text_writer.write_end_element
				end

					-- <implementation>
				implementation_features := eiffel_class.implementation_features
				if implementation_features.count > 0 then
					text_writer.write_start_element ( implementation_element.to_cil )
					generate_xml_features_element ( implementation_features )
					text_writer.write_end_element
				end
					
					-- <bit_or_infix>
				if eiffel_class.bit_or_infix then
					text_writer.write_element_string ( bit_or_infix_element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( bit_or_infix_element.to_cil, false_string.to_cil )
				end
				
					-- </body>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.Xml_class_body_generation_failed), to_support_string (error_messages.Xml_class_body_generation_failed_message))
			last_error := support.last_error
			retry
		end
		
	generate_xml_class_footer (invariants: LINKED_LIST [ARRAY [STRING]]) is
		indexing
			description: "Generate XML class footer from `invariants'."
		require
			non_void_invariants: invariants /= Void
			not_empty_invariants: invariants.count > 0
		local
			retried: BOOLEAN
		do
			if not retried then
					-- <footer>
				text_writer.write_start_element ( footer_element.to_cil )
					-- <invariants>
				generate_xml_elements_from_assertions ( invariants, invariant_element )
					-- </footer>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.Xml_class_footer_generation_failed), to_support_string (error_messages.Xml_class_footer_generation_failed_message ))
			last_error := support.last_error
			retry
		end
	
	generate_xml_element_from_list (xml_element: STRING; a_list: LINKED_LIST[STRING]) is
		indexing
			description: "Generate `xml_element' from `a_list'."
		require
			non_void_element: xml_element /= Void
			not_empty_element: xml_element.count > 0
			non_void_list: a_list /= Void
			not_empty_list: a_list.count > 0
		local
			names: STRING
			retried: BOOLEAN
		do
			if not retried then
				names := string_from_list (a_list)
				if names.count > 0 then
						-- <xml_element>
					text_writer.write_element_string ( xml_element.to_cil, names.to_cil)
				end
			end
		rescue
			retried := True
			retry
		end

	generate_xml_element_from_inheritance_clauses (xml_element: STRING; a_list: LINKED_LIST [INHERITANCE_CLAUSE]) is
		indexing
			description: "Generate `xml_element' from `a_list'."
		require
			non_void_element: xml_element /= Void
			not_empty_element: xml_element.count > 0
			non_void_list: a_list /= Void
			not_empty_list: a_list.count > 0
		local
			names: STRING
			retried: BOOLEAN
		do
			if not retried then
				names := string_from_inheritance_clauses ( a_list )
				if names.count > 0 then
						-- <xml_element>
					text_writer.write_element_string ( xml_element.to_cil, names.to_cil )
				end
			end
		rescue
			retried := True
			retry
		end
		
	generate_xml_features_element (features: LINKED_LIST [EIFFEL_FEATURE]) is
		indexing
			description: "Generate XML features elements from `features'."
		require
			non_void_features: features /= Void
			not_empty_features: features.count > 0
		local
			a_feature: EIFFEL_FEATURE
			value: STRING
			retried: BOOLEAN
		do
			if not retried then
				from
					features.start
				until
					features.after
				loop
					a_feature ?= features.item
					if a_feature /= Void then
						if a_feature.is_field and a_feature.is_static and not a_feature.is_enum_literal and a_feature.is_literal then
							value := from_component_string ( a_feature.literal_value )
							if value /= Void and then value.count > 0 then
								generate_xml_feature_element (a_feature)
							end
						else
							generate_xml_feature_element (a_feature)
						end
					end
					features.forth
				end
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.Xml_class_features_generation_failed), to_support_String (error_messages.Xml_class_features_generation_failed_message))
			last_error := support.last_error
			retry
		end	
	
	generate_xml_feature_element (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Generate XML feature element corresponding to `a_feature'."
		require
			non_void_feature: a_feature /= Void
		local
			arguments: LINKED_LIST [NAMED_SIGNATURE_TYPE_INTERFACE]
			preconditions: LINKED_LIST [ARRAY [STRING]]
			postconditions: LINKED_LIST [ARRAY [STRING]]
			comments: LINKED_LIST [STRING]
			formal_signature_type: FORMAL_SIGNATURE_TYPE
			retried: BOOLEAN
			literal_value: STRING
			temp_feature : SIGNATURE_TYPE
		do
			if not retried then
					-- < feature>
				text_writer.write_start_element ( Feature_Element.to_cil )
	
					-- <modified_feature>
				if a_feature.modified then
					text_writer.write_element_string ( modified_feature_element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( modified_feature_element.to_cil, false_string.to_cil )
				end	
	
					-- <frozen>
				if a_feature.Is_Frozen then
					text_writer.write_element_string ( frozen_feature_element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( frozen_feature_element.to_cil, false_string.to_cil )
				end	
	
					-- <static>
				if a_feature.Is_Static then
					text_writer.write_element_string ( static_element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string (static_element.to_cil, false_string.to_cil )
				end	
	
					-- <abstract>
				if a_feature.Is_Abstract then
					text_writer.write_element_string ( abstract_element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( abstract_element.to_cil, false_string.to_cil )
				end
	
					-- <method>
				if a_feature.Is_Method then
					text_writer.write_element_string ( method_element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Method_Element.to_cil, false_string.to_cil )
				end
	
					-- <field>
				if a_feature.Is_Field then
					text_writer.write_element_string ( Field_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Field_Element.to_cil, false_string.to_cil )
				end
	
					-- <creation_routine>
				if a_feature.Is_Creation_Routine then
					text_writer.write_element_string ( Creation_Routine_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Creation_Routine_Element.to_cil, false_string.to_cil )
				end
	
					-- <prefix>
				if a_feature.Is_Prefix then
					text_writer.write_element_string ( Prefix_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Prefix_Element.to_cil, false_string.to_cil )
				end
	
					-- <infix>
				if a_feature.Is_Infix then
					text_writer.write_element_string ( Infix_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Infix_Element.to_cil, false_string.to_cil )
				end
	
					-- <new_slot>
				if a_feature.New_Slot then
					text_writer.write_element_string ( New_Slot_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( New_Slot_Element.to_cil, false_string.to_cil )
				end
	
					-- <enum_literal>
				if a_feature.Is_Enum_Literal then
					text_writer.write_element_string ( Enum_Literal_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Enum_Literal_Element.to_cil, false_string.to_cil )
				end
	
					-- <is_literal>
				if a_feature.is_literal then
					text_writer.write_element_string ( Is_Literal_Element.to_cil, true_string.to_cil )
				else
					text_writer.write_element_string ( Is_Literal_Element.to_cil, false_string.to_cil )
				end
	
					-- <feature_eiffel_name>
				text_writer.write_element_string ( Feature_Eiffel_Name_Element.to_cil, a_feature.Eiffel_Name.to_cil )
	
					-- <feature_external_name>
				if a_feature.External_Name /= Void and then a_feature.External_Name.count > 0 then
					text_writer.write_element_string ( feature_external_name_element.to_cil, a_feature.external_name.to_cil )
				end
	
					-- <arguments>
				arguments := a_feature.arguments
				if arguments /= Void and then arguments.count > 0 then
					generate_xml_elements_from_feature_arguments ( arguments )
				end
	
				if a_feature.return_type /= Void then 
					temp_feature := a_feature.return_type
						-- <return_type>
					if a_feature.return_type.type_eiffel_name /= Void and a_feature.return_type.type_eiffel_name.count > 0 then
						text_writer.write_element_string ( return_type_element.to_cil, a_feature.return_type.type_eiffel_name.to_cil )
					else
						text_writer.write_element_string ( return_type_element.to_cil, Void)
					end
						
						-- <return_type_full_name>
					text_writer.write_element_string ( return_type_full_name_element.to_cil, a_feature.return_type.type_full_external_name.to_cil )
						-- <return_type_generic_parameter_index>
					formal_signature_type ?= a_feature.return_type
					if formal_signature_type /= Void then
						text_writer.write_element_string ( return_type_generic_parameter_index_element.to_cil, formal_signature_type.generic_parameter_index.to_string )
					end
				end
	
					-- <comments>
				comments ?= a_feature.comments
				if comments /= Void and then comments.count > 0 then
					generate_xml_element_from_list ( from_support_string (comments_element), comments)
				end
	
					-- <preconditions>
				preconditions ?= a_feature.preconditions
				if preconditions.count > 0 then
					generate_xml_elements_from_assertions (preconditions , from_support_string (precondition_element))
				end
	
					-- <postconditions>
				postconditions ?= a_feature.Postconditions
				if postconditions.count > 0 then
					generate_xml_elements_from_assertions (postconditions, from_support_string (postcondition_element))
				end						
	
					-- <literal_value>
				literal_value := from_component_string ( a_feature.literal_value )
				if literal_value /= Void and then literal_value.count > 0 then
					text_writer.write_element_string ( literal_value_element.to_cil, literal_value.to_cil )
				end	
	
					-- </feature>
				text_writer.write_end_element 
			end
		end
		
	generate_xml_elements_from_feature_arguments (arguments: LINKED_LIST [NAMED_SIGNATURE_TYPE_INTERFACE]) is
		indexing
			description: "Generate XML elements from `arguments'"
		require
			non_void_arguments: arguments /= Void
			not_empty_arguments: arguments.count > 0 
		local
			i: INTEGER
			an_argument: NAMED_SIGNATURE_TYPE_INTERFACE
			formal_argument: FORMAL_NAMED_SIGNATURE_TYPE
			an_argument_name: STRING
			an_argument_external_name: STRING
			an_argument_type: STRING
			an_argument_type_full_name: STRING
			retried: BOOLEAN
		do
			if not retried then
					-- <arguments>
				text_writer.write_start_element ( arguments_element.to_cil )

				from
					arguments.start
				until
					arguments.after
				loop
					an_argument ?= arguments.item
					if an_argument /= Void then
							-- <argument>
						text_writer.write_start_element ( argument_element.to_cil )

						an_argument_name := from_component_string ( an_argument.eiffel_name )
						if an_argument_name /= Void and then an_argument_name.count > 0 then
								-- <argument_eiffel_name>
							text_writer.write_element_string ( argument_eiffel_name_element.to_cil, an_argument_name.to_cil)
						end

						an_argument_external_name := from_component_string ( an_argument.external_name )
						if an_argument_external_name /= Void and then an_argument_external_name.count > 0 then
								-- <argument_external_name>
							text_writer.write_element_string ( argument_external_name_element.to_cil, an_argument_external_name.to_cil)
						end

						an_argument_type := from_component_string ( an_argument.type_eiffel_name )
						if an_argument_type /= Void and then an_argument_type.count > 0 then
								-- <argument_type>
							text_writer.write_element_string ( argument_type_element.to_cil, an_argument_type.to_cil )
						end

						an_argument_type_full_name := from_component_string ( an_argument.type_full_external_name )
						if an_argument_type_full_name /= Void and then an_argument_type_full_name.count > 0 then
								-- <argument_type_full_name>
							text_writer.write_element_string ( argument_type_full_name_element.to_cil, an_argument_type_full_name.to_cil)	
						end
						
						formal_argument ?= arguments.item
						if formal_argument /= Void then
								-- <generic_parameter_index>
							text_writer.write_element_string ( generic_parameter_index_element.to_cil, formal_argument.generic_parameter_index.to_string )
						end
						
							-- </argument>
						text_writer.write_end_element
					end
					arguments.forth
				end

					-- </arguments>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.Xml_feature_arguments_generation_failed), to_support_string (error_messages.Xml_feature_arguments_generation_failed_message))
			last_error := support.last_error
			retry
		end
	
	generate_xml_elements_from_assertions (assertions: LINKED_LIST [ARRAY [STRING]]; assertion_type: STRING) is
		indexing
			description: "Generate XML elements from `assertions'."
		require
			non_void_assertion_type: assertion_type /= Void
			not_empty_assertion_type: assertion_type.count > 0
			valid_assertion_type: assertion_type.is_equal ( from_support_string (precondition_element )) or assertion_type.is_equal ( from_support_string (postcondition_element) ) or assertion_type.is_equal ( to_support_string (invariant_element ))
			non_void_assertions: assertions /= Void
			not_empty_assertions: assertions.count > 0
		local
			i: INTEGER
			an_assertion: ARRAY [STRING]
			assertion_tag: STRING
			assertion_text: STRING
			retried: BOOLEAN
		do
			if not retried then
					-- <assertions>
				if assertion_type.is_equal ( from_support_string (precondition_element) ) then
					text_writer.write_start_element ( preconditions_element.to_cil )
				elseif assertion_type.is_equal ( from_support_string (postcondition_element) ) then
					text_writer.write_start_element ( postconditions_element.to_cil )
				elseif assertion_type.is_equal ( from_support_string (invariant_element) ) then
					text_writer.write_start_element ( invariants_element.to_cil ) 
				end

				from
					assertions.start
				until
					assertions.after
				loop
					an_assertion ?= assertions.item
					if an_assertion /= Void and then an_assertion.count = 2 then
							-- <assertion>
						text_writer.write_start_element ( assertion_type.to_cil )

						assertion_tag ?= an_assertion.item (0)
						if assertion_tag /= Void and then assertion_tag.count > 0 then
								-- <assertion_tag>
							if assertion_type.is_equal ( from_support_string ( precondition_element ) ) then
								text_writer.write_element_string ( precondition_tag_element.to_cil, assertion_tag.to_cil)
							elseif assertion_type.is_equal ( from_support_string ( postcondition_element) ) then
								text_writer.write_element_string ( postcondition_tag_element.to_cil, assertion_tag.to_cil)
							elseif assertion_type.is_equal ( from_support_string ( invariant_element ) ) then
								text_writer.write_element_string ( invariant_tag_element.to_cil, assertion_tag.to_cil)
							end												
						end
						assertion_text ?= an_assertion.item (1)
						if assertion_text /= Void and then assertion_text.count > 0 then
								-- <assertion_text>
							if assertion_type.is_equal ( from_support_string ( precondition_element ) ) then
								text_writer.write_element_string ( precondition_text_element.to_cil, assertion_text.to_cil)
							elseif assertion_type.is_equal ( from_support_string ( postcondition_element ) ) then
								text_writer.write_element_string ( postcondition_text_element.to_cil, assertion_text.to_cil)
							elseif assertion_type.is_equal ( from_support_string ( invariant_element) ) then
								text_writer.write_element_string ( invariant_text_element.to_cil, assertion_text.to_cil)
							end	
						end

							-- </assertion>
						text_writer.write_end_element
					end
					assertions.forth
				end	

					-- </assertions>
				text_writer.write_end_element
			end
		rescue
			retried := True
			support.create_error ( to_support_string (error_messages.Xml_feature_assertions_generation_failed), to_support_string (error_messages.Xml_feature_assertions_generation_failed_message))
			last_error := support.last_error
			retry
		end
		
	string_from_list (a_list: LINKED_LIST[STRING]): STRING is
		indexing
			description: "Generate string from `a_list'."
		require
			non_void_list: a_list /= Void
			not_empty_list: a_list.count > 0
		local
			an_item: STRING 
			i: INTEGER
		do
			from
				Result := ""
				a_list.start
			until
				a_list.after
			loop
				an_item ?= a_list.item
				if an_item /= Void and then an_item.count > 0 then
					Result.append ( an_item )
					if i < a_list.count - 1 then
						Result.append ( comma )
						Result.append ( space )
					end
				end
				a_list.forth
			end
		end	

	string_from_inheritance_clauses (a_list: LINKED_LIST [INHERITANCE_CLAUSE]): STRING is
			-- | a_list: SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_INHERITANCECLAUSE]
		indexing
			description: "Generate string from `a_list'."
		require
			non_void_list: a_list /= Void
			not_empty_list: a_list.count > 0
		local
			an_item: INHERITANCE_CLAUSE
		do
			from
				Result := ""
				a_list.start
			until
				a_list.after
			loop
				an_item ?= a_list.item
				if an_item /= Void then
					Result.append( from_component_string (an_item.string_representation) )
					if not (a_list.islast) then
						Result.append ( Comma )
						Result.append ( Space )
					end
				end
				a_list.forth
			end
		end	
	
	update_assembly_description is
		indexing
			description: "Update `assembly_description.xml' located in $EIFFEL\dotnet\assemblies\assembly_folder_name with list of added `types'."
		local
			reflection_support: REFLECTION_SUPPORT
			assembly_description_path: STRING
			file: PLAIN_TEXT_FILE
			code_generation_support: CODE_GENERATION_SUPPORT
			old_eiffel_assembly: EIFFEL_ASSEMBLY
			a_text_writer: SYSTEM_XML_XML_TEXT_WRITER
			public_string: STRING
			subset: STRING			
			dtd_path: STRING
			i: INTEGER
			assembly_type: EIFFEL_CLASS
			retried: BOOLEAN
			white_space_handling:  SYSTEM_XML_WHITESPACE_HANDLING
			formatting:  SYSTEM_XML_FORMATTING
			an_eiffel_cluster_path: STRING
			ascii_encoding: ASCIIENCODING
		do
			if not retried then
				--reflection_support := create {ISE_REFLECTION_SUPPORT_IMPLEMENTATION_REFLECTION_SUPPORT}.make
				create reflection_support.make
				
					-- Add type Xml filename to `assembly_description.xml' located in `$EIFFEL\dotnet\assemblies\assembly_folder_name'.
				assembly_description_path ?= assembly_folder_name.clone ( assembly_folder_name )
				assembly_description_path.append ( "\" )
				assembly_description_path.append ( assembly_description_filename )
				assembly_description_path.append ( from_support_string (xml_extension) )
				assembly_description_path.replace_substring_all ( from_support_string ( reflection_support.Eiffel_key ), from_support_string( reflection_support.Eiffel_delivery_path ) )
				
				create file.make ( assembly_description_path )
				
				if file.exists then
					--code_generation_support := create {ISE_REFLECTION_SUPPORT_IMPLEMENTATION_CODE_GENERATION_SUPPORT}.make
					create code_generation_support.make
					old_eiffel_assembly := code_generation_support.eiffel_assembly_from_xml ( to_support_string ( assembly_description_path ) )
					file.delete
					create ascii_encoding.make_asciiencoding 		
					create a_text_writer.make_system_xml_xml_text_writer_1 ( assembly_description_path.to_cil, ascii_encoding)
						-- Set generation options
					a_text_writer.set_Formatting ( formatting.indented )
					a_text_writer.set_Indentation ( 1 )
					a_text_writer.set_Indent_Char ( '%T' )
					a_text_writer.set_Namespaces ( False )
					a_text_writer.set_Quote_Char ( '%"' )

						-- Write `<!DOCTYPE ...>
					dtd_path := "../"
					dtd_path.append ( from_support_string (dtd_assembly_filename) )
					dtd_path.append ( from_support_string (dtd_Extension) )
					a_text_writer.Write_Doc_Type ( dtd_assembly_filename.to_cil, Void, dtd_path.to_cil, Void)
					
						-- <assembly>
					a_text_writer.write_start_element ( assembly_element.to_cil )

						-- <assembly_name>
					a_text_writer.write_element_string ( assembly_name_element.to_cil, old_eiffel_assembly.assembly_descriptor.name.to_cil)

						-- <assembly_version>
					if old_eiffel_assembly.assembly_descriptor.version /= Void and then old_eiffel_assembly.assembly_descriptor.version.count > 0 then
						a_text_writer.write_element_string (Assembly_Version_Element.to_cil, old_eiffel_assembly.assembly_descriptor.version.to_cil)
					end

						-- <assembly_culture>
					if old_eiffel_assembly.assembly_descriptor.culture /= Void and then old_eiffel_assembly.assembly_descriptor.culture.count > 0 then
						a_text_writer.write_element_string (Assembly_Culture_Element.to_cil, old_eiffel_assembly.assembly_descriptor.culture.to_cil)
					end

						-- <assembly_public_key>
					if old_eiffel_assembly.assembly_descriptor.public_key /= Void and then old_eiffel_assembly.assembly_descriptor.public_key.count > 0 then
						a_text_writer.write_element_string (Assembly_Public_Key_Element.to_cil, old_eiffel_assembly.assembly_descriptor.public_key.to_cil)
					end

						-- <eiffel_cluster_path>
					an_eiffel_cluster_path := from_component_string ( old_eiffel_assembly.eiffel_cluster_path )
					if an_eiffel_cluster_path /= Void and then an_eiffel_cluster_path.count > 0 then
						an_eiffel_cluster_path.replace_substring_all ( from_support_string ( reflection_support.Eiffel_delivery_path ), from_support_string ( reflection_support.Eiffel_key ) )
						a_text_writer.write_element_string (Eiffel_Cluster_Path_Element.to_cil, an_eiffel_cluster_path.to_cil)
					end

						-- <emitter_version_number>
					if old_eiffel_assembly.emitter_version_number /= Void and then old_eiffel_assembly.emitter_version_number.count > 0 then
						a_text_writer.write_element_string (Emitter_Version_Number_Element.to_cil, old_eiffel_assembly.emitter_version_number.to_cil)
					end

						-- <assembly_types>					
					a_text_writer.write_start_element (Assembly_Types_Element.to_cil)
					from
						types.start
					until
						types.after
					loop
						assembly_type ?= types.item
						if assembly_type /= Void then
							a_text_writer.write_element_string (Assembly_Type_Filename_Element.to_cil, reflection_support.Xml_Type_Filename (assembly_type.assembly_descriptor, to_support_string (from_component_string (assembly_type.full_external_name))).to_cil )
						end
						types.forth
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
			support.create_error ( to_support_string (error_messages.Assembly_description_update_failed), to_support_string (error_messages.Assembly_description_update_failed_message))
			last_error := support.last_error
			retry
		end
	
	Assembly_description_filename: STRING is "assembly_description"
		indexing
			description: "Name of `assembly_description.xml"
		end

invariant
	non_void_assembly_folder_name: assembly_folder_name /= Void
	not_empty_assembly_folder_name: assembly_folder_name.count > 0
	
end -- TYPE_STORER
