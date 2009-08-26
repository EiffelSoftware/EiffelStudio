note
	description: "[
		The deferred class which defines the API of all the PEG parsers.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PEG_ABSTRACT_PEG

feature {PEG_ABSTRACT_PEG} -- Behaviours

	behaviour: detachable FUNCTION [ANY, TUPLE [PEG_PARSER_RESULT], PEG_PARSER_RESULT]
			-- Optional behaviour which transforms a result of the children to a new one

	error_strategy: detachable FUNCTION [ANY, TUPLE [PEG_PARSER_RESULT], PEG_PARSER_RESULT]
			-- Optional error strategy which tries to handle failures of a parser

feature {PEG_ABSTRACT_PEG} -- Access

	fixated: BOOLEAN
			-- Is the parser fixed, that is, are sequences and choices always newly created?

	parser_name: detachable READABLE_STRING_8
			-- The optional name for the parser

	error_message_handler: detachable PROCEDURE [ANY, TUPLE [PEG_PARSER_RESULT]] assign set_error_message_handler
			-- If parsing is unsucessful, what should the parser do?
			-- Detachable!

	ommit: BOOLEAN
			-- Should the behaviour be executed?

feature -- Access

	set_error_message_handler (a_error_message_handler: PROCEDURE [ANY, TUPLE [PEG_PARSER_RESULT]])
			-- Sets the error message
		require
			a_error_message_handler_attached: attached a_error_message_handler
		do
			error_message_handler := a_error_message_handler
		ensure
			error_message_handler_set: a_error_message_handler = error_message_handler
		end

	set_name (a_name: READABLE_STRING_8)
			-- `a_name': The name of the parser
			-- Sets the name of the parser.
		require
			a_name_attached: attached a_name
		do
			parser_name := a_name
		ensure
			name_set: parser_name = a_name
		end

	is_cached: BOOLEAN assign set_is_cached
			-- Is the result of this parser cached (True) or is it recomputed on every parse (False)

	set_is_cached (a_is_cached: BOOLEAN)
			-- Sets the is_cached feature
		do
			is_cached := a_is_cached
		ensure
			is_cached_set: is_cached = a_is_cached
		end

	set_behaviour (a_behaviour: FUNCTION [ANY, TUPLE [PEG_PARSER_RESULT], PEG_PARSER_RESULT])
			-- Sets the behaviour.
		require
			a_behaviour_attached: attached a_behaviour
		do
			behaviour := a_behaviour
		ensure
			behaviour_set: behaviour = a_behaviour
		end

	set_error_strategy (a_error_strategy: FUNCTION [ANY, TUPLE [PEG_PARSER_RESULT], PEG_PARSER_RESULT])
			-- Sets the error strategy
		require
			a_error_strategy_attached: attached a_error_strategy
		do
			error_strategy := a_error_strategy
		ensure
			error_strategy_set: error_strategy = a_error_strategy
		end

	ommit_result
			-- Ommit the addition of the character to the result list
		do
			ommit := True
		end

feature -- Basic Functionality

	parse_string (a_string: READABLE_STRING_8): PEG_PARSER_RESULT
			-- Automatically wraps the string and persues to parse with `parse'
		require
			a_string_attached: attached a_string
		do
			Result := parse (create {PEG_PARSER_STRING}.make_from_string (a_string))
		end

	parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- `a_string' the string that should be parsed
			-- Tries to parse a_string
		require
			a_string_attached: attached a_string
		do
			debug ("peg")
				if a_string.count > 0 then
					print (internal_debug_info + "##" + a_string [1].to_character_8.out + "##" + a_string.out)
				else
					print (internal_debug_info + "####" + a_string.out)
				end
			end
			Result := internal_parse (a_string)
			if not Result.success and attached error_message_handler as l_e_m_handler then
				l_e_m_handler.call ([Result])
			end
		ensure
			result_attached: attached Result
		end

	internal_debug_info: READABLE_STRING_8
			-- Returns an informal description of the parser (or the user defined name)
		do
			if attached parser_name as l_parser_name then
				Result := l_parser_name
			else
				Result := default_parse_info
			end
		ensure
			Result_attached: attached Result
		end

	default_parse_info: READABLE_STRING_8
			-- The default informal description of the parser
		deferred
		ensure
			Result_attached: attached Result
		end

	short_debug_info: READABLE_STRING_8
			-- The short informal description of the parser (without children)
		deferred
		ensure
			Result_attached: attached Result
		end

	internal_parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- `a_string' the string that should be parsed
			-- Tries to parse a_string
		require
			a_string_attached: attached a_string
		deferred
		ensure
			result_attached: attached Result
		end

	serialize: READABLE_STRING_8
			-- Serializes the parser recursively
		do
			Result := internal_serialize (create {ARRAYED_LIST [PEG_ABSTRACT_PEG]}.make (20))
		ensure
			result_attached: attached Result
		end

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): READABLE_STRING_8
			-- Serializes the parser recursively. Endless recursions are taken care of.
		deferred
		ensure
			result_attached: attached Result
		end

	already_serialized (a_already_visited: LIST [PEG_ABSTRACT_PEG]; a_parser: PEG_ABSTRACT_PEG): BOOLEAN
			-- Checks if the parser was already serialized. If not it adds it to the table
		do
			if a_already_visited.has (Current) then
				Result := True
			else
				a_already_visited.extend (a_parser)
				Result := False -- Just to be sure.
			end
		end

