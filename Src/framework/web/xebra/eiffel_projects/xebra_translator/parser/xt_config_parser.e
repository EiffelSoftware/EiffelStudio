note
	description: "Summary description for {XT_CONFIG_PARSER}."
	author: ""
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_CONFIG_PARSER

inherit
	XT_XEBRA_PARSER

create
	make

feature -- Basic Functionality

	parse (a_string: STRING): LIST [TUPLE [STRING, STRING, STRING]]
			-- Parses `a_string' and returns a configuration if succesfull, otherwise an empty list
		require
			a_string_attached: attached a_string
		local
			l_result: PEG_PARSER_RESULT
		do
			l_result := xml_parser.parse_string (a_string)
			create {ARRAYED_LIST [TUPLE [STRING, STRING, STRING]]} Result.make (0)
			if l_result.success then
				if not l_result.left_to_parse.is_empty then
					add_parse_error ("Parsing was incomplete. " +
						format_debug (l_result.left_to_parse.debug_information_with_index (l_result.left_to_parse.longest_match.count)))
				else
					if attached {LIST [TUPLE [STRING, STRING, STRING]]} l_result.internal_result.first as l_config then
						Result := l_config
					end
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
				add_parse_error (source_path + ": " + l_result.error_messages.index.out + ": " + l_result.error_messages.item)
				l_result.error_messages.forth
			end
		ensure
			a_string_attached: attached a_string
		end

feature {NONE} -- Parser

	xml_parser: PEG_ABSTRACT_PEG
				--
			local
				xeb_file, xml, plain_html_header, xeb_tag_header, plain_html,
				namespace_identifier, l_attribute, value_attribute,
				plain_text, plain_text_without_behaviour, close_fixed, value, taglib, config: PEG_ABSTRACT_PEG
			once
					-- For graceful recovery of silly mistake: on missing '>' we assume it was there all along
				close_fixed := char ('>')
				close_fixed.fixate

					-- Plain text eats all the characters until it reaches a opening tag. Will put a content
					-- tag (with the parsed text as input) on the result list.		
				plain_text := +((open + (identifier_prefix | slash)).negate + any_char)
				plain_text := plain_text.consumer

					-- Values for attributes of tags. Denote "%=feature%" and "#{variable.something.out}" as well
					-- as normal xml values (plain text)
				value_attribute := (-(quote.negate + any_char)).consumer
				value_attribute.set_name ("value_attribute")

					-- All possible values which can occur in quotes after a tag attribute
				value := value_attribute

					-- Tag attributes
				l_attribute := (ws.optional + identifier + ws.optional + equals + ws.optional + quote + value + quote)
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

				taglib := (open + chars("taglib") + ws.optional + (-l_attribute) + ws.optional + (
										slash |
										(close_fixed + (-xml) + open + slash + ws.optional + chars("taglib"))
									)
							+ close)
				taglib.set_name ("taglib")
				taglib.set_behaviour (agent build_taglib)
				config := (open + chars("config") + ws.optional + (-l_attribute) + ws.optional + (
										slash |
										(close_fixed + (-xml) + open + slash + ws.optional + chars("config"))
									)
							+ close)
				config.set_name ("config")
				config.set_behaviour (agent build_config)

				xml := xml | config | taglib | plain_text
				xml.set_name ("xml")

					-- Xml with pre- and post-context
				xeb_file := ws.optional + xml + ws.optional
				Result := xeb_file
			end

feature {NONE} -- Builders

	build_config (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a list of tuples
		require
			a_result_attached: attached a_result
		local
			l_list: ARRAYED_LIST [TUPLE [STRING, STRING, STRING]]
		do
			from
				Result := a_result
				Result.internal_result.start
				create l_list.make (Result.internal_result.count)
			until
				Result.internal_result.after
			loop
				if attached {TUPLE [STRING, STRING, STRING]} Result.internal_result.item as l_taglib then
					l_list.extend (l_taglib)
				end
				Result.internal_result.forth
			end
			Result.replace_result (l_list)
		ensure
			Result_attached: attached Result
		end

	build_taglib (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a tuble representing a taglib
		require
			a_result_attached: attached a_result
		local
			l_result: TUPLE [name, ecf, path: STRING]
		do
			l_result := ["", "", ""]
			Result := a_result
			if attached {STRING} Result.internal_result [2] as l_name then
				if attached {STRING} Result.internal_result [4] as l_ecf then
					if attached {STRING} Result.internal_result [6] as l_path then
						l_result.name := l_name
						l_result.ecf := l_ecf
						l_result.path := l_path
					end
				end
			end
			Result.replace_result (l_result)
		ensure
			Result_attached: attached Result
		end

end
