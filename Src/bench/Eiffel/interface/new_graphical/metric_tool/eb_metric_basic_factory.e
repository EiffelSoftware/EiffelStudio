indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_BASIC_FACTORY

inherit
	EB_CONSTANTS

	EB_METRIC_SCOPE_INFO

create
	default_create

feature -- Basic metrics creation

	list_of_basic_metrics (tl: EB_METRIC_TOOL): LINKED_LIST [EB_METRIC_BASIC] is
			-- List of all basic metrics available by default for users.
			-- Clssify basic metrics into raw and derived.
		require
			tool_not_void: tl /= Void
		local
			classes, deferred_class, effective_class, invariant_equipped, obsolete_class,
			clusters, compilations,
 			dependents, clients, indirect_clients, heirs, indirect_heirs, parents, indirect_parents,
			suppliers, indirect_suppliers, self,
			all_features, all_attributes, all_commands, all_deferred_feature, all_effective_feature,
			all_exported, all_functions, all_precondition_equipped, all_postcondition_equipped,
			all_queries, all_routines,
			imm_features, imm_attributes, imm_commands, imm_deferred_feature, imm_effective_feature,
			imm_exported, imm_functions, imm_precondition_equipped, imm_postcondition_equipped,
			imm_queries, imm_routines, inherited,
			all_feature_assertions, all_precondition_clauses, all_postcondition_clauses,
			imm_feature_assertions, imm_precondition_clauses, imm_postcondition_clauses,
			formal_generics, formal_generics_constrained, all_formal_arguments, imm_formal_arguments, 
