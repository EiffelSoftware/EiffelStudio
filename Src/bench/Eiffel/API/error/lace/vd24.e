indexing

	description: 
		"Error when two different basic classes in two clusters.";
	date: "$Date$";
	revision: "$Revision $"

class VD24

inherit

	CLASS_ERROR
		redefine
			build_explain
		end;

feature -- Property

	other_cluster: CLUSTER_I;
			-- Other cluster involved

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_class_name (ow);
			ow.put_string ("First cluster: ");
			ow.put_string (other_cluster.cluster_name);
			ow.put_string ("%NSecond cluster: ");
			ow.put_string (cluster.cluster_name);
			ow.new_line;
		end;

feature {UNIVERSE_I} -- Setting

	set_other_cluster (c: CLUSTER_I) is
			-- Assign `c' to `other_cluster'.
		do
			other_cluster := c;
		end;

end -- class VD24
