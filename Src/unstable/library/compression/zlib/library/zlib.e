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
			--	  deflate compresses as much data as possible, and stops when the input
			--  buffer becomes empty or the output buffer becomes full.  It may introduce
			--  some output latency (reading input without producing any output) except when
			--  forced to flush.

			--    The detailed semantics are as follows.  deflate performs one or both of the
			--  following actions:

			--  - Compress more input starting at next_in and update next_in and avail_in
			--    accordingly.  If not all input can be processed (because there is not
			--    enough room in the output buffer), next_in and avail_in are updated and
			--    processing will resume at this point for the next call of deflate().

			--  - Provide more output starting at next_out and update next_out and avail_out
			--    accordingly.  This action is forced if the parameter flush is non zero.
			--    Forcing flush frequently degrades the compression ratio, so this parameter
			--    should be set only when necessary (in interactive applications).  Some
			--    output may be provided even if flush is not set.

			--    Before the call of deflate(), the application should ensure that at least
			--  one of the actions is possible, by providing more input and/or consuming more
			--  output, and updating avail_in or avail_out accordingly; avail_out should
			--  never be zero before the call.  The application can consume the compressed
			--  output when it wants, for example when the output buffer is full (avail_out
			--  == 0), or after each call of deflate().  If deflate returns Z_OK and with
			--  zero avail_out, it must be called again after making room in the output
			--  buffer because there might be more output pending.

			--    Normally the parameter flush is set to Z_NO_FLUSH, which allows deflate to
			--  decide how much data to accumulate before producing output, in order to
			--  maximize compression.

			--    If the parameter flush is set to Z_SYNC_FLUSH, all pending output is
			--  flushed to the output buffer and the output is aligned on a byte boundary, so
			--  that the decompressor can get all input data available so far.  (In
			--  particular avail_in is zero after the call if enough output space has been
			--  provided before the call.) Flushing may degrade compression for some
			--  compression algorithms and so it should be used only when necessary.  This
			--  completes the current deflate block and follows it with an empty stored block
			--  that is three bits plus filler bits to the next byte, followed by four bytes
			--  (00 00 ff ff).

			--    If flush is set to Z_PARTIAL_FLUSH, all pending output is flushed to the
			--  output buffer, but the output is not aligned to a byte boundary.  All of the
			--  input data so far will be available to the decompressor, as for Z_SYNC_FLUSH.
			--  This completes the current deflate block and follows it with an empty fixed
			--  codes block that is 10 bits long.  This assures that enough bytes are output
			--  in order for the decompressor to finish the block before the empty fixed code
			--  block.

			--    If flush is set to Z_BLOCK, a deflate block is completed and emitted, as
			--  for Z_SYNC_FLUSH, but the output is not aligned on a byte boundary, and up to
			--  seven bits of the current block are held to be written as the next byte after
			--  the next deflate block is completed.  In this case, the decompressor may not
			--  be provided enough bits at this point in order to complete decompression of
			--  the data provided so far to the compressor.  It may need to wait for the next
			--  block to be emitted.  This is for advanced applications that need to control
			--  the emission of deflate blocks.

			--    If flush is set to Z_FULL_FLUSH, all output is flushed as with
			--  Z_SYNC_FLUSH, and the compression state is reset so that decompression can
			--  restart from this point if previous compressed data has been damaged or if
			--  random access is desired.  Using Z_FULL_FLUSH too often can seriously degrade
			--  compression.

			--    If deflate returns with avail_out == 0, this function must be called again
			--  with the same value of the flush parameter and more output space (updated
			--  avail_out), until the flush is complete (deflate returns with non-zero
			--  avail_out).  In the case of a Z_FULL_FLUSH or Z_SYNC_FLUSH, make sure that
			--  avail_out is greater than six to avoid repeated flush markers due to
			--  avail_out == 0 on return.

			--    If the parameter flush is set to Z_FINISH, pending input is processed,
			--  pending output is flushed and deflate returns with Z_STREAM_END if there was
			--  enough output space; if deflate returns with Z_OK, this function must be
			--  called again with Z_FINISH and more output space (updated avail_out) but no
			--  more input data, until it returns with Z_STREAM_END or an error.  After
			--  deflate has returned Z_STREAM_END, the only possible operations on the stream
			--  are deflateReset or deflateEnd.

			--    Z_FINISH can be used immediately after deflateInit if all the compression
			--  is to be done in a single step.  In this case, avail_out must be at least the
			--  value returned by deflateBound (see below).  Then deflate is guaranteed to
			--  return Z_STREAM_END.  If not enough output space is provided, deflate will
			--  not return Z_STREAM_END, and it must be called again as described above.

			--    deflate() sets strm->adler to the adler32 checksum of all input read
			--  so far (that is, total_in bytes).

			--    deflate() may update strm->data_type if it can make a good guess about
			--  the input data type (Z_BINARY or Z_TEXT).  In doubt, the data is considered
			--  binary.  This field is only for information purposes and does not affect the
			--  compression algorithm in any manner.

			--    deflate() returns Z_OK if some progress has been made (more input
			--  processed or more output produced), Z_STREAM_END if all input has been
			--  consumed and all output has been produced (only when flush is set to
			--  Z_FINISH), Z_STREAM_ERROR if the stream state was inconsistent (for example
			--  if next_in or next_out was Z_NULL), Z_BUF_ERROR if no progress is possible
			--  (for example avail_in or avail_out was zero).  Note that Z_BUF_ERROR is not
			--  fatal, and deflate() can be called again with more input and more output
			--  space to continue compressing.
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_deflate (a_stream.item, a_flush)
		end

	deflate_end (a_stream: ZLIB_STREAM)
			--   All dynamically allocated data structures for this stream are freed.
			--   This function discards any unprocessed input and does not flush any pending
			--   output.

			--     deflateEnd returns Z_OK if success, Z_STREAM_ERROR if the
			--   stream state was inconsistent, Z_DATA_ERROR if the stream was freed
			--   prematurely (some input or output was discarded).  In the error case, msg
			--   may be set but then points to a static string (which must not be
			--   deallocated).	
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_deflate_end (a_stream.item)
		end

	inflate (a_stream: ZLIB_STREAM; a_flush: NATURAL)
			--   inflate decompresses as much data as possible, and stops when the input
			--  buffer becomes empty or the output buffer becomes full.  It may introduce
			--  some output latency (reading input without producing any output) except when
			--  forced to flush.

			--  The detailed semantics are as follows.  inflate performs one or both of the
			--  following actions:

			--  - Decompress more input starting at next_in and update next_in and avail_in
			--    accordingly.  If not all input can be processed (because there is not
			--    enough room in the output buffer), next_in is updated and processing will
			--    resume at this point for the next call of inflate().

			--  - Provide more output starting at next_out and update next_out and avail_out
			--    accordingly.  inflate() provides as much output as possible, until there is
			--    no more input data or no more space in the output buffer (see below about
			--    the flush parameter).

			--    Before the call of inflate(), the application should ensure that at least
			--  one of the actions is possible, by providing more input and/or consuming more
			--  output, and updating the next_* and avail_* values accordingly.  The
			--  application can consume the uncompressed output when it wants, for example
			--  when the output buffer is full (avail_out == 0), or after each call of
			--  inflate().  If inflate returns Z_OK and with zero avail_out, it must be
			--  called again after making room in the output buffer because there might be
			--  more output pending.

			--    The flush parameter of inflate() can be Z_NO_FLUSH, Z_SYNC_FLUSH, Z_FINISH,
			--  Z_BLOCK, or Z_TREES.  Z_SYNC_FLUSH requests that inflate() flush as much
			--  output as possible to the output buffer.  Z_BLOCK requests that inflate()
			--  stop if and when it gets to the next deflate block boundary.  When decoding
			--  the zlib or gzip format, this will cause inflate() to return immediately
			--  after the header and before the first block.  When doing a raw inflate,
			--  inflate() will go ahead and process the first block, and will return when it
			--  gets to the end of that block, or when it runs out of data.

			--    The Z_BLOCK option assists in appending to or combining deflate streams.
			--  Also to assist in this, on return inflate() will set strm->data_type to the
			--  number of unused bits in the last byte taken from strm->next_in, plus 64 if
			--  inflate() is currently decoding the last block in the deflate stream, plus
			--  128 if inflate() returned immediately after decoding an end-of-block code or
			--  decoding the complete header up to just before the first byte of the deflate
			--  stream.  The end-of-block will not be indicated until all of the uncompressed
			--  data from that block has been written to strm->next_out.  The number of
			--  unused bits may in general be greater than seven, except when bit 7 of
			--  data_type is set, in which case the number of unused bits will be less than
			--  eight.  data_type is set as noted here every time inflate() returns for all
			--  flush options, and so can be used to determine the amount of currently
			--  consumed input in bits.

			--    The Z_TREES option behaves as Z_BLOCK does, but it also returns when the
			--  end of each deflate block header is reached, before any actual data in that
			--  block is decoded.  This allows the caller to determine the length of the
			--  deflate block header for later use in random access within a deflate block.
			--  256 is added to the value of strm->data_type when inflate() returns
			--  immediately after reaching the end of the deflate block header.

			--    inflate() should normally be called until it returns Z_STREAM_END or an
			--  error.  However if all decompression is to be performed in a single step (a
			--  single call of inflate), the parameter flush should be set to Z_FINISH.  In
			--  this case all pending input is processed and all pending output is flushed;
			--  avail_out must be large enough to hold all of the uncompressed data for the
			--  operation to complete.  (The size of the uncompressed data may have been
			--  saved by the compressor for this purpose.) The use of Z_FINISH is not
			--  required to perform an inflation in one step.  However it may be used to
			--  inform inflate that a faster approach can be used for the single inflate()
			--  call.  Z_FINISH also informs inflate to not maintain a sliding window if the
			--  stream completes, which reduces inflate's memory footprint.  If the stream
			--  does not complete, either because not all of the stream is provided or not
			--  enough output space is provided, then a sliding window will be allocated and
			--  inflate() can be called again to continue the operation as if Z_NO_FLUSH had
			--  been used.

			--     In this implementation, inflate() always flushes as much output as
			--  possible to the output buffer, and always uses the faster approach on the
			--  first call.  So the effects of the flush parameter in this implementation are
			--  on the return value of inflate() as noted below, when inflate() returns early
			--  when Z_BLOCK or Z_TREES is used, and when inflate() avoids the allocation of
			--  memory for a sliding window when Z_FINISH is used.

			--     If a preset dictionary is needed after this call (see inflateSetDictionary
			--  below), inflate sets strm->adler to the Adler-32 checksum of the dictionary
			--  chosen by the compressor and returns Z_NEED_DICT; otherwise it sets
			--  strm->adler to the Adler-32 checksum of all output produced so far (that is,
			--  total_out bytes) and returns Z_OK, Z_STREAM_END or an error code as described
			--  below.  At the end of the stream, inflate() checks that its computed adler32
			--  checksum is equal to that saved by the compressor and returns Z_STREAM_END
			--  only if the checksum is correct.

			--    inflate() can decompress and check either zlib-wrapped or gzip-wrapped
			--  deflate data.  The header type is detected automatically, if requested when
			--  initializing with inflateInit2().  Any information contained in the gzip
			--  header is not retained, so applications that need that information should
			--  instead use raw inflate, see inflateInit2() below, or inflateBack() and
			--  perform their own processing of the gzip header and trailer.  When processing
			--  gzip-wrapped deflate data, strm->adler32 is set to the CRC-32 of the output
			--  producted so far.  The CRC-32 is checked against the gzip trailer.

			--    inflate() returns Z_OK if some progress has been made (more input processed
			--  or more output produced), Z_STREAM_END if the end of the compressed data has
			--  been reached and all uncompressed output has been produced, Z_NEED_DICT if a
			--  preset dictionary is needed at this point, Z_DATA_ERROR if the input data was
			--  corrupted (input stream not conforming to the zlib format or incorrect check
			--  value), Z_STREAM_ERROR if the stream structure was inconsistent (for example
			--  next_in or next_out was Z_NULL), Z_MEM_ERROR if there was not enough memory,
			--  Z_BUF_ERROR if no progress is possible or if there was not enough room in the
			--  output buffer when Z_FINISH is used.  Note that Z_BUF_ERROR is not fatal, and
			--  inflate() can be called again with more input and more output space to
			--  continue decompressing.  If Z_DATA_ERROR is returned, the application may
			--  then call inflateSync() to look for a good compression block if a partial
			--  recovery of the data is desired.	
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_inflate (a_stream.item, a_flush.to_integer_32)
		end

	inflate_end (a_stream: ZLIB_STREAM)
			--   All dynamically allocated data structures for this stream are freed.
			--   This function discards any unprocessed input and does not flush any pending
			--   output.

			--     inflateEnd returns Z_OK if success, Z_STREAM_ERROR if the stream state
			--   was inconsistent.  In the error case, msg may be set but then points to a
			--   static string (which must not be deallocated).
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_inflate_end (a_stream.item)
		end

