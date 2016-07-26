note
	description: "Wrapper zlib stream struct"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_STREAM

inherit

	MEMORY_STRUCTURE
		rename
			make as memory_make
		end

create
	make

feature -- Initialization
	make
		do
			memory_make
			c_set_zalloc (item, {ZLIB_CONSTANTS}.Z_NULL)
			c_set_zfree (item, {ZLIB_CONSTANTS}.Z_NULL)
			c_set_opaque (item, {ZLIB_CONSTANTS}.Z_NULL)
		end

feature -- Measurement

	structure_size: INTEGER
		external "C inline use zlib.h"
		alias
			"return sizeof(z_stream);"
		end

feature -- Access

	adler: INTEGER_64
		  -- adler32 value of the uncompressed data.
		do
			Result := c_adler (item)
		end

	available_input: INTEGER
			-- number of bytes available at next_in.
		do
			Result := c_avail_in (item)
		end

	available_output: INTEGER
			-- remaining free space at next_out.
		do
			Result := c_avail_out (item)
		end

	data_type: INTEGER
			-- best guess about the data type: binary or text.
		do
			Result := c_data_type (item)
		end

	message: POINTER
			-- last error message, NULL if no error.
		do
			Result := c_msg (item)
		end

	next_input: POINTER
			-- next input byte.
		do
			Result := c_next_in (item)
		end

	next_output: POINTER
			-- next output byte should be put there.
		do
			Result := c_next_out (item)
		end

	total_input: INTEGER_64
			-- total number of input bytes read so far.
		do
			Result := c_total_in (item)
		end

	total_output: INTEGER_64
			-- total number of bytes output so far.
		do
			Result := c_total_out (item)
		end

feature -- Change Element

	set_available_input (a_val: INTEGER_64)
		do
			c_set_avail_in (item, a_val)
		end

	set_available_output (a_val: INTEGER)
		do
			c_set_avail_out (item, a_val)
		end

	set_next_input (a_val: POINTER)
		do
			c_set_next_in (item, a_val)
		end


	set_next_output (a_val: POINTER)
		do
			c_set_next_out (item, a_val)
		end

feature -- C external Access

	c_next_in (a_item: POINTER): POINTER
		external "C inline use <zlib.h>"
		alias
			"return ((z_stream *)($a_item))->next_in;"
		end

	c_avail_in (a_item: POINTER): INTEGER
		external "C inline use <zlib.h>"
		alias
			"return (EIF_INTEGER)((z_stream *) $a_item)->avail_in;"
		end

	c_total_in (a_item: POINTER): INTEGER_64
		external "C inline use <zlib.h>"
		alias
			"return (EIF_INTEGER_64)((z_stream *) $a_item)->total_in;"
		end

	c_next_out (a_item: POINTER): POINTER
		external "C inline use <zlib.h>"
		alias
			"return (EIF_POINTER)((z_stream *) $a_item)->next_out;"
		end

	c_avail_out (a_item: POINTER): INTEGER
		external "C inline use <zlib.h>"
		alias
			"return (EIF_INTEGER)((z_stream *) $a_item)->avail_out;"
		end

	c_total_out (a_item: POINTER): INTEGER_64
		external "C inline use <zlib.h>"
		alias
			"return (EIF_INTEGER_64)((z_stream *) $a_item)->total_out;"
		end

	c_msg (a_item: POINTER): POINTER
		external "C inline use <zlib.h>"
		alias
			"return (( z_stream *) $a_item)->msg;"
		end

	c_data_type (a_item: POINTER): INTEGER
		external "C inline use <zlib.h>"
		alias
			"return (EIF_INTEGER)((z_stream *) $a_item)->data_type;"
		end

	c_adler (a_item: POINTER): INTEGER
		external "C inline use <zlib.h>"
		alias
			"return (EIF_INTEGER_64)((z_stream *) $a_item)->adler;"
		end

feature -- C external element change

	c_set_next_in (a_item: POINTER; a_val: POINTER)
		external "C inline use <zlib.h>"
		alias
			"((z_stream *)($a_item))->next_in = $a_val"
		end

	c_set_avail_in (a_struct: POINTER; a_val: INTEGER_64)
		external "C [struct %"zlib.h%"] (z_stream, int)"
		alias "avail_in"
		end

	c_set_next_out (a_struct: POINTER; a_val: POINTER)
		external "C [struct %"zlib.h%"] (z_stream, void*)"
		alias "next_out"
		end

	c_set_avail_out (a_struct: POINTER; a_val: INTEGER)
		external "C [struct %"zlib.h%"] (z_stream, int)"
		alias "avail_out"
		end

	c_set_zalloc (a_struct: POINTER; a_val: NATURAL)
		external "C [struct %"zlib.h%"] (z_stream, int)"
		alias "zalloc"
		end

	c_set_zfree (a_struct: POINTER; a_val: NATURAL)
		external "C [struct %"zlib.h%"] (z_stream, int)"
		alias "zfree"
		end

	c_set_opaque (a_struct: POINTER; a_val: NATURAL)
		external "C [struct %"zlib.h%"] (z_stream, int)"
		alias "opaque"
		end


end
