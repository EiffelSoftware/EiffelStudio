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
			current_file.putstring ("%"%N%N");
		end;

	finish_file is
			-- Finish generation of `current_file'.
		local
			temp: STRING
		do
			temp := clone (Infix_file_name);
			temp.append_integer (file_counter);

			Extern_declarations.generate_header (final_file_name (temp, Dot_h));

			Extern_declarations.generate (final_file_name (temp, Dot_h));
			Extern_declarations.wipe_out;
		end;

end
