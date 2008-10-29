indexing
	description:

		"Abstract ancestor to all well formed responses received from the interpreter"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_NORMAL_RESPONSE

inherit

	AUT_RESPONSE
		rename
			make as make_response
		redefine
			is_exception
		end

create

	make,
	make_exception

feature {NONE} -- Initialization

	make (a_response_text: like raw_text) is
			-- Create new response.
		require
			a_response_text_not_void: a_response_text /= Void
		do
			make_response (a_response_text)
		ensure
			response_text_set: raw_text = a_response_text
			exception_void: exception = Void
		end

	make_exception (a_response_text: like raw_text; an_exception: like exception) is
			-- Create new response where an exception was raised.
		require
			a_response_text_not_void: a_response_text /= Void
			an_exception_not_void: an_exception /= Void
		do
			raw_text := a_response_text
			exception := an_exception
		ensure
			response_text_set: raw_text = a_response_text
			exception_set: exception = an_exception
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
			Result := False
		ensure then
			definition: not Result
		end

	is_exception: BOOLEAN is
			-- Does response contain an exception from testee feature?
		do
			Result := exception /= Void
		ensure then
			good_result: Result = (exception /= Void)
		end

	has_exception: BOOLEAN is
			-- Does `Current' contain an exception from testee?
		do
			Result := exception /= Void
		ensure
			good_result: Result = (exception /= Void)
		end

feature -- Access

	exception: AUT_EXCEPTION
			-- Exception raised during request execution (if any)

feature -- Process

	process (a_visitor: AUT_RESPONSE_VISITOR) is
			-- Process `Current' using `a_visitor'.
		do
			a_visitor.process_normal_response (Current)
		end

end