--			comment_lines,
			all_invariant_clauses, imm_invariant_clauses, lines, all_locals, imm_locals: EB_METRIC_BASIC
			functionality: EB_METRIC_BASIC_FUNCTIONALITIES
		do
				-- `functionality' is created just to call features of EB_METRIC_BASIC_FUNCTIONALITIES.
			create functionality

			create Result.make

			create classes.make (interface_names.metric_classes, interface_names.metric_class_unit, tl, Cluster_scope,
				<< [Cluster_scope, functionality~number_of_classes_in_cluster],
				   [System_scope, functionality~number_of_classes_in_system] >>)
			Result.extend (classes)
				create deferred_class.make (interface_names.metric_deferred_class, interface_names.metric_class_unit, tl, Cluster_scope,
					<< [Cluster_scope, functionality~number_of_deferred_classes_in_cluster],
					   [System_scope, functionality~number_of_deferred_classes_in_system] >>)
				Result.extend (deferred_class)
				create effective_class.make (interface_names.metric_effective_class, interface_names.metric_class_unit, tl, Cluster_scope,
					<< [Cluster_scope, functionality~number_of_effective_classes_in_cluster],
					   [System_scope, functionality~number_of_effective_classes_in_system] >>)
				Result.extend (effective_class)
				create invariant_equipped.make (interface_names.metric_invariant_equipped, interface_names.metric_contract_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_invariant_equipped_in_class] >>)
				Result.extend (invariant_equipped)
				create obsolete_class.make (interface_names.metric_obsolete, interface_names.metric_class_unit, tl, Cluster_scope,
					<< [Cluster_scope, functionality~number_of_obsolete_classes_in_cluster],
					   [System_scope, functionality~number_of_obsolete_classes_in_system] >>)
				Result.extend (obsolete_class)


			create clusters.make (interface_names.metric_clusters, interface_names.metric_cluster_unit, tl, Cluster_scope,
				<< [Cluster_scope, functionality~number_of_clusters_in_cluster],
				   [System_scope, functionality~number_of_clusters_in_system] >>)
			Result.extend (clusters)


			create compilations.make (interface_names.metric_compilations, interface_names.metric_compilation_unit, tl, System_scope,
				<< [System_scope, functionality~number_of_compilations] >>)
			Result.extend (compilations)


			create dependents.make (interface_names.metric_dependents, interface_names.metric_class_unit, tl, Class_scope,
				<< [Class_scope, functionality~number_of_dependents_of_class] >>)
			Result.extend (dependents)
				create clients.make (interface_names.metric_clients, interface_names.metric_class_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_clients_of_class] >>)
				Result.extend (clients)
				create indirect_clients.make (interface_names.metric_indirect_clients, interface_names.metric_class_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_indirect_clients_of_class] >>)
				Result.extend (indirect_clients)
				create heirs.make (interface_names.metric_heirs, interface_names.metric_class_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_heirs_of_class] >>)
				Result.extend (heirs)
				create indirect_heirs.make (interface_names.metric_indirect_heirs, interface_names.metric_class_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_indirect_heirs_of_class] >>)
				Result.extend (indirect_heirs)
				create parents.make (interface_names.metric_parents, interface_names.metric_class_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_parents_of_class] >>)
				Result.extend (parents)
				create indirect_parents.make (interface_names.metric_indirect_parents, interface_names.metric_class_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_indirect_parents_of_class] >>)
				Result.extend (indirect_parents)
				create suppliers.make (interface_names.metric_suppliers, interface_names.metric_class_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_suppliers_of_class] >>)
				Result.extend (suppliers)
				create indirect_suppliers.make (interface_names.metric_indirect_suppliers, interface_names.metric_class_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_indirect_suppliers_of_class] >>)
				Result.extend (indirect_suppliers)
				create self.make (interface_names.metric_self, interface_names.metric_class_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_self_of_class] >>)
				Result.extend (self)


			create all_features.make (interface_names.metric_all_features, interface_names.metric_feature_unit, tl, Class_scope,
				<< [Class_scope, functionality~number_of_all_features] >>)
			Result.extend (all_features)
				create all_attributes.make (interface_names.metric_all_attributes, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_all_attributes] >>)
				Result.extend (all_attributes)
				create all_commands.make (interface_names.metric_all_commands, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_all_commands] >>)
				Result.extend (all_commands)
				create all_deferred_feature.make (interface_names.metric_all_deferred_feature, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_all_deferred_features] >>)
				Result.extend (all_deferred_feature)
				create all_effective_feature.make (interface_names.metric_all_effective_feature, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_all_effective_features] >>)
				Result.extend (all_effective_feature)
				create all_exported.make (interface_names.metric_all_exported, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_all_exported_features] >>)
				Result.extend (all_exported)
				create all_functions.make (interface_names.metric_all_functions, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_all_functions] >>)
				Result.extend (all_functions)
				create all_postcondition_equipped.make (interface_names.metric_all_postcondition_equipped, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_all_postcondition_equipped_in_class] >>)
				Result.extend (all_postcondition_equipped)
				create all_precondition_equipped.make (interface_names.metric_all_precondition_equipped, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_all_precondition_equipped_in_class] >>)
				Result.extend (all_precondition_equipped)
				create all_queries.make (interface_names.metric_all_queries, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_all_queries] >>)
				Result.extend (all_queries)
				create all_routines.make (interface_names.metric_all_routines, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_all_routines] >>)
				Result.extend (all_routines)
				create inherited.make (interface_names.metric_inherited, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_inherited_features] >>)
				Result.extend (inherited)

			create imm_features.make (interface_names.metric_imm_features, interface_names.metric_feature_unit, tl, Class_scope,
				<< [Class_scope, functionality~number_of_imm_features] >>)
			Result.extend (imm_features)
				create imm_attributes.make (interface_names.metric_imm_attributes, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_attributes] >>)
				Result.extend (imm_attributes)
				create imm_commands.make (interface_names.metric_imm_commands, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_commands] >>)
				Result.extend (imm_commands)
				create imm_deferred_feature.make (interface_names.metric_imm_deferred_feature, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_deferred_features] >>)
				Result.extend (imm_deferred_feature)
				create imm_effective_feature.make (interface_names.metric_imm_effective_feature, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_effective_features] >>)
				Result.extend (imm_effective_feature)
				create imm_exported.make (interface_names.metric_imm_exported, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_exported_features] >>)
				Result.extend (imm_exported)
				create imm_functions.make (interface_names.metric_imm_functions, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_functions] >>)
				Result.extend (imm_functions)
				create imm_postcondition_equipped.make (interface_names.metric_imm_postcondition_equipped, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_postcondition_equipped_in_class] >>)
				Result.extend (imm_postcondition_equipped)
				create imm_precondition_equipped.make (interface_names.metric_imm_precondition_equipped, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_precondition_equipped_in_class] >>)
				Result.extend (imm_precondition_equipped)
				create imm_queries.make (interface_names.metric_imm_queries, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_queries] >>)
				Result.extend (imm_queries)
				create imm_routines.make (interface_names.metric_imm_routines, interface_names.metric_feature_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_routines] >>)
				Result.extend (imm_routines)

			create all_feature_assertions.make (interface_names.metric_all_feature_assertions, interface_names.metric_contract_clause_unit, tl, Feature_scope,
				<< [Feature_scope, functionality~number_of_feature_assertions_in_feature],
					[Class_scope, all_feature_assertions~default_class_value_inherited] >>)
			Result.extend (all_feature_assertions)
				create all_postcondition_clauses.make (interface_names.metric_all_postcondition_clauses, interface_names.metric_contract_clause_unit, tl, Feature_scope,
					<< [Feature_scope, functionality~number_of_postcondition_clauses_in_feature],
						[Class_scope, all_postcondition_clauses~default_class_value_inherited] >>)
				Result.extend (all_postcondition_clauses)
				create all_precondition_clauses.make (interface_names.metric_all_precondition_clauses, interface_names.metric_contract_clause_unit, tl, Feature_scope,
					<< [Feature_scope, functionality~number_of_precondition_clauses_in_feature],
						[Class_scope, all_precondition_clauses~default_class_value_inherited] >>)
				Result.extend (all_precondition_clauses)

			create imm_feature_assertions.make (interface_names.metric_imm_feature_assertions, interface_names.metric_contract_clause_unit, tl, Feature_scope,
				<< [Feature_scope, functionality~number_of_feature_assertions_in_feature] >>)
			Result.extend (imm_feature_assertions)
				create imm_postcondition_clauses.make (interface_names.metric_imm_postcondition_clauses, interface_names.metric_contract_clause_unit, tl, Feature_scope,
					<< [Feature_scope, functionality~number_of_postcondition_clauses_in_feature] >>)
				Result.extend (imm_postcondition_clauses)
				create imm_precondition_clauses.make (interface_names.metric_imm_precondition_clauses, interface_names.metric_contract_clause_unit, tl, Feature_scope,
					<< [Feature_scope, functionality~number_of_precondition_clauses_in_feature] >>)
				Result.extend (imm_precondition_clauses)

			create formal_generics.make (interface_names.metric_formal_generics, interface_names.metric_class_unit, tl, Class_scope,
				<< [Class_scope, functionality~number_of_formal_generics] >>)
			Result.extend (formal_generics)
				create formal_generics_constrained.make (interface_names.metric_formal_generics_constrained, interface_names.metric_class_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_formal_generics_constrained] >>)
				Result.extend (formal_generics_constrained)

			create all_formal_arguments.make (interface_names.metric_formals, interface_names.metric_local_unit, tl, Feature_scope,
				<< [Feature_scope, functionality~number_of_formal_arguments],
					[Class_scope, all_formal_arguments~default_class_value_inherited] >>)
			Result.extend (all_formal_arguments)
				create imm_formal_arguments.make (interface_names.metric_imm_formals, interface_names.metric_local_unit, tl, Feature_scope,
					<< [Feature_scope, functionality~number_of_formal_arguments] >>)
				Result.extend (imm_formal_arguments)

			create all_invariant_clauses.make (interface_names.metric_invariant_clauses, interface_names.metric_contract_clause_unit, tl, Class_scope,
				<< [Class_scope, functionality~number_of_all_invariant_clauses] >>)
			Result.extend (all_invariant_clauses)
				create imm_invariant_clauses.make (interface_names.metric_imm_invariant_clauses, interface_names.metric_contract_clause_unit, tl, Class_scope,
					<< [Class_scope, functionality~number_of_imm_invariant_clauses] >>)
				Result.extend (imm_invariant_clauses)

			create lines.make (interface_names.metric_lines, interface_names.metric_line_unit, tl, Feature_scope,
				<< [Feature_scope, functionality~number_of_lines_in_feature],
				   [Class_scope, functionality~number_of_lines_in_class] >>)
			Result.extend (lines)

			create all_locals.make (interface_names.metric_locals, interface_names.metric_local_unit, tl, Feature_scope,
				<< [Feature_scope, functionality~number_of_locals],
					[Class_scope, functionality~number_of_all_locals_in_class] >>)
			Result.extend (all_locals)
				create imm_locals.make (interface_names.metric_imm_locals, interface_names.metric_local_unit, tl, Feature_scope,
					<< [Feature_scope, functionality~number_of_locals] >>)
				Result.extend (imm_locals)

--			create comment_lines.make (interface_names.metric_comment_lines, interface_names.metric_line_unit, tl, Class_scope,
--				<< [Feature_scope, functionality~number_of_comment_lines_in_feature],
--				   [Class_scope, functionality~number_of_comment_lines_in_class] >>)
--			Result.extend (comment_lines)


			create raw_metric_list.make
			raw_metric_list.extend (classes)
			raw_metric_list.extend (clusters)
			raw_metric_list.extend (compilations)
			raw_metric_list.extend (dependents)
			raw_metric_list.extend (all_features)
			raw_metric_list.extend (imm_features)
			raw_metric_list.extend (all_feature_assertions)
			raw_metric_list.extend (imm_feature_assertions)
			raw_metric_list.extend (formal_generics)
			raw_metric_list.extend (all_formal_arguments)
			raw_metric_list.extend (all_invariant_clauses)
			raw_metric_list.extend (lines)
			raw_metric_list.extend (all_locals)

			create derived_metric_list.make
			derived_metric_list.extend (deferred_class)
			derived_metric_list.extend (effective_class)
			derived_metric_list.extend (invariant_equipped)
			derived_metric_list.extend (obsolete_class)
			derived_metric_list.extend (dependents)
			derived_metric_list.extend (clients)
			derived_metric_list.extend (indirect_clients)
			derived_metric_list.extend (heirs)
			derived_metric_list.extend (indirect_heirs)
			derived_metric_list.extend (parents)
			derived_metric_list.extend (indirect_parents)
			derived_metric_list.extend (suppliers)
			derived_metric_list.extend (indirect_suppliers)
			derived_metric_list.extend (self)
			derived_metric_list.extend (all_attributes)
			derived_metric_list.extend (all_commands)
			derived_metric_list.extend (all_deferred_feature)
			derived_metric_list.extend (all_effective_feature)
			derived_metric_list.extend (all_exported)
			derived_metric_list.extend (all_functions)
			derived_metric_list.extend (all_postcondition_equipped)
			derived_metric_list.extend (all_precondition_equipped)
			derived_metric_list.extend (all_queries)
			derived_metric_list.extend (all_routines)
			derived_metric_list.extend (inherited)
			derived_metric_list.extend (imm_attributes)
			derived_metric_list.extend (imm_commands)
			derived_metric_list.extend (imm_deferred_feature)
			derived_metric_list.extend (imm_effective_feature)
			derived_metric_list.extend (imm_exported)
			derived_metric_list.extend (imm_functions)
			derived_metric_list.extend (imm_postcondition_equipped)
			derived_metric_list.extend (imm_precondition_equipped)
			derived_metric_list.extend (imm_queries)
			derived_metric_list.extend (imm_routines)
			derived_metric_list.extend (all_postcondition_clauses)
			derived_metric_list.extend (all_precondition_clauses)
			derived_metric_list.extend (imm_postcondition_clauses)
			derived_metric_list.extend (imm_precondition_clauses)
			derived_metric_list.extend (formal_generics_constrained)
			derived_metric_list.extend (imm_invariant_clauses)
			derived_metric_list.extend (imm_formal_arguments)
			derived_metric_list.extend (imm_locals)
		end

	metric_menu: EV_MENU is
			-- Fill the metric menu that displays all available metrics with the basic ones.
			-- Derived metrics appear in a sub menu of their raw parent metric.
		local
			classes_menu, dependents_menu, all_features_menu, imm_features_menu,
			all_feature_assertions_menu, imm_feature_assertions_menu,
			formal_generics_menu, invariant_clauses_menu, formal_arguments_menu, local_menu: EV_MENU
			menu_item: EV_MENU_ITEM
		do
			create Result
--			Result.set_minimum_width (140)

			create classes_menu.make_with_text (interface_names.metric_classes)
				create menu_item.make_with_text (interface_names.metric_all)
				classes_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_deferred_class)
				classes_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_effective_class)
				classes_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_invariant_equipped)
				classes_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_obsolete)
				classes_menu.extend (menu_item)
			Result.extend (classes_menu)

			create menu_item.make_with_text (interface_names.metric_clusters)
			Result.extend (menu_item)
			create menu_item.make_with_text (interface_names.metric_compilations)
			Result.extend (menu_item)

			create dependents_menu.make_with_text (interface_names.metric_dependents)
				create menu_item.make_with_text (interface_names.metric_all)
				dependents_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_clients)
				dependents_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_indirect_clients)
				dependents_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_heirs)
				dependents_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_indirect_heirs)
				dependents_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_parents)
				dependents_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_indirect_parents)
				dependents_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_suppliers)
				dependents_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_indirect_suppliers)
				dependents_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_self)
				dependents_menu.extend (menu_item)
			Result.extend (dependents_menu)

			create all_features_menu.make_with_text (interface_names.metric_all_features)
				create menu_item.make_with_text (interface_names.metric_all)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_attributes)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_commands)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_deferred_feature)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_effective_feature)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_exported)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_functions)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_postcondition_equipped)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_precondition_equipped)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_queries)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_routines)
				all_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_inherited)
				all_features_menu.extend (menu_item)
			Result.extend (all_features_menu)

			create imm_features_menu.make_with_text (interface_names.metric_imm_features)
				create menu_item.make_with_text (interface_names.metric_all)
				imm_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_attributes)
				imm_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_commands)
				imm_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_deferred_feature)
				imm_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_effective_feature)
				imm_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_exported)
				imm_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_functions)
				imm_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_postcondition_equipped)
				imm_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_precondition_equipped)
				imm_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_queries)
				imm_features_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_routines)
				imm_features_menu.extend (menu_item)
			Result.extend (imm_features_menu)

			create all_feature_assertions_menu.make_with_text (interface_names.metric_all_feature_assertions)
				create menu_item.make_with_text (interface_names.metric_all)
				all_feature_assertions_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_postcondition_clauses)
				all_feature_assertions_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_all_precondition_clauses)
				all_feature_assertions_menu.extend (menu_item)
			Result.extend (all_feature_assertions_menu)

			create imm_feature_assertions_menu.make_with_text (interface_names.metric_imm_feature_assertions)
				create menu_item.make_with_text (interface_names.metric_all)
				imm_feature_assertions_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_postcondition_clauses)
				imm_feature_assertions_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_precondition_clauses)
				imm_feature_assertions_menu.extend (menu_item)
			Result.extend (imm_feature_assertions_menu)

			create formal_generics_menu.make_with_text (interface_names.metric_formal_generics)
				create menu_item.make_with_text (interface_names.metric_all)
				formal_generics_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_formal_generics_constrained)
				formal_generics_menu.extend (menu_item)
			Result.extend (formal_generics_menu)

			create formal_arguments_menu.make_with_text (interface_names.metric_formals)
				create menu_item.make_with_text (interface_names.metric_all)
				formal_arguments_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_formals)
				formal_arguments_menu.extend (menu_item)
			Result.extend (formal_arguments_menu)

			create invariant_clauses_menu.make_with_text (interface_names.metric_invariant_clauses)
				create menu_item.make_with_text (interface_names.metric_all)
				invariant_clauses_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_invariant_clauses)
				invariant_clauses_menu.extend (menu_item)
			Result.extend (invariant_clauses_menu)
				
			create menu_item.make_with_text (interface_names.metric_lines)
			Result.extend (menu_item)

			create local_menu.make_with_text (interface_names.metric_locals)
				create menu_item.make_with_text (interface_names.metric_all)
				local_menu.extend (menu_item)
				create menu_item.make_with_text (interface_names.metric_imm_locals)
				local_menu.extend (menu_item)
			Result.extend (local_menu)

			Result.extend (create {EV_MENU_SEPARATOR})
		end

	raw_metric_list: LINKED_LIST [EB_METRIC]
		-- List of all raw metrics.

	derived_metric_list: LINKED_LIST [EB_METRIC]
		-- List of all derived metrics.

end -- class EB_METRIC_BASIC_FACTORY
