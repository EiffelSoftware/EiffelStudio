note
	description: "[
		{XT_XEBRA_PARSER}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_XEBRA_PARSER

feature -- Access

	digit: PEG_ABSTRACT_PEG
	upper_case: PEG_ABSTRACT_PEG
	lower_case: PEG_ABSTRACT_PEG
	space: PEG_ABSTRACT_PEG
	tab: PEG_ABSTRACT_PEG
	newline: PEG_ABSTRACT_PEG
	return: PEG_ABSTRACT_PEG
	feed: PEG_ABSTRACT_PEG
	quote: PEG_ABSTRACT_PEG
	equals: PEG_ABSTRACT_PEG
	open: PEG_ABSTRACT_PEG
	close: PEG_ABSTRACT_PEG
	slash: PEG_ABSTRACT_PEG
	colon: PEG_ABSTRACT_PEG
	dot: PEG_ABSTRACT_PEG
	open_curly: PEG_ABSTRACT_PEG
	close_curly: PEG_ABSTRACT_PEG
	percent: PEG_ABSTRACT_PEG
	sharp: PEG_ABSTRACT_PEG
	exclamation: PEG_ABSTRACT_PEG
	any_char: PEG_ABSTRACT_PEG
	eof: PEG_ABSTRACT_PEG
	underscore, hyphen, identifier, comment, ws: PEG_ABSTRACT_PEG

	make
			-- Initialize parsers
		do
			digit := 		range ('0', '9')
			upper_case := 	range ('A', 'Z')
			lower_case := 	range ('a', 'z')
			space := 		char (' ')
			tab := 			char ('%T')
			newline := 		char ('%N')
			return := 		char ('%R')
			feed := 		char ('%F')
			quote :=  		char ('%"')
			equals := 		char ('=')
			open :=   		char ('<')
			close :=  		char ('>')
			slash :=  		char ('/')
			colon := 		char (':')
			dot := 			char ('.')
			open_curly := 	char ('{')
			close_curly :=	char ('}')
			percent := 		char ('%%')
			sharp := 		char ('#')
			exclamation := 	char ('!')
			any_char := create {PEG_ANY}.make
			any_char.ommit_result
			eof := any_char.negate
			underscore := char ('_')
			hyphen := char ('-')
				-- A common identifier. Will put the identifier {STRING} on the stack
			identifier := (hyphen | underscore | upper_case | lower_case) + (-(hyphen | underscore | upper_case | lower_case | digit))
			identifier := identifier.consumer
			identifier.fixate

				-- XML comments
			comment := chars_without_ommit ("<!--") + (-(chars("-->").negate + any_char)) + chars_without_ommit ("-->")
			comment.set_behaviour (agent concatenate_results)

				-- Whitespace: Eats all the whitespace until something else appears
			ws := create {PEG_WHITE_SPACE_CHARACTER}.make
			ws.ommit_result
			ws := +ws
		end

feature {NONE} -- Convenience

	range (a_first_char, a_last_char: CHARACTER): PEG_RANGE
				-- Builds an ommiter {PEG_CHARACTER} (doesn't put any characters to the result list)
		require
			a_first_char_attached: attached a_first_char
			a_last_char_attached: attached a_last_char
		do
			create Result.make_with_range (a_first_char, a_last_char)
			Result.ommit_result
		ensure
			Result_attached: attached Result
		end

	char (a_character: CHARACTER): PEG_CHARACTER
			-- Builds an ommiter {PEG_CHARACTER} (doesn't put any characters to the result list)
		require
			a_character_attached: attached a_character
		do
			create Result.make_with_character (a_character)
			Result.ommit_result
		ensure
			Result_attached: attached result
		end

	rchar (a_character: CHARACTER): PEG_CHARACTER
			-- Builds an ommiter {PEG_CHARACTER} (doesn't put any characters to the result list)
		require
			a_character_attached: attached a_character
		do
			create Result.make_with_character (a_character)
		ensure
			Result_attached: attached result
		end

	chars (a_string: STRING): PEG_SEQUENCE
			-- Creates a parser which parses the `a_string'
		require
			a_string_attached: attached a_string
			a_string_not_empty: not a_string.is_empty
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
		ensure
			Result_attached: attached Result
		end

	chars_without_ommit (a_string: STRING): PEG_SEQUENCE
			-- Creates a parser which parses the `a_string'
		require
			a_string_attached: attached a_string
			a_string_not_empty: not a_string.is_empty
		local
			l_i: INTEGER
		do
			create Result.make
			from
				l_i := 1
			until
				l_i > a_string.count
			loop
				Result := Result + create {PEG_CHARACTER}.make_with_character (a_string [l_i])
				l_i := l_i + 1
			end
		ensure
			Result_attached: attached Result
		end

feature {XT_XEBRA_PARSER} -- Behaviours

	concatenate_results (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Concatenates all result's 'out'-output to a single {String}
		require
			a_result_attached: attached a_result
		local
			l_product: STRING
		do
			l_product := ""
			from
				a_result.internal_result.start
			until
				a_result.internal_result.after
			loop
				l_product := l_product + a_result.internal_result.item.out
				a_result.internal_result.forth
			end
			Result := a_result
			Result.internal_result.wipe_out
			Result.append_result (l_product)
		ensure
			Result_attached: attached Result
		end

end
