note
	description: "Zlib API wrapper for operations provided by the c zlib library"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB

inherit

	ZLIB_CONSTANTS

feature -- Status Report

	last_operation: INTEGER

feature -- Basic Functions

	version: STRING
		local
			l_cstring: C_STRING
		do
			create l_cstring.make_by_pointer (z_lib_version)
			Result := l_cstring.string
		end

	deflate (a_stream: ZLIB_STREAM; a_flush: NATURAL)
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_deflate (a_stream.item, a_flush)
		end

	deflate_end (a_stream: ZLIB_STREAM)
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_deflate_end (a_stream.item)
		end

	inflate (a_stream: ZLIB_STREAM; a_flush: BOOLEAN)
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_inflate (a_stream.item, a_flush.to_integer)
		end

	inflate_end (a_stream: ZLIB_STREAM)
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_inflate_end (a_stream.item)
		end

feature -- Utitlity Functions

	compress (a_target, a_target_len, a_source: POINTER; a_source_len: INTEGER)
		do
			last_operation := c_compress (a_target, a_target_len, a_source, a_source_len)
		end

	uncompress (a_target, a_target_len, a_source: POINTER; a_source_len: INTEGER)
		do
			last_operation := c_uncompress (a_target, a_target_len, a_source, a_source_len)
		end -- uncompress

feature -- Helper Functions

	inflate_init (a_stream: ZLIB_STREAM)
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_inflate_init (a_stream.item, z_lib_version, a_stream.structure_size)
		end

	deflate_init (a_stream: ZLIB_STREAM; a_level: INTEGER)
		require
			non_void_stream: a_stream /= Void
			known_level: a_level >= Z_default_compression and then a_level <= Z_best_compression
		do
			last_operation := c_deflate_init (a_stream.item, a_level, z_lib_version, a_stream.structure_size)
		end

feature {NONE} -- C externals

	z_lib_version: POINTER
		external
			"C use <zlib.h>"
		alias
			"zlibVersion"
		end

	c_compress (a_target, a_target_len, a_source: POINTER; a_source_len: INTEGER): INTEGER
		external
			"C inline use <zlib.h>"
		alias
			"compress"
		end

	c_deflate (a_stream: POINTER; a_flush: NATURAL): INTEGER
		external
			"C use <zlib.h>"
		alias
			"deflate"
		end

	c_deflate_end (a_stream: POINTER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"deflateEnd"
		end

	c_deflate_init (a_stream: POINTER; a_level: INTEGER; a_version: POINTER; a_struct_size: INTEGER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"deflateInit_"
		end

	c_inflate (a_stream: POINTER; a_flush: INTEGER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"inflate"
		end

	c_inflate_end (a_stream: POINTER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"inflateEnd"
		end

	c_inflate_init (a_stream, a_version: POINTER; a_struct_size: INTEGER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"inflateInit_"
		end

	c_uncompress (a_target, a_target_len, a_source: POINTER; a_source_len: INTEGER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"uncompress"
		end

end
