note
	description: "{
A hexadecimal dump of a buffer or memory location
}"
	system: "Amalasoft Eiffel LIbrary"
	source: "Amalasoft Corporation"
	license: "Eiffel Forum V2"
	copyright: "Copyright (c) 2012 Amalasoft Corporation.  All Rights Reserved"
	date: "$Date$"
	revision: "$Revision: 001$"
	howto: "See comments at bottom of class."
	history: "See comments at bottom of class."

class AEL_PF_HEXDUMP

inherit
	AEL_PRINTF

create
	make_with_string, make_with_addr

 --|========================================================================
feature {NONE} -- Initialization
 --|========================================================================

	make_with_addr (p: POINTER; sz: INTEGER)
			-- Create Current as a dump of memory from address 'p' for 'sz' 
			-- bytes.
		require
			valid_address: p /= Default_pointer
			valid_size: sz > 0
		local
			ts: STRING_8
			mp: MANAGED_POINTER
			i, lim: INTEGER
		do
			--| Convert to a string then create as if a buffer
			create ts.make (sz)
			create mp.share_from_pointer (p, sz)
			lim := sz
			from i := 0
			until	i >= lim
			loop
				ts.extend (mp.read_character (i))
				i := i + 1
			end
			make_with_string (ts)
		end

	--|--------------------------------------------------------------

	make_with_string (v: STRING_GENERAL)
			-- Create Current from string 'v'.
		require
			exists: v /= Void
		do
			buffer := v.as_string_8
		ensure
			buffer_exists: buffer /= Void and then buffer.count = v.count
		end

--|========================================================================
feature -- Status
--|========================================================================

	use_wide_format: BOOLEAN
			-- Generate output in wide format?
			-- Default is 128 bytes per line
			-- Wide is 512 bytes per line

	use_hex_addresses: BOOLEAN
			-- Show addresses in output as hexadecimal (decimal otherwise)

	suppress_ascii_chars: BOOLEAN
			-- Suppress genration of ASCII chars/strings at line ends?

	sequences_per_chunk: INTEGER
			-- Number of sequqence in a 'chunk' of output

--|========================================================================
feature -- Formatting values
--|========================================================================

	sequence_length: INTEGER
			-- Number of bytes in each byte sequence

	row_width: INTEGER
			-- Overall width of each full row

	address_fld_width: INTEGER
			-- Overall width of address section of a row

	sequence_width: INTEGER
			-- Overall width of value section of a row

	ascii_fld_width: INTEGER
			-- Overall width of ASCII section of a row, including delimiters

	address_gutter_width: INTEGER
			-- Width of gutter between address and sequence values

	ascii_gutter_width: INTEGER
			-- Width of gutter between sequence values and ascii section

	address_format: detachable STRING
			-- Printf format string for address (position) field
		note
			option: stable
		attribute
		end

	sequence_format: detachable STRING
			-- Printf format string for sequence (line)
		note
			option: stable
		attribute
		end

 --|========================================================================
feature -- Components
 --|========================================================================

	buffer: STRING_8
			-- String tp be dumped\
			-- Is unchanged

 --|========================================================================
