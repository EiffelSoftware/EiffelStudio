note
	description: "[
		{XT_XEB_PARSER}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_XEB_PARSER

inherit
	XT_XEBRA_PARSER

create
	make_with_registry

feature -- Initialization

	make_with_registry (a_registry: XP_SERVLET_GG_REGISTRY)
		require
			a_registry_attached: attached a_registry
		do
			make
			registry := a_registry
			source_path := "No source path specified."
		ensure
			registry_set: registry = a_registry
		end

feature {NONE} -- Access

	registry: XP_SERVLET_GG_REGISTRY
			-- The registry for the taglibs

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

feature {NONE} -- Implementation

	xml_parser: PEG_ABSTRACT_PEG
			--
		local
			xeb_file, xml, plain_html_header, xeb_tag_header, plain_html, xeb_tag, doctype,
			namespace_identifier, l_attribute, dynamic_attribute, variable_attribute, value_attribute,
			plain_text, plain_text_without_behaviour, close_fixed, value, plain_html_long_end,
			xeb_tag_long_end: PEG_ABSTRACT_PEG
		once
				-- For graceful recovery of silly mistake: on missing '>' we assume it was there all along
			close_fixed := char ('>')
			close_fixed.set_error_message_handler (agent handle_close_error)
			close_fixed.fixate

				-- Plain text eats all the characters until it reaches a opening tag. Will put a content
				-- tag (with the parsed text as input) on the result list.		
			plain_text := +((open + (identifier_prefix | slash)).negate + any_char)
			plain_text := plain_text.consumer
			plain_text.set_behaviour (agent build_content_tag)
			plain_text.set_name ("plain-text")

				-- Values for attributes of tags. Denote "%=feature%" and "#{variable.something.out}" as well
				-- as normal xml values (plain text)
			value_attribute := (-(quote.negate + any_char)).consumer
			value_attribute.set_behaviour (agent build_value_attribute)
			value_attribute.set_name ("value_attribute")
			dynamic_attribute := (percent + equals + (identifier + (-(dot + identifier))).consumer + percent)
			dynamic_attribute.set_behaviour (agent build_dynamic_attribute)
			dynamic_attribute.set_name ("dynamic_attribute")
			variable_attribute := (sharp + open_curly + (identifier + (+(dot + identifier))).consumer + close_curly)
			variable_attribute.set_behaviour (agent build_variable_attribute)
			variable_attribute.set_name ("variable_attribute")

				-- All possible values which can occur in quotes after a tag attribute
			value := variable_attribute | dynamic_attribute | value_attribute

				-- Tag attributes
			l_attribute := (ws.optional + identifier + ws.optional + equals + ws.optional + quote + value + quote)
			l_attribute.set_behaviour (agent build_attribute)
			l_attribute.fixate
			l_attribute.set_name ("attribute")

			namespace_identifier := identifier + colon + identifier
			namespace_identifier.fixate
			namespace_identifier.set_name ("namespace_identifier")
			plain_html_header := identifier + (ws + (-l_attribute)).optional
			plain_html_header.fixate
			plain_html_header.set_name ("plain_html")
			xeb_tag_header := namespace_identifier + (ws + (-l_attribute)).optional
			xeb_tag_header.fixate
			xeb_tag_header.set_name ("xeb_tag_header")

			create {PEG_CHOICE} xml.make

			plain_html_long_end := (close_fixed + (-xml) + open + slash + ws.optional + identifier)
			plain_html := (open + identifier.enforce +
							plain_html_header + ws.optional + (
									slash | plain_html_long_end
								) + ws.optional + close_fixed
						)
			plain_html.set_name ("plain_html")
			plain_html.set_behaviour (agent build_plain_html)
			plain_html.set_error_message_handler (agent handle_plain_html_error)

			xeb_tag_long_end := (close_fixed + (-xml) + open + slash + ws.optional + namespace_identifier)
			xeb_tag := (open +
							xeb_tag_header + ws.optional + (
									slash | xeb_tag_long_end
								) + ws.optional + close_fixed
						)

			xeb_tag.set_error_message_handler (agent handle_xeb_tag_error)

			xeb_tag.set_behaviour (agent build_xeb_tag)
			xeb_tag.set_name ("xeb_tag")
			xml := xml | (xeb_tag | plain_html) | plain_text
			xml.set_name ("xml")

				-- Same as `plain_text' but no behaviour (no content tag is generated)
			plain_text_without_behaviour := +((open + any_char).negate + any_char)

				-- Doctype
			doctype := char ('<') + char ('!') + plain_text_without_behaviour
			doctype := doctype.consumer
			doctype.set_behaviour (agent build_content_tag)
			doctype.set_name ("doctype")

				-- Xml with pre- and post-context
			xeb_file := ws.optional + doctype.optional + ws.optional + xml + ws.optional
			xeb_file.set_behaviour (agent build_root_tag)
			Result := xeb_file
		end

feature -- Parser error strategies

	handle_xeb_tag_error (a_result: PEG_PARSER_RESULT)
		require
			a_result_attached: attached a_result
		local
			l_count: INTEGER
		do
			l_count := a_result.internal_result.count
			if l_count > 1 then
				a_result.put_error_message ("Missing end tag for start tag '" + a_result.internal_result [1].out + ":" + a_result.internal_result [2].out + "'!")
			else
				a_result.put_error_message ("Invalid tag!")
			end
		end

	handle_plain_html_error (a_result: PEG_PARSER_RESULT)
		require
			a_result_attached: attached a_result
		local
			l_count: INTEGER
		do
			l_count := a_result.internal_result.count
			if l_count > 0 then
				a_result.put_error_message ("Missing end tag for start tag '" + a_result.internal_result [1].out + "'!")
			else
				a_result.put_error_message ("Invalid tag!")
			end
		end

	handle_close_error (a_result: PEG_PARSER_RESULT)
			-- Tells you that here is a '>' missing
		require
			a_result_attached: attached a_result
		do
			a_result.put_error_message ("Missing '>'")
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

	build_plain_html (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a html tag
		require
			a_result_attached: attached a_result
		local
			l_tag: XP_TAG_ELEMENT
			l_i: INTEGER
		do
			Result := a_result
			if attached {STRING} a_result.internal_result.first as l_id then
				create l_tag.make ("", l_id, "XTAG_XEB_HTML_TAG", format_debug (a_result.left_to_parse.debug_information))
				from
					l_i := 2
				until
					l_i > a_result.internal_result.count
				loop
					if attached {TUPLE [id: STRING; value: XP_TAG_ARGUMENT]} a_result.internal_result [l_i] as l_attribute then
--						if l_tag.has_attribute (l_attribute.id) then
--							Result.put_error_message ("Invalid argument detected for " + l_id + ": " + l_attribute.id + "=" + l_attribute.value.value)
--						else
							l_tag.put_attribute (l_attribute.id, l_attribute.value)
--						end
					elseif attached {XP_TAG_ELEMENT} a_result.internal_result[l_i] as l_subtag then
						l_tag.put_subtag (l_subtag)
					end
					l_i := l_i + 1
				end
				if attached {STRING} a_result.internal_result.last as l_last_tag then
					if not l_last_tag.is_equal (l_id) then
						Result.put_error_message ("Non-matching end tag: " + a_result.internal_result.last.out +
											" for start tag: " + a_result.internal_result.first.out)
					end
				end
			end
			if attached l_tag then
				Result.replace_result (l_tag)
			end

		ensure
			Result_attached: attached Result
		end

	build_xeb_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a xebra tag
		require
			a_result_attached: attached a_result
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
								l_i > a_result.internal_result.count
							loop
								if attached {TUPLE [id: STRING; value: XP_TAG_ARGUMENT]} a_result.internal_result [l_i] as l_attribute then
									if not l_taglib.argument_belongs_to_tag (l_attribute.id, l_id) then
										Result.put_error_message ("Invalid argument detected for " + l_namespace + ":" + l_id + ": " + l_attribute.id + "=" + l_attribute.value.value)
									else
										l_tag.put_attribute (l_attribute.id, l_attribute.value)
									end
								elseif attached {XP_TAG_ELEMENT} a_result.internal_result[l_i] as l_subtag then
									l_tag.put_subtag (l_subtag)
								end
								l_i := l_i + 1
							end
							if attached {STRING} a_result.internal_result [a_result.internal_result.count-1] as l_l_namespace then
								if attached {STRING} a_result.internal_result.last as l_l_id then
									l_end_tag := l_namespace + ":" + l_l_id
									if not (l_namespace+":"+l_id).is_equal (l_end_tag) then
										Result.put_error_message ("Unmatched tags: " + l_namespace+":"+l_id + " expected but found: " + l_end_tag)
									end
								end
							end
						else
							Result.put_error_message ("Unknown tag for taglib: " + l_namespace + ":" + l_id)
						end
					else
						Result.put_error_message ("Unknown taglib: " + l_namespace)
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

feature -- Basic Functionality

	parse (a_string: STRING): BOOLEAN
			-- Parses a_string and generates a template
		require
			a_string_attached: attached a_string
		local
			l_result: PEG_PARSER_RESULT
			l_index: INTEGER
		do
			create template.make_empty
			l_result := xml_parser.parse (create {PEG_PARSER_STRING}.make_from_string (a_string))
			if l_result.success and attached {XP_TAG_ELEMENT} l_result.internal_result.first as l_root_tag then
				if not l_result.left_to_parse.is_empty then
					add_parse_error ("Parsing was incomplete. " +
						format_debug (l_result.left_to_parse.debug_information_with_index (l_result.left_to_parse.longest_match.count)))
				else
					template.put_root_tag (l_root_tag)
					Result := True
				end
			else
				from
				l_index := l_result.left_to_parse.longest_match.error_messages.count
				until
					l_index < 1
				loop
					add_parse_error (source_path + ": " + l_index.out + ": " + l_result.left_to_parse.longest_match.error_messages [l_index])
					l_index := l_index - 1
				end
				add_parse_error ("Parsing was not successfull! Error location: " +
					format_debug (l_result.left_to_parse.debug_information_with_index (l_result.left_to_parse.longest_match.count)))
			end
			from
				l_index := l_result.error_messages.count
			until
				l_index < 1
			loop
				add_parse_error (source_path + ": " + l_index.out + ": " + l_result.error_messages [l_index])
				l_index := l_index - 1
			end
		ensure
			template_generated: Result implies template /= Void
		end

invariant
	registry_attached: attached registry

end
