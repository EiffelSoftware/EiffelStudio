indexing
	description:

		"Abstract ancestor to all responses received from the interpreter"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class AUT_RESPONSE

feature {NONE} -- Initialization

	make (a_response_text: like raw_text) is
			-- Create new response.
		require
			a_response_text_not_void: a_response_text /= Void
		do
			raw_text := a_response_text
		ensure
			text_set: raw_text = a_response_text
		end

feature -- Status report

	is_bad: BOOLEAN is
			-- Is response not well formed syntacticly?
		deferred
		end

	is_error: BOOLEAN is
			-- Is response an error message?
		deferred
		end

	is_normal: BOOLEAN is
			-- Is response a normal response?
		do
			Result := not is_bad and not is_error
		ensure
			definition: Result = (not is_bad and not is_error)
		end

	is_exception: BOOLEAN is
			-- Does response contain an exception from testee feature?
		do
		end

feature -- Access

	text: STRING is
			-- Response as received in unparsed form
		do
			Result := raw_text
		ensure
			result_attached: Result /= Void
		end

feature -- Process

	process (a_visitor: AUT_RESPONSE_VISITOR) is
			-- Process `Current' using `a_visitor'.
		require
			a_visitor_attached: a_visitor /= Void
		deferred
		end

feature{NONE} -- Implementation

		raw_text: STRING
				-- Text associated with Current response

invariant
	raw_text_attached: raw_text /= Void

end
