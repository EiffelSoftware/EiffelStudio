indexing
	description:"Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author:     "Arnaud PICHERY from an Eric Bezault model"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class
	EDITOR_SCANNER

inherit
	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton,
			reset as reset_compressed_scanner_skeleton
		export
			{NONE} all
		end

	UT_CHARACTER_CODES
		export
			{NONE} all
		end

	KL_IMPORTED_INTEGER_ROUTINES
	KL_IMPORTED_STRING_ROUTINES
	KL_SHARED_PLATFORM
	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS

	STRING_HANDLER

	SYSTEM_ENCODINGS
		export
			{NONE} all
		end

feature {NONE} -- Local variables

	i_, nb_: INTEGER
	char_: CHARACTER
	str_: STRING
	code_: INTEGER

feature {NONE} -- Initialization

	make is
			-- Create a new Eiffel scanner.
		do
			make_with_buffer (Empty_buffer)
			create eif_buffer.make (Init_buffer_size)
		end

feature -- Start Job / Reinitialization

	execute(a_string: STRING) is
			-- Analyze a string.
			-- `a_string' in UTF8.
		require
			string_not_empty: not a_string.is_empty
		do
			if end_of_verbatim_string then
				end_of_verbatim_string := False
			end
			if start_of_verbatim_string then
				start_of_verbatim_string := False
			end
			if in_verbatim_string then
				set_start_condition (verbatim_st)
			end
			current_start_condition := start_condition
			reset
			set_input_buffer (new_string_buffer(a_string))
			scan
		end

	execute_with_wide_string (a_string: STRING_32) is
			-- Analyze a string.
			-- `a_string' in UTF32.
		require
			string_not_empty: not a_string.is_empty
		local
			l_string: STRING
		do
			if current_encoding /= Void then
				if not current_encoding_is_utf8 then
					utf32.convert_to (current_encoding, a_string)
					l_string := utf32.last_converted_stream
					if not current_encoding.last_conversion_successful then
						l_string := a_string.as_string_8
					end
				else
					l_string := utf32_to_utf8 (a_string)
				end
			else
				l_string := a_string.as_string_8
			end
			execute (l_string)
		end

	reset is
			-- Reset scanner before scanning next input.
		do
			reset_compressed_scanner_skeleton
			eif_buffer.wipe_out
			end_token := Void
			first_token := Void
			in_comments := False
			set_start_condition (current_start_condition)
		end

feature -- Access

	curr_token: EDITOR_TOKEN
			-- Current token analysed

	end_token: EDITOR_TOKEN
			-- Last token analysed.

	first_token: EDITOR_TOKEN
			-- First token analysed.

	last_value: ANY
			-- Semantic value to be passed to the parser

	eif_buffer: STRING
			-- Buffer for lexial tokens

	tab_size: INTEGER
			-- Cell that contains the size of tabulations
			-- blank spaces.

	current_encoding: ENCODING is
			-- Current encoding of the scanning text.
		do
			Result := utf8
		end

feature -- Query

	in_verbatim_string: BOOLEAN
			-- Are we inside a verbatim string?

	end_of_verbatim_string: BOOLEAN
			-- Was end of verbatim string found?

	start_of_verbatim_string: BOOLEAN
			-- Was start of verbatim string found?

feature -- Status Setting

	set_in_verbatim_string (a_flag: BOOLEAN) is
			-- Set `in_verbatim_string' to `a_flag'
		do
			in_verbatim_string := a_flag
			if a_flag then
				set_start_condition (verbatim_st)
			else
				set_start_condition (initial_st)
			end
		ensure
			value_set: in_verbatim_string = a_flag
		end

feature -- Element Change

	set_tab_size (size: INTEGER) is
			-- Set `tab_size' to `size'.
		do
			tab_size := size
		end

