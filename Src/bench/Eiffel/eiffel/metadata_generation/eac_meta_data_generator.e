indexing
	description: "Register Eiffel.NET type into Eiffel Assembly Cache"
	date: "$Date$"
	revision: "$Revision$"

class
	EAC_META_DATA_GENERATOR

inherit
	SHARED_IL_CONSTANTS
		export
			{NONE} all
		end

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize COM proxy.
		do
			create assembly_descriptors.make (5)
			create assembly_names.make (5)
		end

feature -- Basic Operation

	add (class_c: CLASS_C) is
			-- Register type described in `class_c' into EAC.
		require
			non_void_class_c: class_c /= Void
			external_class: class_c.is_external
			signed_assembly: class_c.ast.top_indexes.assembly_name /= Void
		local
			ast: CLASS_AS 
			parents: EIFFEL_LIST [PARENT_AS]
			parent_classes: FIXED_LIST [CL_TYPE_A]
			parent: PARENT_PROXY
			local_rename_clauses: LIST [RENAME_CLAUSE_PROXY]
			local_redefine_clauses: LIST [REDEFINE_CLAUSE_PROXY]
			local_undefine_clauses: LIST [UNDEFINE_CLAUSE_PROXY]
			local_select_clauses: LIST [SELECT_CLAUSE_PROXY]
			local_export_clauses: LIST [EXPORT_CLAUSE_PROXY]
			features: FEATURE_TABLE
			feature_proxy: EIFFEL_FEATURE_PROXY
			current_feature: FEATURE_I
			signature_type: SIGNATURE_TYPE_PROXY
			constant: CONSTANT_I
			an_external: EXTERNAL_I
			an_extension: IL_EXTENSION_I
			a_deferred: DEF_PROC_I
			a_attribute: ATTRIBUTE_I
			a_string: STRING
			named_signature: NAMED_SIGNATURE_TYPE_PROXY
			eac_registrar: EIFFEL_CLASS_PROXY
			found: BOOLEAN
			op_name: STRING
		do
			ast := class_c.ast
			create eac_registrar.make
			eac_registrar.make1
			eac_registrar.set_deferred (class_c.is_deferred)
			eac_registrar.set_expanded (class_c.is_expanded)
			eac_registrar.set_frozen (class_c.is_frozen)
			if ast.top_indexes /= Void and then ast.top_indexes.enum_type /= Void then
				eac_registrar.set_enum_type (ast.top_indexes.enum_type)
			end
			eac_registrar.set_create_none (class_c.creators /= Void and then class_c.creators.is_empty)
			a_string := clone (class_c.name)
			a_string.to_upper
			eac_registrar.set_eiffel_name (a_string)
			eac_registrar.set_external_names (class_c.external_class_name)
			create a_string.make (256)
			a_string.append (ast.top_indexes.assembly_name.item (1))
			a_string.append (ast.top_indexes.assembly_name.item (2))
			a_string.append (ast.top_indexes.assembly_name.item (3))
			a_string.append (ast.top_indexes.assembly_name.item (4))
			assembly_descriptors.search (a_string)
			if assembly_descriptors.found then
				assembly_descriptors.found_item.extend (eac_registrar)
			else
				assembly_names.put (ast.top_indexes.assembly_name, a_string)
				assembly_descriptors.put (create {LINKED_LIST [EIFFEL_CLASS_PROXY]}.make, a_string)
				assembly_descriptors.item (a_string).extend (eac_registrar)
			end

			parents := ast.parents
			if parents /= Void then
				from
					parents.start
				until
					parents.after
				loop
					create parent.make
					a_string := parents.item.type.class_name
					a_string.to_upper
					parent.make1 (a_string)
					if parents.item.renaming /= Void then
						-- Rename clauses
						from
							local_rename_clauses := rename_clauses (parents.item.renaming)
							local_rename_clauses.start
						until
							local_rename_clauses.after
						loop
							parent.add_rename_clause (local_rename_clauses.item)
							local_rename_clauses.forth
						end						
					end
	
					if parents.item.redefining /= Void then
						-- Redefine clauses
						from
							local_redefine_clauses := redefine_clauses (parents.item.redefining)
							local_redefine_clauses.start
						until
							local_redefine_clauses.after
						loop
							parent.add_redefine_clause (local_redefine_clauses.item)
							local_redefine_clauses.forth
						end
					end
	
					-- Undefine clauses
					if parents.item.undefining /= Void then
						from
							local_undefine_clauses := undefine_clauses (parents.item.undefining)
							local_undefine_clauses.start
						until
							local_undefine_clauses.after
						loop
							parent.add_undefine_clause (local_undefine_clauses.item)
							local_undefine_clauses.forth
						end
					end
	
					-- Select clauses
					if parents.item.selecting /= Void then
						from
							local_select_clauses := select_clauses (parents.item.selecting)
							local_select_clauses.start
						until
							local_select_clauses.after
						loop
							parent.add_select_clause (local_select_clauses.item)
							local_select_clauses.forth
						end
					end

					-- Export clauses
					if parents.item.exports /= Void then
						from
							local_export_clauses := export_clauses (parents.item.exports)
							local_export_clauses.start
						until
							local_export_clauses.after
						loop
							parent.add_export_clause (local_export_clauses.item)
							local_export_clauses.forth
						end
					end
	
					eac_registrar.add_parent (parent)
					parents.forth
				end
			end
			
			-- Features
			check
				features_not_void: class_c.feature_table /= Void
			end
			from
				features := class_c.feature_table
				features.start
			until
				features.after
			loop
				create feature_proxy.make
				feature_proxy.make1
				current_feature := features.item_for_iteration
				an_external ?= current_feature
				if an_external /= Void then
					an_extension ?= an_external.extension
				else
					a_deferred ?= current_feature
					if a_deferred /= Void then
						an_extension ?= a_deferred.extension
					else
						a_attribute ?= current_feature
						if a_attribute /= Void then
							an_extension ?= a_attribute.extension
						else
							-- This is an artificial feature
							-- If current class is an enum then it's the feature `|'
							eac_registrar.set_bit_or_infix (class_c.is_enum)
							an_extension := Void
						end
					end
				end
				if an_extension /= Void and current_feature.written_in = class_c.class_id then
					if current_feature.is_infix then
						op_name := extract_symbol_from_infix (current_feature.feature_name)
						feature_proxy.set_eiffel_name ("%"" + op_name + "%"")
					elseif current_feature.is_prefix then
						op_name := extract_symbol_from_prefix (current_feature.feature_name)
						feature_proxy.set_eiffel_name ("%"" + op_name + "%"")
						create named_signature.make
						named_signature.make1
						named_signature.set_type_full_external_name (class_c.external_class_name)
						feature_proxy.add_argument (named_signature)
					else
						feature_proxy.set_eiffel_name (current_feature.feature_name)
					end
					if an_extension.type /= Creator_type then
						feature_proxy.set_external_name (current_feature.external_name)						
					end
					feature_proxy.set_frozen (current_feature.is_frozen)					
					if an_extension.type = Static_field_type or an_extension.type = Field_type or an_extension.type = Enum_field_type then
						feature_proxy.set_field (True)
					elseif an_extension.type = Creator_type then
						feature_proxy.set_creation_routine (True)
					else
						feature_proxy.set_method (True)
					end
					feature_proxy.set_abstract (an_extension.type = Deferred_type)
					feature_proxy.set_prefix (current_feature.is_prefix)
					feature_proxy.set_infix (current_feature.is_infix)
					feature_proxy.set_static (an_extension.type = Static_field_type or an_extension.type = Static_type or an_extension.type = Operator_type)
					if class_c.is_enum then
						feature_proxy.set_literal (True)
						feature_proxy.set_enum_literal (True)
						feature_proxy.set_static (True)
					end
					
					if current_feature.is_constant then
						feature_proxy.set_literal (True)
						constant ?= current_feature
						feature_proxy.set_literal_value (constant.value.string_value)
					else
						if current_feature.is_attribute or current_feature.is_function then
							create signature_type.make
							signature_type.make1
							if current_feature.type.actual_type.has_generics then
								a_string := clone (current_feature.type.actual_type.dump)
							else
								-- To avoid "EXPANDED" in "EXPANDED <class name>" that `dump' generates
								a_string := clone (current_feature.type.actual_type.associated_class.name)
							end
							a_string.to_upper
							signature_type.set_type_eiffel_name (a_string)
							signature_type.set_type_full_external_name (names_heap.item (an_extension.return_type))
							feature_proxy.set_return_type (signature_type)
						elseif an_extension.type /= Creator_type then
							create signature_type.make
							signature_type.make1
							signature_type.set_type_full_external_name ("System.Void")
							feature_proxy.set_return_type (signature_type)
						end
						if current_feature.arguments /= Void then
							from
								current_feature.arguments.start
							until
								current_feature.arguments.after
							loop
								create named_signature.make
								named_signature.make1
								if current_feature.arguments.item.actual_type.has_generics then
									a_string := clone (current_feature.arguments.item.actual_type.dump)
								else
									-- To avoid "EXPANDED" in "EXPANDED <class name>" that `dump' generates
									a_string := clone (current_feature.arguments.item.actual_type.associated_class.name)
								end
								a_string.to_upper
								named_signature.set_type_eiffel_name (a_string)
								a_string := current_feature.arguments.item_name (current_feature.arguments.index)
								named_signature.set_eiffel_name (a_string)
								named_signature.set_external_name (a_string)
								named_signature.set_type_full_external_name (Names_heap.item (an_extension.argument_types.item (current_feature.arguments.index)))
								feature_proxy.add_argument (named_signature)
								current_feature.arguments.forth
							end							
						end
						
						if current_feature.is_origin and an_extension.type /= Creator_type then
							parent_classes := class_c.parents
							from
								parent_classes.start
								found := False
							until
								found or parent_classes.after
							loop
								found := parent_classes.item.associated_class.feature_table.feature_of_rout_id (current_feature.rout_id_set.first) /= Void
								parent_classes.forth
							end
							feature_proxy.set_new_slot (not found)
						end
						if an_extension.type = Creator_type then
							eac_registrar.add_initialization_feature (feature_proxy)
						elseif not current_feature.export_status.is_all then
							eac_registrar.add_implementation_feature (feature_proxy)
						elseif current_feature.is_function or current_feature.is_attribute then
							eac_registrar.add_access_feature (feature_proxy)
						elseif current_feature.is_procedure then
							eac_registrar.add_basic_operation (feature_proxy)
						else
							eac_registrar.add_special_feature (feature_proxy)
						end
					end
				end
				features.forth
			end
		ensure
			-- registered: type is in EAC
		end

	generate is
			-- Generate metadata for all assemblies in `assembly_descriptors'.
		local
			full_name: STRING
			assembly_descriptor: ASSEMBLY_DESCRIPTOR_PROXY
			assembly_name: ARRAY [STRING]
			xml_generator: XML_CODE_GENERATOR_PROXY
			classes: LIST [EIFFEL_CLASS_PROXY]
		do
			from
				assembly_descriptors.start
				create xml_generator.make
				xml_generator.make_xml_code_generator
			until
				assembly_descriptors.after
			loop
				full_name := assembly_descriptors.key_for_iteration
				check
					valid_fullname: assembly_names.has (full_name)
				end
				create assembly_descriptor.make
				assembly_name := assembly_names.item (full_name)
				assembly_descriptor.make1 (assembly_name.item (1), assembly_name.item (2), assembly_name.item (3), assembly_name.item (4))
				classes := assembly_descriptors.item_for_iteration
				from
					classes.start
				until
					classes.after
				loop
					classes.item.set_assembly_descriptor (assembly_descriptor)
					xml_generator.replace_type (classes.item)
					classes.forth
				end
				assembly_descriptors.forth
			end
		end

feature {NONE} -- Implementation

	rename_clauses (renaming: EIFFEL_LIST [RENAME_AS]): LIST [RENAME_CLAUSE_PROXY] is
			-- Rename clauses for EAC registration
		require
			renaming_not_void: renaming /= Void
		local
			rename_clause: RENAME_CLAUSE_PROXY
			a_string, another_string: STRING
		do
			from
				renaming.start
				create {LINKED_LIST [RENAME_CLAUSE_PROXY]} Result.make
			until
				renaming.after
			loop
				create rename_clause.make
				a_string := renaming.item.old_name.internal_name
				another_string := renaming.item.new_name.internal_name
				rename_clause.set_source_name (a_string)
				rename_clause.set_target_name (another_string)
				Result.extend (rename_clause)
				renaming.forth
			end
		ensure
			rename_clauses_not_void: Result /= Void
		end
			
	undefine_clauses (undefining: EIFFEL_LIST [FEATURE_NAME]): LIST [UNDEFINE_CLAUSE_PROXY] is
			-- Undefine clauses for EAC registration
		require
			undefining_not_void: undefining /= Void
		local
			undefine_clause: UNDEFINE_CLAUSE_PROXY
			a_string: STRING
		do
			from
				undefining.start
				create {LINKED_LIST [UNDEFINE_CLAUSE_PROXY]} Result.make
			until
				undefining.after
			loop
				create undefine_clause.make
				a_string := undefining.item.internal_name
				undefine_clause.set_source_name (a_string)
				Result.extend (undefine_clause)
				undefining.forth
			end
		ensure
			undefine_clauses_not_void: Result /= Void
		end

	redefine_clauses (redefining: EIFFEL_LIST [FEATURE_NAME]): LIST [REDEFINE_CLAUSE_PROXY] is
			-- Redefine clauses for EAC registration
		require
			redefining_not_void: redefining /= Void
		local
			redefine_clause: REDEFINE_CLAUSE_PROXY
			a_string: STRING
		do
			from
				redefining.start
				create {LINKED_LIST [REDEFINE_CLAUSE_PROXY]} Result.make
			until
				redefining.after
			loop
				create redefine_clause.make
				a_string := redefining.item.internal_name
				redefine_clause.set_source_name (a_string)
				Result.extend (redefine_clause)
				redefining.forth
			end
		ensure
			redefine_clauses_not_void: Result /= Void
		end

	select_clauses (selecting: EIFFEL_LIST [FEATURE_NAME]): LIST [SELECT_CLAUSE_PROXY] is
			-- Select clauses for EAC registration
		require
			selecting_not_void: selecting /= Void
		local
			select_clause: SELECT_CLAUSE_PROXY
			a_string: STRING
		do
			from
				selecting.start
				create {LINKED_LIST [SELECT_CLAUSE_PROXY]} Result.make
			until
				selecting.after
			loop
				create select_clause.make
				a_string := selecting.item.internal_name
				select_clause.set_source_name (a_string)
				Result.extend (select_clause)
				selecting.forth
			end
		ensure
			select_clauses_not_void: Result /= Void
		end

	export_clauses (exports: EIFFEL_LIST [EXPORT_ITEM_AS]): LIST [EXPORT_CLAUSE_PROXY] is
			-- Export clauses for EAC registration
		require
			exports_not_void: exports /= Void
		local
			features: FEATURE_LIST_AS
			export_list: EIFFEL_LIST [EXPORT_ITEM_AS]
			feature_names: EIFFEL_LIST [FEATURE_NAME]
			export_clause: EXPORT_CLAUSE_PROXY
			clients: EIFFEL_LIST [ID_AS]
			a_string: STRING
		do
			from
				export_list.start
				create {LINKED_LIST [EXPORT_CLAUSE_PROXY]} Result.make
			until
				export_list.after
			loop
				create export_clause.make
				export_clause.make1
				from
					clients := export_list.item.clients.clients
					clients.start
				until
					clients.after
				loop
					a_string := clients.item
					export_clause.add_exportation (a_string)
					clients.forth
				end
				features ?= export_list.item.features
				if features /= Void then
					feature_names := features.features
					from
						feature_names.start
					until
						feature_names.after
					loop
						a_string := feature_names.item.internal_name
						export_clause.add_feature_name (a_string)
						feature_names.forth
					end
				else
					export_clause.set_all
				end
				Result.extend (export_clause)
				export_list.forth
			end
		ensure
			export_clauses_not_void: Result /= Void
		end

	assembly_descriptors: HASH_TABLE [LINKED_LIST [EIFFEL_CLASS_PROXY], STRING]
			-- Assemblies whose metadata need updating (dependencies)

	assembly_names: HASH_TABLE [ARRAY [STRING], STRING]
			-- Assemblies names

	Comma: CHARACTER is ','
			-- Comma

	Equal_symbol: CHARACTER is '='
			-- Equal symbol
	
invariant
	descriptors_not_void: assembly_descriptors /= Void
	one_name_per_descriptor: assembly_descriptors.count = assembly_names.count -- and each key is identical

end -- class EAC_META_DATA_GENERATOR
	
