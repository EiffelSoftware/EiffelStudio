note

    description:

        "control struct and low level interface of libbzip2 as one class"

    library:    "ELJ/ifs"
    author:     "Uwe Sander"
	copyright:  "Copyright (c) 2002, Uwe Sander and others"
    license:    "Eiffel Forum License v1"
    date:       "$Date$"
    revision:   "$Revision$"
    last:       "$Author$"
	status:     "Untested"
	complete:   "yes"

class BZSTREAM

inherit

	BZLIB
		undefine
			copy,
			is_equal
		end

	MEMORY_STRUCTURE

create
	make

feature -- Measurement

	structure_size: INTEGER
		external "C inline use zlib.h"
		alias
			"return sizeof(bz_stream);"
		end

feature -- Basic Operations

	compress_init (a_block_size100k, a_verbosity, a_work_factor: INTEGER)
		do
			last_operation := BZ2_bzCompressInit (item, a_block_size100k, a_verbosity, a_work_factor)
		end

	compress (a_action: INTEGER)
		do
			last_operation := BZ2_bzCompress (item, a_action)
		end

	compress_end
		do
			last_operation := BZ2_bzCompressEnd (item)
		end

	decompress_init (a_verbosity, a_small: INTEGER)
		do
			last_operation := BZ2_bzDecompressInit (item, a_verbosity, a_small)
		end

	decompress
		do
			last_operation := BZ2_bzDecompress (item)
		end

	decompress_end (a_strm: POINTER)
		do
			last_operation := BZ2_bzDecompressEnd (a_strm)
		end

feature -- BZ_STREAM Access

	available_input: INTEGER
		do
			Result := c_avail_in (item)
		end

	available_output: INTEGER
		do
			Result := c_avail_out (item)
		end

	next_input: POINTER
		do
			Result := c_next_in (item)
		end

	next_output: POINTER
		do
			Result := c_next_out (item)
		end

	state: POINTER
		do
--			Result := c_msg (item)
		end -- state

	total_input_low32: INTEGER
		do
			Result := c_total_in_lo32 (item)
		end

	total_input_high32: INTEGER
		do
			Result := c_total_in_hi32 (item)
		end

	total_output_low32: INTEGER
		do
			Result := c_total_out_lo32 (item)
		end

	total_output_high32: INTEGER
		do
			Result := c_total_out_hi32 (item)
		end

feature --Change element

	set_available_input (a_val: INTEGER)
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

feature {NONE} -- C Externals Struct access

	c_next_in (a_item: POINTER): POINTER
		external "C inline use <bzlib.h>"
		alias "return ((bz_stream *)($a_item))->next_in;"
		end

	c_avail_in (a_item: POINTER): INTEGER
		external "C inline use <bzlib.h>"
		alias "return ((bz_stream *)($a_item))->avail_in;"
		end

	c_total_in_lo32 (a_item: POINTER): INTEGER
		external "C inline use <bzlib.h>"
		alias "return ((bz_stream *)($a_item))->total_in_lo32;"
		end

	c_total_in_hi32 (a_item: POINTER): INTEGER
		external "C inline use <bzlib.h>"
		alias "return ((bz_stream *)($a_item))->total_in_hi32;"
		end

	c_next_out (a_item: POINTER): POINTER
		external "C inline use <bzlib.h>"
		alias "return ((bz_stream *)($a_item))->next_out;"
		end

	c_avail_out (a_item: POINTER): INTEGER
		external "C inline use <bzlib.h>"
		alias "return ((bz_stream *)($a_item))->avail_out;"
		end

	c_total_out_lo32 (a_item: POINTER): INTEGER
		external "C inline use <bzlib.h>"
		alias "return ((bz_stream *)($a_item))->total_out_lo32;"
		end

	c_total_out_hi32 (a_item: POINTER): INTEGER
		external "C inline use <bzlib.h>"
		alias "return ((bz_stream *)($a_item))->total_in_hi32;"
		end

	c_state (a_item: POINTER): POINTER
		external "C inline use <bzlib.h>"
		alias "return ((bz_stream *)($a_item))->state;"
		end


feature {NONE} -- C Externals Struct change element

	c_set_next_in (a_item: POINTER; a_val: POINTER)
		external "C inline use <bzlib.h>"
		alias
			"((bz_stream *)($a_item))->next_in = $a_val"
		end

	c_set_avail_in (a_item: POINTER; a_val: INTEGER)
		external "C inline use <zlib.h>"
		alias
			"((bz_stream *)($a_item))->avail_in = $a_val"
		end

	c_set_next_out (a_item: POINTER; a_val: POINTER)
		external "C inline use <zlib.h>"
		alias
			"((bz_stream *)($a_item))->next_out = $a_val"
		end

	c_set_avail_out (a_item: POINTER; a_val: INTEGER)
		external "C inline use <zlib.h>"
		alias
			"((bz_stream *)($a_item))->avail_out = $a_val"
		end

end
