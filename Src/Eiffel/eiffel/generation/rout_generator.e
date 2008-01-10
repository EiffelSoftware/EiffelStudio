indexing
	description: "Generator of routine tables"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

			file.put_string ("#include %"");
			file.put_string (Epoly);
			file.put_integer (file_counter);
			file.put_string (Dot_h);
			file.put_string ("%"%N%N");
		end;

	finish_file is
			-- Finish generation of `current_buffer'.
		local
			temp: STRING
			header_file: INDENT_FILE
			packet_number, n: INTEGER
		do
			current_buffer.clear_all
			current_buffer.put_string ("#include %"eif_eiffel.h%"");
			current_buffer.start_c_specific_code
			Extern_declarations.generate (current_buffer);
			current_buffer.end_c_specific_code
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
