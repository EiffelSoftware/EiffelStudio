-- Error when no class in a file *.e

class VD10

inherit

	CLUSTER_ERROR
		redefine
			build_explain
		end

feature

	file_name: STRING;
			-- File name involved

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
			file_name := s;
		end;

	code: STRING is
			-- error code
		do
			Result := "VD10";
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%Tfile: ");
			a_clickable.put_string (file_name);
			a_clickable.put_string ("%N");
		end;

end
