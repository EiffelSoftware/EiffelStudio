-- Error when two clusters have the same name

class VDCN


inherit

	CLUSTER_ERROR
		redefine
			build_explain
		end

feature

	code: STRING is "VDCN";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%TCluster ");
			a_clickable.put_string (cluster.cluster_name);
			a_clickable.new_line;
		end;

end
