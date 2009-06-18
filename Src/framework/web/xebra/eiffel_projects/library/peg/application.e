indexing
	description : "project application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			xml, leaf_xml, composite_xml, namespace_xml, namespace_leaf_xml,
			identifier, l_attribute, digit, upper_case, lower_case, open, close, slash,
			tab, newline, ws, hyphen, underscore, dynamic_attribute, open_curly, close_curly,
			sharp, percent, dot, variable_attribute, xml_file,
			space, quote, equals, value, any_char, plain_text, colon: PARSING_EXPRESSION_GRAMMAR
		do
			digit := create {PEG_RANGE}.make_with_range ('0', '9')
			upper_case := create {PEG_RANGE}.make_with_range ('A', 'Z')
			lower_case := create {PEG_RANGE}.make_with_range ('a', 'z')
			space :=  char (' ')
			tab := char ('%T')
			newline := char ('%N')
			quote :=  char ('%"')
			equals := char ('=')
			open :=   char ('<')
			close :=  char ('>')
			slash :=  char ('/')
			colon :=  char (':')
			dot := char ('.')
			open_curly := char ('{')
			close_curly := char ('}')
			percent := char ('%%')
			sharp := char ('#')

			underscore := create {PEG_CHARACTER}.make_with_character ('_') -- don't ommit
			hyphen := create {PEG_CHARACTER}.make_with_character ('-') -- don't ommit, so don't use char

			ws := (-(newline | tab | space)) --whitespace

			any_char := create {PEG_ANY}.make

			plain_text := +(open.negate + any_char)
			plain_text.set_behaviour (agent build_plain_text)

			identifier := (hyphen | underscore | upper_case | lower_case) + (-(hyphen | underscore | upper_case | lower_case | digit))
			identifier.set_behaviour (agent build_identifier)

			dynamic_attribute := percent + equals + identifier + percent
			variable_attribute := sharp + open_curly + identifier + dot + identifier + close_curly

			value := variable_attribute | dynamic_attribute | (-(quote.negate + any_char))
			value.set_behaviour (agent build_identifier)

			l_attribute := (ws + identifier + ws + equals + ws + quote + value + quote)
			l_attribute.set_behaviour (agent build_attribute)

			xml := create {PEG_CHOICE}.make

			composite_xml := open + identifier + (-l_attribute) + close + (+xml).optional + open + slash + identifier + close
			namespace_xml := open + identifier + colon + identifier + (-l_attribute) + close + (+xml) + open +slash + identifier + colon + identifier + close
			leaf_xml := open + identifier + (-l_attribute) + ws + slash + close
			namespace_leaf_xml := open + identifier + colon + identifier + (-l_attribute) + ws + slash + close

			composite_xml.set_behaviour (agent build_tag)
			namespace_xml.set_behaviour (agent build_tag)
			leaf_xml.set_behaviour (agent build_tag)
			namespace_leaf_xml.set_behaviour (agent build_tag)

			xml := xml | namespace_leaf_xml | leaf_xml | namespace_xml | composite_xml | plain_text

			xml_file := ws + xml + ws

			print ("%N" + xml_file.parse (source).out)
		end

	char (a_character: CHARACTER): PEG_CHARACTER
		do
			create Result.make_with_character (a_character)
			Result.ommit_result
		end

	chars (a_string: STRING): PEG_SEQUENCE
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
		end

	build_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		local
			l_result: STRING
		do
			l_result := "(tag: "
			from
				a_result.internal_result.start
			until
				a_result.internal_result.after
			loop
				l_result := l_result + a_result.internal_result.item.out
				a_result.internal_result.forth
			end
			l_result := l_result + ")"
			Result := a_result
			Result.internal_result.wipe_out
			Result.append_result (l_result)
		end

	build_attribute (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		local
			l_name, l_value: STRING
			l_new_result: ARRAYED_LIST [ANY]
		do
			if attached {STRING} a_result.internal_result [1] as ll_name then
				l_name := ll_name
			end
			if attached {STRING} a_result.internal_result [2] as ll_value then
				l_value := ll_value
			end
			Result := a_result
			create l_new_result.make (2)
			l_new_result.extend ("attribute (" + l_name + "," + l_value + ")")
			Result.set_result (l_new_result)
		end

	build_identifier (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
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
		end

	build_plain_text (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
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
			Result.append_result ("(plain_text: '" + l_product + "')")
		end

end
