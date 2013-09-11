note
	description: "Summary description for {HTML_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_PARSER

inherit
	XML_STANDARD_PARSER
		redefine
			report_missing_attribute_value,
			report_unsupported_bom_value
		end

create
	make

feature {NONE} -- Query

	report_unsupported_bom_value (a_bom: READABLE_STRING_GENERAL)
		do
			-- Accept unsupported bom value: ignore
		end

	report_missing_attribute_value (p: detachable READABLE_STRING_32; n: READABLE_STRING_32)
		do
			-- Accept attribute without value
			-- assume it is empty
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
