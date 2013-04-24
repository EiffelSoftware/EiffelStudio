note
	description:
		"Output facility switchable between in-memory string, file and standard output"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XML_OUTPUT

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	set_output_to_string,
	set_output_to_string_32,
	set_output_file,
	set_output_stream,
	set_output_standard,
	set_output_standard_error

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			set_output_to_string
		end

feature -- Initialization

	set_output_to_string
			-- Set output to new string.
		local
			s: STRING_8
		do
			create s.make_empty
			set_output_string (s)
		ensure
			last_output_empty: attached internal_last_output as o and then o.is_empty
		end

	set_output_to_string_32
			-- Set output to new string.
		local
			s: STRING_32
		do
			create s.make_empty
			set_output_string (s)
		ensure
			last_output_empty: attached internal_last_output as o and then o.is_empty
		end

	set_output_string (a_string: STRING_GENERAL)
			-- Initialize output to given string,
			-- the result must still be collected from
			-- last_output, which may be another string.
		require
			a_string_not_void: a_string /= Void
			is_string_8_or_32: attached {STRING_8} a_string or attached {STRING_32} a_string
		do
			internal_last_output := a_string
			if attached {STRING_32} a_string as s32 then
				create {XML_STRING_32_OUTPUT_STREAM} output_stream.make (s32)
			elseif attached {STRING_8} a_string as s8 then
				create {XML_STRING_8_OUTPUT_STREAM} output_stream.make (s8)
			else
				check is_string_8_or_32: False end
				create {XML_NULL_OUTPUT_STREAM} output_stream.make
				internal_last_output := Void
			end
		ensure
			last_output_set: internal_last_output = a_string
		end

	set_output_file (a_file: FILE)
			-- Initialize output to given file,
		require
			a_file_not_void: a_file /= Void
		do
			set_output_stream (create {XML_FILE_OUTPUT_STREAM}.make (a_file))
			internal_last_output := Void
		end

	set_output_stream (a_stream: like output_stream)
			-- Set output to stream.
		require
			a_stream_not_void: a_stream /= Void
		do
			output_stream := a_stream
			internal_last_output := Void
		end

	set_output_standard
			-- Set output to standard output (Default).
		do
			create {XML_FILE_OUTPUT_STREAM} output_stream.make (io.output)
			internal_last_output := Void
		end

	set_output_standard_error
			-- Set output to standard error.
		do
			create {XML_FILE_OUTPUT_STREAM} output_stream.make (io.error)
			internal_last_output := Void
		end


feature -- Status report

	has_last_output: BOOLEAN
			-- Has last output?
		do
			Result := internal_last_output /= Void
		end

	last_output_is_valid_as_string_8: BOOLEAN
			-- Is associated last output a valid string_8 value?
		do
			Result := attached internal_last_output as o and then o.is_valid_as_string_8
		end

feature -- Access

	last_output: detachable STRING
		require
			last_output_is_valid_as_string_8: last_output_is_valid_as_string_8
		do
			if attached internal_last_output as o then
				Result := o.to_string_8 -- last_output_is_valid_as_string_8
			end
		end

	last_output_32: detachable STRING_32
		do
			if attached internal_last_output as o then
				Result := o.to_string_32
			end
		end

feature -- Basic operation

	flush
			-- Flush `output_stream'.
		do
			if attached output_stream as s and then s.is_open_write then
				s.flush
			end
		end

feature {NONE} -- Implementation

	internal_last_output: detachable STRING_GENERAL
			-- Last output;
			-- May be void if standard output or stream is used.

	output_stream: XML_OUTPUT_STREAM

feature -- Output, interface to descendants

	output (a_string: READABLE_STRING_GENERAL)
			-- Output string 8 value.
			-- All output from descendants should go through this for
			-- convenient redefinition.
		require
			a_string_not_void: a_string /= Void
		do
			output_stream.put_string_general (a_string)
		end

invariant
	output_stream_attached: output_stream /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
