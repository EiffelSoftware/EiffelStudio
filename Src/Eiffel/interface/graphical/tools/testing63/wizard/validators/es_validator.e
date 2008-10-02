indexing
	description: "[
		Validator that is able to define a error message.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_VALIDATOR

inherit
	ES_SHARED_LOCALE_FORMATTER

feature -- Access

	last_error_message: ?STRING_32
			-- Error message of last validation if any

feature -- Status report

	is_valid: BOOLEAN
			-- Did last validation succeed?
		do
			Result := last_error_message = Void
		ensure
			not_result_implies_error_message: not Result implies last_error_message /= Void
		end

feature {NONE} -- Status setting

	set_error (a_message: !STRING)
			-- Set error message for current validation
			--
			-- `a_message': Error message
		do
			last_error_message := local_formatter.translation (a_message)
		ensure
			not_valid: not is_valid
		end

	set_formatted_error (a_message: !STRING; a_tokens: !TUPLE)
			-- Set error message for current validation and replace tokens
			--
			-- `a_message': Error message with tokens
			-- `token_values': Values with which tokens should be replaced.
		do
			last_error_message := local_formatter.formatted_translation (a_message, a_tokens)
		ensure
			not_valid: not is_valid
		end

	reset
			-- Remove any previous error message
		do
			last_error_message := Void
		ensure
			valid: is_valid
		end

end
