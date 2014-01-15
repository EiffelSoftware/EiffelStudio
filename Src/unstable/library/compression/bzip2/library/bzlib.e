note
	description: "Summary description for {BZIP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BZLIB

feature

	Run:              INTEGER = 0
	Flush:            INTEGER = 1
	Finish:           INTEGER = 2

	Ok:               INTEGER = 0
	Run_ok:           INTEGER = 1
	Flush_ok:         INTEGER = 2
	Finish_ok:        INTEGER = 3
	Stream_end:       INTEGER = 4
	Sequence_error:   INTEGER = -1
	Param_error:      INTEGER = -2
	Mem_error:        INTEGER = -3
	Data_error:       INTEGER = -4
	Data_error_magic: INTEGER = -5
	Io_error:         INTEGER = -6
	Unexpected_eof:   INTEGER = -7
	Outbuff_full:     INTEGER = -8
	Config_error:     INTEGER = -9

feature --Status Report

	last_operation: INTEGER

feature {NONE} -- C externals

	BZ2_bzCompressInit (a_strm: POINTER; a_block_size100k, a_verbosity, a_work_factor: INTEGER): INTEGER
		external "C use %"bzlib.h%""
		alias "BZ2_bzCompressInit"
		end

	BZ2_bzCompress (a_strm: POINTER; a_action: INTEGER): INTEGER
		external "C use %"bzlib.h%""
		alias "BZ2_bzCompress"
		end

	BZ2_bzCompressEnd (a_strm: POINTER): INTEGER
		external "C use %"bzlib.h%""
		alias "BZ2_bzCompressEnd"
		end

	BZ2_bzDecompressInit (a_strm: POINTER; a_verbosity, a_small: INTEGER): INTEGER
		external "C use %"bzlib.h%""
		alias "BZ2_bzDecompressInit"
		end

	BZ2_bzDecompress (a_strm: POINTER): INTEGER
		external "C use %"bzlib.h%""
		alias "BZ2_bzDecompress"
		end

	BZ2_bzDecompressEnd (a_strm: POINTER): INTEGER
		external "C use %"bzlib.h%""
		alias "BZ2_bzDecompressEnd"
		end

	BZ2_bzReadOpen (a_bzerror, a_file: POINTER; a_verbosity, a_small: INTEGER; a_unused: POINTER; a_nunused: INTEGER) : POINTER
		external "C use %"bzlib.h%""
		alias "BZ2_bzReadOpen"
		end

	BZ2_bzReadClose (a_bzerror, a_bzfile: POINTER)
		external "C use %"bzlib.h%""
		alias "BZ2_bzReadClose"
		end

	BZ2_bzReadGetUnused (a_bzerror, a_bzfile, a_unused, a_nunused: POINTER)
		external "C use %"bzlib.h%""
		alias "BZ2_bzReadGetUnused"
		end

	BZ2_bzRead (a_bzerror, a_bzfile, a_buf: POINTER; a_len: INTEGER): INTEGER
		external "C use %"bzlib.h%""
		alias "BZ2_bzRead"
		end

	BZ2_bzWriteOpen (a_bzerror, a_bzfile: POINTER; a_block_size100k, a_verbosity, a_work_factor: INTEGER): POINTER
		external "C use %"bzlib.h%""
		alias "BZ2_bzWriteOpen"
		end

	BZ2_bzWrite (a_bzerror, a_bzfile, a_buf: POINTER; a_len: INTEGER)
		external "C use %"bzlib.h%""
		alias "BZ2_bzWrite"
		end

	BZ2_bzWriteClose (a_bzerror, a_bzfile: POINTER; a_abandon: INTEGER; a_nbytes_in, a_nbytes_out: POINTER)
		external "C use %"bzlib.h%""
		alias "BZ2_bzWriteClose"
		end

	BZ2_bzWriteClose64 (a_bzerror, a_bzfile: POINTER; a_abandon: INTEGER; a_nbytes_in_lo32, a_nbytes_in_hi32, a_nbytes_out_lo32, a_nbytes_out_hi32: POINTER)
		external "C use %"bzlib.h%""
		alias "BZ2_bzWriteClose64"
		end

	BZ2_bzBuffToBuffCompress (a_dest, a_dest_len, a_source: POINTER; a_source_len, a_block_size100k, a_verbosity, a_work_factor: INTEGER): INTEGER
		external "C use %"bzlib.h%""
		alias "BZ2_bzBuffToBuffCompress"
		end

	BZ2_bzBuffToBuffDecompress (a_dest, a_dest_len, a_source: POINTER; a_source_len, a_small, a_verbosity: INTEGER): INTEGER
		external "C use %"bzlib.h%""
		alias "BZ2_bzBuffToBuffDecompress"
		end
end
