note
	description: "Summary description for {PARSING_EXPRESSION_GRAMMAR}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PEG_ABSTRACT_PEG

feature {PEG_ABSTRACT_PEG} -- Access

	behaviour: FUNCTION [ANY, TUPLE [PEG_PARSER_RESULT], PEG_PARSER_RESULT]
			-- Optional behaviour which transforms a result of the children to a new one

	error_strategy: FUNCTION [ANY, TUPLE [PEG_PARSER_RESULT], PEG_PARSER_RESULT]
			-- Optional error strategy which tries to handle failures of a parser

feature -- Access

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

feature -- Basic Functionality

	parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
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
		deferred
		ensure
			result_attached: attached Result
		end

feature -- Implementation

	build_result (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- `a_result': The results of the children
			-- If a behaviour is set the result is processed to a new one
		require
			a_result_attached: attached a_result
			a_result_successfull: a_result.success
		do
			Result := a_result
			if not ommit then
				if attached behaviour then
					if attached a_result then
						Result := behaviour.item ([a_result])
					end
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

	add alias "+" (other: PEG_ABSTRACT_PEG): PEG_SEQUENCE
		do
			create Result.make
			Result := (Result + Current) + other
		end

	add_choice alias "|" (other: PEG_ABSTRACT_PEG): PEG_CHOICE
		do
			create Result.make
			Result := (Result | Current) | other
		end

	add_zero_or_more alias "-": PEG_ABSTRACT_PEG
		do
			create {PEG_ZERO_OR_MORE} Result.make (Current)
		end

	add_one_or_more alias "+": PEG_ABSTRACT_PEG
		do
			create {PEG_ONE_OR_MORE} Result.make (Current)
		end

	negate: PEG_NEGATE
			-- Returns Current negated
		do
			create Result.make (Current)
		end

	optional: PEG_OPTIONAL
			-- Returns Current as optional parser
		do
			create Result.make (Current)
		end

end
