-- Error when no class in a file *.e

class VD10

inherit

	CLUSTER_ERROR
		redefine
			trace
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
			-- error cide
		do
			Result := "VD10";
		end;

	trace is
			-- Debug purpose
		local
			dummy_reference: CLASS_C
		do
			error_window.put_string ("Error ");
			error_window.put_clickable_string (stone (dummy_reference), code);
			error_window.put_string (":%N");
			error_window.put_string ("%Tfile: ");
			error_window.put_string (file_name);
			error_window.put_string ("%N");
		end;

end
