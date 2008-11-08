indexing
	description: "[
		Outputstream filter that transparently indents lines
	]"
	copyright: "Copyright (c) 2007, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class
	TEST_INDENTING_SOURCE_WRITER

inherit

	KI_TEXT_OUTPUT_STREAM
		redefine
			is_open_write,
			is_closable,
			eol,
			name,
			put_character,
			put_new_line,
			put_string,
			flush,
			close
		end

	KL_SHARED_STREAMS
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (a_output_stream: like output_stream) is
			-- Create a new filter, using `a_output_stream' as output stream.
		require
			a_output_stream_not_void: a_output_stream /= Void
		do
			output_stream := a_output_stream
		ensure
			output_stream_set: output_stream = a_output_stream
			indent_level_initialized: indentation = 0
		end

feature -- Status report

	is_open_write: BOOLEAN is
			-- Can items be written to output stream?
		do
			Result := output_stream.is_open_write
		end

	is_closable: BOOLEAN is
			-- Can current output stream be closed?
		do
			Result := output_stream.is_closable
		end

feature -- Access

	output_stream: KI_TEXT_OUTPUT_STREAM
			-- Output output stream

	indentation: INTEGER
			-- Level by which lines should be currently indented

	eol: STRING is
			-- Line separator
		do
			Result := output_stream.eol
		end

	name: STRING is
			-- Name of output stream
		do
			Result := output_stream.name
		end

feature -- Level Change

	indent is
			-- Increase level of indentation.
		do
			indentation := indentation + 1
		ensure
			indent_level_increased: indentation = old indentation + 1
		end

	dedent is
			-- Decrease level of indentation.
		require
			indent_level_big_enough: indentation > 0
		do
			indentation := indentation - 1
		ensure
			indent_level_decreased: indentation = old indentation - 1
		end

feature -- Output

	put_character (v: CHARACTER) is
			-- Write `v' to output stream.
		do
			if not indentation_printed then
				print_indentation
			end
			output_stream.put_character (v)
		end

	put_new_line is
			-- Write a line separator to output stream.
		do
			Precursor
			indentation_printed := False
		end

	put_string (a_string: STRING) is
			-- Write `a_string' to output stream.
		do
			if not indentation_printed then
				print_indentation
			end
			output_stream.put_string (a_string)
		end

feature -- Basic operations

	flush is
			-- Flush buffered data to disk.
		do
			output_stream.flush
		end

	close is
			-- Try to close output stream if it is closable. Set
			-- `is_open_write' to false if operation was successful.
		do
			output_stream.close
		end

feature -- Setting

	set_output_stream (a_output_stream: like output_stream) is
			-- Set `output_stream' to `a_output_stream'.
		require
			a_output_stream_not_void: a_output_stream /= Void
			a_output_stream_is_open_write: a_output_stream.is_open_write
		do
			output_stream := a_output_stream
		ensure
			output_stream_set: output_stream = a_output_stream
		end

	set_null_output_stream is
			-- Set `output_stream' to `null_output_stream'.
		do
			output_stream := null_output_stream
		ensure
			output_stream_set: output_stream = null_output_stream
		end

feature {NONE} -- Implementation

	print_indentation is
			-- Print currentl level of indentation to `output_stream'.
		require
			not_printed: not indentation_printed
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > indentation
			loop
				output_stream.put_character ('%T')
				i := i + 1
			end
			indentation_printed := True
		ensure
			printed: indentation_printed
		end

	indentation_printed: BOOLEAN
			-- Was indentation already printed for this line?

invariant

	indent_level_not_negative: indentation >= 0
	output_stream_not_void: output_stream /= Void

end
