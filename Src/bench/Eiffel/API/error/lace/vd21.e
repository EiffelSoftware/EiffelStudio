indexing

	description: 
		"Error for unreadable file.";
	date: "$Date$";
	revision: "$Revision $"

class VD21

inherit

	FILE_ERROR
		redefine
			build_explain
		end;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			if cluster /= Void then
				put_cluster_name (st);
			end;
			put_file_name (st)
		end;

end -- class VD21
