-- Generator of attribute offset tables

class ATTR_GENERATOR 

inherit

	TABLE_GENERATOR
		rename
			Dot_x as postfix_file_name
		end

feature

	init_file (file: INDENT_FILE) is
			-- Initialization of new file
		require else
			current_buffer_exists: current_buffer /= Void;
		do
			file.putstring ("#include %"eif_macros.h%"%N%N");
		end;

end
