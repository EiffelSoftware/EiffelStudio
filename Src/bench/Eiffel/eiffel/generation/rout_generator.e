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
			current_file.putstring ("#include <macros.h>%N");
			current_file.putstring ("#include %"");
			current_file.putstring (Infix_file_name);
			current_file.putint (file_counter);
			current_file.putstring (Dot_h);
			current_file.putstring ("%"%N");
		end;

	finish_file is
			-- Finish generation of `current_file'.
		local
			file_name: STRING;
		do
			file_name := build_path (Final_generation_path, Infix_file_name);
			file_name.append_integer (file_counter);
			file_name.append (Dot_h);
			Extern_declarations.generate (file_name);
			Extern_declarations.wipe_out;
		end;

end
