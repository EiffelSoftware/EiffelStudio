note

	description:

		"General lexical analyzers"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class YY_SCANNER

inherit

	ANY
			-- Export features of ANY.

	KL_SHARED_STANDARD_FILES

feature {NONE} -- Initialization

	make
			-- Create a new scanner with
			-- standard input as input file.
		do
			make_with_file (std.input)
		end

	make_with_file (a_file: KI_CHARACTER_INPUT_STREAM)
			-- Create a new scanner with
			-- `a_file' as input file.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			make_with_buffer (new_file_buffer (a_file))
		end

	make_with_buffer (a_buffer: like input_buffer)
			-- Create a new scanner with
			-- `a_buffer' as input buffer.
		require
			a_buffer_not_void: a_buffer /= Void
		do
			input_buffer := a_buffer
		ensure
			input_buffer_set: input_buffer = a_buffer
		end

feature -- Initialization

	reset
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in `wrap' before scanning
			-- another input buffer.)
		deferred
		end

feature -- Access

	last_token: INTEGER
			-- Code of last token read
			-- (0 means that the end-of-input has been reached,
			-- non-positive values mean that an error occurred
			-- (see header-comment of `scanning_error'.))

	text: STRING
			-- Text of last token read
			-- (Create a new string at each call.)
		deferred
		ensure
			text_not_void: Result /= Void
			correct_count: Result.count = text_count
		end

	text_item (i: INTEGER): CHARACTER
			-- `i'-th character of last token read
		require
			i_large_enough: i >= 1
			i_small_enough: i <= text_count
		deferred
		ensure
			definition: Result = text.item (i)
		end

	text_substring (s, e: INTEGER): STRING
			-- Substring of last token read
			-- (Create a new string at each call.)
			-- (For efficiency reason, this function can bypass the
			-- call to `text' and create the substring directly from
			-- the input buffer.)
		require
			meaningful_start: 1 <= s
			meaningful_interval: s <= e + 1
			meaningful_end: e <= text_count
		deferred
		ensure
			text_substring_not_void: Result /= Void
			text_substring_empty: (s > e) implies (Result.count = 0)
			definition: s <= e implies Result.is_equal (text.substring (s, e))
		end

	start_condition: INTEGER
			-- Start condition
		deferred
		end

feature -- Measurement

	text_count: INTEGER
			-- Number of characters in last token read
		deferred
		ensure
			positive_count: Result >= 0
		end

	line: INTEGER
			-- Line number of last token read when
			-- '%option line' has been specified
		deferred
		ensure
			line_positive: Result >= 1
		end

	column: INTEGER
			-- Column number of last token read when
			-- '%option line' has been specified
		deferred
		ensure
			column_positive: Result >= 1
		end

	position: INTEGER
			-- Position of last token read (i.e. number of
			-- characters from the start of the input source)
			-- when '%option position' has been specified
		deferred
		ensure
			position_positive: Result >= 1
		end

feature -- Status report

	end_of_file: BOOLEAN
			-- Has the end of input buffer been reached?
			-- This means that `last_token' has been set
			-- to 0 indicating "all done".
		do
			Result := (last_token = yyEOF_token)
		end

	scanning_error: BOOLEAN
			-- Has an error occurred during scanning?
			-- This can occur when too many `reject' are called (and hence
			-- nothing can be matched anymore) or when the option "nodefault"
			-- (or option -s) has been specified but the default rule is
			-- matched nevertheless.
		do
			Result := (last_token = yyError_token)
		end

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		deferred
		end

feature -- Setting

	set_last_token (a_token: INTEGER)
			-- Set `last_token' to `a_token'.
		do
			last_token := a_token
		ensure
			last_token_set: last_token = a_token
		end

	set_start_condition (a_start_condition: INTEGER)
			-- Set `start_condition' to `a_start_condition'.
		require
			valid_start_condition: valid_start_condition (a_start_condition)
		deferred
		ensure
			start_condition_set: start_condition = a_start_condition
		end

