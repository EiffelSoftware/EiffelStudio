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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if cluster /= Void then
				put_cluster_name (ow);
			end;
			put_file_name (ow)
		end;

end -- class VD21