feature -- Utitlity Functions

	compress (a_target, a_target_len, a_source: POINTER; a_source_len: INTEGER)
			--	     Compresses the source buffer into the destination buffer.  sourceLen is
			--   the byte length of the source buffer.  Upon entry, destLen is the total size
			--   of the destination buffer, which must be at least the value returned by
			--   compressBound(sourceLen).  Upon exit, destLen is the actual size of the
			--   compressed buffer.

			--     compress returns Z_OK if success, Z_MEM_ERROR if there was not
			--   enough memory, Z_BUF_ERROR if there was not enough room in the output
			--   buffer.
		do
			last_operation := c_compress (a_target, a_target_len, a_source, a_source_len)
		end

	uncompress (a_target, a_target_len, a_source: POINTER; a_source_len: INTEGER)
			--     Decompresses the source buffer into the destination buffer.  sourceLen is
			--   the byte length of the source buffer.  Upon entry, destLen is the total size
			--   of the destination buffer, which must be large enough to hold the entire
			--   uncompressed data.  (The size of the uncompressed data must have been saved
			--   previously by the compressor and transmitted to the decompressor by some
			--   mechanism outside the scope of this compression library.) Upon exit, destLen
			--   is the actual size of the uncompressed buffer.

			--     uncompress returns Z_OK if success, Z_MEM_ERROR if there was not
			--   enough memory, Z_BUF_ERROR if there was not enough room in the output
			--   buffer, or Z_DATA_ERROR if the input data was corrupted or incomplete.  In
			--   the case where there is not enough room, uncompress() will fill the output
			--   buffer with the uncompressed data up to that point.	
		do
			last_operation := c_uncompress (a_target, a_target_len, a_source, a_source_len)
		end

	compress_bound (a_source_len: INTEGER): INTEGER
			--     compressBound() returns an upper bound on the compressed size after
			--   compress() or compress2() on sourceLen bytes.  It would be used before a
			--   compress() or compress2() call to allocate the destination buffer.		
		do
			Result := c_compress_bound (a_source_len)
		end

	gzopen (a_path: READABLE_STRING_GENERAL; a_mode: STRING): POINTER
			--   Opens a gzip (.gz) file for reading or writing.  The mode parameter is as
			--   in fopen ("rb" or "wb") but can also include a compression level ("wb9") or
			--   a strategy: 'f' for filtered data as in "wb6f", 'h' for Huffman-only
			--   compression as in "wb1h", 'R' for run-length encoding as in "wb1R", or 'F'
			--   for fixed code compression as in "wb9F".  (See the description of
			--   deflateInit2 for more information about the strategy parameter.)  'T' will
			--   request transparent writing or appending with no compression and not using
			--   the gzip format.

			--     "a" can be used instead of "w" to request that the gzip stream that will
			--   be written be appended to the file.  "+" will result in an error, since
			--   reading and writing to the same gzip file is not supported.  The addition of
			--   "x" when writing will create the file exclusively, which fails if the file
			--   already exists.  On systems that support it, the addition of "e" when
			--   reading or writing will set the flag to close the file on an execve() call.

			--     These functions, as well as gzip, will read and decode a sequence of gzip
			--   streams in a file.  The append function of gzopen() can be used to create
			--   such a file.  (Also see gzflush() for another way to do this.)  When
			--   appending, gzopen does not test whether the file begins with a gzip stream,
			--   nor does it look for the end of the gzip streams to begin appending.  gzopen
			--   will simply append a gzip stream to the existing file.

			--     gzopen can be used to read a file which is not in gzip format; in this
			--   case gzread will directly read from the file without decompression.  When
			--   reading, this will be detected automatically by looking for the magic two-
			--   byte gzip header.

			--     gzopen returns NULL if the file could not be opened, if there was
			--   insufficient memory to allocate the gzFile state, or if an invalid mode was
			--   specified (an 'r', 'w', or 'a' was not provided, or '+' was provided).
			--   errno can be checked to determine if the reason gzopen failed was that the
			--   file could not be opened.
		require
				non_void_path: a_path /= Void
				non_void_mode: a_mode /= Void
		local
			l_path: C_STRING
			l_mode: C_STRING
		do
			create l_path.make (a_path)
			create l_mode.make (a_mode)
			Result := c_gzopen (l_path.item, l_mode.item)
		end

	gzclose (a_file: POINTER)
			--	 Flushes all pending output if necessary, closes the compressed file and
			--   deallocates the (de)compression state.  Note that once file is closed, you
			--   cannot call gzerror with file, since its structures have been deallocated.
			--   gzclose must not be called more than once on the same file, just as free
			--   must not be called more than once on the same allocation.

			--     gzclose will return Z_STREAM_ERROR if file is not valid, Z_ERRNO on a
			--   file operation error, Z_MEM_ERROR if out of memory, Z_BUF_ERROR if the
			--   last read ended in the middle of a gzip stream, or Z_OK on success.		
		do
			last_operation := c_gzclose (a_file)
		end


	gzwrite (a_file: POINTER; a_buffer: POINTER; a_len: INTEGER)
			--     Writes the given number of uncompressed bytes into the compressed file.
			--   gzwrite returns the number of uncompressed bytes written or 0 in case of
			--   error.
		do
			last_operation := c_gzwrite (a_file, a_buffer, a_len)
		end


	gzread (a_file: POINTER; a_buffer: POINTER; a_len: INTEGER)
			--		     Reads the given number of uncompressed bytes from the compressed file.  If
			--   the input file is not in gzip format, gzread copies the given number of
			--   bytes into the buffer directly from the file.

			--     After reaching the end of a gzip stream in the input, gzread will continue
			--   to read, looking for another gzip stream.  Any number of gzip streams may be
			--   concatenated in the input file, and will all be decompressed by gzread().
			--   If something other than a gzip stream is encountered after a gzip stream,
			--   that remaining trailing garbage is ignored (and no error is returned).

			--     gzread can be used to read a gzip file that is being concurrently written.
			--   Upon reaching the end of the input, gzread will return with the available
			--   data.  If the error code returned by gzerror is Z_OK or Z_BUF_ERROR, then
			--   gzclearerr can be used to clear the end of file indicator in order to permit
			--   gzread to be tried again.  Z_OK indicates that a gzip stream was completed
			--   on the last gzread.  Z_BUF_ERROR indicates that the input file ended in the
			--   middle of a gzip stream.  Note that gzread does not return -1 in the event
			--   of an incomplete gzip stream.  This error is deferred until gzclose(), which
			--   will return Z_BUF_ERROR if the last gzread ended in the middle of a gzip
			--   stream.  Alternatively, gzerror can be used before gzclose to detect this
			--   case.

			--     gzread returns the number of uncompressed bytes actually read, less than
			--   len for end of file, or -1 for error.
		do
			last_operation := c_gzread (a_file, a_buffer, a_len)
		end

