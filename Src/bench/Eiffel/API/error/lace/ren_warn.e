indexing

	description: 
		"Warning for rename clause in Ace.";
	date: "$Date$";
	revision: "$Revision $"

class REN_WARN

inherit

	CLUSTER_ERROR
		redefine
			build_explain, code
		end

feature -- Property

	code: STRING is "VD35";
			-- Error code

feature -- Ouput

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st)
		end;

end -- class REN_WARN