feature {NONE} -- Factory

	new_text_token (a_text: STRING): EDITOR_TOKEN is
			-- Create text token from `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			create {EDITOR_TOKEN_TEXT} Result.make (lexer_encoding_to_utf32 (a_text))
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Encoding implementation

	lexer_encoding_to_utf32 (a_text: STRING): STRING_32 is
			-- Convert `a_text' of lexer encoding to UTF-32.
		require
			a_text_not_void: a_text /= Void
		local
			l_str: STRING_32
		do
			if current_encoding /= Void then
					-- We use Eiffel implementation to convert UTF-8 to UTF-32
					-- instead of the encoding library.
					-- This is twice faster.
				if not current_encoding_is_utf8 then
					current_encoding.convert_to (utf32, a_text)
					l_str := current_encoding.last_converted_string
					if current_encoding.last_conversion_successful then
						Result := l_str
					else
						Result := a_text
					end
				else
					Result := utf8_to_utf32 (a_text)
				end
			else
				Result := a_text
			end
		ensure
			Result_not_void: Result /= Void
		end

	current_encoding_is_utf8: BOOLEAN is
			-- Is `current_encoding' UTF8?
			-- Use once to optimize, since the encoding is not going to change.
		once
			if current_encoding /= Void then
				Result := current_encoding.is_equal (utf8)
			end
		end

	utf8_to_utf32 (a_string: STRING_8): STRING_32 is
			-- UTF32 to UTF8 conversion, Eiffel implementation.
		local
			l_ptr: MANAGED_POINTER
			l_nat8: NATURAL_8
			l_code: NATURAL_32
			i, nb, cnt: INTEGER
		do
			from
				i := 0
				cnt := 0
				nb := a_string.count
				create l_ptr.share_from_pointer (a_string.area.base_address, nb)
				create Result.make (nb)
				Result.set_count (nb)
			until
				i = nb
			loop
				l_nat8 := l_ptr.read_natural_8 (i)
				cnt := cnt + 1
				if l_nat8 <= 127 then
						-- Form 0xxxxxxx.
					Result.put (l_nat8.to_character_8, cnt)

				elseif (l_nat8 & 0xE0) = 0xC0 then
						-- Form 110xxxxx 10xxxxxx.
					l_code := (l_nat8 & 0x1F).to_natural_32 |<< 6
					i := i + 1
					l_nat8 := l_ptr.read_natural_8 (i)
					l_code := l_code | (l_nat8 & 0x3F).to_natural_32
					Result.put (l_code.to_character_32, cnt)

				elseif (l_nat8 & 0xF0) = 0xE0 then
					-- Form 1110xxxx 10xxxxxx 10xxxxxx.
					l_code := (l_nat8 & 0x0F).to_natural_32 |<< 12
					l_nat8 := l_ptr.read_natural_8 (i + 1)
					l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 6)
					l_nat8 := l_ptr.read_natural_8 (i + 2)
					l_code := l_code | (l_nat8 & 0x3F).to_natural_32
					Result.put (l_code.to_character_32, cnt)
					i := i + 2

				elseif (l_nat8 & 0xF8) = 0xF0 then
					-- Form 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx.
					l_code := (l_nat8 & 0x07).to_natural_32 |<< 18
					l_nat8 := l_ptr.read_natural_8 (i + 1)
					l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 12)
					l_nat8 := l_ptr.read_natural_8 (i + 2)
					l_code := l_code | ((l_nat8 & 0x3F).to_natural_32 |<< 6)
					l_nat8 := l_ptr.read_natural_8 (i + 3)
					l_code := l_code | (l_nat8 & 0x3F).to_natural_32
					Result.put (l_code.to_character_32, cnt)
					i := i + 3

				elseif (l_nat8 & 0xFC) = 0xF8 then
					-- Starts with 111110xx
					-- This seems to be a 5 bytes character,
					-- but UTF-8 is restricted to 4, then substitute with a space
					Result.put (' ', cnt)
					i := i + 4

				else
					-- Starts with 1111110x
					-- This seems to be a 6 bytes character,
					-- but UTF-8 is restricted to 4, then substitute with a space
					Result.put (' ', cnt)
					i := i + 5

				end
				i := i + 1
			end
			Result.set_count (cnt)
		end

	utf32_to_utf8 (a_string: STRING_32): STRING_8 is
			-- Convert UTF32 to UTF8.
		require
			a_string_not_void: a_string /= Void
		local
			bytes_written: INTEGER
			i: INTEGER
			l_code: NATURAL_32
			l_string_length: INTEGER
		do
			l_string_length := a_string.count

				-- First compute how many bytes we need to convert `a_string' to UTF-8.
			from
				i := l_string_length
				bytes_written := 0
			until
				i = 0
			loop
				l_code := a_string.code (i)
				if l_code <= 127 then
					bytes_written := bytes_written + 1
				elseif l_code <= 0x7FF then
					bytes_written := bytes_written + 2
				elseif l_code <= 0xFFFF then
					bytes_written := bytes_written + 3
				else -- l_code <= 0x10FFFF
					bytes_written := bytes_written + 4
				end
				i := i - 1
			end

				-- Fill `utf_ptr8' with the converted data.
			from
				i := 1
				create Result.make (bytes_written)
			until
				i > l_string_length
			loop
				l_code := a_string.code (i)
				if l_code <= 127 then
						-- Of the form 0xxxxxxx.
					Result.append_code (l_code)
				elseif l_code <= 0x7FF then
						-- Insert 110xxxxx 10xxxxxx.
					Result.append_code (0xC0 | (l_code |>> 6))
					Result.append_code (0x80 | (l_code & 0x3F))
				elseif l_code <= 0xFFFF then
						-- Start with 1110xxxx
					Result.append_code (0xE0 | (l_code |>> 12))
					Result.append_code (0x80 | ((l_code |>> 6) & 0x3F))
					Result.append_code (0x80 | (l_code & 0x3F))
				else -- l_code <= 0x10FFFF then
						-- Start with 11110xxx
					check
						max_4_bytes: l_code <= 0x10FFFF
						-- UTF-8 has been restricted to 4 bytes characters
					end
					Result.append_code (0xF0 | (l_code |>> 18))
					Result.append_code (0x80 | ((l_code |>> 12) & 0x3F))
					Result.append_code (0x80 | ((l_code |>> 6) & 0x3F))
					Result.append_code (0x80 | (l_code & 0x3F))
				end
				i := i + 1
			end
		end

feature {NONE} -- Processing

	update_token_list is
			-- Link the current token to the last one.
		do
			if end_token = Void then
				first_token := curr_token
			else
				end_token.set_next_token(curr_token)
			end
			curr_token.set_previous_token(end_token)
			end_token := curr_token
		end

feature {NONE} -- Constants

	Init_buffer_size: INTEGER is 80
				-- Initial size for `eif_buffer'

	in_comments: BOOLEAN
			-- Are we inside a comment?

	current_start_condition: INTEGER

feature {NONE} -- Implementation

	is_verbatim_string_closer: BOOLEAN is
			-- Is `text' a valid Verbatim_string_closer?
		local
			i, j, nb: INTEGER
			found: BOOLEAN
		do
				-- Look for first character ].
				-- (Note that `text' matches the following
				-- regexp:   [ \t\r]*\][^%\n"]*\"  .)
			from j := 1 until found loop
				if text_item (j) = ']' then
					found := True
				end
				j := j + 1
			end
			nb := text.count
			if nb = (text_count - j) then
				Result := True
				from i := 1 until i > nb loop
					if text.item (i) = text_item (j) then
						i := i + 1
						j := j + 1
					else
						Result := False
						i := nb + 1  -- Jump out of the loop.
					end
				end
			end
		end

	INITIAL_st: INTEGER is 0
	VERBATIM_st: INTEGER is 1

invariant
	eif_buffer_not_void: eif_buffer /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EDITOR_SCANNER
