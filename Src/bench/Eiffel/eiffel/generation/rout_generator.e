indexing
	description: "Generator of routine tables"
	date: "$Date$"
	revision: "$Revision$"

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
		do
				-- Let's finish C code generation of current block.
			current_buffer.end_c_specific_code

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

			temp := Epoly.twin
			n := file_counter
			temp.append_integer (n);

			packet_number := n // System.makefile_generator.System_packet_number + 2
			create header_file.make_open_write (final_file_name (temp, Dot_h, packet_number))
			current_buffer.put_in_file (header_file)
			header_file.close

			current_buffer.clear_all
			
				-- Start C code generation for next block
			current_buffer.start_c_specific_code
		end;

end
