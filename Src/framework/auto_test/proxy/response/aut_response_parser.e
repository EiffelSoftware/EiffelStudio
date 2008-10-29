indexing
	description:

		"Abstract parser for interpreter responses"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class AUT_RESPONSE_PARSER

inherit

	ERL_G_TYPE_ROUTINES

	KL_SHARED_OPERATING_SYSTEM
		export {NONE} all end

	EXCEP_CONST
		export {NONE} all end

	AUT_SHARED_INTERPRETER_INFO

feature {NONE} -- Initialization

	make (a_system: like system) is
			-- Create new parser for interpreter responses.
		require
			a_system_not_void: a_system /= Void
		do
			system := a_system
		ensure
			system_set: system = a_system
		end

feature -- Access

	system: SYSTEM_I
			-- System

	last_response: AUT_RESPONSE
			-- Last response parsed

feature -- Status report

	is_bad_socket_response (a_response: TUPLE [a_output: STRING; a_error: STRING]): BOOLEAN is
			-- Is `a_response' retrieved from socket bad?
		do

		end

feature -- Parsing

	parse_start_response is
			-- Parse the response issued by the interpreter after it has been
			-- started.
		deferred
		ensure
			last_response_not_void: last_response /= Void
		end

	parse_stop_response is
			-- Parse the response issued by the interpreter after it received a stop request.
		deferred
		ensure
			last_response_not_void: last_response /= Void
		end

	parse_invoke_response is
			-- Parse the response issued by the interpreter after a
			-- create-object/create-object-default/invoke-feature/invoke-and-assign-feature
			-- request has been sent.
		deferred
		ensure
			last_response_not_void: last_response /= Void
		end

	parse_assign_expression_response  is
			-- Parse response issued by interpreter after receiving an
			-- assign-expresion request.
		deferred
		ensure
			last_response_not_void: last_response /= Void
		end

	parse_type_of_variable_response is
			-- Parse response issued by interpreter after receiving a
			-- retrieve-type-of-variable request.
		deferred
		ensure
			last_response_not_void: last_response /= Void
		end

	parse_empty_response is
			-- Parse a response consisting of no characters.
		deferred
		end

	retrieve_response is
			-- Retrieve response from the interpreter,
			-- store it in `last_raw_response'.
		deferred
		end

	last_raw_response: AUT_RAW_RESPONSE
			-- Raw response retrieved by `retrieve_response'.

	raw_response_analyzer: AUT_RAW_RESPONSE_ANALYZER
			-- Raw response analyzer.

	parse_response is
			-- Parse response from interpreter, store it in `last_response'.
		do
			retrieve_response
			raw_response_analyzer.set_raw_response (last_raw_response)
			last_response := raw_response_analyzer.response
		ensure
			last_response_attached: last_response /= Void
		end

end
