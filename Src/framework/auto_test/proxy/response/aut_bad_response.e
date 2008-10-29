indexing
	description:

		"Abstract ancestor to all ill-formed responses received from the interpreter"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_BAD_RESPONSE

inherit

	AUT_RESPONSE

create

	make

feature -- Status report

	is_bad: BOOLEAN is
			-- Is response not well formed syntacticly?
		do
			Result := True
		ensure then
			definition: Result
		end

	is_error: BOOLEAN is
			-- Is response an error message?
		do
			Result := False
		ensure then
			definition: not Result
		end

feature -- Process

	process (a_visitor: AUT_RESPONSE_VISITOR) is
			-- Process `Current' using `a_visitor'.
		do
			a_visitor.process_bad_response (Current)
		end

end
