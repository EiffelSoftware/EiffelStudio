indexing

	description:
		"Files, viewed as persistent sequences of bytes";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class RAW_FILE

inherit
	FILE
		rename
			index as position
		redefine
			file_reopen, file_open, file_dopen
		end

creation

	make, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write,
	make_open_read_append

feature -- Status report

	support_storable: BOOLEAN is True
			-- Can medium be used to an Eiffel structure?

feature -- Output

	put_integer, putint (i: INTEGER) is
			-- Write binary value of `i' at current position.
		do
			file_pib (file_pointer, i)
		end;

	put_boolean, putbool (b: BOOLEAN) is
			-- Write binary value of `b' at current position.
		local
			ext_bool_str: ANY
		do
			if b then
				put_character ('%/001/')
			else
				put_character ('%U')
			end;
		end;

	put_real, putreal (r: REAL) is
			-- Write binary value of `r' at current position.
		do
			file_prb (file_pointer, r)
		end;

	put_double, putdouble (d: DOUBLE) is
			-- Write binary value `d' at current position.
		do
			file_pdb (file_pointer, d)
		end;

feature -- Input

	read_integer, readint is
			-- Read the binary representation of a new integer
			-- from file. Make result available in `last_integer'.
		do
			last_integer := file_gib (file_pointer)
		end;


	read_real, readreal is
			-- Read the binary representation of a new real
			-- from file. Make result available in `last_real'.
		do
			last_real := file_grb (file_pointer)
		end;

	read_double, readdouble is
			-- Read the binary representation of a new double
			-- from file. Make result available in `last_double'.
		do
			last_double := file_gdb (file_pointer)
		end;

feature {NONE} -- Implementation

	file_gib (file: POINTER): INTEGER is
			-- Get an integer from `file'
		external
			"C | %"eif_file.h%""
		end;

	file_grb (file: POINTER): REAL is
			-- Read a real from `file'
		external
			"C | %"eif_file.h%""
		end;

	file_gdb (file: POINTER): DOUBLE is
			-- Read a double from `file'
		external
			"C | %"eif_file.h%""
		end;

	file_open (f_name: POINTER; how: INTEGER): POINTER is
			-- File pointer for file `f_name', in mode `how'.
		external
			"C | %"eif_file.h%""
		alias
			"file_binary_open"
		end;

	file_dopen (fd, how: INTEGER): POINTER is
			-- File pointer for file of descriptor `fd' in mode `how'
			-- (which must fit the way `fd' was obtained).
		external
			"C | %"eif_file.h%""
		alias
			"file_binary_dopen"
		end;

	file_reopen (f_name: POINTER; how: INTEGER; file: POINTER): POINTER is
			-- File pointer to `file', reopened to have new name `f_name'
			-- in a mode specified by `how'.
		external
			"C | %"eif_file.h%""
		alias
			"file_binary_reopen"
		end;

	file_pib (file: POINTER; n: INTEGER) is
			-- Put `n' to end of `file'.
		external
			"C | %"eif_file.h%""
		end;

	file_prb (file: POINTER; r: REAL) is
			-- Put `r' to end of `file'.
		external
			"C | %"eif_file.h%""
		end;

	file_pdb (file: POINTER; d: DOUBLE) is
			-- Put `d' to end of `file'.
		external
			"C | %"eif_file.h%""
		end;

invariant

	not_plain_text: not is_plain_text

end -- class RAW_FILE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
