-- Generator of routine tables

class ROUT_GENERATOR 

inherit

	TABLE_GENERATOR
		rename
			Erout as infix_file_name,
			Dot_c as postfix_file_name
		redefine
			finish_file
		end;
	SHARED_DECLARATIONS;

feature 

	Size_limit: INTEGER is 10000;
			-- Limit of size for each generated file

	init_file is
			-- Initialization of new file
		require else
			current_file_exists: current_file /= Void;
			is_open: current_file.is_open_write;
		do
			current_file.putstring ("#include %"macros.h%"%N");
			current_file.putstring ("#include %"");
			current_file.putstring (Infix_file_name);
			current_file.putint (file_counter);
			current_file.putstring (Dot_h);
			current_file.putstring ("%"%N");
		end;

	finish_file is
			-- Finish generation of `current_file'.
		local
			dir_name: DIRECTORY_NAME;
			file_name: FILE_NAME;
			subdir: DIRECTORY
			temp: STRING
		do
			!!dir_name.make_from_string (Final_generation_path);
			temp := clone (System_object_prefix);
			temp.append_integer (1);
			dir_name.extend (temp);

			!! subdir.make (dir_name.path);
			if not subdir.exists then
				subdir.create
			end;
			!!file_name.make_from_string (dir_name.path);
			temp := clone (Infix_file_name);
			temp.append_integer (file_counter);
			temp.append (Dot_h);
			file_name.set_file_name (temp);

			Extern_declarations.generate (file_name.path);
			Extern_declarations.wipe_out;
		end;

end