feature -- Output
 --|========================================================================

	to_string (ss, es: INTEGER; opt: STRING; sa, cs: INTEGER): STRING
			-- The string (hex dump) representation of Current
			--
			-- 'opt' can contain 0 or more characters denoting output 
			-- options
			--
			-- 'ss' and 'es' are start and end sequence numbers to 
			-- included in Result.  By default, output includes all 
			-- sequences in 'buffer'
			-- If 'ss' = 0, then the assumed start is '1'
			-- If 'es' = 0 then end is end of the buffer
			-- If 'es' is greater than the total number of sequence, 
			-- then end is the end of the bugger
			--
			-- If included, 'A' denotes "DO NOT show ASCII chars at line 
			-- end"
			-- If included, 'a' denotes "show ASCII chars at line end"
			--   Default, included for completeness
			-- If included, 'd' denotes "show addresses as decimal"
			--   Default, included for completeness
			-- If included, 'w' denotes "wide format"
			--   64 byte sequences (default is 16)
			-- If included, 'x' denotes "show addresses as hexadecimal"
			--   Default is to show addressed in decimal
			--
			-- 'sa' is the starting address to associate with position 0
			--
			-- If 'cs' is positive, then add a blank line every 
			-- 'cs' sequences (cs<=0 suppresses line insertion)
		require
			options_exist: opt /= Void
			valid_start: ss >= 0
			valid_end: es >= ss
		local
			spos, epos, sbc, seqno, lim: INTEGER
			seq, acs, sfmt: STRING_8
		do
			process_options (opt, cs)

			seqno := ss
			if seqno = 0 then
				seqno := 1
			end
			if es = 0 then
				-- No explicit end point
				lim := buffer.count
			else
				lim := es
			end

			create Result.make (row_width * (buffer.count))
			acs := ""
			check attached sequence_format as l_sf then sfmt := l_sf end

			from
				--spos := 1
				spos := ((seqno - 1) * sequence_length) + 1
			until spos > buffer.count or seqno > lim
			loop
				epos := ((spos - 1) + sequence_length).min (buffer.count)
				seq := buffer.substring (spos, epos)
				if sbc = sequences_per_chunk then
					Result.extend ('%N')
					sbc := 0
				end
				sbc := sbc + 1
				if not suppress_ascii_chars then
					acs := bytes_as_ascii (seq)
				end
				Result.append (
					aprintf (sfmt, << (spos - 1 + sa), string_out (seq), acs >>))
				spos := spos + sequence_length
				seqno := seqno + 1
			end
		end

	--|--------------------------------------------------------------

	to_list (ss, es, sa: INTEGER; opt: STRING): LINKED_LIST [ARRAY [STRING]]
			-- List of row output strings, each with 3 sections, 
			-- unadorned
			-- For use by list-oriented user interfaces
			--
			-- 'ss' and 'es' are start and end sequence numbers to 
			-- included in Result.  By default, output includes all 
			-- sequences in 'buffer'
			-- If 'ss' = 0, then the assumed start is '1'
			-- If 'es' = 0 then end is end of the buffer
			-- If 'es' is greater than the total number of sequence, 
			-- then end is the end of the bugger
			--
			-- 'opt' can contain 0 or more characters denoting output 
			-- options
			--
			-- If included, 'd' denotes "show addresses as decimal"
			--   Default, included for completeness
			-- If included, 'w' denotes "wide format"
			--   64 byte sequences (default is 16)
			-- If included, 'x' denotes "show addresses as hexadecimal"
			--   Default is to show addressed in decimal
			--
			-- 'sa' is the starting address to associate with position 0
			--
		require
			options_exist: opt /= Void
			valid_start: ss >= 0
			valid_end: es >= ss
		local
			spos, epos, seqno, lim: INTEGER
			seq, afmt: STRING_8
			row: ARRAY [STRING]
			acs: STRING
		do
			process_options (opt, 0)
			create Result.make
			acs := ""

			seqno := ss
			if seqno = 0 then
				seqno := 1
			end
			if es = 0 then
				-- No explicit end point
				lim := buffer.count
			else
				lim := es
			end

			check attached address_format as l_af then afmt := l_af end
			from
				spos := ((seqno - 1) * sequence_length) + 1
			until spos > buffer.count or seqno > lim
			loop
				epos := ((spos - 1) + sequence_length).min (buffer.count)
				seq := buffer.substring (spos, epos)
				if not suppress_ascii_chars then
					acs := bytes_as_ascii (seq)
				end
				row := << aprintf (afmt, (spos - 1 + sa)), string_out (seq), acs >>
				Result.extend (row)
				spos := spos + sequence_length
				seqno := seqno + 1
			end
		ensure
			exists: Result /= Void
		end

 --|========================================================================
