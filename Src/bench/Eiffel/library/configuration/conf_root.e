indexing
	description: "The root feature."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ROOT

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_cluster, a_class, a_feature: STRING) is
			-- Create.
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			a_class_lower: a_class.is_equal (a_class.as_lower)
			a_feature_ok: a_feature /= Void and then not a_feature.is_empty
			a_feature_lower: a_feature.is_equal (a_feature.as_lower)
		do
			cluster_name := a_cluster
			if cluster_name /= Void and then cluster_name.is_empty then
				cluster_name := Void
			end
			class_name := a_class
			feature_name := a_feature
		ensure
			cluster_set: cluster_name = a_cluster
			class_set: class_name = a_class
			feature_set: feature_name = a_feature
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is it the same file_rule as `other'?
		do
			Result := equal (cluster_name, other.cluster_name) and
				equal (class_name, other.class_name) and
				equal (feature_name, other.feature_name)
		end

feature -- Access, stored in configuration file

	cluster_name: STRING
			-- The name of the root cluster.

	class_name: STRING
			-- The name of the root class.

	feature_name: STRING
			-- The name of the root feature.

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_cluster_name (a_name: like cluster_name) is
			-- Set `cluster_name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			cluster_name := a_name
		ensure
			name_set: cluster_name = a_name
		end

	set_class_name (a_name: like class_name) is
			-- Set `class_name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			class_name := a_name
		ensure
			name_set: class_name = a_name
		end

	set_feature_name (a_name: like feature_name) is
			-- Set `feature_name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			feature_name := a_name
		ensure
			name_set: feature_name = a_name
		end

invariant
	cluster_name_ok: cluster_name /= Void implies not cluster_name.is_empty
	cluster_name_lower: cluster_name /= Void implies cluster_name.is_equal (cluster_name.as_lower)
	class_name_ok: class_name /= Void and then not class_name.is_empty
	class_name_lower: class_name.is_equal (class_name.as_lower)
	feature_name_ok: feature_name /= Void and then not feature_name.is_empty
	feature_name_lower: feature_name.is_equal (feature_name.as_lower)

end
