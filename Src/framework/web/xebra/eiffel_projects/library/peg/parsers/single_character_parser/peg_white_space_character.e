note
	description: "[
		{PEG_WHITE_SPACE_CHARACTER}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_WHITE_SPACE_CHARACTER

inherit
	PEG_ABSTRACT_PEG
create
	make

feature {NONE} -- Initialization

	make
			--
		do
			behaviour := agent build
		end

feature {NONE} -- Access

	character: CHARACTER
			-- The representing character

feature -- Implementation

	internal_parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		do
			if a_string.is_empty then
				create Result.make (a_string, False)
				Result := fix_result (Result)
			else
				if is_whitespace (a_string [1]) then
					create Result.make (a_string.substring_index (2), True)
					if not ommit then
						Result.append_result (a_string [1])
					end
					Result := build_result (Result)
				else
					create Result.make (a_string, False)
					Result := fix_result (Result)
				end
			end
		end

	default_parse_info: STRING
			-- <Precursor>	
		do
			Result := "whitespace"
		end

	short_debug_info: STRING
			-- <Precursor>		
		do
			Result := default_parse_info
		end

feature {NONE} -- Implementation

	is_whitespace (a_character: CHARACTER): BOOLEAN
			-- Checks wether the character is a whitespace or not
		do
			Result := (a_character.code >= 0) and (a_character.code <= 32)
		end

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): STRING
			-- <Precursor>
		do
			Result := "whitespace"
		end

	build (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- `a_result': The result
		require
			a_result_attached: attached a_result
		do
			if not ommit then
				a_result.append_result (character)
			end
			Result := a_result;
		end

end
