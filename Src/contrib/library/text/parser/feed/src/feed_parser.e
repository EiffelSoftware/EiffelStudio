note
	description: "[
				Interface common to any FEED parser.
				
				Usage:
					create parser
					if attached parser.feed_from_string (l_feed_content) as l_feed then
						...
						
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FEED_PARSER

inherit
	FEED_PARSER_UTILITIES

feature -- Access

	name: STRING
			-- Associated name.
		deferred
		ensure
			not_blanc: not Result.is_whitespace
		end

	is_detected (xdoc: XML_DOCUMENT): BOOLEAN
			-- Is `xdoc' an feed representation or Current supported format?		
		deferred
		end

	feed (xdoc: XML_DOCUMENT): detachable FEED
			-- Feed from `xdoc' XML document.
		require
			is_detected: is_detected (xdoc)
		deferred
		end

feature -- Basic operations		

	feed_from_string (a_content: READABLE_STRING_8): like feed
			-- Feed from `a_content' document.
		local
			p: XML_STANDARD_PARSER
			cb_tree: XML_CALLBACKS_FILTER_DOCUMENT
			xdoc: XML_DOCUMENT
		do
			create p.make
			create cb_tree.make_null
			p.set_callbacks (cb_tree)
			p.parse_from_string_8 (a_content)
			if p.is_correct then
				xdoc := cb_tree.document
				if is_detected (xdoc) then
					Result := feed (xdoc)
				end
			end
		end

end
