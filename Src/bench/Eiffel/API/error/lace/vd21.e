-- Error for unreadable file

class VD21

inherit

	FILE_ERROR
		redefine
			build_explain
		end;

feature

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if cluster /= Void then
				put_cluster_name (ow);
			end;
			put_file_name (ow)
		end;

end
