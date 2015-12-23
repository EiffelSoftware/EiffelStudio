note
	description: "[
				XML markup constants
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_MARKUP_CONSTANTS

inherit
	XML_XMLNS_CONSTANTS

feature -- Constants

feature -- Constants

	Stag_start: STRING_32 = "<"
	Stag_end: STRING_32 = ">"
	Etag_start: STRING_32 = "</"
	Etag_end: STRING_32
		once
			Result := Stag_end
		end

	Emptytag_start: STRING_32
		once
			Result := Stag_start
		end

	Emptytag_end: STRING_32 = "/>"

	Pi_start: STRING_32 = "<?"
	Pi_end: STRING_32 = "?>"

	Space_s: STRING_32 = " "
	Eq_s: STRING_32 = "="
	Quot_s: STRING_32 = "%""
	Lf_s: STRING_32 = "%N"
	Prefix_separator: STRING_32 = ":"

	Lt_char: CHARACTER = '<'
	Gt_char: CHARACTER = '>'
	Amp_char: CHARACTER = '&'
	Quot_char: CHARACTER = '%"'

	Lf_char: CHARACTER = '%N'
	Cr_char: CHARACTER = '%R'
	Tab_char: CHARACTER = '%T'
	Space_char: CHARACTER = ' '

	Lt_entity: STRING_32 = "&lt;"
	Gt_entity: STRING_32 = "&gt;"
	Amp_entity: STRING_32 = "&amp;"
	Quot_entity: STRING_32 = "&quot;"
	Apos_entity: STRING_32 = "&apos;"

	Char_entity_prefix: STRING_32 = "&#"
	Entity_suffix: STRING_32 = ";"

	Comment_start: STRING_32 = "<!--"
	Comment_end: STRING_32 = "-->"

	xml_prefix: STRING_32 = "xml"
	xml_space: STRING_32 = "space"

	xml_space_preserve: STRING_32 = "preserve"

	xml_version_1_0: STRING_32 = "1.0"
	xml_version_1_1: STRING_32 = "1.1"

	xml_id: STRING_32 = "id"
	xml_id_with_prefix: STRING_32 = "xml:id"

	xml_lang: STRING_32 = "lang"
	xml_lang_with_prefix: STRING_32 = "xml:lang"

	xml_base: STRING_32 = "base"
	xml_base_with_prefix: STRING_32 = "xml:base"

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
