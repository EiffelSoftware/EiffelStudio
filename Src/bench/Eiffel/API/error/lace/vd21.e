-- Error for unreadable file

class VD21

inherit

	CLUSTER_ERROR

feature

	file_name: STRING;
			-- Unreadable file name

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
			file_name := s
		end;

	code: STRING is "VD21"
			-- Error code

end
