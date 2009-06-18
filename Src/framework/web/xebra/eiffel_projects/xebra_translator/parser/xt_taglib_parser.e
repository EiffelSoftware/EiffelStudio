note
	description: "[
		{XT_TAGLIB_PARSER}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_TAGLIB_PARSER

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

create
	make

feature -- Initialization

	make
		do
		end

	tag_lib_parser: PEG_ABSTRACT_PEG
			--
		local
			taglib, tag, tags, l_attribute, identifier,
			digit, upper_case, lower_case, ws, value, any_char, plain_text,
			open, close, slash, hyphen, underscore, quote, exclamation,
			open_curly, close_curly, sharp, percent, dot, equals, colon,
			tab, newline, space: PEG_ABSTRACT_PEG
		once
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
			exclamation := char ('!')

			underscore := create {PEG_CHARACTER}.make_with_character ('_') -- don't ommit
			hyphen := create {PEG_CHARACTER}.make_with_character ('-') -- don't ommit, so don't use char

			ws := (-(newline | tab | space)) --whitespace

			any_char := create {PEG_ANY}.make
			any_char.ommit_result

			plain_text := + (open.negate + any_char)

			identifier := (hyphen | underscore | upper_case | lower_case) + (-(hyphen | underscore | upper_case | lower_case | digit))
			identifier.set_behaviour (agent concatenate_results)

			value := ws + quote + (-(quote.negate + any_char)) + quote + ws
			value.set_behaviour (agent concatenate_results)

				-- Taglib specific
			l_attribute := open + chars ("attribute") + ws + chars ("id") + ws + equals + value + slash + close
			l_attribute.set_behaviour (agent build_attribute)
			tag := open + chars ("tag") + ws + chars ("id") + ws + equals + value + chars("class") +
					ws + equals + value + close + (-(l_attribute | plain_text)) + open + slash + chars ("tag") + close
			tag.set_behaviour (agent build_tag)
			tags := (tag | plain_text)
			taglib := open + chars("taglib") + ws + chars("id") + ws + equals + value + close
							+ (-tags) + open + slash + ws + chars("taglib") + ws + close
			taglib.set_behaviour (agent build_taglib)
			Result := taglib
		end

	parse (a_string: STRING): XTL_TAG_LIBRARY
			-- Parses a_string and generates a template
		require
			a_string_attached: attached a_string
		local
			l_result: PEG_PARSER_RESULT
		do
			l_result := tag_lib_parser.parse (a_string)
			if l_result.success and attached {XTL_TAG_LIBRARY} l_result.internal_result.first as l_taglib then
				if l_result.left_to_parse.is_empty then
					add_parse_error ("Parsing of taglib was incomplete: %"" + l_result.left_to_parse+ "%"")
				else
					Result := l_taglib
				end
			else
				add_parse_error ("Parsing of taglib was not successfull!")
			end
		end

	char (a_character: CHARACTER): PEG_CHARACTER
		do
			create Result.make_with_character (a_character)
			Result.ommit_result
		end

	chars (a_string: STRING): PEG_SEQUENCE
			-- Creates a parser which parses the `a_string'
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

	build_attribute (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		local
			l_attribute: XTL_TAG_DESCRIPTION_ATTRIBUTE
		do
			Result := a_result
			if attached {STRING} a_result.internal_result.first as l_value then
				create l_attribute.make
				l_attribute.set_value (l_value)
				Result.replace_result (l_attribute)
			else
				add_parse_error ("Attribute not valid!")
			end
		end

	build_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		local
			l_tag: XTL_TAG_DESCRIPTION
		do
			Result := a_result
			if attached {STRING} Result.internal_result.first as l_id then
				if attached {STRING} Result.internal_result [2] as l_class then
					create l_tag.make (l_id, l_class)
					from
						Result.internal_result.start
						Result.internal_result.forth
						Result.internal_result.forth
					until
						Result.internal_result.after
					loop
						if attached {XTL_TAG_DESCRIPTION_ATTRIBUTE} Result.internal_result.item as l_description then
							l_tag.put_attribute_description (l_description)
						else
						--	add_parse_error ("Erroneous tag attribute description!")
						end
						Result.internal_result.forth
					end
				end
			end
			Result.internal_result.wipe_out
			if attached l_tag then
				Result.replace_result (l_tag)
			end
		end

	build_taglib (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		local
			l_taglib: XTL_TAG_LIBRARY
		do
			Result := a_result
			create l_taglib.make
			from
				Result.internal_result.start
			until
				Result.internal_result.after
			loop
				if attached {XTL_TAG_DESCRIPTION} Result.internal_result.item as l_description then
					l_taglib.put_tag (l_description)
				elseif attached {STRING} Result.internal_result.item as l_name then
					l_taglib.set_id (l_name)
				end
				Result.internal_result.forth
			end
			Result.replace_result (l_taglib)
		end

	concatenate_results (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
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

	add_parse_error (a_message: STRING)
			-- Adds a parse error to the error maanager
		do
			error_manager.add_error (create {XERROR_PARSE}.make
				([a_message]), False)
		end

feature -- Access

	template: XP_TEMPLATE
			-- The resulting template

	xeb_file: PEG_ABSTRACT_PEG
			-- The xeb parsing grammar

end
