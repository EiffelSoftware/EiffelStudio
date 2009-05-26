note
	description: "[
		{XWA_REGEXP_VALIDATOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_REGEXP_VALIDATOR

inherit
	XWA_VALIDATOR

feature -- Intialization

	make
			--
		do
			create regexp.make
			regexp.compile (regular_expression)
		ensure
			regexp_attached: attached regexp
			regexp_compiled: attached regexp.is_compiled
		end

feature {NONE} -- Access

	regexp: RX_PCRE_MATCHER
			-- The compiled regular expression

feature -- Implementation

	validate (a_argument: STRING): BOOLEAN
			-- Validates if `a_argument' is valid
		do
			Result := regexp.matches (a_argument)
		end

	regular_expression: STRING
			-- The regular expression that should be used for the validation
		deferred
		ensure
			result_attached: attached Result
		end

end
