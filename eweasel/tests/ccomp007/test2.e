
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2

feature

	make_directory_name (dir_name, comp: STRING): STRING
			-- Full name of directory in `dir_name'
			-- with last_component `comp'.
		require
			dir_name_not_void: dir_name /= Void;
			component_not_void: comp /= Void;
		do
			Result := make_file_name (dir_name, comp);
		end;

	make_file_name (dir_name, f_name: STRING): STRING
			-- Full name of file in directory `dir_name'
			-- with name `f_name'.
		require
			dir_name_not_void: dir_name /= Void;
			file_name_not_void: f_name /= Void;
		do 
			create Result.make (dir_name.count + f_name.count);
			Result.append (dir_name);
			Result.extend ('/');
			Result.append (f_name);
		end;

	valid_fd (fd: INTEGER): BOOLEAN
		do
			Result := fd >= 0;
		end;

	compilation_flag: STRING 
		do
		end;
end
