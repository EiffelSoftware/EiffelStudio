-- Generator of routine tables in DLE mode

class 

	DLE_ROUT_GENERATOR 

inherit

	ROUT_GENERATOR
		redefine
			finish, finish_file
		end

feature 

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
			current_file.putstring ("void dle_erout");
			current_file.putint (file_counter);
			current_file.putstring ("(void)");
			current_file.new_line;
			current_file.putchar ('{');
			current_file.new_line;
			current_file.indent;
			Rout_declarations.generate_dle (current_file);
			current_file.exdent;
			current_file.putchar ('}');
			current_file.new_line
		end;

	finish_file is
			-- Finish generation of `current_file'.
		local
			temp: STRING
		do
			temp := clone (Infix_file_name);
			temp.append_integer (file_counter);
			Rout_declarations.generate_header (final_file_name (temp, Dot_h));
			Rout_declarations.generate (final_file_name (temp, Dot_h));
			Rout_declarations.wipe_out
		end;

invariant

	dle_system: System.extendible or System.is_dynamic

end -- class DLE_ROUT_GENERATOR
