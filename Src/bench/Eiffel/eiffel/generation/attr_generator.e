-- Generator of attribute offset tables

class ATTR_GENERATOR 

inherit

	TABLE_GENERATOR
		rename
			Eattr as infix_file_name,
			Dot_x as postfix_file_name
		end

feature

	init_file is
			-- Initialization of new file
		require else
			current_buffer_exists: current_buffer /= Void;
		do
				-- Clear buffer for Current generation
			current_buffer.clear_all
			current_buffer.putstring ("#include %"eif_macros.h%"%N%N");
		end;

end
