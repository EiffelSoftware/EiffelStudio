note
	description: "[
				XML markup constants
			]"
	date: "$Date$"
	revision: "$Revision$"

class XML_MARKUP_CONSTANTS

feature -- Constants

	Stag_start: STRING = "<"
	Stag_end: STRING = ">"
	Etag_start: STRING = "</"
	Etag_end: STRING
		once
			Result := Stag_end
		end

	Emptytag_start: STRING
		once
			Result := Stag_start
		end
		
	Emptytag_end: STRING = "/>"

	Pi_start: STRING = "<?"
	Pi_end: STRING = "?>"

	Space_s: STRING = " "
	Eq_s: STRING = "="
	Quot_s: STRING = "%""
	Lf_s: STRING = "%N"
	Prefix_separator: STRING = ":"

	Lt_char: CHARACTER = '<'
	Gt_char: CHARACTER = '>'
	Amp_char: CHARACTER = '&'
	Quot_char: CHARACTER = '%"'

	Lf_char: CHARACTER = '%N'
	Cr_char: CHARACTER = '%R'
	Tab_char: CHARACTER = '%T'
	Space_char: CHARACTER = ' '

	Lt_entity: STRING = "&lt;"
	Gt_entity: STRING = "&gt;"
	Amp_entity: STRING = "&amp;"
	Quot_entity: STRING = "&quot;"

	Char_entity_prefix: STRING = "&#"
	Entity_suffix: STRING = ";"

	Comment_start: STRING = "<!--"
	Comment_end: STRING = "-->"

	default_namespace: string = ""
	xmlns: string = "xmlns"

	xml_prefix: string = "xml"
	xml_space: string = "space"

	xml_space_preserve: string = "preserve"

	xml_version_1_0: string = "1.0"
	xml_version_1_1: string = "1.1"

	xml_prefix_namespace: string = "http://www.w3.org/xml/1998/namespace"
	xmlns_namespace: string = "http://www.w3.org/2000/xmlns/"

	xml_id: string = "id"
	xml_id_with_prefix: string = "xml:id"

	xml_lang: string = "lang"
	xml_lang_with_prefix: string = "xml:lang"

	xml_base: string = "base"
	xml_base_with_prefix: STRING = "xml:base"

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