feature -- Helper Functions

	inflate_init (a_stream: ZLIB_STREAM)
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_inflate_init (a_stream.item, z_lib_version, a_stream.structure_size)
		end


	inflate_init_2 (a_stream: ZLIB_STREAM; a_windows_bits: INTEGER)
			-- 	This is another version of inflateInit with an extra parameter.  The
			--   fields next_in, avail_in, zalloc, zfree and opaque must be initialized
			--   before by the caller.

			--     The windowBits parameter is the base two logarithm of the maximum window
			--   size (the size of the history buffer).  It should be in the range 8..15 for
			--   this version of the library.  The default value is 15 if inflateInit is used
			--   instead.  windowBits must be greater than or equal to the windowBits value
			--   provided to deflateInit2() while compressing, or it must be equal to 15 if
			--   deflateInit2() was not used.  If a compressed stream with a larger window
			--   size is given as input, inflate() will return with the error code
			--   Z_DATA_ERROR instead of trying to allocate a larger window.

			--     windowBits can also be zero to request that inflate use the window size in
			--   the zlib header of the compressed stream.

			--     windowBits can also be -8..-15 for raw inflate.  In this case, -windowBits
			--   determines the window size.  inflate() will then process raw deflate data,
			--   not looking for a zlib or gzip header, not generating a check value, and not
			--   looking for any check values for comparison at the end of the stream.  This
			--   is for use with other formats that use the deflate compressed data format
			--   such as zip.  Those formats provide their own check values.  If a custom
			--   format is developed using the raw deflate format for compressed data, it is
			--   recommended that a check value such as an adler32 or a crc32 be applied to
			--   the uncompressed data as is done in the zlib, gzip, and zip formats.  For
			--   most applications, the zlib format should be used as is.  Note that comments
			--   above on the use in deflateInit2() applies to the magnitude of windowBits.

			--     windowBits can also be greater than 15 for optional gzip decoding.  Add
			--   32 to windowBits to enable zlib and gzip decoding with automatic header
			--   detection, or add 16 to decode only the gzip format (the zlib format will
			--   return a Z_DATA_ERROR).  If a gzip stream is being decoded, strm->adler is a
			--   crc32 instead of an adler32.

			--     inflateInit2 returns Z_OK if success, Z_MEM_ERROR if there was not enough
			--   memory, Z_VERSION_ERROR if the zlib library version is incompatible with the
			--   version assumed by the caller, or Z_STREAM_ERROR if the parameters are
			--   invalid, such as a null pointer to the structure.  msg is set to null if
			--   there is no error message.  inflateInit2 does not perform any decompression
			--   apart from possibly reading the zlib header if present: actual decompression
			--   will be done by inflate().  (So next_in and avail_in may be modified, but
			--   next_out and avail_out are unused and unchanged.) The current implementation
			--   of inflateInit2() does not process any header information -- that is
			--   deferred until inflate() is called.	
		require
			non_void_stream: a_stream /= Void
		do
			last_operation := c_inflate_init_2 (a_stream.item, a_windows_bits, z_lib_version, a_stream.structure_size)
		end


	deflate_init (a_stream: ZLIB_STREAM; a_level: INTEGER)
		require
			non_void_stream: a_stream /= Void
			known_level: a_level >= Z_default_compression and then a_level <= Z_best_compression
		do
			last_operation := c_deflate_init (a_stream.item, a_level, z_lib_version, a_stream.structure_size)
		end


	deflate_init_2 (a_stream: ZLIB_STREAM; a_level: INTEGER; a_method: INTEGER; a_windowBits: INTEGER; a_memLevel: INTEGER; a_strategy: INTEGER )
			--		     This is another version of deflateInit with more compression options.  The
			--   fields next_in, zalloc, zfree and opaque must be initialized before by the
			--   caller.

			--     The method parameter is the compression method.  It must be Z_DEFLATED in
			--   this version of the library.

			--     The windowBits parameter is the base two logarithm of the window size
			--   (the size of the history buffer).  It should be in the range 8..15 for this
			--   version of the library.  Larger values of this parameter result in better
			--   compression at the expense of memory usage.  The default value is 15 if
			--   deflateInit is used instead.

			--     windowBits can also be -8..-15 for raw deflate.  In this case, -windowBits
			--   determines the window size.  deflate() will then generate raw deflate data
			--   with no zlib header or trailer, and will not compute an adler32 check value.

			--     windowBits can also be greater than 15 for optional gzip encoding.  Add
			--   16 to windowBits to write a simple gzip header and trailer around the
			--   compressed data instead of a zlib wrapper.  The gzip header will have no
			--   file name, no extra data, no comment, no modification time (set to zero), no
			--   header crc, and the operating system will be set to 255 (unknown).  If a
			--   gzip stream is being written, strm->adler is a crc32 instead of an adler32.

			--     The memLevel parameter specifies how much memory should be allocated
			--   for the internal compression state.  memLevel=1 uses minimum memory but is
			--   slow and reduces compression ratio; memLevel=9 uses maximum memory for
			--   optimal speed.  The default value is 8.  See zconf.h for total memory usage
			--   as a function of windowBits and memLevel.

			--     The strategy parameter is used to tune the compression algorithm.  Use the
			--   value Z_DEFAULT_STRATEGY for normal data, Z_FILTERED for data produced by a
			--   filter (or predictor), Z_HUFFMAN_ONLY to force Huffman encoding only (no
			--   string match), or Z_RLE to limit match distances to one (run-length
			--   encoding).  Filtered data consists mostly of small values with a somewhat
			--   random distribution.  In this case, the compression algorithm is tuned to
			--   compress them better.  The effect of Z_FILTERED is to force more Huffman
			--   coding and less string matching; it is somewhat intermediate between
			--   Z_DEFAULT_STRATEGY and Z_HUFFMAN_ONLY.  Z_RLE is designed to be almost as
			--   fast as Z_HUFFMAN_ONLY, but give better compression for PNG image data.  The
			--   strategy parameter only affects the compression ratio but not the
			--   correctness of the compressed output even if it is not set appropriately.
			--   Z_FIXED prevents the use of dynamic Huffman codes, allowing for a simpler
			--   decoder for special applications.

			--     deflateInit2 returns Z_OK if success, Z_MEM_ERROR if there was not enough
			--   memory, Z_STREAM_ERROR if any parameter is invalid (such as an invalid
			--   method), or Z_VERSION_ERROR if the zlib library version (zlib_version) is
			--   incompatible with the version assumed by the caller (ZLIB_VERSION).  msg is
			--   set to null if there is no error message.  deflateInit2 does not perform any
			--   compression: this will be done by deflate().
			--*/
		require
			non_void_stream: a_stream /= Void
			known_level: a_level >= Z_default_compression and then a_level <= Z_best_compression
		do
			last_operation := c_deflate_init_2 (a_stream.item, a_level, a_method, a_windowBits, a_memLevel, a_strategy,  z_lib_version, a_stream.structure_size)
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
			"C use <zlib.h>"
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

	c_deflate_init_2 (a_stream: POINTER; a_level: INTEGER; a_method: INTEGER; a_windowBits: INTEGER; a_memLevel: INTEGER; a_strategy: INTEGER; a_version: POINTER; a_struct_size: INTEGER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"deflateInit2_"
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

	c_inflate_init_2 (a_stream: POINTER; a_windows_bits: INTEGER; a_version: POINTER; a_struct_size: INTEGER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"inflateInit2_"
		end

	c_uncompress (a_target, a_target_len, a_source: POINTER; a_source_len: INTEGER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"uncompress"
		end


	c_compress_bound (a_source_len: INTEGER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"compressBound"
		end

	c_gzopen (a_path:POINTER; a_mode:POINTER): POINTER
		external
			"C use <zlib.h>"
		alias
			"gzopen"
		end

	c_gzclose (a_file: POINTER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"gzclose"
		end


	c_gzwrite (a_file: POINTER; a_buffer: POINTER; a_len: INTEGER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"gzwrite"
		end


	c_gzread (a_file: POINTER; a_buffer: POINTER; a_len: INTEGER): INTEGER
		external
			"C use <zlib.h>"
		alias
			"gzread"
		end



end
