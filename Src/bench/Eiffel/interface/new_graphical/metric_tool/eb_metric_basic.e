indexing
	description: "Representation of metric objects whose function is hard-implemented."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_BASIC

inherit
	EB_METRIC

	SHARED_WORKBENCH

	EB_CONSTANTS

	EB_METRIC_SCOPE_INFO

create
	default_create,
	make

feature -- Initialization

	make (a_name, a_unit: STRING; tl: EB_METRIC_TOOL; minimal: INTEGER; agent_array: ARRAY [TUPLE [INTEGER, FUNCTION [ANY, TUPLE [ANY], DOUBLE]]]) is
			-- Build default array of agents to calculate metrics over scopes (for a given scope, sum on smaller scopes).
			-- Overwrite it with agents specified in `agent_array'.
		require
			correct_name: a_name /= Void and then not a_name.is_empty
			correct_unit: a_unit /= Void and then not a_unit.is_empty
			correct_scope: minimal >= Feature_scope and minimal <= Archive_scope
			tool_not_void: tl /= Void
		local
			i: INTEGER
			scope_action: TUPLE [INTEGER, FUNCTION [ANY, TUPLE [ANY], DOUBLE]]
			action: FUNCTION [ANY, TUPLE [ANY], DOUBLE]
			index: INTEGER_REF
		do
			name := a_name
			unit := a_unit
			tool := tl
			min_scope := minimal
			create processors.make (Feature_scope, System_scope)
			processors.put (~default_feature_value, Feature_scope)
			processors.put (~default_class_value, Class_scope)
			processors.put (~default_cluster_value, Cluster_scope)
			processors.put (~default_system_value, System_scope)

			from
				i := agent_array.lower
			until
				i > agent_array.upper
			loop
				scope_action := agent_array @ i
				action ?= scope_action @ 2
				index ?= scope_action @ 1
				processors.put (action, index.item)
				i := i + 1
			end
		end

feature -- Access

	processors: ARRAY [FUNCTION [ANY, TUPLE [ANY], DOUBLE]]
		-- Array of agents to evaluate metrics over scopes. Each line of array
		-- is specific in calculation for a given scope.
		-- For e.g. processors @ upper_index evaluates metrics over a system scope.

feature -- Default agents

	default_feature_value (s: EB_METRIC_SCOPE): DOUBLE is
			-- This feature is always overwritten when `min_scope' = `Feature_scope'.
			-- Otherwise return zero.
		require
			scope_not_void: s /= Void
		do
			Result := 0
		end

	default_class_value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Sum results of metrics evaluated over written features of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			feat_scope: EB_METRIC_SCOPE
			list_features: LIST [E_FEATURE]
		do
			if s.index > min_scope then
				feat_scope := tool.scope (interface_names.metric_this_feature)
				list_features := s.class_c.written_in_features
				from
					list_features.start
				until
					list_features.after
				loop
					feat_scope.set_e_feature (list_features.item)
					Result := Result + (processors @ Feature_scope).item ([feat_scope])
					list_features.forth
				end
			end
		end

	default_class_value_inherited (s: EB_METRIC_SCOPE): DOUBLE is
			-- Sum results of metrics evaluated over inherited and proper features of `s.class_c'.
		require
			scope_not_void: s /= Void
			scope_is_class: s.index = Class_scope
			class_set: s.class_c /= Void
		local
			feat_scope: EB_METRIC_SCOPE
			table_features: FEATURE_TABLE
			cursor: CURSOR
		do
			if s.index > min_scope then
				feat_scope := tool.scope (interface_names.metric_this_feature)
				table_features := s.class_c.feature_table
				from
					table_features.start
				until
					table_features.after
				loop
					feat_scope.set_e_feature (table_features.item_for_iteration.e_feature)
					cursor := table_features.cursor
					Result := Result + (processors @ Feature_scope).item ([feat_scope])
					table_features.go_to (cursor)
					table_features.forth
				end
			end
		end

	default_cluster_value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Sum results of metrics evaluated over classes of `s.cluster_i'.
		require
			scope_not_void: s /= Void
			scope_is_cluster: s.index = Cluster_scope
			cluster_set: s.cluster_i /= Void
		local
			sub_clusters: ARRAYED_LIST [CLUSTER_I]
			classes: HASH_TABLE [CLASS_I, STRING]
			a_class_scope, scope: EB_METRIC_SCOPE
			progress_value: INTEGER
		do
				-- Do not work directly on `s' since other metrics rely on it, otherwise, further 
				-- calculations will be done on a wrong scope (`s' changes during recursive features).
			scope := clone (s)
			if scope.index > min_scope then
				a_class_scope := tool.scope (interface_names.metric_this_class)
				classes := scope.cluster_i.classes

				tool.progress_dialog.start (classes.count)
				tool.progress_dialog.set_value (0)

				from
					classes.start
				until
					classes.after
				loop
					if classes.item_for_iteration /= Void and then classes.item_for_iteration.compiled_class /= Void then
						a_class_scope.set_class_c (classes.item_for_iteration.compiled_class)
						Result := Result + (processors @ Class_scope).item ([a_class_scope])
						tool.progress_dialog.set_current_entity (classes.item_for_iteration.name_in_upper)
						progress_value := progress_value + 1
						tool.progress_dialog.set_value (progress_value)
					end
					classes.forth
				end

				sub_clusters := scope.cluster_i.sub_clusters
				if sub_clusters.count /= 0 then
					from
						sub_clusters.start
					until
						sub_clusters.exhausted
					loop
						scope.set_cluster_i (sub_clusters.item)
						Result := Result + default_cluster_value (scope)
						sub_clusters.forth
					end
				end

			end
		end

	default_system_value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Sum results of metrics evaluated over all classes of `s.system_i'.
		require
			scope_not_void: s /= Void
			scope_is_system: s.index = System_scope
			system_set: s.system_i /= Void
		local
			i: INTEGER
			array_classes: ARRAY [CLASS_C]
			a_class_scope: EB_METRIC_SCOPE
			progress_value: INTEGER
		do
			if s.index > min_scope then
				array_classes:= s.system_i.classes.sorted_classes
				a_class_scope := tool.scope (interface_names.metric_this_class)

				tool.progress_dialog.start (array_classes.count)
				tool.progress_dialog.set_value (0)

				from
					i := 1
				until
					i > array_classes.count
				loop
					if array_classes.item (i) /= Void then 
						a_class_scope.set_class_c (array_classes.item (i))
						Result := Result + (processors @ Class_scope).item ([a_class_scope])
						tool.progress_dialog.set_current_entity (array_classes.item (i).name_in_upper)
					end
					progress_value := progress_value + 1
					tool.progress_dialog.set_value (progress_value)
					i := i + 1
				end
			end
		end

feature -- Basic metrics calculation

	value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Evaluate current metric over `s.index' scope type
		do
			Result := (processors @ s.index).item ([s])
		end

end -- class EB_METRIC_BASIC
