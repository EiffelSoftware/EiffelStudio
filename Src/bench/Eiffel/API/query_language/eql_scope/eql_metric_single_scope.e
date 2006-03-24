indexing
	description: "Representation of scope which metrics are calculated over"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_METRIC_SINGLE_SCOPE

inherit
	EQL_SINGLE_SCOPE
		redefine
			is_metric_scope
		end

	EB_METRIC_SCOPE

create
	default_create,
	make,
	make_with_feature,
	make_with_class,
	make_with_cluster,
	make_with_system

feature{NONE} -- Initialization

	make_with_feature (a_feature: like e_feature) is
			-- Initialize `e_feature' with `a_feature'.
		do
			make (feature_scope)
			set_e_feature (a_feature)
		ensure
			e_feature_set: e_feature = a_feature
		end

	make_with_class (a_class: like class_c) is
			-- Initialize `class_c' with `a_class'.
		do
			make (class_scope)
			set_class_c (a_class)
		ensure
			class_c_set: class_c = a_class
		end

	make_with_cluster (a_cluster: like cluster_i) is
			-- Initialize `cluster_i' with `a_cluster'.
		do
			make (cluster_scope)
			set_cluster_i (a_cluster)
		ensure
			cluster_i_set: cluster_i = a_cluster
		end

	make_with_system (a_system: like system_i) is
			-- Initialize `system_i' with `a_system'.
		do
			make (system_scope)
			set_system_i (a_system)
		ensure
			system_i_set: system_i = a_system
		end

feature -- Status reporting

	is_metric_scope: BOOLEAN is True

	is_system_i_set: BOOLEAN is
			-- Is `system_i' set?
		do
			Result := system_i /= Void
		ensure
			good_result: Result implies system_i /= Void
		end

	is_cluster_i_set: BOOLEAN is
			-- Is `cluster_i' set?
		do
			Result := cluster_i /= Void
		ensure
			good_result: Result implies cluster_i /= Void
		end

	is_class_c_set: BOOLEAN is
			-- Is `class_c' set?
		do
			Result := class_c /= Void
		ensure
			good_result: Result implies class_c /= Void
		end

	is_e_feature_set: BOOLEAN is
			-- Is `e_feature' set?
		do
			Result := e_feature /= Void
		ensure
			good_result: Result implies e_feature /= Void
		end

	valid_scope: BOOLEAN is
			-- Is current scope valid?
		do
			Result := index = archive_scope or
					 (index = system_scope and then is_system_i_set) or
					 (index = cluster_scope and then is_cluster_i_set) or
					 (index = class_scope and then is_class_c_set) or
					 (index = feature_scope and then is_e_feature_set)
		end


end
