note
	description : "[
			Simple XML parser

			It does not perform any strict verification, and does not handle the encoding.
			This is really a simple xml parser which might answer basic XML parsing.
		]"
	date: "$Date$"
	revision: "$Revision$"

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
			a_file_is_readable: a_file.is_open_read and then a_file.is_readable
		deferred
		end

	parse_from_filename (a_filename: READABLE_STRING_GENERAL)
			-- Parse from file named `a_filename'
		require
			a_filename_valid: a_filename /= Void and then not a_filename.is_empty
		deferred
		end

feature -- Status

	is_correct: BOOLEAN
			-- Has no error been detected?
		do
			Result := not error_occurred
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

feature -- Settings

	string_8_compatibility_enabled: BOOLEAN
			-- Is string_8_callbacks enabled?
			-- i.e: instance of STRING_8 are passed to callbacks instead of STRING_32
		deferred
		end

	enable_string_8_compatibility
			-- Enable `string_8_callbacks'
		require
			string_8_compatibility_disabled: not string_8_compatibility_enabled
		deferred
		ensure
			string_8_compatibility_set: string_8_compatibility_enabled
		end

	disable_string_8_compatibility
			-- Disable `string_8_callbacks'
		require
			string_8_compatibility_enabled: string_8_compatibility_enabled
		deferred
		ensure
			string_8_compatibility_disabled: not string_8_compatibility_enabled
		end

feature -- Access

	frozen last_error_description: detachable STRING_8
			-- Last error message
		do
			Result := error_message
		end

	error_message: detachable STRING_8
			-- Error message
		do
			if attached error_message_32 as err then
				Result := err.as_string_8
			end
		ensure
			result_attached_implies_error: Result /= Void implies error_occurred
		end

	frozen last_error_description_32: detachable STRING_32
			-- Last error message
		do
			Result := error_message_32
		end

	error_message_32: detachable STRING_32
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

feature {XML_CALLBACKS} -- Error

	report_error_from_callback (a_msg: READABLE_STRING_GENERAL)
			-- Report error from callbacks
		deferred
		end

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