feature {NONE} -- Formatting support routines
 --|========================================================================

	address_out (v: NATURAL_32): STRING
			-- Address field representation
		local
			ts: STRING
			i, lim: INTEGER
		do
			create Result.make (address_fld_width)
			ts := v.out
			--| Prepend zeroes for full-width
			lim := address_fld_width - ts.count
			from i := 1
			until i > lim
			loop
				Result.extend ('0')
				i := i + 1
			end
			--| Add value itself
			Result.append (ts)
		ensure
			valid: Result /= Void and then Result.count = address_fld_width
		end

	--|--------------------------------------------------------------

	string_out (v: STRING_8): STRING
			-- Representation of the given byte sequence (string)
			-- For each byte (char), show value as 2 nibbles
			-- Add spaces between words, longs and quads, per options
		require
			exists: v /= Void and then not v.is_empty
			short_enough: v.count <= sequence_length
		local
			i, lim: INTEGER
			cc: INTEGER
		do
			create Result.make (sequence_width)
			lim := v.count
			from i := 1
			until i > lim
			loop
				Result.append ((v.item (i).code.to_natural_8).to_hex_string)
				cc := cc + 1
				i := i + 1
				--| Add spacing between values, per options
				if i <= lim then
					inspect cc
					when 2 then
						Result.extend (' ')
					when 4 then
						if use_wide_format then
							Result.extend (' ')
						else
							Result.append ("  ")
							cc := 0
						end
					when 6 then
						check
							wide_only: use_wide_format
						end
						Result.extend (' ')
					when 8 then
						check
							wide_only: use_wide_format
						end
						Result.append ("  ")
						cc := 0
					else
					end
				end
			end
			--| Pad a short row to the full row width
			from i := Result.count
			--until i >= sequence_width
			until i > sequence_width
			loop
				Result.extend (' ')
				i := i + 1
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	bytes_as_ascii (v: STRING_8): STRING
			-- ASCII string representation of byte sequence 'v'.
		require
			exists: v /= Void and then not v.is_empty
			short_enough: v.count <= sequence_length
			ascii_not_suppressed: not suppress_ascii_chars
		local
			i, lim: INTEGER
		do
			create Result.make (ascii_fld_width)
			lim := v.count
			from i := 1
			until i > lim
			loop
				if v.item(i).is_printable then
					Result.extend (v.item(i))
				else
					--| Substitute a blank for a non-printable
					Result.extend (' ')
				end
				i := i + 1
			end
			--| Pad to end of field
			lim := ascii_fld_width
			from i := Result.count
			until i >= lim
			loop
				Result.extend (' ')
				i := i + 1
			end
		ensure
			exists: Result /= Void
			valid_width: Result.count = ascii_fld_width
		end

--|========================================================================
feature {NONE} -- Support
--|========================================================================

	process_options (opt: STRING; cs: INTEGER)
			-- Parse and record formatting options
		require
			options_exist: opt /= Void
		local
			i, lim: INTEGER
		do
			--| reset to defaults
			suppress_ascii_chars := False
			use_wide_format := False
			use_hex_addresses := False
			sequences_per_chunk := 0

			lim := opt.count
			from i := 1
			until i > lim
			loop
				inspect opt.item (i)
				when 'A' then
					suppress_ascii_chars := True
				when 'a' then
					suppress_ascii_chars := False
				when 'd' then
					use_hex_addresses := False
				when 'w' then
					use_wide_format := True
				when 'x' then
					use_hex_addresses := True
				else
					-- Invalid option; Ignore
				end
				i := i + 1
			end

			if cs > 0 then
				sequences_per_chunk := cs
			end

			--| Set formatting values according to options

			if use_wide_format then
				sequence_length := K_wide_sequence_length
				row_width := K_wide_row_width
				address_fld_width := K_wide_address_fld_width
				sequence_width := K_wide_sequence_width
				ascii_fld_width := K_wide_ascii_fld_width
				address_gutter_width := K_wide_addr_to_sequence_gutter
				ascii_gutter_width := K_wide_sequence_to_ascii_gutter
			else
				sequence_length := K_dflt_sequence_length
				row_width := K_dflt_row_width
				address_fld_width := K_dflt_address_fld_width
				sequence_width := K_dflt_sequence_width
				ascii_fld_width := K_dflt_ascii_fld_width
				address_gutter_width := K_dflt_addr_to_sequence_gutter
				ascii_gutter_width := K_dflt_sequence_to_ascii_gutter
			end

			address_format := "%%0" + address_fld_width.out
			if use_hex_addresses then
				address_format.append ("x ")
			else
				address_format.append ("d ")
			end
			if use_wide_format then
				sequence_format := address_format + " %%s "
			else
				sequence_format := address_format + "   %%s  "
			end

			if suppress_ascii_chars then
				sequence_format.append ("%%s%N")
			else
				sequence_format.append ("|%%s|%N")
			end
		end

 --|========================================================================
