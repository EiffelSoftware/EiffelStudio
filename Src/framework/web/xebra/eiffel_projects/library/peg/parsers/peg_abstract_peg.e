note
	description: "Summary description for {PARSING_EXPRESSION_GRAMMAR}."
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PEG_ABSTRACT_PEG

inherit
	XU_SHARED_OUTPUTTER

feature {PEG_ABSTRACT_PEG} -- Behaviours

	behaviour: FUNCTION [ANY, TUPLE [PEG_PARSER_RESULT], PEG_PARSER_RESULT]
			-- Optional behaviour which transforms a result of the children to a new one

	error_strategy: FUNCTION [ANY, TUPLE [PEG_PARSER_RESULT], PEG_PARSER_RESULT]
			-- Optional error strategy which tries to handle failures of a parser

feature {PEG_ABSTRACT_PEG} -- Access

	fixated: BOOLEAN
			-- Is the parser fixed, that is, are sequences and choices always newly created?

	parser_name: STRING
			-- The optional name for the parser

feature -- Access

	set_name (a_name: STRING)
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

	ommit: BOOLEAN
			-- Should the behaviour be executed?

	ommit_result
			-- Ommit the addition of the character to the result list
		do
			ommit := True
		end

	is_debug: BOOLEAN
		once
			Result := True
		end

feature -- Basic Functionality

	parse_string (a_string: STRING): PEG_PARSER_RESULT
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
			if o.debug_level >= 10 then
				o.dprint (internal_debug_info + "###" + a_string.out, 10)
			end
			Result := internal_parse (a_string)
		ensure
			result_attached: attached Result
		end

	internal_debug_info: STRING
			-- Returns an informal description of the parser (or the user defined name)
		do
			if attached parser_name then
				Result := parser_name
			else
				Result := default_parse_info
			end
		ensure
			Result_attached: attached Result
		end

	default_parse_info: STRING
			-- The default informal description of the parser
		deferred
		ensure
			Result_attached: attached Result
		end

	short_debug_info: STRING
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

	serialize: STRING
			-- Serializes the parser recursively
		do
			Result := internal_serialize (create {ARRAYED_LIST [PEG_ABSTRACT_PEG]}.make (20))
		ensure
			result_attached: attached Result
		end

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): STRING
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
			if attached behaviour then
				if attached a_result then
					Result := behaviour.item ([a_result])
				end
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
			if attached error_strategy then
				Result := error_strategy.item ([a_result])
			end
		ensure
			result_attached: attached Result
		end

feature -- Convenience

	add alias "+" (a_other: PEG_ABSTRACT_PEG): PEG_SEQUENCE
		require
			a_other_attached: attached a_other
		do
			create Result.make
			Result := (Result + Current) + a_other
		ensure
			Result_attached: attached Result
		end

	add_choice alias "|" (a_other: PEG_ABSTRACT_PEG): PEG_CHOICE
		require
			a_other_attached: attached a_other
		do
			create Result.make
			Result := (Result | Current) | a_other
		ensure
			Result_attached: attached Result
		end

	add_zero_or_more alias "-": PEG_ABSTRACT_PEG
		do
			create {PEG_ZERO_OR_MORE} Result.make (Current)
		ensure
			Result_attached: attached Result
		end

	add_one_or_more alias "+": PEG_ABSTRACT_PEG
		do
			create {PEG_ONE_OR_MORE} Result.make (Current)
		ensure
			Result_attached: attached Result
		end

	negate: PEG_NEGATE
			-- Returns Current negated
		do
			create Result.make (Current)
		ensure
			Result_attached: attached Result
		end

	enforce: PEG_ENFORCE
			-- Returns Current enforced
		do
			create Result.make (Current)
		ensure
			Result_attached: attached Result
		end

	optional: PEG_OPTIONAL
			-- Returns Current as optional parser
		do
			create Result.make (Current)
		ensure
			Result_attached: attached Result
		end

	fixate
			-- Forces the parser to generate new sequences and choice parsers if built
			-- with + or | respectively
		do
			fixated := True
		ensure
			fixated: fixated
		end

	consumer: PEG_CONSUMER
			-- Transforms Current a consumer parser
		do
			create Result.make (Current)
		ensure
			Result_attached: attached Result
		end

end
