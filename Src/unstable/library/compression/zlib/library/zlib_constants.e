note
	description: "Zlib Constants"
	date: "$Date$"
	revision: "$Revision$"

class
	ZLIB_CONSTANTS

feature -- Constants - Flush Values

		--! Flush values
		--! Allowed flush values; see deflate() and inflate() below for details

	Z_no_flush: NATURAL = 0

	Z_partial_flush: NATURAL = 1

	Z_sync_flush: NATURAL = 2

	Z_full_flush: NATURAL = 3

	Z_finish: NATURAL = 4

	Z_block: NATURAL = 5

	Z_trees: NATURAL = 6

feature -- Constants - Return Codes

		--! Return codes for the compression/decompression functions. Negative values
		--! are errors, positive values are used for special but normal events.

	Z_ok: INTEGER = 0

	Z_stream_end: INTEGER = 1

	Z_need_dict: INTEGER = 2

	Z_errno: INTEGER = -1

	Z_stream_error: INTEGER = -2

	Z_data_error: INTEGER = -3

	Z_mem_error: INTEGER = -4

	Z_buf_error: INTEGER = -5

	Z_version_error: INTEGER = -6

feature -- Constants - Compression levels

		--! compression levels */

	Z_no_compression: INTEGER = 0

	Z_best_speed: INTEGER = 1

	Z_best_compression: INTEGER = 9

	Z_default_compression: INTEGER = -1

feature -- Constants - Compression strategy

		--! compression strategy

	Z_filtered: NATURAL = 1

	Z_huffman_only: NATURAL = 2

	Z_rle: NATURAL = 3

	Z_fixed: NATURAL = 4

	Z_default_strategy: NATURAL = 0

feature -- Constants - Data type

		--! Possible values of the data_type field

	Z_binary: NATURAL = 0

	Z_text: NATURAL = 1

	Z_ascii: NATURAL = 1 --! Z_TEXT for compatibility with 1.2.2 and earlier

	Z_unknown: NATURAL = 2

	Z_deflated: NATURAL = 8
			-- The deflate compression method (the only one supported in this version)

	Z_null: NATURAL = 0
			-- for initializing zalloc, zfree, opaque *


feature -- Constants - Memory Levels

   	Z_mem_default: INTEGER = 8
			-- memLevel parameter specifies how much memory should be allocated
			-- for the internal compression state.

	Z_mem_level_1: INTEGER = 1
			-- memLevel=1 uses minimum memory but is
			-- slow and reduces compression ratio.

	Z_mem_level_9: INTEGER = 9
			-- memLevel=9 uses maximum memory for optimal speed.

feature -- Window Bits

	Z_windows_bits: INTEGER_INTERVAL
			-- windowBits determine the windows size
			-- 8..15, default value 8.
		once
			create Result.make (8, 15)
		end

	Z_default_window_bits: INTEGER = 15
			-- default value, use with deflateInit.


feature -- Status Report

	is_valid_flush (a_value: NATURAL): BOOLEAN
			-- Is value `a_value` a valid flush value?
		do
			Result := a_value  = Z_no_flush or else
						a_value = Z_partial_flush or else
						a_value = Z_sync_flush or else
						a_value = Z_full_flush or else
						a_value = Z_finish or else
						a_value = Z_block or else
						a_value = Z_trees
		ensure
			is_instance_free: class
		end

end
