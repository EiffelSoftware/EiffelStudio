-- Generator of routine tables

class ROUT_GENERATOR 

inherit
	TABLE_GENERATOR
		rename
			Erout as infix_file_name,
			Dot_c as postfix_file_name
		redefine
			finish_file
		end

	SHARED_DECLARATIONS

feature 

	init_file is
			-- Initialization of new file
		require else
			current_buffer_exists: current_buffer /= Void;
		do
				-- Clear buffer for Current generation
			current_buffer.clear_all
			current_buffer.putstring ("#include %"eif_macros.h%"%N");
			current_buffer.putstring ("#include %"");
			current_buffer.putstring (Infix_file_name);
			current_buffer.putint (file_counter);
			current_buffer.putstring (Dot_h);
			current_buffer.putstring ("%"%N%N");
		end;

	finish_file is
			-- Finish generation of `current_buffer'.
		local
			temp: STRING
			header_file: INDENT_FILE
		do
			{TABLE_GENERATOR} Precursor

			Extern_declarations.generate_header (current_buffer);
			Extern_declarations.generate (current_buffer);
			Extern_declarations.wipe_out;

			temp := clone (Infix_file_name);
			temp.append_integer (file_counter - 1);

			!! header_file.make_open_write (final_file_name (temp, Dot_h))
			header_file.put_string (current_buffer)
			header_file.close
		end;

end
