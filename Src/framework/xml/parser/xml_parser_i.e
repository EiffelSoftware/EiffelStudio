note
	description : "[
			Simple XML parser

			It does not perform any strict verification, and does not handle the encoding.
			This is really a simple xml parser which might answer basic XML parsing.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_PARSER_I

inherit
	XML_CALLBACKS_SOURCE

feature -- Parsing

	parse_from_stream (a_stream: XML_INPUT_STREAM)
			-- Parse stream `a_stream'
		require
			a_stream_attached: a_stream /= Void
		deferred
		end

	parse_from_string (a_string: STRING)
			-- Parse string `a_string'
		require
			a_string_attached: a_string /= Void
		deferred
		end

	parse_from_file (a_file: FILE)
			-- Parse from file `a_file'
		require
			a_file_attached: a_file /= Void
			a_file_readable: a_file.is_open_read and then a_file.readable
		deferred
		end

feature -- Status

	error_occurred: BOOLEAN
			-- Error occurred?
		deferred
		end

feature -- Access

	error_position: XML_POSITION
			-- Position when error occurred
		deferred
		ensure
			result_attached: Result /= Void
		end

	position: XML_POSITION
			-- Current position in the XML entity being parsed.
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True 

end
