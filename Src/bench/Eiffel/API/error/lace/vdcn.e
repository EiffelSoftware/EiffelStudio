-- Error when two clusters have the same name

class VDCN


inherit

	CLUSTER_ERROR
		redefine
			trace
		end

feature

	code: STRING is "VDCN";
			-- Error code

	trace is
			-- Debug purpose
		do
			io.error.putstring ("code VDCN: cluster ");
			io.error.putstring (cluster.cluster_name);
			io.error.new_line;
		end;

end
