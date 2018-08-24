note
	description: "Input for a tool execution."
	date: "$Date$"
	revision: "$Revision$"

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
				internal_features_list.append (features_written_in_class (l_cursor.item))
			end
			internal_features_list.append (individual_features)
		ensure
			internal_features_list_created: internal_features_list /= Void
		end

end
