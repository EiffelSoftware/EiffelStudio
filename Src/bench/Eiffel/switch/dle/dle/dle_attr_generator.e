-- Generator of attribute offset tables in DLE mode

class 

	DLE_ATTR_GENERATOR 

inherit

	ATTR_GENERATOR
		redefine
			finish, finish_file, init_file
		end;

	SHARED_DECLARATIONS

feature

	init_file is
			-- Initialization of new file
		do
			current_file.putstring ("#include %"eif_macros.h%"%N");
			if System.is_dynamic then
				current_file.putstring ("#include %"");
				current_file.putstring (Infix_file_name);
				current_file.putint (file_counter);
				current_file.putstring (Dot_h);
				current_file.putstring ("%"%N")
			end;
			current_file.new_line
		end;
			
	finish is
			-- Close `current_file'.
		do
			if System.is_dynamic then
				generate_dle
			end;
			current_file.close;
			finish_file
		end;

	generate_dle is
			-- Generate the initialization function (assignments
			-- of pointers to static tables) in `current_file'.
		require
			current_file_exists: current_file /= Void;
			is_open: current_file.is_open_write;
			dynamic_system: System.is_dynamic
		do
			current_file.putstring ("void dle_eattr");
			current_file.putint (file_counter);
			current_file.putstring ("(void)");
			current_file.new_line;
			current_file.putchar ('{');
			current_file.new_line;
			current_file.indent;
			Attr_declarations.generate_dle (current_file);
			current_file.exdent;
			current_file.putchar ('}');
			current_file.new_line
		end;

	finish_file is
			-- Finish generation of `current_file'.
		local
			temp: STRING
		do
			if System.is_dynamic then
				temp := clone (Infix_file_name);
				temp.append_integer (file_counter);
				Attr_declarations.generate_header (final_file_name (temp, Dot_h))
				Attr_declarations.generate (final_file_name (temp, Dot_h))
			end;
			Attr_declarations.wipe_out
		end;

invariant

	dle_system: System.extendible or System.is_dynamic

end -- class DLE_ATTR_GENERATOR
