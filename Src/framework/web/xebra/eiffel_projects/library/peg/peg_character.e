note
	description: "Summary description for {PEG_CHARACTER}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_CHARACTER

inherit
	PEG_SINGLE_CHARACTER_PARSER

create
	make_with_character

feature -- Initialization

	make_with_character (a_character: CHARACTER)
			-- `a_character' The character which is matched
		require
			a_character_attached: attached a_character
		do
			behaviour := agent build
			character := a_character
		ensure
			character_set: attached character and then character = a_character
		end

feature {NONE} -- Access

	character: CHARACTER

feature -- Implementation

	parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		do
			if a_string.is_empty then
				create Result.make (a_string, False)
				Result := fix_result (Result)
			else
				if a_string.starts_with (character) then
					create Result.make (a_string.substring (2, a_string.count), True)
					Result := build_result (Result)
				else
					create Result.make (a_string, False)
					Result := fix_result (Result)
				end
			end
		end

	serialize: STRING
			-- <Precursor>
		do
			Result := "'" + character.out + "'"
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
