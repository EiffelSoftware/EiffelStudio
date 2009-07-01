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
	XT_XEBRA_PARSER
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			Precursor
		end

feature {NONE} -- Access

	tag_lib_parser: PEG_ABSTRACT_PEG
			--
		local
			l_taglib, l_tag, l_tags, l_attribute,
			value, plain_text: PEG_ABSTRACT_PEG
		once
			plain_text := + (open.negate + any_char)

			value := quote + (-(quote.negate + any_char)).consumer + quote
			value.set_behaviour (agent concatenate_results)

				-- Taglib specific
			l_attribute := open + chars ("attribute") + ws + chars ("id") + ws.optional + equals + ws.optional + value + ws.optional + slash + close
			l_attribute.fixate
			l_attribute.set_behaviour (agent build_attribute)
			l_tag := open + chars ("tag") + ws + chars ("id") + ws.optional + equals + ws.optional + value + ws.optional + chars("class") +
					ws.optional + equals + ws.optional + value + ws.optional + close + (-(l_attribute | plain_text)) + open + slash + ws.optional + chars ("tag") + ws.optional + close
			l_tag.fixate
			l_tag.set_behaviour (agent build_tag)
			l_tags := (l_tag | plain_text)
			l_taglib := ws.optional + open + chars("taglib") + ws + chars("id") + ws.optional + equals + ws.optional + value + ws.optional + close
							+ (-l_tags) + open + slash + ws.optional + chars("taglib") + ws.optional + close + ws.optional
			l_taglib.set_behaviour (agent build_taglib)
			Result := l_taglib
		end

feature -- Access

	template: XP_TEMPLATE
			-- The resulting template

	xeb_file: PEG_ABSTRACT_PEG
			-- The xeb parsing grammar

feature -- Basic functionality

	parse (a_string: STRING): XTL_TAG_LIBRARY
			-- Parses a_string and generates a template
		require
			a_string_attached: attached a_string
		local
			l_result: PEG_PARSER_RESULT
		do
			l_result := tag_lib_parser.parse (create {PEG_PARSER_STRING}.make_from_string (a_string))
			if l_result.success and attached {XTL_TAG_LIBRARY} l_result.internal_result.first as l_taglib then
				if not l_result.left_to_parse.is_empty then
					add_parse_error ("Parsing of taglib was incomplete: %"" + l_result.left_to_parse.out + "%"")
				else
					Result := l_taglib
				end
			else
				add_parse_error ("Parsing of taglib was not successfull!")
			end
		end

feature {NONE} -- Convenience

	add_parse_error (a_message: STRING)
			-- Adds a parse error to the error maanager
		do
			error_manager.add_error (create {XERROR_PARSE}.make
				([a_message]), False)
		end

feature {NONE} -- Parser behaviours

	build_attribute (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a {XTL_TAG_DESCRIPTION_ATTRIBUTE}
		require
			a_result_attached: attached a_result
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
		ensure
			Result_attached: attached Result
		end

	build_tag (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Bulds a {XTL_TAG_DESCRIPTION} and adds {XTL_TAG_DESCRIPTION_ATTRIBUTE}s to it
		require
			a_result_attached: attached a_result
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
		ensure
			Result_attached: attached Result
		end

	build_taglib (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Bulds a {XTL_TAG_LIBRARY} and adds {XTL_TAG_DESCRIPTION}s to it
		require
			a_result_attached: attached a_result
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
		ensure
			Result_attached: attached Result
		end

end
