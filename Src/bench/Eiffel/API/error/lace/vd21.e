-- Error for unreadable file

class VD21

inherit

	FILE_ERROR
		redefine
			build_explain
		end;

feature

	build_explain is
		do
			if cluster /= Void then
				put_cluster_name;
			end;
			put_file_name
		end;

end
