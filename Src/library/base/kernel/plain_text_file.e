indexing

	description:
		"Files viewed as persistent sequences of ASCII characters"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class PLAIN_TEXT_FILE

inherit
	FILE
		rename
			index as position
		redefine
			is_plain_text
		end

create

	make, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write,
	make_open_read_append

feature -- Status report

	is_plain_text: BOOLEAN is
			-- Is file reserved for text (character sequences)? (Yes)
		do
			Result := True
		end

	support_storable: BOOLEAN is False
			-- Can medium be used to store an Eiffel structure?

feature -- Output

	put_integer, putint (i: INTEGER) is
			-- Write ASCII value of `i' at current position.
		do
			file_pi (file_pointer, i)
		end

	put_boolean, putbool (b: BOOLEAN) is
			-- Write ASCII value of `b' at current position.
		local
			ext_bool_str: ANY
		do
			if b then
				ext_bool_str := true_string.to_c
				file_ps (file_pointer, $ext_bool_str, true_string.count)
			else
				ext_bool_str := false_string.to_c
				file_ps (file_pointer, $ext_bool_str, false_string.count)
			end
		end

	put_real, putreal (r: REAL) is
			-- Write ASCII value of `r' at current position.
		do
			file_pr (file_pointer, r)
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write ASCII value `d' at current position.
		do
			file_pd (file_pointer, d)
		end

feature -- Input

	read_integer, readint is
			-- Read the ASCII representation of a new integer
			-- from file. Make result available in `last_integer'.
		do
			last_integer := file_gi (file_pointer)
		end

	read_real, readreal is
			-- Read the ASCII representation of a new real
			-- from file. Make result available in `last_real'.
		do
			last_real := file_gr (file_pointer)
		end

	read_double, readdouble is
			-- Read the ASCII representation of a new double
			-- from file. Make result available in `last_double'.
		do
			last_double := file_gd (file_pointer)
		end

feature {NONE} -- Implementation

	file_gi (file: POINTER): INTEGER is
			-- Get an integer from `file'
		external
			"C (FILE *): EIF_INTEGER | %"eif_file.h%""
		end

	file_gr (file: POINTER): REAL is
			-- Read a real from `file'
		external
			"C (FILE *): EIF_REAL | %"eif_file.h%""
		end

	file_gd (file: POINTER): DOUBLE is
			-- Read a double from `file'
		external
			"C (FILE *): EIF_DOUBLE | %"eif_file.h%""
		end

	file_pi (file: POINTER; n: INTEGER) is
			-- Put `n' to end of `file'.
		external
			"C (FILE *, EIF_INTEGER) | %"eif_file.h%""
		end

	file_pr (file: POINTER; r: REAL) is
			-- Put `r' to end of `file'.
		external
			"C (FILE *, EIF_REAL) | %"eif_file.h%""
		end

	file_pd (file: POINTER; d: DOUBLE) is
			-- Put `d' to end of `file'.
		external
			"C (FILE *, EIF_DOUBLE) | %"eif_file.h%""
		end

invariant

	plain_text: is_plain_text

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class PLAIN_TEXT_FILE



