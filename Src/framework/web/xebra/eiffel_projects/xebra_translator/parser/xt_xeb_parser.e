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
		do
			template.controller_class := a_class_name
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
			identifier, l_attribute, dynamic_attribute, variable_attribute,
			digit, upper_case, lower_case, ws, value, any_char, plain_text, plain_text_without_behaviour,
			open, close, slash, hyphen, underscore, quote, exclamation,
			open_curly, close_curly, sharp, percent, dot, equals, colon, comment,
			tab, newline, space, return: PEG_ABSTRACT_PEG
		once
			digit := create {PEG_RANGE}.make_with_range ('0', '9')
			upper_case := create {PEG_RANGE}.make_with_range ('A', 'Z')
			lower_case := create {PEG_RANGE}.make_with_range ('a', 'z')
			space :=  char (' ')
			tab := char ('%T')
			newline := char ('%N')
			return := char ('%R')
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
			hyphen := create {PEG_CHARACTER}.make_with_character ('-') -- don't ommit, so don't use `char' feature

			ws := (-(newline | tab | space | return)) --whitespace

			any_char := create {PEG_ANY}.make

			plain_text := +((open + any_char).negate + any_char)
			plain_text.set_behaviour (agent build_content_tag)

			identifier := (hyphen | underscore | upper_case | lower_case) + (-(hyphen | underscore | upper_case | lower_case | digit))
			identifier.set_behaviour (agent concatenate_results)

			dynamic_attribute := percent + equals + identifier + percent
			variable_attribute := sharp + open_curly + identifier + (+(dot + identifier)) + close_curly

			value := variable_attribute | dynamic_attribute | (-(quote.negate + any_char))
			value.set_behaviour (agent concatenate_results)

			l_attribute := (ws + identifier + ws + equals + ws + quote + value + quote)
			l_attribute.set_behaviour (agent build_attribute)

			xml := create {PEG_CHOICE}.make

			comment := chars_without_ommit ("<!--") + (-(chars("-->").negate + any_char)) + chars_without_ommit ("-->")
			comment.set_behaviour (agent build_content_tag)

			composite_xml := open + identifier + (-l_attribute) + close + (+xml).optional + open + slash + identifier + close
			namespace_xml := open + identifier + colon + identifier + (-l_attribute) + close + (+xml) + open +slash + identifier + colon + identifier + close
			leaf_xml := open + identifier + (-l_attribute) + ws + slash + close
			namespace_leaf_xml := open + identifier + colon + identifier + (-l_attribute) + ws + slash + close

			composite_xml.set_behaviour (agent build_html_tag)
			namespace_xml.set_behaviour (agent build_tag)
			leaf_xml.set_behaviour (agent build_leaf_html_tag)
			namespace_leaf_xml.set_behaviour (agent build_leaf_tag)

			xml := xml | namespace_leaf_xml | leaf_xml | namespace_xml | composite_xml | comment | plain_text

			plain_text_without_behaviour := +((open + any_char).negate + any_char)
			doctype := create {PEG_CHARACTER}.make_with_character ('<') + create {PEG_CHARACTER}.make_with_character ('!') + plain_text_without_behaviour
			doctype.set_behaviour (agent build_content_tag)

			create {PEG_SEQUENCE} xeb_file.make
			xeb_file := xeb_file + ws.optional + doctype.optional + xml + ws.optional
			xeb_file.set_behaviour (agent build_root_tag)
			Result := xeb_file
		end

	char (a_character: CHARACTER): PEG_CHARACTER
			-- Builds an ommiter {PEG_CHARACTER}
		require
			a_character_attached: attached a_character
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

	chars_without_ommit (a_string: STRING): PEG_SEQUENCE
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
				Result := Result + create {PEG_CHARACTER}.make_with_character (a_string [l_i])
				l_i := l_i + 1
			end
		end

	build_html_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a html tag
		local
			l_tag: XP_TAG_ELEMENT
			l_i: INTEGER
		do
			Result := a_result
			if attached {STRING} a_result.internal_result [1] as l_id then
				create l_tag.make ("", l_id, "XTAG_XEB_HTML_TAG", format_debug(a_result.left_to_parse.debug_information))
				from
					l_i := 2
				until
					l_i > a_result.internal_result.count-2
				loop
					if attached {TUPLE [id: STRING; value: STRING]} a_result.internal_result [l_i] as l_attribute then
						if l_tag.has_attribute (l_attribute.id) then
							Result.put_error_message ("Double occurence of attribute detected: " + l_attribute.id + "=" + l_attribute.value)
						else
							l_tag.put_attribute (l_attribute.id, create {XP_TAG_ARGUMENT}.make (l_attribute.value))
						end
					elseif attached {XP_TAG_ELEMENT} a_result.internal_result[l_i] as l_subtag then
						l_tag.put_subtag (l_subtag)
					end
					l_i := l_i + 1
				end
				if not a_result.internal_result.last.is_equal (a_result.internal_result.first) then
					Result.put_error_message ("Non-matching end tag: " + a_result.internal_result.last.out +
										" for start tag: " + a_result.internal_result.first.out)
				else
				--	Result.replace_result (l_tag)
				end
			end
			if attached l_tag then
				Result.replace_result (l_tag)
			end
		end

	build_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a tag (with namespace and hence taglib)
		require
			registry_attached: attached registry
		local
			l_tag: XP_TAG_ELEMENT
			l_taglib: XTL_TAG_LIBRARY
			l_i: INTEGER
			l_end_tag: STRING
		do
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
								l_i > a_result.internal_result.count-2
							loop
								if attached {TUPLE [id: STRING; value: STRING]} a_result.internal_result [l_i] as l_attribute then
									if l_tag.has_attribute (l_attribute.id) then
										Result.put_error_message ("Double occurence of attribute detected: " + l_attribute.id + "=" + l_attribute.value)
									else
										l_tag.put_attribute (l_attribute.id, create {XP_TAG_ARGUMENT}.make (l_attribute.value))
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
		end

	build_leaf_html_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a html tag
		local
			l_tag: XP_TAG_ELEMENT
		do
			Result := a_result
			if attached {STRING} a_result.internal_result.first as l_id then
				create l_tag.make ("", l_id, "XTAG_XEB_HTML_TAG", format_debug(a_result.left_to_parse.debug_information))
				from
					Result.internal_result.start
					Result.internal_result.forth -- Begin with the second
				until
					Result.internal_result.after
				loop
					if attached {TUPLE [id: STRING; value: STRING]} a_result.internal_result.item as l_attribute then
						if l_tag.has_attribute (l_attribute.id) then
							Result.put_error_message ("Double occurence of attribute detected: " + l_attribute.id + "=" + l_attribute.value)
						else
							l_tag.put_attribute (l_attribute.id, create {XP_TAG_ARGUMENT}.make (l_attribute.value))
						end
					end
					Result.internal_result.forth
				end
			end
			if attached l_tag then
				Result.replace_result (l_tag)
			end
		end

	build_leaf_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a tag
		local
			l_tag: XP_TAG_ELEMENT
			l_taglib: XTL_TAG_LIBRARY
		do
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
								if attached {TUPLE [id: STRING; value: STRING]} a_result.internal_result.item as l_attribute then
									if l_tag.has_attribute (l_attribute.id) then
										Result.put_error_message ("Double occurence of attribute detected: " + l_attribute.id + "=" + l_attribute.value)
									else
										l_tag.put_attribute (l_attribute.id, create {XP_TAG_ARGUMENT}.make (l_attribute.value))
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
		end

	build_content_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a content from the results
		local
			l_tag: XP_TAG_ELEMENT
		do
			Result := concatenate_results (a_result)
			if attached {STRING} a_result.internal_result [1] as l_content then
				create l_tag.make ("", "content", "XTAG_XEB_CONTENT_TAG", format_debug(a_result.left_to_parse.debug_information))
				l_tag.put_attribute ("text", create {XP_TAG_ARGUMENT}.make (l_content))
				Result.replace_result (l_tag)
			end
		end

	format_debug (a_line_row: TUPLE [line: INTEGER; row: INTEGER]): STRING
			-- Formats the line/row information
		require
			a_line_row_attached: attached a_line_row
		do
			Result := "line: " + a_line_row.line.out + " row: " + a_line_row.row.out + " of file: " + source_path
		end

	build_root_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Concatenate final tags to root_tag
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
		end

	build_attribute (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds an attribute tuple from the result
		local
			l_attribute: TUPLE [STRING, STRING]
		do
			Result := a_result
			if attached {STRING} a_result.internal_result [1] as l_id then
				if attached {STRING} a_result.internal_result [2] as l_value then
					l_attribute := [l_id, l_value]
				end
			end

			Result.replace_result (l_attribute)
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
				add_parse_error ("Parsing was not successfull!")
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
