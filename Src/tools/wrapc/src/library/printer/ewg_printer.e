note

	description:

		"Abstract printer"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_PRINTER

create
	make,
	make_string

feature {NONE} -- Initialization

	make (an_output_stream: like output_stream)
			-- Create new printer with `a_output_stream' as output stream.
		require
			an_output_stream_not_void: an_output_stream /= Void
		do
			output_stream := an_output_stream
			make_internal
		ensure
			output_stream_set: output_stream = an_output_stream
		end

	make_string (an_output_string: STRING)
			-- Create new printer which appends to `an_output_string'.
		require
			an_output_string_not_void: an_output_string /= Void
		do
			create {KL_STRING_OUTPUT_STREAM} output_stream.make (an_output_string)
			make_internal
		end

	make_internal
			-- Redefine this routine in descendants if needed.
		do
		end

feature -- Setting

	set_output_stream (an_output_stream: like output_stream)
			-- Make `an_output_stream' the new `output_stream'.
		require
			an_output_stream_not_void: an_output_stream /= Void
		do
			output_stream := an_output_stream
		ensure
			output_stream_set: output_stream = an_output_stream
		end

	set_string (an_output_string: STRING)
			-- Make this printer append its output to `an_output_string'.
		require
			an_output_string_not_void: an_output_string /= Void
		do
			create {KL_STRING_OUTPUT_STREAM} output_stream.make (an_output_string)
		end

feature -- Status

	output_stream: KI_TEXT_OUTPUT_STREAM
			-- Output stream of this printer

invariant

	output_stream_not_void: output_stream /= Void

end
