-- Warning for rename clause in Ace

class REN_WARN

inherit

	CLUSTER_ERROR
		redefine
			build_explain, code
		end

feature

	code: STRING is "VD35";
			-- Error code

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow)
		end;

end
