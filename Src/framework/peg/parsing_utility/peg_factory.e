note
	description: "[
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_FACTORY

feature -- Predefined PEGs
	
	plus: PEG_ABSTRACT_PEG 
		do
			Result := char ('+') 
			Result.ommit_result
		end
		
	minus: PEG_ABSTRACT_PEG 
		do
			Result := char ('-') 
			Result.ommit_result  
		end
		
	dot: PEG_ABSTRACT_PEG 
		do 
			Result := char ('.') 
			Result.ommit_result
		end
			
	quote: PEG_ABSTRACT_PEG 
		do 
			Result := char ('"')
			Result.ommit_result 
		end
			
	colon: PEG_ABSTRACT_PEG 
		do 
			Result := char (':') 
			Result.ommit_result 
		end
			
	comma: PEG_ABSTRACT_PEG 
		do 
			Result := char (',')
			Result.ommit_result 
		end
			
	back_slash: PEG_ABSTRACT_PEG 
		do 
			Result := char ('\')
			Result.ommit_result 
		end
			
	open_square: PEG_ABSTRACT_PEG
		do 
			Result := char ('[')
			Result.ommit_result 
		end
			
	close_square: PEG_ABSTRACT_PEG
		do 
			Result := char (']')
			Result.ommit_result 
		end
			
	open_curly: PEG_ABSTRACT_PEG
		do 
			Result := char ('{')
			Result.ommit_result
		end
			
	close_curly: PEG_ABSTRACT_PEG
		do 
			Result := char ('}')
			Result.ommit_result 
		end
	
	digits: PEG_ABSTRACT_PEG
			-- Non-empty string of digits [0-9]
			-- Ommits the result
		do
			create {PEG_RANGE} Result.make_with_range ('0', '9')
			Result.ommit_result
			Result := +Result
		ensure
			Result_attached: attached Result
		end
	
	any: PEG_ANY
			--  The Parser which accepts anything (1 character)
			-- Ommits the result
		do
			create {PEG_ANY} Result.make
			Result.ommit_result
		ensure
			Result_attached: attached Result
		end
		
	whitespace: PEG_ABSTRACT_PEG
			-- A chain of whitespaces
			-- Ommits the result
		do
			create {PEG_WHITE_SPACE_CHARACTER} Result.make
			Result.ommit_result
			Result := +Result
		end
		
feature --

	stringp (a_string: STRING): PEG_SEQUENCE
			-- Generates a parser which parses `a_string'
		require
			a_string_valid: attached a_string and then not a_string.is_empty
		local
			l_i: INTEGER
		do
			create Result.make
			from
				l_i := 1
			until
				l_i > a_string.count
			loop
				Result := Result + char (a_string [l_i])
				l_i := l_i + 1
			end
			Result.fixate
		ensure
			Result_attached: attached Result
		end

	char (a_char: CHARACTER): PEG_CHARACTER
			-- Generates  Character Parser
		require
			a_char_attached: attached a_char
		do
			create Result.make_with_character (a_char)
			Result.ommit_result
		ensure
			Result_attached: attached Result
		end
		
end
