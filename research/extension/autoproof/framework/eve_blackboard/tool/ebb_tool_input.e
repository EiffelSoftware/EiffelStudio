note
	description: "Input for a tool execution."

class
	EBB_TOOL_INPUT

inherit

	EBB_SHARED_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize empty input set.
		do
			create {LINKED_SET [attached CONF_GROUP]} individual_clusters.make
			create {LINKED_SET [attached CLASS_C]} individual_classes.make
			create {LINKED_SET [attached FEATURE_I]} individual_features.make
		end

feature -- Access

	individual_clusters: attached LIST [attached CONF_GROUP]
			-- List of individual clusters.

	individual_classes: attached LIST [attached CLASS_C]
			-- List of individual classes.

	individual_features: attached LIST [attached FEATURE_I]
			-- List of individual features.

	classes: attached LIST [attached CLASS_C]
			-- List of all classes form a cluster of `individual_clusters'
			-- merged with the list of classes from `individual_classes'.
		do
			if internal_classes_list = Void then
				build_internal_classes_list
			end
			check attached internal_classes_list end
			Result := internal_classes_list
		end

	features: attached LIST [attached FEATURE_I]
			-- List of all features written in one of the classes
			-- from `classes' merged with the list of features
			-- from `individual_features'.
		do
			if internal_features_list = Void then
				build_internal_features_list
			end
			check attached internal_features_list end
			Result := internal_features_list
		end

feature -- Element change

	add_feature (a_feature: attached FEATURE_I)
			-- Add feature `a_feature'.
		do
			individual_features.extend (a_feature)
			internal_features_list := Void
		end

	add_class (a_class: attached CLASS_C)
			-- Add class `a_class'.
		do
			individual_classes.extend (a_class)
			internal_classes_list := Void
			internal_features_list := Void
		end

	add_cluster (a_cluster: attached CONF_GROUP)
			-- Add cluster `a_cluster'.
		require
			False
		do
			check False end
		end

feature {NONE} -- Implementation

	internal_classes_list: detachable LIST [attached CLASS_C]
			-- Internal list of classes.
			-- Used for lazy initialization of `classes' list.

	internal_features_list: detachable LIST [attached FEATURE_I]
			-- Internal list of features.
			-- Used for lazy intialization of `features' list.

	build_internal_classes_list
			-- Build `internal_classes_list'.
		do
			create {LINKED_SET [attached CLASS_C]} internal_classes_list.make
			-- TODO: get all classes from cluster
			internal_classes_list.append (individual_classes)
		ensure
			internal_classes_list_created: internal_classes_list /= Void
		end

	build_internal_features_list
			-- Build `internal_features_list'.
		do
			create {LINKED_SET [attached FEATURE_I]} internal_features_list.make
			across classes as l_cursor loop
				internal_features_list.append (features_written_in_class (l_cursor))
			end
			internal_features_list.append (individual_features)
		ensure
			internal_features_list_created: internal_features_list /= Void
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2010 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
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
