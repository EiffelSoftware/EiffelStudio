indexing
	description: "Implementation of each basic metric's functionality."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_BASIC_FUNCTIONALITIES
	
inherit
	EB_METRIC_SCOPE_INFO
	
create
	default_create

feature -- Classes: 1

	list_of_classes_in_cluster (s: EB_METRIC_SCOPE): LINKED_LIST [CLASS_C] is
			-- Return list of classes included in cluster and recursicely in sub-clusters of `s.cluster_i'.
		require
			scope_not_void: s /= Void
			scope_is_cluster: s.index = Cluster_scope
			cluster_set: s.cluster_i /= Void
		local
			a_cluster: CLUSTER_I
			sub_clusters: ARRAYED_LIST [CLUSTER_I]
			classes: HASH_TABLE [CLASS_I, STRING]
			scope: EB_METRIC_SCOPE
		do
			create Result.make
				-- Do not work directly on `s' since other metrics rely on it, otherwise, further 
				-- calculations will be done on a wrong scope (`s' changes during recursive features).
			scope := clone (s)
			a_cluster := scope.cluster_i
			sub_clusters := a_cluster.sub_clusters
			if sub_clusters.count /= 0 then
				from
					sub_clusters.start
				until
					sub_clusters.exhausted
				loop
					scope.set_cluster_i (sub_clusters.item)
					Result.append (list_of_classes_in_cluster (scope))
					sub_clusters.forth
				end
			end

			classes := a_cluster.classes
			from
				classes.start
			until
				classes.after
			loop
				if classes.item_for_iteration /= Void and then classes.item_for_iteration.compiled_class /= Void then
					Result.extend (classes.item_for_iteration.compiled_class)
				end
				classes.forth
			end
		end

	list_of_classes_in_system (s: EB_METRIC_SCOPE): LINKED_LIST [CLASS_C] is
			-- Return list of classes included in system `s.system_i'.
		require
			scope_not_void: s /= Void
			scope_is_system: s.index = System_scope
			system_set: s.system_i /= Void
		local
			i: INTEGER
			array_classes: ARRAY [CLASS_C]
		do
			create Result.make
			array_classes:= s.system_i.classes.sorted_classes
			from
				i := 1
			until
				i > array_classes.count
			loop
				if array_classes.item (i) /= Void then 
					Result.extend (array_classes.item (i))
				end
				i := i + 1
			end
		end

	number_of_classes_in_cluster (s: EB_METRIC_SCOPE): DOUBLE is
			-- Count number of classes in cluster `s.cluster_i'.
		require
			scope_not_void: s /= Void
			scope_is_cluster: s.index = Cluster_scope
			cluster_set: s.cluster_i /= Void
		do
			Result := list_of_classes_in_cluster (s).count
		end

	number_of_classes_in_system (s: EB_METRIC_SCOPE): DOUBLE is
			-- Count number of classes in system `s.system_i'.
		require
			scope_not_void: s /= Void
			scope_is_system: s.index = System_scope
			system_set: s.system_i /= Void
		do
			Result := list_of_classes_in_system (s).count
		end

	number_of_deferred_classes_in_cluster (s: EB_METRIC_SCOPE): DOUBLE is
			-- Count number of deferred classes in cluster `s.cluster_i'.
		require
			scope_not_void: s /= Void
			scope_is_cluster: s.index = Cluster_scope
			cluster_set: s.cluster_i /= Void
		local
			class_list: LINKED_LIST [CLASS_C]
		do
			class_list := list_of_classes_in_cluster (s)
			from
				class_list.start
			until
				class_list.after
			loop
				if class_list.item.is_deferred then
					Result := Result + 1
				end
				class_list.forth
			end
		end

	number_of_deferred_classes_in_system (s: EB_METRIC_SCOPE): DOUBLE is
			-- Count number of deferred classes in system `s.system_i'.
		require
			scope_not_void: s /= Void
			scope_is_system: s.index = System_scope
			system_set: s.system_i /= Void
		local
			class_list: LINKED_LIST [CLASS_C]
		do
			class_list := list_of_classes_in_system (s)
			from
				class_list.start
			until
				class_list.after
			loop
				if class_list.item.is_deferred then
					Result := Result + 1
				end
				class_list.forth
			end
		end

	 number_of_effective_classes_in_cluster (s: EB_METRIC_SCOPE): DOUBLE is
			-- Count number of effective classes in cluster `s.cluster_i'.
		require
			scope_not_void: s /= Void
			scope_is_cluster: s.index = Cluster_scope
			cluster_set: s.cluster_i /= Void
		do
			Result := number_of_classes_in_cluster (s) - number_of_deferred_classes_in_cluster (s)
		end

	 number_of_effective_classes_in_system (s: EB_METRIC_SCOPE): DOUBLE is
			-- Count number of classes in system `s.system_i'.
		require
			scope_not_void: s /= Void
			scope_is_system: s.index = System_scope
			system_set: s.system_i /= Void
		do
			Result := number_of_classes_in_system (s) - number_of_deferred_classes_in_system (s)
		end

	 number_of_invariant_equipped_in_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Return 1 when `s.class_c' is invariant equipped, 0 else.
	 	require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			if s.class_c.has_invariant then
				Result := 1
			end
		end

	number_of_obsolete_classes_in_cluster (s: EB_METRIC_SCOPE): DOUBLE is
			-- Count number of obsolete classes in cluster `s.cluster_i'.
		require
			scope_not_void: s /= Void
			scope_is_cluster: s.index = Cluster_scope
			cluster_set: s.cluster_i /= Void
		local
			class_list: LINKED_LIST [CLASS_C]
		do
			class_list := list_of_classes_in_cluster (s)
			from
				class_list.start
			until
				class_list.after
			loop
				if class_list.item.is_obsolete then
					Result := Result + 1
				end
				class_list.forth
			end
		end

	number_of_obsolete_classes_in_system (s: EB_METRIC_SCOPE): DOUBLE is
			-- Count number of classes in system `s.system'
		require
			scope_not_void: s /= Void
			scope_is_system: s.index = System_scope
			system_set: s.system_i /= Void
		local
			class_list: LINKED_LIST [CLASS_C]
		do
			class_list := list_of_classes_in_system (s)
			from
				class_list.start
			until
				class_list.after
			loop
				if class_list.item.is_obsolete then
					Result := Result + 1
				end
				class_list.forth
			end
		end

feature -- Clusters: 2

	number_of_clusters_in_cluster (s: EB_METRIC_SCOPE): DOUBLE is
			-- Count recursively number of clusters included in cluster `s.cluster_i'.
		require
			scope_not_void: s /= Void
			scope_is_cluster: s.index = Cluster_scope
			cluster_set: s.cluster_i /= Void
		local
			sub_clusters: ARRAYED_LIST [CLUSTER_I]
			scope: EB_METRIC_SCOPE
		do
				-- Do not work directly on `s' since other metrics rely on it, otherwise, further 
				-- calculations will be done on a wrong scope (`s' changes during recursive features).
			scope := clone (s)
			sub_clusters := scope.cluster_i.sub_clusters
			Result := Result + sub_clusters.count
			if sub_clusters.count /= 0 then
				from
					sub_clusters.start
				until
					sub_clusters.exhausted
				loop
					scope.set_cluster_i (sub_clusters.item)
					Result := Result + number_of_clusters_in_cluster (scope)
					sub_clusters.forth
				end
			end
		end

	number_of_clusters_in_system (s: EB_METRIC_SCOPE): DOUBLE is
			-- Count number of clusters in system `s.system_i'.
		require
			scope_not_void: s /= Void
			scope_is_system: s.index = System_scope
			system_set: s.system_i /= Void
		do	
			Result := s.system_i.universe.clusters.count
		end

feature -- Compilations: 3

	 number_of_compilations (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count number of compilations in `s.system_i'.
		require
			scope_not_void: s /= Void
			scope_is_system: s.index = System_scope
			system_set: s.system_i /= Void
		do
			Result := s.system_i.workbench.compilation_counter - 1
		end

feature -- Dependents: 4

	 number_of_dependents_of_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count number of all dependents of `s.class_c' that is clients, heirs, suppliers and parents.
	 		-- Both indirect and indirect dependents are counted.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			dependents_table: HASH_TABLE [STRING, CLASS_C]
		do
			create dependents_table.make (100)
			fill_indirect_clients_table (dependents_table, s.class_c)
			fill_indirect_heirs_table (dependents_table, s.class_c)
			fill_indirect_suppliers_table (dependents_table, s.class_c)
			fill_indirect_parents_table (dependents_table, s.class_c)
			Result := dependents_table.count
		end

	 number_of_clients_of_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count number of direct clients of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			Result := s.class_c.clients.count
		end

	 number_of_indirect_clients_of_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count number of indirect clients of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			indirect_clients_table: HASH_TABLE [STRING, CLASS_C]
		do
			create indirect_clients_table.make (100)
			fill_indirect_clients_table (indirect_clients_table, s.class_c)
			Result := indirect_clients_table.count
		end

	 fill_indirect_clients_table (indirect_clients_table: HASH_TABLE [STRING, CLASS_C]; a_class: CLASS_C) is
	 		-- Fill `indirect_clients_table' with clients of `a_class', and recursively clients
	 		-- of each client.
	 	require
	 		clients_table_not_void: indirect_clients_table /= Void
	 		class_not_void: a_class /= Void
		local
			clients_list: LINKED_LIST [CLASS_C]
			cursor: CURSOR
		do
			clients_list := a_class.clients
			from
				clients_list.start
			until
				clients_list.after
			loop
				indirect_clients_table.put (clients_list.item.name, clients_list.item)
				if not indirect_clients_table.conflict then
					cursor := clients_list.cursor
					fill_indirect_clients_table (indirect_clients_table, clients_list.item)
					clients_list.go_to (cursor)
				end
				clients_list.forth
			end
		end

	 number_of_heirs_of_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count number of direct heirs of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			Result := s.class_c.descendants.count
		end

	 number_of_indirect_heirs_of_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count number of indirect heirs of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			indirect_heirs_table: HASH_TABLE [STRING, CLASS_C]
		do
			create indirect_heirs_table.make (100)
			fill_indirect_heirs_table (indirect_heirs_table, s.class_c)
			Result := indirect_heirs_table.count
		end

	 fill_indirect_heirs_table (indirect_heirs_table: HASH_TABLE [STRING, CLASS_C]; a_class: CLASS_C) is
	 		-- Fill `indirect_heirs_table' with heirs of `a_class', and recursively heirs
	 		-- of each heir.
	 	require
	 		heirs_table_not_void: indirect_heirs_table /= Void
	 		class_not_void: a_class /= Void
		local
			heirs_list: LINKED_LIST [CLASS_C]
		do
			heirs_list := a_class.descendants
			from
				heirs_list.start
			until
				heirs_list.after
			loop
				indirect_heirs_table.put (heirs_list.item.name, heirs_list.item)
				fill_indirect_heirs_table (indirect_heirs_table, heirs_list.item)
				heirs_list.forth
			end
		end

	 number_of_parents_of_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count number of direct parents of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			Result := s.class_c.parents.count
		end

	 number_of_indirect_parents_of_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count number of indirect parents of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			indirect_parents_table: HASH_TABLE [STRING, CLASS_C]
		do
			create indirect_parents_table.make (100)
			fill_indirect_parents_table (indirect_parents_table, s.class_c)
			Result := indirect_parents_table.count
		end

	fill_indirect_parents_table (indirect_parents_table: HASH_TABLE [STRING, CLASS_C]; a_class: CLASS_C) is
	 		-- Fill `indirect_parents_table' with parents of `a_class', and recursively parents
	 		-- of each parent.
	 	require
	 		parents_table_not_void: indirect_parents_table /= Void
	 		class_not_void: a_class /= Void
		local
			parents_list: FIXED_LIST [CL_TYPE_A]
		do
			parents_list := a_class.parents
			from
				parents_list.start
			until
				parents_list.after
			loop
				indirect_parents_table.put (parents_list.item.associated_class.name, parents_list.item.associated_class)
				fill_indirect_parents_table (indirect_parents_table, parents_list.item.associated_class)
				parents_list.forth
			end
		end

	 number_of_suppliers_of_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count number of direct suppliers of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			Result := s.class_c.suppliers.count
		end

	 number_of_indirect_suppliers_of_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count number of indirect suppliers of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			indirect_suppliers_table: HASH_TABLE [STRING, CLASS_C]
		do
			create indirect_suppliers_table.make (100)
			fill_indirect_suppliers_table (indirect_suppliers_table, s.class_c)
			Result := indirect_suppliers_table.count
		end

	 fill_indirect_suppliers_table (indirect_suppliers_table: HASH_TABLE [STRING, CLASS_C]; a_class: CLASS_C) is
	 		-- Fill `indirect_suppliers_table' with suppliers of `a_class', and recursively suppliers
	 		-- of each supplier.
	 	require
	 		suppliers_table_not_void: indirect_suppliers_table /= Void
	 		class_not_void: a_class /= Void
		local
			suppliers_list: SUPPLIER_LIST
			cursor: CURSOR
		do
			suppliers_list := a_class.suppliers
			from
				suppliers_list.start
			until
				suppliers_list.after
			loop
				indirect_suppliers_table.put (suppliers_list.item.supplier.name, suppliers_list.item.supplier)
				if not indirect_suppliers_table.conflict then
					cursor := suppliers_list.cursor
					fill_indirect_suppliers_table (indirect_suppliers_table, suppliers_list.item.supplier)
					suppliers_list.go_to (cursor)
				end
				suppliers_list.forth
			end
		end

	 number_of_self_of_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Count self for class, that is 1!
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := 1
		end

feature -- 	All features: 5

	 number_of_all_features (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class features of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := s.class_c.feature_table.count
		end

	 number_of_all_attributes (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class attributes of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			table_features: FEATURE_TABLE
		do
			table_features := s.class_c.feature_table
			from
				table_features.start
			until
				table_features.after
			loop
				if table_features.item_for_iteration.e_feature.ast.is_attribute then
					Result := Result + 1
				end
				table_features.forth
			end
		end

	 number_of_all_commands (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class commands of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := number_of_all_features (s) - number_of_all_attributes (s) - number_of_all_functions (s) 
		end

	 number_of_all_deferred_features (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class deferred features of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			table_features: FEATURE_TABLE
		do
			table_features := s.class_c.feature_table
			from
				table_features.start
			until
				table_features.after
			loop
				if not table_features.item_for_iteration.e_feature.ast.is_attribute and then
					table_features.item_for_iteration.e_feature.ast.is_deferred then
					Result := Result + 1
				end
				table_features.forth
			end
		end

	 number_of_all_effective_features (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class effective features of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := number_of_all_features (s) - number_of_all_deferred_features (s)
		end

	 number_of_all_exported_features (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class exported features of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			table_features: FEATURE_TABLE
		do
			table_features := s.class_c.feature_table
			from
				table_features.start
			until
				table_features.after
			loop
				if table_features.item_for_iteration.e_feature.export_status.is_all then
					Result := Result + 1
				end
				table_features.forth
			end
		end

	 number_of_all_functions (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class functions of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			table_features: FEATURE_TABLE
		do
			table_features := s.class_c.feature_table
			from
				table_features.start
			until
				table_features.after
			loop
				if table_features.item_for_iteration.e_feature.ast.is_function then
					Result := Result + 1
				end
				table_features.forth
			end
		end

	 number_of_all_postcondition_equipped_in_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class features having postconditions of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			table_features: FEATURE_TABLE
		do
			table_features := s.class_c.feature_table
			from
				table_features.start
			until
				table_features.after
			loop
				if table_features.item_for_iteration.e_feature.has_postcondition then
					Result := Result + 1
				end
				table_features.forth
			end
		end

	 number_of_all_precondition_equipped_in_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class features having preconditions of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			table_features: FEATURE_TABLE
		do
			table_features := s.class_c.feature_table
			from
				table_features.start
			until
				table_features.after
			loop
				if table_features.item_for_iteration.e_feature.has_precondition then
					Result := Result + 1
				end
				table_features.forth
			end
		end

	 number_of_all_queries (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class queries of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := number_of_all_attributes (s) + number_of_all_functions (s)
		end

	 number_of_all_routines (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of inherited and written in class routines of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := number_of_all_functions (s) + number_of_all_commands (s)
		end

feature -- 	Immediate features: 6

	 number_of_imm_features (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper features of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := s.class_c.written_in_features.count
		end

	 number_of_imm_attributes (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper attributes of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			list_features: LIST [E_FEATURE]
		do
			list_features := s.class_c.written_in_features
			from
				list_features.start
			until
				list_features.after
			loop
				if list_features.item.ast.is_attribute then
					Result := Result + 1
				end
				list_features.forth
			end
		end

	 number_of_imm_commands (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper commands of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := number_of_imm_features (s) - number_of_imm_attributes (s) - number_of_imm_functions (s) 
		end

	 number_of_imm_deferred_features (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper deferred features of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			list_features: LIST [E_FEATURE]
		do
			list_features := s.class_c.written_in_features
			from
				list_features.start
			until
				list_features.after
			loop
				if not list_features.item.ast.is_attribute and then list_features.item.ast.is_deferred then
					Result := Result + 1
				end
				list_features.forth
			end
		end

	 number_of_imm_effective_features (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper effective features of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := number_of_imm_features (s) - number_of_imm_deferred_features (s)
		end

	 number_of_imm_exported_features (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper exported features of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			list_features: LIST [E_FEATURE]
		do
			list_features := s.class_c.written_in_features
			from
				list_features.start
			until
				list_features.after
			loop
				if list_features.item.export_status.is_all then
					Result := Result + 1
				end
				list_features.forth
			end
		end

	 number_of_imm_functions (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper functions of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			list_features: LIST [E_FEATURE]
		do
			list_features := s.class_c.written_in_features
			from
				list_features.start
			until
				list_features.after
			loop
				if list_features.item.ast.is_function then
					Result := Result + 1
				end
				list_features.forth
			end
		end

	 number_of_imm_postcondition_equipped_in_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper features having postconditions of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			list_features: LIST [E_FEATURE]
		do
			list_features := s.class_c.written_in_features
			from
				list_features.start
			until
				list_features.after
			loop
				if list_features.item.has_postcondition then
					Result := Result + 1
				end
				list_features.forth
			end
		end

	 number_of_imm_precondition_equipped_in_class (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper features having preconditions of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			list_features: LIST [E_FEATURE]
		do
			list_features := s.class_c.written_in_features
			from
				list_features.start
			until
				list_features.after
			loop
				if list_features.item.has_precondition then
					Result := Result + 1
				end
				list_features.forth
			end
		end

	 number_of_imm_queries (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper queries of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := number_of_imm_attributes (s) + number_of_imm_functions (s)
		end

	 number_of_imm_routines (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of proper routines of `s.class_c' (that are written in class).
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		do
			Result := number_of_imm_functions (s) + number_of_imm_commands (s)
		end

	 number_of_inherited_features (s: EB_METRIC_SCOPE): DOUBLE is
	 		-- Number of strictly inherited features of `s.class_c'.
	 	require
	 		scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
	 		class_set: s.class_c /= Void
		local
			feature_table: FEATURE_TABLE
			list_features: LIST [E_FEATURE]
		do
			feature_table := s.class_c.feature_table
			list_features := s.class_c.written_in_features
			Result := feature_table.count - list_features.count
		end

feature -- Feature_assertions: 7

	number_of_feature_assertions_in_feature (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of assertions clauses in `s.e_feature'.
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := number_of_postcondition_clauses_in_feature (s) + number_of_precondition_clauses_in_feature (s)
		end

	number_of_postcondition_clauses_in_feature (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of postcondition clauses in `s.e_feature'.
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := s.e_feature.ast.number_of_postcondition_slots
		end

	number_of_precondition_clauses_in_feature (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of precondition clauses in `s.e_feature'.
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := s.e_feature.ast.number_of_precondition_slots
		end

feature -- Formal generics: 8

	number_of_formal_generics (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of formal generics of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			if s.class_c.generics /= Void then
				Result := s.class_c.generics.count
			end
		end

	number_of_formal_generics_constrained (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of constrianed formal generics of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			generics: EIFFEL_LIST [FORMAL_DEC_AS]
		do
			generics := s.class_c.generics
			if generics /= Void then
				from
					generics.start
				until
					generics.after
				loop
					if generics.item.has_constraint then
						Result := Result + 1
					end
					generics.forth
				end
			end
		end

feature -- Formal arguments: 9

	number_of_formal_arguments (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of formal arguments of `s.e_feature'.
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := s.e_feature.argument_count
		end

feature -- Invariant clause: 10

	 number_of_imm_invariant_clauses (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of immediate invariant clauses of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			if s.class_c.ast.invariant_part /= Void then
				Result := s.class_c.ast.invariant_part.assertion_list.count
			end
		end

	 number_of_all_invariant_clauses (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of immediate and inherited invariant clauses of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			indirect_parents_table: HASH_TABLE [STRING, CLASS_C]
			parent: CLASS_C
		do
			create indirect_parents_table.make (100)
			fill_indirect_parents_table (indirect_parents_table, s.class_c)
			from
				indirect_parents_table.start
			until
				indirect_parents_table.after
			loop
				if indirect_parents_table.key_for_iteration /= Void then
					parent := indirect_parents_table.key_for_iteration
					if parent.ast.invariant_part /= Void then
						Result := Result + parent.ast.invariant_part.assertion_list.count
					end
				end
				indirect_parents_table.forth
			end
			if not indirect_parents_table.has (s.class_c) then
				if s.class_c.ast.invariant_part /= Void then 
					Result := Result + s.class_c.ast.invariant_part.assertion_list.count
				end
			end
		end

feature -- Lines: 11

	number_of_lines_in_feature (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of lines in `s.e_feature'.
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		local
			sp,ep,count :INTEGER
			f: PLAIN_TEXT_FILE
			str: STRING
			cl: CLASS_C
			retried: BOOLEAN
			error_dialog: EB_INFORMATION_DIALOG
		do
			if not retried then
				cl := s.e_feature.written_class	
				create f.make_open_read (cl.file_name)
				if f.exists and then f.is_readable then
					sp := s.e_feature.ast.start_position
					ep := s.e_feature.ast.end_position
					count := ep - sp + 1
					f.go (sp)
					f.read_stream (count)
					str := f.last_string
					Result := str.occurrences ('%N')
					f.close
				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to read file:%N"
								+ cl.file_name)
			error_dialog.show
			retry
		end

	number_of_lines_in_class (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of lines in `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			f: PLAIN_TEXT_FILE
			str: STRING
			retried: BOOLEAN
			error_dialog: EB_INFORMATION_DIALOG
		do
			if not retried then
				create f.make_open_read (s.class_c.file_name)
				if f.exists and then f.is_readable then
					f.read_stream (f.count)
					str := f.last_string
					Result := str.occurrences ('%N')
					f.close
				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to read file:%N"
								+ f.name)
			error_dialog.show
			retry
		end

feature -- Locals: 12

	number_of_locals (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of local variables in `s.e_feature'.
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		local
			feature_i: FEATURE_I
			byte_code: BYTE_CODE
		do
			feature_i := s.e_feature.associated_class.feature_table.item (s.e_feature.name)
			if feature_i.byte_server.has (feature_i.body_index) then
				byte_code := feature_i.byte_server.item (feature_i.body_index)
				if byte_code.locals /= Void then
					Result := byte_code.locals.count
				end
			end
		end

	number_of_all_locals_in_class (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of local variables of inherited and proper features of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			feature_table: FEATURE_TABLE
			feature_i: FEATURE_I
			byte_code: BYTE_CODE
		do
			feature_table := s.class_c.feature_table
			from
				feature_table.start
			until
				feature_table.after
			loop
				feature_i := feature_table.item_for_iteration
				if feature_i /= Void and then feature_i.byte_server.has (feature_i.body_index) then
					byte_code := feature_i.byte_server.item (feature_i.body_index)
					if byte_code.locals /= Void then
						Result := Result + byte_code.locals.count
					end
				end
				feature_table.forth
			end
		end

feature -- Comments:

	number_of_comment_lines_in_feature (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of header comment lines in `s.e_feature'.
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		local
--			class_comments_server: CLASS_COMMENTS_SERVER
		do
		end

	number_of_comment_lines_in_class (s: EB_METRIC_SCOPE): DOUBLE is
			-- Number of comment lines in `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
--			class_comments_server: CLASS_COMMENTS_SERVER
--			class_comments: CLASS_COMMENTS
--			id: INTEGER
--			file_ids: LINKED_SET [INTEGER]
		do
--			file_ids := s.class_c.class_comments_server.file_ids
--			id := s.class_c.class_id
--			class_comments_server := s.class_c.class_comments_server
--			from
--				file_ids.start
--			until
--				file_ids.after
--			loop
--				if class_comments_server.has (file_ids.item) then
--					class_comments := class_comments_server.item (file_ids.item)
--					from
--						class_comments.start
--					until
--						class_comments.after
--					loop
--						Result := Result + class_comments.item_for_iteration.count
--						class_comments.forth
--					end
--				end
--				file_ids.forth
--			end
		end

feature -- Access

	test_class: CLASS_C
		-- Used when glancing through `scope.class_c' dependents.

	set_test_class (tc: CLASS_C) is
			-- Assign `tc' to `test_class'.
		do
			test_class := tc
		end

feature -- Derived metrics

	is_class_deferred (s: EB_METRIC_SCOPE): BOOLEAN is
		-- Is `s.class_c' deferred?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			Result := s.class_c.is_deferred
		end

	is_class_effective (s: EB_METRIC_SCOPE): BOOLEAN is
		-- Is `s.class_c' effective?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			Result := not s.class_c.is_deferred
		end

	is_class_invariant_equipped (s: EB_METRIC_SCOPE): BOOLEAN is
		-- Is `s.class_c' invariant equipped?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			Result := s.class_c.has_invariant
		end

	is_class_invariant_equipped_less (s: EB_METRIC_SCOPE): BOOLEAN is
		-- has `s.class_c' no invariant?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			Result := not s.class_c.has_invariant
		end

	is_class_obsolete (s: EB_METRIC_SCOPE): BOOLEAN is
		-- Is `s.class_c' obsolete?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			Result := s.class_c.is_obsolete
		end

	is_class_not_obsolete (s: EB_METRIC_SCOPE): BOOLEAN is
		-- Is `s.class_c' not obsolete?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		do
			Result := not s.class_c.is_obsolete
		end

	is_class_direct_client (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `test_class' direct_client of `s.class_c'?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
			test_class_not_void: test_class /= Void
		do
			Result := s.class_c.clients.has (test_class)
		end

	is_class_direct_heir (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `test_class' direct_heir of `s.class_c'?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
			test_class_not_void: test_class /= Void
		do
			Result := s.class_c.descendants.has (test_class)
		end

	is_class_direct_parent (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `test_class' direct_parent of `s.class_c'?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
			test_class_not_void: test_class /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A]
		do
			parents := s.class_c.parents
			from
				parents.start
			until
				parents.after
			loop
				Result := Result or equal (parents.item.associated_class, test_class)
				parents.forth
			end
		end

	is_class_direct_supplier (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `test_class' direct_supplier of `s.class_c'?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
			test_class_not_void: test_class /= Void
		do
			Result := s.class_c.suppliers.classes.has (test_class)
		end

	is_class_client (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `test_class' direct or indirect_client of `s.class_c'?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
			test_class_not_void: test_class /= Void
		local
			table: HASH_TABLE [STRING, CLASS_C]
		do
			create table.make (100)
			fill_indirect_clients_table (table, s.class_c)
			Result := table.has (test_class)
		end

	is_class_heir (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `test_class' direct_or indirect heir of `s.class_c'?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
			test_class_not_void: test_class /= Void
		local
			table: HASH_TABLE [STRING, CLASS_C]
		do
			create table.make (100)
			fill_indirect_heirs_table (table, s.class_c)
			Result := table.has (test_class)
		end

	is_class_parent (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `test_class' direct_or indirect parent of `s.class_c'?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
			test_class_not_void: test_class /= Void
		local
			table: HASH_TABLE [STRING, CLASS_C]
		do
			create table.make (100)
			fill_indirect_parents_table (table, s.class_c)
			Result := table.has (test_class)
		end

	is_class_supplier (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `test_class' direct_or indirect supplier of `s.class_c'?
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
			test_class_not_void: test_class /= Void
		local
			table: HASH_TABLE [STRING, CLASS_C]
		do
			create table.make (100)
			fill_indirect_suppliers_table (table, s.class_c)
			Result := table.has (test_class)
		end

	is_feature_attribute (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' attribute?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := s.e_feature.ast.is_attribute
		end

	is_feature_routine (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' a routine?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := not s.e_feature.ast.is_attribute
		end

	is_feature_querie (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' a querie?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := s.e_feature.ast.is_attribute or
						s.e_feature.ast.is_function
		end

	is_feature_command (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' a command?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := not s.e_feature.ast.is_attribute and
						not s.e_feature.ast.is_function
		end

	is_feature_function (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' a function?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := s.e_feature.ast.is_function
		end

	is_feature_not_function (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' not a function?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := not s.e_feature.ast.is_function
		end

	is_feature_deferred (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' deferred?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := not s.e_feature.ast.is_attribute and then
						s.e_feature.ast.is_deferred
		end

	is_feature_effective (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' effective?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := not is_feature_deferred (s)
		end

	is_feature_exported (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' exported?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := s.e_feature.export_status.is_all
		end

	is_feature_not_exported (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' restricted or secret?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := not s.e_feature.export_status.is_all
		end

	is_feature_inherited (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' strictly inherited (that is not written in `s.class_c')?
		require
			scope_not_void: s /= Void
			feature_set: s.e_feature /= Void
			class_set: s.class_c /= Void
			scope_is_feature: s.index = Feature_scope
		local
			feature_table: FEATURE_TABLE
			list_features: LIST [E_FEATURE]
		do
			feature_table := s.class_c.feature_table
			list_features := s.class_c.written_in_features
			list_features.compare_objects
			Result := feature_table.has (s.e_feature.name)
					and not list_features.has (s.e_feature)
		end

	is_feature_not_inherited (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Is `s.e_feature' written in class `s.class_c'?
		require
			scope_not_void: s /= Void
			feature_set: s.e_feature /= Void
			class_set: s.class_c /= Void
			scope_is_feature: s.index = Feature_scope
		local
			list_features: LIST [E_FEATURE]
		do
			list_features := s.class_c.written_in_features
			list_features.compare_objects
			Result := list_features.has (s.e_feature)
		end

	is_feature_precondition_equipped (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Has `s.e_feature' precondition clauses?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := s.e_feature.has_precondition
		end

	is_feature_precondition_equipped_less (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Has `s.e_feature' no precondition clause?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := not s.e_feature.has_precondition
		end

	is_feature_postcondition_equipped (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Has `s.e_feature' postcondition clauses?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := s.e_feature.has_postcondition
		end

	is_feature_postcondition_equipped_less (s: EB_METRIC_SCOPE): BOOLEAN is
			-- Has `s.e_feature' no precondition clauses?
		require
			scope_not_void: s /= Void
			scope_is_feature: s.index = Feature_scope
			feature_set: s.e_feature /= Void
		do
			Result := not s.e_feature.has_postcondition
		end

end -- class EB_METRIC_BASIC_FUNCTIONALITIES
