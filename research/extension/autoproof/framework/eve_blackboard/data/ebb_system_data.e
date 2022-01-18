note
	description: "Blackboard data for the system."

class
	EBB_SYSTEM_DATA

inherit

	EBB_PARENT_ELEMENT [EBB_SYSTEM_DATA, EBB_CLUSTER_DATA]

	SHARED_WORKBENCH
		export {NONE} all end

	EBB_SHARED_HELPER
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize empty system data.
		do
			create cluster_data_table.make (10)
			create class_data_table.make (100)
			create feature_data_table.make (1000)
		end

feature -- Access

	cluster_data (a_cluster: CONF_GROUP): attached EBB_CLUSTER_DATA
			-- Cluster data for cluster `a_cluster'.
		do
			check cluster_data_table.has_key (a_cluster) end
			Result := cluster_data_table.item (a_cluster)
		end

	class_data (a_class: CLASS_I): attached EBB_CLASS_DATA
			-- Blackboard data for class `a_class'.
		do
			check class_data_table.has_key (a_class.name) end
			Result := class_data_table.item (a_class.name)
		end

	feature_data (a_feature: FEATURE_I): attached EBB_FEATURE_DATA
			-- Blackboard data for feature `a_feature'.
		do
			check feature_data_table.has_key (a_feature.body_index) end
			Result := feature_data_table.item (a_feature.body_index)
		end

	clusters: LIST [EBB_CLUSTER_DATA]
			-- List of clusters.
		do
			Result := cluster_data_table.linear_representation
		end

	classes: LIST [EBB_CLASS_DATA]
			-- List of classes.
		do
			Result := class_data_table.linear_representation
		end

	features: LIST [EBB_FEATURE_DATA]
			-- List of features.
		do
			Result := feature_data_table.linear_representation
		end

feature -- Status report

	has_class (a_class: CLASS_I): BOOLEAN
			-- Does system have data about class `a_class'?
		do
			Result := class_data_table.has_key (a_class.name)
		end

	has_class_by_name (a_name: STRING): BOOLEAN
			-- Does system have data about class `a_class'?
		do
			Result := class_data_table.has_key (a_name)
		end

	has_feature (a_feature: FEATURE_I): BOOLEAN
			-- Does system have data about feature `a_feature'?
		do
			Result := feature_data_table.has_key (a_feature.body_index)
		end

feature -- Update

	update_from_universe
			-- Update blackboard using current data from universe.
		local
			l_groups: ARRAYED_LIST [CONF_GROUP]
			l_group: CONF_GROUP
		do
			from
				l_groups := universe.groups
				l_groups.start
			until
				l_groups.after
			loop
				l_group := l_groups.item
				if l_group.is_cluster and not l_group.is_test_cluster then
					update_cluster (l_group)
				end
				l_groups.forth
			end
		end

	add_class (a_class: CLASS_I)
			-- Add class `a_class'.
		local
			l_class_data: EBB_CLASS_DATA
			l_features: LIST [FEATURE_I]
		do
			if a_class.name.is_case_insensitive_equal ("ITP_INTERPRETER_ROOT") then
				l_class_data := Void
			elseif not class_data_table.has_key (a_class.name) then
				create l_class_data.make (a_class)
				class_data_table.extend (l_class_data, a_class.name)
			else
				l_class_data := class_data_table.item (a_class.name)
			end

			if l_class_data /= Void and then l_class_data.is_compiled then
				from
					l_features := features_written_in_class (l_class_data.compiled_class)
					l_features.start
				until
					l_features.after
				loop
					internal_update_feature (l_features.item, l_class_data)
					l_features.forth
				end
			end
		end

	remove_class (a_class: CLASS_I)
			-- Remove class `a_class'.
		local
			l_class: EBB_CLASS_DATA
		do
			l_class := class_data (a_class)
			if l_class /= Void then
				across l_class.children as l_children loop
					remove_feature (l_children.associated_feature)
				end
			end
			class_data_table.remove (a_class.name)
		end

	update_class (a_class: CLASS_I)
			-- Update class `a_class'.
		do

		end

	add_feature (a_feature: FEATURE_I)
			-- Add feature `a_feature'.
		require
			not_added: not has_feature (a_feature)
		local
			l_class: EBB_CLASS_DATA
		do
			l_class := class_data (a_feature.written_class.original_class)
			check l_class /= Void end
			internal_update_feature (a_feature, l_class)
		end

	remove_feature (a_feature: FEATURE_I)
			-- Remove feature `a_feature'.
		require
			added: has_feature (a_feature)
		local
			l_class: EBB_CLASS_DATA
			l_feature: EBB_FEATURE_DATA
		do
			l_feature := feature_data (a_feature)
			check l_feature /= Void end
			l_class := class_data (a_feature.written_class.original_class)
			check l_class /= Void end

			check l_class.children.has (l_feature) end
			check l_feature.parent = l_class end
			l_feature.set_parent (Void)
			check not l_class.children.has (l_feature) end
			feature_data_table.remove (a_feature.body_index)
		end

	update_feature (a_feature: FEATURE_I)
			-- Update feature `a_feature'.
		require
			added: has_feature (a_feature)
		do
			feature_data (a_feature).set_stale
		end

feature {NONE} -- Implementation

	cluster_data_table: HASH_TABLE [EBB_CLUSTER_DATA, CONF_GROUP]
			-- Hashtable storing cluster data, indexed by cluster.

	class_data_table: HASH_TABLE [EBB_CLASS_DATA, STRING]
			-- Hashtable storing class data, indexed by class name.

	feature_data_table: HASH_TABLE [EBB_FEATURE_DATA, INTEGER]
			-- Hashtable storing feature data, indexed by ???.

	update_cluster (a_cluster: CONF_GROUP)
			-- Update data from `a_cluster'.
		require
			is_cluster: a_cluster.is_cluster
			not_internal: not a_cluster.is_test_cluster
		do
				-- Update classes of this cluster
			if attached a_cluster.classes then
				across a_cluster.classes as c loop
					add_class (universe.classes_with_name (c.name).first)
				end
			end
		end

	internal_update_class (a_class: CLASS_C)
			-- Update data from `a_class'.
		local
			l_class_data: EBB_CLASS_DATA
			l_features: LIST [FEATURE_I]
		do
			if not class_data_table.has_key (a_class.name) then
				create l_class_data.make (a_class.original_class)
				class_data_table.extend (l_class_data, a_class.name)
			else
				l_class_data := class_data_table.item (a_class.name)
			end

				-- Update features of this class
			from
				l_features := features_written_in_class (a_class)
				l_features.start
			until
				l_features.after
			loop
					-- TODO: decide where we filter out attributes...
				internal_update_feature (l_features.item, l_class_data)
				l_features.forth
			end
		end

	internal_update_feature (a_feature: FEATURE_I; a_class_data: EBB_CLASS_DATA)
			-- Update data from feature `a_feature'.
		local
			l_feature_data: EBB_FEATURE_DATA
		do
			if not feature_data_table.has_key (a_feature.body_index) then
				create l_feature_data.make (a_feature)
				feature_data_table.extend (l_feature_data, a_feature.body_index)
			else
				l_feature_data := feature_data_table.item (a_feature.body_index)
			end

			l_feature_data.set_parent (a_class_data)

			if is_feature_data_verified (l_feature_data) then
				l_feature_data.set_stale
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2010-2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
