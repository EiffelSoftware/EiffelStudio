note
	description: "[
				Metadata parser from string or file
				
				usage
				loader: MD_LOADER
				
				create loader.make_with_string (a_html_content)
				if attached loader.microdata as md then
					... manipulate the metadata from `md'
				end
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_LOADER

create
	make_with_path,
	make_with_string

feature {NONE} -- Initialization

	make_with_path (a_filename: PATH)
		do
			initialize
			xml_parser.parse_from_path (a_filename)
			if not xml_parser.error_occurred then
				build_microdata
			end
		end

	make_with_string (a_string: READABLE_STRING_GENERAL)
		do
			initialize
			xml_parser.parse_from_string (a_string)
			if not xml_parser.error_occurred then
				build_microdata
			end
		end

	initialize
		local
			p: HTML_PARSER
			cb: XML_CALLBACKS_DOCUMENT
		do
			create p.make
			create cb.make_null
			p.set_callbacks (cb)

			xml_callback_document := cb
			xml_parser := p
		end

	build_microdata
		local
			md: like microdata
			ext: XML_MD_EXTRACTOR
		do
			create md.make

			if attached xml_callback_document.document as xdoc then
				create ext.make_with_document (md)
				xdoc.process (ext)
				md := ext.document
			end
			microdata := md
		end

feature -- Access

	microdata: detachable MD_DOCUMENT

feature {NONE} -- Implementation

	xml_parser: XML_PARSER

	xml_callback_document: XML_CALLBACKS_DOCUMENT

;note
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
