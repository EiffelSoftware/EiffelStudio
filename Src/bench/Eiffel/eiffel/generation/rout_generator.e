-- Generator of routine tables

class ROUT_GENERATOR 

inherit
	TABLE_GENERATOR
		rename
			Dot_c as postfix_file_name
		redefine
			finish_file
		end

	SHARED_DECLARATIONS

feature 

	init_file (file: INDENT_FILE) is
			-- Initialization of new file
		require else
			current_buffer_exists: current_buffer /= Void;
		do
			file.putstring ("#include %"eif_macros.h%"%N");
			file.putstring ("#include %"");
			file.putstring (Epoly);
			file.putint (file_counter);
			file.putstring (Dot_h);
			file.putstring ("%"%N%N");
		end;

	finish_file is
			-- Finish generation of `current_buffer'.
		local
			temp: STRING
			header_file: INDENT_FILE
			packet_number, n: INTEGER
		do
			current_buffer.clear_all

			Extern_declarations.generate_header (current_buffer);
			Extern_declarations.generate (current_buffer);
			Extern_declarations.wipe_out;

			temp := clone (Epoly);
			n := file_counter
			temp.append_integer (n);

			packet_number := n // System.makefile_generator.System_packet_number + 2
			!! header_file.make_open_write (final_file_name (temp, Dot_h, packet_number))
			header_file.put_string (current_buffer)
			header_file.close

			current_buffer.clear_all
		end;

end