feature {PEG_ABSTRACT_PEG} -- Implementation

	build_result (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- `a_result': The results of the children
			-- If a behaviour is set the result is processed to a new one
		require
			a_result_attached: attached a_result
			a_result_successfull: a_result.success
		do
			Result := a_result
			if attached behaviour as l_behaviour then
				Result := l_behaviour.item ([a_result])
			end
		ensure
			result_attached: attached Result
		end

	fix_result (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- `a_result': The results of the children
			-- If a error strategy is set the result is processed to a new one
		require
			a_result_attached: attached a_result
			a_result_unsuccessfull: not a_result.success
		do
			Result := a_result
			if attached error_strategy as l_error_strategy then
				Result := l_error_strategy.item ([a_result])
			end
		ensure
			result_attached: attached Result
		end

feature -- Convenience

	add alias "+" (a_other: PEG_ABSTRACT_PEG): PEG_SEQUENCE
			-- `a_other': The parser to be added
			-- Convenience feature to add two pegs together in a sequence
		require
			a_other_attached: attached a_other
		do
			create Result.make
			Result := (Result + Current) + a_other
		ensure
			Result_attached: attached Result
		end

	add_with_whitespace alias "&+" (a_other: PEG_ABSTRACT_PEG): PEG_SEQUENCE
			-- `a_other': The parser to be added after the whitespaces
			-- Convience feature to add two pegs together in a sequence with an arbitrary number
			-- (at least 1) of whitespaces inbetween
		require
			a_other_attached: attached a_other
		local
			l_ws: PEG_WHITE_SPACE_CHARACTER
		do
			create Result.make
			create l_ws.make
			l_ws.ommit_result
			Result := (Result + Current + (+l_ws) + a_other)
		ensure
			Result_attached: attached Result
		end

	add_with_optional_whitespace alias "|+" (a_other: PEG_ABSTRACT_PEG): PEG_SEQUENCE
			-- `a_other': The parser to be added after the whitescaces
			-- Convience feature to add two pegs together in a sequence with an arbitrary number
			-- (zero or more) of whitespaces inbetween
		require
			a_other_attached: attached a_other
		local
			l_ws: PEG_WHITE_SPACE_CHARACTER
		do
			create Result.make
			create l_ws.make
			l_ws.ommit_result
			Result := (Result + Current + (-l_ws) + a_other)
		ensure
			Result_attached: attached Result
		end

	add_choice alias "|" (a_other: PEG_ABSTRACT_PEG): PEG_CHOICE
			-- `a_other': The parser to be added to the choice
			-- Convenience feature to build choice chains
			-- A new choice {PEG_CHOICE} is created and reused
			-- for every subsequent addition of a parser
		require
			a_other_attached: attached a_other
		do
			create Result.make
			Result := (Result | Current) | a_other
		ensure
			Result_attached: attached Result
		end

	add_zero_or_more alias "-": PEG_ABSTRACT_PEG
			-- Wraps `Current' into a zero or more parser
		do
			create {PEG_ZERO_OR_MORE} Result.make (Current)
		ensure
			Result_attached: attached Result
		end

	add_one_or_more alias "+": PEG_ABSTRACT_PEG
			-- Wraps `Current' into a one or more parser
		do
			create {PEG_ONE_OR_MORE} Result.make (Current)
		ensure
			Result_attached: attached Result
		end

	negate: PEG_NEGATE
			-- Returns Current negated, i.e. "!Current"
		do
			create Result.make (Current)
		ensure
			Result_attached: attached Result
		end

	enforce: PEG_ENFORCE
			-- Returns Current enforced, i.e. "&Current"
		do
			create Result.make (Current)
		ensure
			Result_attached: attached Result
		end

	optional: PEG_OPTIONAL
			-- Returns Current as optional parser, i.e. "Current?"
		do
			create Result.make (Current)
		ensure
			Result_attached: attached Result
		end

	fixate
			-- Forces the parser to generate new sequences and choice parsers if built
			-- with + (|+, |&) or | respectively
		do
			fixated := True
		ensure
			fixated: fixated
		end

	consumer: PEG_CONSUMER
			-- Transforms Current into a consumer parser
		do
			create Result.make (Current)
		ensure
			Result_attached: attached Result
		end

end
