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
				utf32.convert_to (current_encoding, a_string)
				l_string := utf32.last_converted_stream
				if not current_encoding.last_conversion_successful then
					l_string := a_string.as_string_8
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
				current_encoding.convert_to (utf32, a_text)
				l_str := current_encoding.last_converted_string
				if current_encoding.last_conversion_successful then
					Result := l_str
				else
					Result := a_text
				end
			else
				Result := a_text
			end
		ensure
			Result_not_void: Result /= Void
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
