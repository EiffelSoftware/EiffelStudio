note
	description:
		"Output facility switchable between in-memory string and standard output"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XML_OUTPUT

inherit
	ANY

feature -- Output

	set_output_to_string
			-- Set output to new string.
		do
			create last_output.make_empty
			output_stream := Void
		ensure
			last_output_not_void: attached last_output as o
			last_output_empty: o.count = 0
		end

	set_output_string (a_string: attached like last_output)
			-- Initialize output to given string,
			-- the result must still be collected from
			-- last_output, which may be another string.
		require
			a_string_not_void: a_string /= Void
		do
			last_output := a_string.twin
			output_stream := Void
		end

	set_output_file (a_file: FILE)
			-- Initialize output to given file,
		require
			a_file_not_void: a_file /= Void
		do
			set_output_stream (create {XML_FILE_OUTPUT_STREAM}.make (a_file))
		end

	set_output_stream (a_stream: like output_stream)
			-- Set output to stream.
		require
			a_stream_not_void: a_stream /= Void
		do
			output_stream := a_stream
			last_output := Void
		end

	set_output_standard
			-- Set output to standard output (Default).
		do
			create {XML_FILE_OUTPUT_STREAM} output_stream.make (io.output)
			last_output := Void
		end

	set_output_standard_error
			-- Set output to standard error.
		do
			create {XML_FILE_OUTPUT_STREAM} output_stream.make (io.error)
			last_output := Void
		end

	last_output: detachable STRING
			-- Last output;
			-- May be void if standard output or stream is used.

	flush
			-- Flush `output_stream'.
		do
			if attached output_stream as s and then s.is_open_write then
				s.flush
			end
		end

feature {NONE} -- Output stream

	output_stream: detachable XML_OUTPUT_STREAM

feature -- Output, interface to descendants

	output (a_string: STRING)
			-- Output string.
			-- All output from descendants should go through this for
			-- convenient redefinition.
		require
			a_string_not_void: a_string /= Void
		local
			s: like output_stream
		do
			if attached last_output as o then
				o.append (a_string)
			else
				s := output_stream
				if s = Void then
					set_output_standard
					check out_stream_selected: s /= Void end
				end
				if s /= Void then
					s.put_string (a_string)
				else
					--| no output_stream then no effect
				end
			end
			check one_set: output_stream /= Void or last_output /= Void end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
