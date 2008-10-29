indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_ERROR_RESPONSE

inherit

	AUT_RESPONSE
		rename
			make as make_response
		end

create

	make

feature {NONE} -- Initialization

	make (a_response_text: like raw_text) is
			-- Create new response.
		require
			a_response_text_not_void: a_response_text /= Void
		do
			make_response (a_response_text)
		ensure
			response_text_set: raw_text = a_response_text
		end

feature -- Status report

	is_bad: BOOLEAN is
			-- Is response not well formed syntacticly?
		do
			Result := False
		ensure then
			definition: not Result
		end

	is_error: BOOLEAN is
			-- Is response an error message?
		do
			Result := True
		ensure then
			definition: Result
		end

feature -- Process

	process (a_visitor: AUT_RESPONSE_VISITOR) is
			-- Process `Current' using `a_visitor'.
		do
			a_visitor.process_error_response (Current)
		end

end
