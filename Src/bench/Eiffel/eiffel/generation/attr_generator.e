-- Generator of attribute offset tables

class ATTR_GENERATOR 

inherit

	TABLE_GENERATOR
		rename
			Eattr as infix_file_name,
			Dot_x as postfix_file_name
		end

feature

	Size_limit: INTEGER is 20000;
			-- Limit of size for each generated file

	init_file is
			-- Initialization of new file
		require else
			current_file_exists: current_file /= Void;
			is_open: current_file.is_open_write;
		do
			current_file.putstring ("#include %"eif_macros.h%"%N%N");
		end;

end
