indexing

	description: 
		"Data representation of cluster information.";
	date: "$Date$";
	revision: "$Revision $"

class S_CLUSTER_DATA

inherit

	S_LINKABLE_DATA
		redefine
			chart, set_chart
		end

creation

	make

feature -- Properties

	classes: FIXED_LIST [S_CLASS_DATA];
			-- Class path within Current 

	clusters: FIXED_LIST [S_CLUSTER_DATA];
			-- Clusters within Current cluster

	chart: S_CHART;
			-- Informal description of Current cluster

	reversed_engineered_file_name: STRING is
			-- Directory path of reversed engineered cluster
			-- (with environment variables not interpreted)
		do
		end;

feature -- Setting 

	set_classes (l: like classes) is
			-- Set classes to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_zero: not l.has (Void)
		do
			classes := l
		ensure
			classes_set: classes = l
		end;

	set_clusters (l: like clusters) is
			-- Set clusters to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			clusters := l
		ensure
			clusters_set: clusters = l
		end;

	set_chart (ch: like chart) is
			-- Set chart to `ch'.
		do
			chart := ch;
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current's name before or after other's name?
		do
			Result := (- view_id) < (- other.view_id)
		end;

end -- class S_CLUSTER_DATA
