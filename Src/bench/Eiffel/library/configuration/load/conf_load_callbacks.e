indexing
	description: "The callbacks that react on the xml parsing."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD_CALLBACKS

inherit
	XM_CALLBACKS_NULL
		redefine
			on_error
		end

	CONF_FILE_CONSTANTS



feature -- Status

	is_error: BOOLEAN
			-- Was there an error during the parsing.

	last_error: CONF_ERROR_PARSE
			-- The last error message from the parser.

feature -- Callbacks

	on_error (a_message: STRING) is
			-- Event producer detected an error.
		do
			set_parse_error_message (a_message)
		end

feature {NONE} -- Implementation

	check_uuid (a_value: STRING): BOOLEAN is
			-- Check that `a_value' is a valid uuid.
		require
			a_value_not_void: a_value /= Void
		local
			l_regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			if not a_value.is_empty then
				create l_regexp.make
				l_regexp.compile ("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
				l_regexp.match (a_value)
				if l_regexp.has_matched then
					Result := True
				else
					set_error (create {CONF_ERROR_UUID})
				end
			else
				set_error (create {CONF_ERROR_UUID})
			end
		ensure
			No_error_implies_Result: not is_error implies Result
		end

	check_version (a_value: STRING) is
			-- Check that `a_value' is the correct version.
		do
			if a_value = Void or else not a_value.is_equal (namespace) then
				set_error (create {CONF_ERROR_VERSION})
			end
		end


	set_error (an_error: CONF_ERROR_PARSE) is
			-- Set `an_error'.
		require
			an_error_ok: an_error /= Void
		do
			is_error := True
			last_error := an_error
		end

	set_parse_error_message (a_message: STRING) is
			-- We have a parse error with a message.
		local
			l_error: CONF_ERROR_PARSE
		do
			create l_error
			l_error.set_message (a_message)
			is_error := True
			last_error := l_error
		end

end
