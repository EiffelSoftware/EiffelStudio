-- Generator of attribute offset tables

class ATTR_GENERATOR 

inherit

	TABLE_GENERATOR

feature

	Infix_file_name: STRING is "/Eattr";
			-- Infix string for file names

	Postfix_file_name: CHARACTER is
			-- Postfix character for file names
		do
			if context.final_mode then
				Result := 'x'
			else
				Result := 'c'
			end
		end;

	Size_limit: INTEGER is 10000;
			-- Limit of size for each generated file

	init_file is
			-- Initialization of new file
		require else
			current_file_exists: current_file /= Void;
			is_open: current_file.is_open_write;
		do
			current_file.putstring ("#include %"macros.h%"%N%N");
			if not context.final_mode then
				current_file.putstring ("#include %"struct.h%"%N%N");
			end;
		end;

end