feature {NONE} -- Size constants
 --|========================================================================

	K_wide_sequence_length: INTEGER = 64
			-- Number of bytes dumped in each byte sequence,
			-- in wide format

	K_dflt_sequence_length: INTEGER = 16
			-- Number of bytes dumped in each byte sequence,
			-- in default format

	--|--------------------------------------------------------------

	K_wide_row_width: INTEGER = 227
			-- Overall width of each full row, in wide format
			-- 9 = {8 digit position + 1 spaces} +
			-- 167 = {(4+1+4+2) * 16} - 1 +
			-- 50 = {1 + 48 + 1} ASCII out +
			-- 1 newline

	K_dflt_row_width: INTEGER = 74
			-- Overall width of each full row, in default format
			-- 11 = {8 digit position + 3 spaces} +
			-- 44 = {(4+1+4+2) * 4} +
			-- 18 = {1 + 16 + 1} ASCII out +
			-- 1 newline

	--|--------------------------------------------------------------

	K_wide_address_fld_width: INTEGER = 8
			-- Overall width of address section of a row

	K_dflt_address_fld_width: INTEGER = 8
			-- Overall width of address section of a row

	--|--------------------------------------------------------------

	K_wide_sequence_width: INTEGER = 165
			-- Overall width of value section of a row, in wide format
			-- = {(4+1+4+2) * 16} - 1 - 8 - 2

	K_dflt_sequence_width: INTEGER = 42
			-- Overall width of value section of a row, in default format
			-- 42 = {(4+1+4+2) * 4} - 2

	--|--------------------------------------------------------------

	K_wide_ascii_fld_width: INTEGER = 64
			-- Overall width of ASCII section of a row, EXcluding 
			-- delimiters, in wide format

	K_dflt_ascii_fld_width: INTEGER = 16
			-- Overall width of ASCII section of a row, EXcluding 
			-- delimiters, in default format

	--|--------------------------------------------------------------

	K_wide_addr_to_sequence_gutter: INTEGER = 1
			-- Width of gutter between address and actual sequence area, 
			-- in wide format

	K_dflt_addr_to_sequence_gutter: INTEGER = 3
			-- Width of gutter between address and actual sequence area, 
			-- in default format

	--|--------------------------------------------------------------

	K_wide_sequence_to_ascii_gutter: INTEGER = 1
			-- Width of gutter between sequence values and ascii 
			-- section, in wide format

	K_dflt_sequence_to_ascii_gutter: INTEGER = 2
			-- Width of gutter between sequence values and ascii 
			-- section, in default format

	--|--------------------------------------------------------------
invariant
	buffer_exists: buffer /= Void

end -- class AEL_PF_HEXDUMP

--|----------------------------------------------------------------------
--| License
--|
--| This software is furnished under the Eiffel Forum License, version 2,
--| and may be used and copied only in accordance with the terms of that
--| license and with the inclusion of the above copyright notice.
--|
--| Refer to the Eiffel Forum License, version 2 text for specifics.
--|
--| The information in this software is subject to change without notice
--| and should not be construed as a commitment by Amalasoft.
--|
--| Amalasoft assumes no responsibility for the use or reliability of this
--| software.
--|
--|----------------------------------------------------------------------
--| History
--|
--| 001 14-Nov-2012
--|     Significant modifications to much older module (HEX_DUMP).
--|     Added format options to output routines (to_string, and 
--|     to_list).
--|     Converted to use ael_printf in part of the logic.
--|     Added to AEL printf cluster.
--|     Compiled and tested with Eiffel Studio 7.1
--|----------------------------------------------------------------------
--| How-to
--|
--| Create and instance of this object with either a memory address 
--| (POINTER) or with a buffer (STRING).
--| Generate either a string form of the dump (to_string) or a linked 
--| list of dump records (to_list) for use in a GUI, for example.
--| See comments in to_list and to_string routines for options.
--|----------------------------------------------------------------------
