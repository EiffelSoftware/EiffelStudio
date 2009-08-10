note
	description: "[
		{XT_TAGLIB_PARSER}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_TAGLIB_PARSER

inherit
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
			create template.make_empty
			--create xeb_file.
		end

feature {NONE} -- Access

	tag_lib_parser: PEG_ABSTRACT_PEG
			--
		local
			l_taglib, l_tag, l_tags, l_attribute,
			value, plain_text: PEG_ABSTRACT_PEG
		once
			plain_text := + (open.negate + any)

			value := quote + (-(quote.negate + any)).consumer + quote
			value.set_behaviour (agent concatenate_results)

				-- Taglib specific
			l_attribute := open + stringp ("attribute") &+ stringp ("id") |+ equals |+ value |+
							(stringp ("optional") |+ equals |+ value).optional |+ slash + close
			l_attribute.fixate
			l_attribute.set_behaviour (agent build_attribute)
			l_tag := open + stringp ("tag") &+ stringp ("id") |+ equals |+ value |+ stringp("class") |+
					equals |+ value |+ close + (-(l_attribute | plain_text)) + open + slash |+ stringp ("tag") |+ close
			l_tag.fixate
			l_tag.set_behaviour (agent build_tag)
			l_tags := (l_tag | plain_text)
			l_taglib := whitespaces.optional + open + stringp("taglib") &+ stringp("id") |+ equals |+ value |+ close
							+ (-l_tags) + open + slash |+ stringp("taglib") |+ close + whitespaces.optional
			l_taglib.set_behaviour (agent build_taglib)
			Result := l_taglib
		end

feature -- Access

	template: XP_TEMPLATE
			-- The resulting template

feature -- Basic functionality

	parse (a_string: STRING): detachable XTL_TAG_LIBRARY
			-- Parses a_string and generates a template
		require
			a_string_attached: attached a_string
		local
			l_result: PEG_PARSER_RESULT
		do
			l_result := tag_lib_parser.parse (create {PEG_PARSER_STRING}.make_from_string (a_string))
			if l_result.success and attached {XTL_TAG_LIBRARY} l_result.internal_result.first as l_taglib then
				if not l_result.left_to_parse.is_empty then
					add_parse_error ("Parsing of taglib was incomplete. " + l_result.longest_match_debug)
				else
					Result := l_taglib
				end
			else
				add_parse_error ("Parsing of taglib was not successfull! Error location: " + l_result.longest_match_debug)
			end
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
				if a_result.internal_result.count > 1 and then
					attached {STRING} a_result.internal_result [2] as l_optional then
					if l_optional.is_boolean then
						l_attribute.optional := l_optional.to_boolean;
					else
						add_parse_error ("Invalid Boolean value for attribute: '" + l_value + "'! Assumed 'False'.")
					end
				end
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
			l_tag: detachable XTL_TAG_DESCRIPTION
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
			if attached l_tag as ll_tag then
				Result.replace_result (ll_tag)
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