feature -- Scanning

	scan
			-- Scan `input_buffer' until end of file is found
			-- or an error occurs.
		do
			from
				read_token
			until
				last_token <= 0
			loop
				read_token
			end
		ensure
			end_of_file: not scanning_error implies end_of_file
		end

	read_token
			-- Read a token from `input_buffer'.
			-- Make result available in `last_token'.
		deferred
		end

feature -- Element change

	append_text_to_string (a_string: STRING)
			-- Append `text' at end of `a_string'.
			-- (For efficiency reason, this feature can bypass the
			-- call to `text' and directly copy the characters from
			-- the input buffer.)
		require
			a_string_not_void: a_string /= Void
		do
			a_string.append_string (text)
		ensure
			count_set: a_string.count = old (a_string.count) + text_count
		end

	append_text_substring_to_string (s, e: INTEGER; a_string: STRING)
			-- Append `text_substring' at end of `a_string'.
			-- (For efficiency reason, this feature can bypass
			-- the call to `text_substring' and directly copy
			-- the characters from the input buffer.)
		require
			a_string_not_void: a_string /= Void
			s_large_enough: 1 <= s
			valid_interval: s <= e + 1
			e_small_enough: e <= text_count
		do
			a_string.append_string (text_substring (s, e))
		ensure
			count_set: a_string.count = old (a_string.count) + (e - s + 1)
		end

	terminate
			-- Terminate scanner and set `last_token'
			-- to 0 indicating "all done".
		do
			last_token := yyEOF_token
		end

	wrap: BOOLEAN
			-- Should current scanner terminate when end of file is reached?
			-- This function can be redefined to switch to another input
			-- buffer (but don't forget to update `start_condition').
			-- (default: True.)
		do
			Result := True
		end

	more
			-- Tell scanner to append the next matched token
			-- to current value of `text' instead of
			-- replacing it.
		deferred
		end

	less (n: INTEGER)
			-- Return all but the first `n' matched
			-- characters back to `input_buffer'.
		require
			n_large_enough: n >= 0
			n_small_enough: n <= text_count
		deferred
		ensure
			text_count_set: text_count = n
		end

	unread_character (c: CHARACTER)
			-- Put `c' back to `input_buffer'. This will alter both
			-- `text' and the content of `input_buffer'.
		deferred
		end

	read_character
			-- Read a character from `input_buffer'.
			-- Make result available in `last_character'.
		deferred
		end

	last_character: CHARACTER
			-- Last character read by `read_character'

feature -- Input

	input_buffer: YY_BUFFER
			-- Input buffer

	set_input_buffer (a_buffer: like input_buffer)
			-- Set `input_buffer' to `a_buffer'.
		require
			a_buffer_not_void: a_buffer /= Void
		do
			input_buffer := a_buffer
		ensure
			input_buffer_set: input_buffer = a_buffer
		end

	flush_input_buffer
			-- Flush `input_buffer'. `input_buffer' will be automatically
			-- refilled unless end of file has been found.
		do
			input_buffer.flush
		ensure
			flushed: input_buffer.count = 0
		end

	new_file_buffer (a_file: KI_CHARACTER_INPUT_STREAM): YY_FILE_BUFFER
			-- New input buffer for `a_file'
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			create Result.make (a_file)
		ensure
			new_buffer_not_void: Result /= Void
		end

	new_string_buffer (a_string: STRING): YY_BUFFER
			-- New input buffer for `a_string'
		require
			a_string_not_void: a_string /= Void
		do
			create Result.make (a_string)
		ensure
			new_buffer_not_void: Result /= Void
		end

	Empty_buffer: YY_BUFFER
			-- Empty input buffer
		once
			create Result.make ("")
		ensure
			empty_buffer_not_void: Result /= Void
		end

feature -- Output

	output (a_text: like text)
			-- Output `a_text'.
			-- (Note: this routine can be redefined in descendant
			-- classes. Default: print `a_text' to standard output.)
		require
			a_text_not_void: a_text /= Void
		do
			std.output.put_string (a_text)
		end

	echo
			-- Output `text' using feature `output'.
		do
			output (text)
		end

feature -- Action

	pre_action
			-- Action executed before every semantic action
			-- when '%option pre-action' has been specified.
			-- (Note: this routine can be redefined in descendant
			-- classes. Default: do nothing.)
		do
		end

	post_action
			-- Action executed after every semantic action
			-- when '%option post-action' has been specified.
			-- (Note: this routine can be redefined in descendant
			-- classes. Default: do nothing.)
		do
		end

	pre_eof_action
			-- Action executed before every end-of-file semantic action
			-- (i.e. <<EOF>>) when '%option pre-eof-action' has been specified.
			-- (Note: this routine can be redefined in descendant classes.
			-- Default: do nothing.)
		do
		end

	post_eof_action
			-- Action executed after every end-of-file semantic action
			-- (i.e. <<EOF>>) when '%option post-eof-action' has been specified.
			-- (Note: this routine can be redefined in descendant classes.
			-- Default: do nothing.)
		do
		end

	default_action
			-- Action executed when default rule is matched.
			-- (Note: this routine can be redefined in descendant classes.
			-- Default: print last character read to standard output.)
		do
			echo
		end

feature -- Error handling

	fatal_error (a_message: STRING)
			-- A fatal error occurred.
			-- Print `a_message'.
		require
			a_message_not_void: a_message /= Void
		do
			std.error.put_string (a_message)
			std.error.put_character ('%N')
		end

feature -- Debugging

	print_last_token
			-- Print to standard error debug information
			-- about the last token read. Can be redefined
			-- in descendant classes to print more information.
			-- (Called at the end of `read_token' when compiled
			-- with 'debug ("GELEX")' enabled).
		deferred
		end

feature {NONE} -- Constants

	yyEOF_token: INTEGER = 0
			-- Predefined EOF token code

	yyError_token: INTEGER = -1
			-- Predefined Error token code

	yyUnknown_token: INTEGER = -2
			-- Predefined Unknown token code

invariant

	input_buffer_not_void: input_buffer /= Void
	valid_start_condition: valid_start_condition (start_condition)

end
