note
	description: "[
		{XT_XEB_PARSER}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_XEB_PARSER

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

create
	make_with_registry

feature -- Initialization

	make_with_registry (a_registry: XP_SERVLET_GG_REGISTRY)
		require
			a_registry_attached: attached a_registry
		do
			registry := a_registry
			source_path := "No source path specified."
		ensure
			registry_set: registry = a_registry
		end

feature {NONE} -- Access

	registry: XP_SERVLET_GG_REGISTRY
			-- The registry for the taglibs

	source_path: STRING
			-- The path to the original file

feature -- Access

	template: XP_TEMPLATE
			-- The resulting template

	deactivate_render
			-- The current will not be rendered
		do
			template.is_template := True
		end

	put_class_name (a_class_name: STRING)
			-- Sets the class name of the template
		require
			a_class_name_valid: attached a_class_name and then not a_class_name.is_empty
		do
			template.controller_class := a_class_name
		ensure
			class_set: template.controller_class = a_class_name
		end

	set_source_path (a_source_path: STRING)
			-- Sets the source path.
		require
			a_source_path_attached: attached a_source_path
		do
			source_path := a_source_path
		ensure
			source_path_set: source_path = a_source_path
		end

feature {NONE} -- Implementation

	xml_parser: PEG_ABSTRACT_PEG
			--
		local
			xeb_file, xml, leaf_xml, composite_xml, namespace_xml, namespace_leaf_xml, doctype,
			identifier, l_attribute, dynamic_attribute, variable_attribute, value_attribute,
			digit, upper_case, lower_case, ws, value, any_char, plain_text, plain_text_without_behaviour,
			open, close, close_fixed, slash, hyphen, underscore, quote, exclamation,
			open_curly, close_curly, sharp, percent, dot, equals, colon, comment,
			tab, newline, space, return, feed, epsilon: PEG_ABSTRACT_PEG
		once
				-- Basic parsers (single character parsers)
			digit := create {PEG_RANGE}.make_with_range ('0', '9')
			upper_case := create {PEG_RANGE}.make_with_range ('A', 'Z')
			lower_case := create {PEG_RANGE}.make_with_range ('a', 'z')
			space := char (' ')
			tab := char ('%T')
			newline := char ('%N')
			return := char ('%R')
			feed := char ('%F')
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
			epsilon := create {PEG_EPSILON}.make
			any_char := create {PEG_ANY}.make

				-- For graceful recovery of silly mistake of missing '>' we add a error strategy
			close_fixed := char ('>')
			close_fixed.set_error_strategy (agent handle_close_error)

				-- Directly create with constructor because the character should be put onto the result list
			underscore := create {PEG_CHARACTER}.make_with_character ('_')
			hyphen := create {PEG_CHARACTER}.make_with_character ('-')

				-- Whitespace: Eats all the whitespace until something else appears
			ws := create {PEG_WHITE_SPACE_CHARACTER}.make
			ws.ommit_result
			ws := -ws

				-- A common identifier. Will put the identifier {STRING} on the stack
			identifier := (hyphen | underscore | upper_case | lower_case) + (-(hyphen | underscore | upper_case | lower_case | digit))
			identifier.set_behaviour (agent concatenate_results)

				-- Plain text eats all the characters until it reaches a opening tag. Will put a content
				-- tag (with the parsed text as input) on the result list
			plain_text := +((open + (identifier | slash)).negate + any_char)
			plain_text.set_behaviour (agent build_content_tag)

				-- Values for attributes of tags. Denote "%=feature%" and "#{variable.something.out}"
			value_attribute := (-(quote.negate + any_char))
			value_attribute.set_behaviour (agent build_value_attribute)
			dynamic_attribute := percent + equals + identifier + percent
			dynamic_attribute.set_behaviour (agent build_dynamic_attribute)
			variable_attribute := sharp + open_curly + identifier + (+(rchar ('.') + identifier)) + close_curly
			variable_attribute.set_behaviour (agent build_variable_attribute)

				-- All possible values which can occur in quotes after a tag attribute
			value := variable_attribute | dynamic_attribute | value_attribute

				-- Tag attributes
			l_attribute := (ws + identifier + ws + equals + ws + quote + value + quote)
			l_attribute.set_behaviour (agent build_attribute)

				-- XML comments
			comment := chars_without_ommit ("<!--") + (-(chars("-->").negate + any_char)) + chars_without_ommit ("-->")
			comment.set_behaviour (agent build_content_tag)

			xml := create {PEG_CHOICE}.make
				-- Normal xml without namespaces. With children tags (or text)
			composite_xml := open + identifier + (-l_attribute) + close_fixed + (-xml) + open + slash + identifier + ws.optional + close_fixed
				-- Normal xml with namespaces. With children tags (or text)
			namespace_xml := open + identifier + colon + identifier + (-l_attribute) + close_fixed + (-xml) + open + slash + identifier + colon + identifier + ws.optional + close_fixed
				-- Normal xml without namespaces and without children
			leaf_xml := open + identifier + (-l_attribute) + ws + slash + close_fixed
				-- Normal xml with namespaces and without children
			namespace_leaf_xml := open + identifier + colon + identifier + (-l_attribute) + ws + slash + close_fixed

			composite_xml.set_behaviour (agent build_html_tag)
			namespace_xml.set_behaviour (agent build_tag)
			leaf_xml.set_behaviour (agent build_leaf_html_tag)
			namespace_leaf_xml.set_behaviour (agent build_leaf_tag)

				-- XML tree
			xml := xml | namespace_leaf_xml | leaf_xml | namespace_xml | composite_xml | comment | plain_text

				-- Same as `plain_text' but no behaviour (no content tag is generated)
			plain_text_without_behaviour := +((open + any_char).negate + any_char)

				-- Doctype
			doctype := rchar ('<') + rchar ('!') + plain_text_without_behaviour
			doctype.set_behaviour (agent build_content_tag)

				-- Xml with pre- and post-context
			xeb_file := ws.optional + doctype.optional + xml + ws.optional
			xeb_file.set_behaviour (agent build_root_tag)
			Result := xeb_file
		end

feature -- Parser error strategies

	handle_close_error (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Fixes the missing '>' by assuming it is there
		require
			a_result_attached: attached a_result
		do
			Result := a_result
			Result.put_error_message ("Missing '>'")
			Result.success := True
		ensure
			Result_attached: attached Result
		end

feature -- Parser Behaviours

	build_dynamic_attribute (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a dynamic attribute
		require
			a_result_attached: attached a_result
		do
			Result := concatenate_results (a_result)
			if attached {STRING} Result.internal_result.first as l_argument then
				Result.replace_result (create {XP_TAG_DYNAMIC_ARGUMENT}.make (l_argument))
			end
		ensure
			Result_attached: attached Result
		end

	build_variable_attribute (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- builds a variable attribute
		require
			a_result_attached: attached a_result
		do
			Result := concatenate_results (a_result)
			if attached {STRING} Result.internal_result.first as l_argument then
				Result.replace_result (create {XP_TAG_VARIABLE_ARGUMENT}.make (l_argument))
			end
		ensure
			Result_attached: attached Result
		end

	build_value_attribute (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- builds a value attribute
		require
			a_result_attached: attached a_result
		do
			Result := concatenate_results (a_result)
			if attached {STRING} Result.internal_result.first as l_argument then
				Result.replace_result (create {XP_TAG_VALUE_ARGUMENT}.make (l_argument))
			end
		ensure
			Result_attached: attached Result
		end

	build_html_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a html tag
		require
			a_result_attached: attached a_result
		local
			l_tag: XP_TAG_ELEMENT
			l_i: INTEGER
		do
			print ("%Nbuild_html_tag " + a_result.out)
			Result := a_result
			if attached {STRING} a_result.internal_result.first as l_id then
				create l_tag.make ("", l_id, "XTAG_XEB_HTML_TAG", format_debug (a_result.left_to_parse.debug_information))
				from
					l_i := 2
				until
					l_i > a_result.internal_result.count-1
				loop
					if attached {TUPLE [id: STRING; value: XP_TAG_ARGUMENT]} a_result.internal_result [l_i] as l_attribute then
						if l_tag.has_attribute (l_attribute.id) then
							Result.put_error_message ("Double occurence of attribute detected: " + l_attribute.id + "=" + l_attribute.value.value)
						else
							l_tag.put_attribute (l_attribute.id, l_attribute.value)
						end
					elseif attached {XP_TAG_ELEMENT} a_result.internal_result[l_i] as l_subtag then
						l_tag.put_subtag (l_subtag)
					end
					l_i := l_i + 1
				end
				if not a_result.internal_result.last.is_equal (a_result.internal_result.first) then
					Result.put_error_message ("Non-matching end tag: " + a_result.internal_result.last.out +
										" for start tag: " + a_result.internal_result.first.out)
				end
			end
			if attached l_tag then
				Result.replace_result (l_tag)
			end
		ensure
			Result_attached: attached Result
		end

	build_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a tag (with namespace and hence taglib)
		require
			a_result: attached a_result
		local
			l_tag: XP_TAG_ELEMENT
			l_taglib: XTL_TAG_LIBRARY
			l_i: INTEGER
			l_end_tag: STRING
		do
			print ("%Nbuild_tag " + a_result.out)
			Result := a_result
			if attached {STRING} a_result.internal_result.first as l_namespace then
				if attached {STRING} a_result.internal_result [2] as l_id then
					if registry.contains_tag_lib (l_namespace) then
						l_taglib := registry.retrieve_taglib (l_namespace)
						if l_taglib.contains (l_id) then
							l_tag := l_taglib.create_tag (l_namespace, l_id, l_taglib.get_class_for_name (l_id), format_debug(a_result.left_to_parse.debug_information))
							from
								l_i := 3
							until
								l_i > a_result.internal_result.count-1
							loop
								if attached {TUPLE [id: STRING; value: XP_TAG_ARGUMENT]} a_result.internal_result [l_i] as l_attribute then
									if l_tag.has_attribute (l_attribute.id) then
										Result.put_error_message ("Double occurence of attribute detected: " + l_attribute.id + "=" + l_attribute.value.value)
									else
										l_tag.put_attribute (l_attribute.id, l_attribute.value)
									end
								elseif attached {XP_TAG_ELEMENT} a_result.internal_result[l_i] as l_subtag then
									l_tag.put_subtag (l_subtag)
								end
								l_i := l_i + 1
							end
							l_end_tag := a_result.internal_result [a_result.internal_result.count-1].out + ":" + a_result.internal_result [a_result.internal_result.count].out
							if not (l_namespace+":"+l_id).is_equal (l_end_tag) then
								Result.put_error_message ("Unmatched tags: " + l_namespace+":"+l_id + " expected but found: " + l_end_tag)
							end
						else
							Result.put_error_message ("Unknown tag for taglib: " + l_namespace + ":" + l_id)
						end
					else
						Result.put_error_message ("Unknown tag_lib: " + l_namespace)
					end
				end
			end
			if attached l_tag then
				Result.replace_result (l_tag)
			end
		ensure
			Result_attached: attached Result
		end

	build_leaf_html_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a html tag
		require
			a_result_attached: attached a_result
		local
			l_tag: XP_TAG_ELEMENT
		do
			print ("%Nbuild_leaf_html_tag " + a_result.out)
			Result := a_result
			if attached {STRING} a_result.internal_result.first as l_id then
				create l_tag.make ("", l_id, "XTAG_XEB_HTML_TAG", format_debug(a_result.left_to_parse.debug_information))
				from
					Result.internal_result.start
					Result.internal_result.forth -- Begin with the second
				until
					Result.internal_result.after
				loop
					if attached {TUPLE [id: STRING; value: XP_TAG_ARGUMENT]} a_result.internal_result.item as l_attribute then
						if l_tag.has_attribute (l_attribute.id) then
							Result.put_error_message ("Double occurence of attribute detected: " + l_attribute.id + "=" + l_attribute.value.value)
						else
							l_tag.put_attribute (l_attribute.id, l_attribute.value)
						end
					end
					Result.internal_result.forth
				end
			end
			if attached l_tag then
				Result.replace_result (l_tag)
			end
		ensure
			Result_attached: attached Result
		end

	build_leaf_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a tag
		require
			a_result_attached: attached a_result
		local
			l_tag: XP_TAG_ELEMENT
			l_taglib: XTL_TAG_LIBRARY
		do
			print ("%Nbuild_leaf_tag " + a_result.out)
			Result := a_result
			if attached {STRING} a_result.internal_result.first as l_namespace then
				if attached {STRING} a_result.internal_result [2] as l_id then
					if registry.contains_tag_lib (l_namespace) then
						l_taglib := registry.retrieve_taglib (l_namespace)
						if l_taglib.contains (l_id) then
							l_tag := l_taglib.create_tag (l_namespace, l_id, l_taglib.get_class_for_name (l_id), format_debug(a_result.left_to_parse.debug_information))
							from
								Result.internal_result.start
								Result.internal_result.forth -- Begin with the second
							until
								Result.internal_result.after
							loop
								if attached {TUPLE [id: STRING; value: XP_TAG_ARGUMENT]} a_result.internal_result.item as l_attribute then
									if l_tag.has_attribute (l_attribute.id) then
										Result.put_error_message ("Double occurence of attribute detected: " + l_attribute.id + "=" + l_attribute.value.value)
									else
										l_tag.put_attribute (l_attribute.id, l_attribute.value)
									end
								end
								Result.internal_result.forth
							end
						end
					end
				end
			end
			if attached l_tag then
				Result.replace_result (l_tag)
			end
		ensure
			Result_attached: attached Result
		end

	build_content_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a content from the results
		require
			a_result_attached: attached a_result
		local
			l_tag: XP_TAG_ELEMENT
		do
			Result := concatenate_results (a_result)
			if attached {STRING} a_result.internal_result [1] as l_content then
				create l_tag.make ("", "content", "XTAG_XEB_CONTENT_TAG", format_debug(a_result.left_to_parse.debug_information))
				l_tag.put_attribute ("text", create {XP_TAG_VALUE_ARGUMENT}.make (l_content))
				Result.replace_result (l_tag)
			end
		ensure
			Result_attached: attached Result
		end

	build_root_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Concatenate final tags to root_tag
		require
			a_result_attached: attached a_result
		local
			l_tag: XP_TAG_ELEMENT
		do
			Result := a_result
			create l_tag.make ("", "html", "XTAG_XEB_CONTAINER_TAG", format_debug(a_result.left_to_parse.debug_information))
			from
				Result.internal_result.start
			until
				Result.internal_result.after
			loop
				if attached {XP_TAG_ELEMENT} Result.internal_result.item as l_subtag then
					l_tag.put_subtag (l_subtag)
				end
				Result.internal_result.forth
			end
			Result.replace_result (l_tag)
		ensure
			Result_attached: attached a_result
		end

	build_attribute (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds an attribute tuple from the result
		require
			a_result_attached: attached a_result
		local
			l_attribute: TUPLE [STRING, XP_TAG_ARGUMENT]
		do
			Result := a_result
			if attached {STRING} a_result.internal_result [1] as l_id then
				if attached {XP_TAG_ARGUMENT} a_result.internal_result [2] as l_value then
					l_attribute := [l_id, l_value]
					Result.replace_result (l_attribute)
				end
			end
		ensure
			Result_attached: attached a_result
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
			Result.replace_result (l_product)
		end

feature {NONE} -- Convenience

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

	format_debug (a_line_row: TUPLE [line: INTEGER; row: INTEGER]): STRING
			-- Formats the line/row information
		require
			a_line_row_attached: attached a_line_row
		do
			Result := "line: " + a_line_row.line.out + " row: " + a_line_row.row.out + " of file: " + source_path
		ensure
			Result_attached_and_not_empty: attached Result and then not Result.is_empty
		end

	add_parse_error (a_message: STRING)
			-- Adds a parse error to the error maanager
		do
			error_manager.add_error (create {XERROR_PARSE}.make
				([a_message]), False)
		end

feature -- Basic Functionality

	parse (a_string: STRING): BOOLEAN
			-- Parses a_string and generates a template
		require
			a_string_attached: attached a_string
		local
			l_result: PEG_PARSER_RESULT
		do
			create template.make_empty
			l_result := xml_parser.parse (create {PEG_PARSER_STRING}.make_from_string (a_string))
			if l_result.success and attached {XP_TAG_ELEMENT} l_result.internal_result [1] as l_root_tag then
				if not l_result.left_to_parse.is_empty then
					add_parse_error ("Parsing was not complete: %"" + l_result.left_to_parse.out + "%"")
				else
					template.put_root_tag (l_root_tag)
					Result := True
				end
			else

				add_parse_error ("Parsing was not successfull! Error location: " +
					format_debug (l_result.left_to_parse.debug_information_with_index (l_result.left_to_parse.longest_match.count)))
			end
			from
				l_result.error_messages.start
			until
				l_result.error_messages.after
			loop
				add_parse_error (l_result.error_messages.index.out + ": " + l_result.error_messages.item)
				l_result.error_messages.forth
			end
		end

end
