indexing

	description:
		"Files, viewed as persistent sequences of bytes"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class RAW_FILE

inherit
	FILE
		rename
			index as position,
			reader as text_reader,
			writer as text_writer
		redefine
			close
		end

create

	make, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write,
	make_open_read_append

feature -- Status report

	support_storable: BOOLEAN is True
			-- Can medium be used to an Eiffel structure?

feature -- Status setting

	close is
			-- Free allocated resources.
		do
			Precursor {FILE}
			internal_breader := Void
			internal_bwriter := Void
		end

feature -- Output

	put_integer, putint (i: INTEGER) is
			-- Write binary value of `i' at current position.
		do
			writer.write_int32 (i)
		end

	put_boolean, putbool (b: BOOLEAN) is
			-- Write binary value of `b' at current position.
		do
			writer.write_boolean (b)
		end

	put_real, putreal (r: REAL) is
			-- Write binary value of `r' at current position.
		do
			writer.write_single (r)
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write binary value `d' at current position.
		do
			writer.write (d)
		end

	put_data (p: POINTER; size: INTEGER) is
			-- Put `data' of length `size' pointed by `p' at
			-- current position.
		local
			i: INTEGER
			byte: INTEGER_8
		do
			from
				i := 0
			until
				i > (size - 1)
			loop
				writer.write_byte (feature {MARSHAL}.read_byte (p + i))
				i := i + 1
			end
		end

feature -- Input

	read_integer, readint is
			-- Read the binary representation of a new integer
			-- from file. Make result available in `last_integer'.
		local
			buf: SPECIAL [CHARACTER]
		do
			last_integer := reader.read_int32
		end


	read_real, readreal is
			-- Read the binary representation of a new real
			-- from file. Make result available in `last_real'.
		do
			last_real := reader.read_single
		end

	read_double, readdouble is
			-- Read the binary representation of a new double
			-- from file. Make result available in `last_double'.
		do
			last_double := reader.read_double
		end

feature {NONE} -- Implementation

	c_open_modifier: INTEGER is 32768
			-- Open the file in binary mode.

	writer: BINARY_WRITER is
			-- What is used to write in the file.
		do
			if internal_bwriter = Void then
				create internal_bwriter.make (internal_stream)
			end
			Result := internal_bwriter
		end

	internal_bwriter: BINARY_WRITER
			-- Once per opening value of `writer'.

	reader: BINARY_READER is
			-- What is used to read in the file.
		do
			if internal_breader = Void then
				create internal_breader.make (internal_stream)
			end
			Result := internal_breader
		end

	internal_breader: BINARY_READER
			-- Once per opening value of `reader'.

invariant

	not_plain_text: not is_plain_text

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

end -- class RAW_FILE



