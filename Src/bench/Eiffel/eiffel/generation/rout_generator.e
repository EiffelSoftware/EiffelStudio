-- Generator of routine tables

class ROUT_GENERATOR 

inherit

	TABLE_GENERATOR
		redefine
			finish_file
		end;
	SHARED_DECLARATIONS;

feature 

	Infix_file_name: STRING is "/Erout";
			-- Infix string for file names

	Postfix_file_name: CHARACTER is 'c';
			-- Postfix character for file names

	Size_limit: INTEGER is 10000;
			-- Limit of size for each generated file

	init_file is
			-- Initialization of new file
		require else
			current_file_exists: current_file /= Void;
			is_open: current_file.is_open_write;
		do
			current_file.putstring ("#include <macros.h>%N");
			if context.final_mode then
				current_file.putstring ("#include %"Erout");
				current_file.putint (file_counter);
				current_file.putstring (".h%"%N");
			else
				current_file.putstring ("#include %"struct.h%"%N%N");
			end;
		end;

	finish_file is
			-- Finish generation of `current_file'.
		local
			file_name: STRING;
		do
			if context.final_mode then
				file_name := Final_generation_path.twin;
				file_name.append ("/Erout");
				file_name.append_integer (file_counter);
				file_name.append (".h");
				Extern_declarations.generate (file_name);
				Extern_declarations.wipe_out;
			end;
		end;

end
