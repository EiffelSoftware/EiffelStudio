note
	description : "[
			XML parser

			It does not perform any strict verification, and does not handle the encoding.
			This is really a simple xml parser which might answer basic XML parsing.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Extensible Markup Language (XML) 1.0", "protocol=URI", "src=http://www.w3.org/TR/xml/"

deferred class
	XML_PARSER

inherit
	XML_CALLBACKS_SOURCE

feature -- Parsing

	parse_from_stream (a_stream: XML_INPUT_STREAM)
			-- Parse stream `a_stream'
		require
			a_stream_attached: a_stream /= Void
		deferred
		end

	parse_from_string (a_string: READABLE_STRING_GENERAL)
			-- Parse string general `a_string'
		require
			a_string_attached: a_string /= Void
		do
			if attached {READABLE_STRING_8} a_string as s8 then
				parse_from_string_8 (s8)
			elseif attached {READABLE_STRING_32} a_string as s32 then
				parse_from_string_32 (s32)
			else
				check is_string_32: a_string.is_string_32 end
				parse_from_string_32 (a_string.to_string_32)
			end
		end

	parse_from_string_8 (a_string: READABLE_STRING_8)
			-- Parse string_8 `a_string'
		require
			a_string_attached: a_string /= Void
		deferred
		end

	parse_from_string_32 (a_string: READABLE_STRING_32)
			-- Parse string_32 `a_string'
		require
			a_string_attached: a_string /= Void
		deferred
		end

	parse_from_file (a_file: FILE)
			-- Parse from file `a_file'
		require
			a_file_attached: a_file /= Void
			a_file_is_readable: a_file.is_open_read and then a_file.is_readable
		deferred
		end

	parse_from_path (a_path: PATH)
			-- Parse from file named `a_path'
		require
			a_path_valid: a_path /= Void and then not a_path.is_empty
		deferred
		end

	parse_from_filename (a_filename: READABLE_STRING_GENERAL)
			-- Parse from file named `a_filename'
		obsolete "Use parse_from_path [2017-05-31]"
		require
			a_filename_valid: a_filename /= Void and then not a_filename.is_empty
		local
			p: PATH
		do
			create p.make_from_string (a_filename)
			parse_from_path (p)
		end

feature -- Status

	is_correct: BOOLEAN
			-- Has no error been detected?
		do
			Result := not error_occurred
		end

	truncation_reported: BOOLEAN
			-- Is parsed xml content truncation reported?
			-- is meaningful only when no error was detected.
		deferred
		end

	error_occurred: BOOLEAN
			-- Error occurred?
		deferred
		end

	last_error: INTEGER
			-- Last error's code
			-- See {XML_ERROR_CODES}.
		do
			if error_occurred then
				Result := {XML_ERROR_CODES}.Xml_err_unknown
			else
				Result := {XML_ERROR_CODES}.Xml_err_none
			end
		end

feature -- Access

	frozen last_error_description: detachable STRING_32
			-- Last error message
		do
			Result := error_message
		end

	error_message: detachable STRING_32
			-- Error message
		deferred
		ensure
			result_attached_implies_error: Result /= Void implies error_occurred
		end

	error_position: detachable XML_POSITION
			-- Position when error occurred
		deferred
		ensure
			result_attached_if_error: error_occurred implies Result /= Void
		end

	position: XML_POSITION
			-- Current position in the XML entity being parsed.
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Element change

	set_encoding (a_encoding: READABLE_STRING_GENERAL)
			-- Set encoding to `a_encoding'.
		require
			a_encoding_not_empty: a_encoding /= Void and then (not a_encoding.is_empty and a_encoding.is_valid_as_string_8)
		deferred
		end

feature {XML_CALLBACKS} -- Error

	report_error_from_callback (a_msg: READABLE_STRING_GENERAL)
			-- Report error from callbacks
		deferred
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
