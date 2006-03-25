indexing
	description: "Representation of metric objects whose function is hard-implemented."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make (a_name, a_unit: STRING; minimal: INTEGER; agent_array: ARRAY [TUPLE [INTEGER, FUNCTION [ANY, TUPLE [ANY], DOUBLE]]]) is
			-- Build default array of agents to calculate metrics over scopes (for a given scope, sum on smaller scopes).
			-- Overwrite it with agents specified in `agent_array'.
		require
			correct_name: a_name /= Void and then not a_name.is_empty
			correct_unit: a_unit /= Void and then not a_unit.is_empty
			correct_scope: minimal >= Feature_scope and minimal <= Archive_scope
		do
			name := a_name
			unit := a_unit
			min_scope := minimal
			create processors.make (Feature_scope, System_scope)
			processors.put (agent default_feature_value, Feature_scope)
			processors.put (agent default_class_value, Class_scope)
			processors.put (agent default_cluster_value, Cluster_scope)
			processors.put (agent default_system_value, System_scope)

			if agent_array /= Void then
				override_processors_with (agent_array)
			end
		end

feature -- Settings

	override_processors_with (agent_array: ARRAY [TUPLE [INTEGER, FUNCTION [ANY, TUPLE [ANY], DOUBLE]]]) is
			-- Override `processors' with data from `agent_array'.
		require
			agent_array_not_void: agent_array /= Void
		local
			i: INTEGER
			action: FUNCTION [ANY, TUPLE [ANY], DOUBLE]
			scope_action: TUPLE [INTEGER, FUNCTION [ANY, TUPLE [ANY], DOUBLE]]
			index: INTEGER_REF
		do
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

feature {NONE} -- Implementation: Access

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
				feat_scope := scope (interface_names.metric_this_feature)
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
				feat_scope := scope (interface_names.metric_this_feature)
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
			a_class_scope, l_scope: EB_METRIC_SCOPE
			progress_value: INTEGER
			progress_count: INTEGER
		do
				-- Do not work directly on `s' since other metrics rely on it, otherwise, further
				-- calculations will be done on a wrong scope (`s' changes during recursive features).
			l_scope := s.twin
			if l_scope.index > min_scope then
				a_class_scope := scope (interface_names.metric_this_class)
				classes := l_scope.cluster_i.classes

				progress_count := classes.count
				progress_value := 0

				from
					classes.start
				until
					classes.after
				loop
					if classes.item_for_iteration /= Void and then classes.item_for_iteration.compiled_class /= Void then
						a_class_scope.set_class_c (classes.item_for_iteration.compiled_class)
						Result := Result + (processors @ Class_scope).item ([a_class_scope])
						if not progress_changed_actions.is_empty then
							progress_changed_actions.call ([progress_value, progress_count, classes.item_for_iteration.name_in_upper])
						end
						progress_value := progress_value + 1
					end
					classes.forth
				end

				sub_clusters := l_scope.cluster_i.sub_clusters
				if sub_clusters.count /= 0 then
					from
						sub_clusters.start
					until
						sub_clusters.exhausted
					loop
						l_scope.set_cluster_i (sub_clusters.item)
						Result := Result + default_cluster_value (l_scope)
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
			progress_count: INTEGER
		do
			if s.index > min_scope then
				array_classes:= s.system_i.classes.sorted_classes
				a_class_scope := scope (interface_names.metric_this_class)
				progress_count := array_classes.count
				progress_value := 0

				from
					i := 1
				until
					i > array_classes.count
				loop
					if array_classes.item (i) /= Void then
						a_class_scope.set_class_c (array_classes.item (i))
						Result := Result + (processors @ Class_scope).item ([a_class_scope])
						if not progress_changed_actions.is_empty then
							progress_changed_actions.call ([progress_value, progress_count, array_classes.item (i).name_in_upper])
						end
					end
					progress_value := progress_value + 1
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_METRIC_BASIC
