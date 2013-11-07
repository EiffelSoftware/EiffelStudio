note
	description:"Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author:     "Arnaud PICHERY from an Eric Bezault model"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class
	EDITOR_SCANNER

inherit

	STRING_HANDLER

	SYSTEM_ENCODINGS
		export
			{NONE} all
		end

feature {NONE} -- Local variables

	i_, nb_: INTEGER
	char_: CHARACTER
	str_: detachable STRING
	code_: INTEGER

feature {NONE} -- Initialization

	make
			-- Create a new Eiffel scanner.
		do
			create eif_buffer.make (Init_buffer_size)
		end

feature -- Start Job / Reinitialization

	execute(a_string: STRING)
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
			scan
		end

	execute_with_wide_string (a_string: STRING_32)
			-- Analyze a string.
			-- `a_string' in UTF32.
		require
			string_not_empty: not a_string.is_empty
		local
			u: UTF_CONVERTER
		do
			execute (u.utf_32_string_to_utf_8_string_8 (a_string))
		end

	reset
			-- Reset scanner before scanning next input.
		do
			eif_buffer.wipe_out
			end_token := Void
			first_token := Void
			in_comments := False
			set_start_condition (current_start_condition)
		end

feature -- Access

	curr_token: detachable EDITOR_TOKEN
			-- Current token analysed

	end_token: detachable EDITOR_TOKEN
			-- Last token analysed.

	first_token: detachable EDITOR_TOKEN
			-- First token analysed.

	last_value: detachable ANY
			-- Semantic value to be passed to the parser

	eif_buffer: STRING
			-- Buffer for lexial tokens

	tab_size: INTEGER
			-- Cell that contains the size of tabulations
			-- blank spaces.

	current_encoding: ENCODING
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

	is_windows_eol_preferred: BOOLEAN
			-- Is windows eol preferred?

feature -- Status Setting

	set_in_verbatim_string (a_flag: BOOLEAN)
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

	set_start_condition (a_st: INTEGER)
		deferred
		end

	start_condition: INTEGER
		deferred
		end

	scan
		deferred
		end

feature -- Element Change

	set_tab_size (size: INTEGER)
			-- Set `tab_size' to `size'.
		do
			tab_size := size
		end

	set_is_windows_eol_preferred (b: BOOLEAN)
			-- Set `is_windows_eol_preferred' with `b'.
		do
			is_windows_eol_preferred := b
		end

feature {NONE} -- Factory

	new_text_token (a_text: STRING): EDITOR_TOKEN
			-- Create text token from `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			create {EDITOR_TOKEN_TEXT} Result.make (lexer_encoding_to_utf32 (a_text))
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Encoding implementation

	lexer_encoding_to_utf32 (a_text: STRING): STRING_32
			-- Convert `a_text' of lexer encoding to UTF-32.
		require
			a_text_not_void: a_text /= Void
		do
			if current_encoding /= Void then
				current_encoding.convert_to (utf32, a_text)
				if current_encoding.last_conversion_successful then
					Result := current_encoding.last_converted_string.as_string_32
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

	update_token_list
			-- Link the current token to the last one.
		require
			curr_token_not_void: curr_token /= Void
		local
			l_end_token: like end_token
			l_curr_token: like curr_token
		do
			l_end_token := end_token
			if l_end_token = Void then
				first_token := curr_token
			else
				l_end_token.set_next_token (curr_token)
			end
			l_curr_token := curr_token
			check l_curr_token /= Void end -- Implied by precondition
			l_curr_token.set_previous_token (l_end_token)
			end_token := curr_token
		end

feature {NONE} -- Constants

	Init_buffer_size: INTEGER = 80
				-- Initial size for `eif_buffer'

	in_comments: BOOLEAN
			-- Are we inside a comment?

	current_start_condition: INTEGER

feature {NONE} -- Implementation

	INITIAL_st: INTEGER = 0
	VERBATIM_st: INTEGER = 1

invariant
	eif_buffer_not_void: eif_buffer /= Void

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EDITOR_SCANNER
