-- Error when two clusters have the same name

class VDCN

inherit

	CLUSTER_ERROR
		redefine
			code
		end;

feature

	code: STRING is "VDCN";
			-- Error code

	build_explain is
		do
			put_cluster_name;
		end;

end
