-- Error when opening of file failed

class VD22

inherit

	ERROR

feature

	file_name: STRING;
			-- Unreadable file name

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
			file_name := s;
		end;

	code: STRING is "VD22";
			-- Error code

end
