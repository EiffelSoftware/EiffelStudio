note
	description: "Collection of default feed parsers."
	date: "$Date$"
	revision: "$Revision$"

class
	FEED_DEFAULT_PARSERS

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create {ARRAYED_LIST [FEED_PARSER]} parsers.make (2)
			parsers.force (create {RSS_2_FEED_PARSER})
			parsers.force (create {ATOM_FEED_PARSER})
		end

feature -- Access		

	parsers: LIST [FEED_PARSER]
			-- Available Feed parsers.

feature -- Access

	feed_from_string (a_atom_content: READABLE_STRING_8): detachable FEED
		local
			p: XML_STANDARD_PARSER
			cb_tree: XML_CALLBACKS_FILTER_DOCUMENT
			xdoc: XML_DOCUMENT
		do
			create p.make
			create cb_tree.make_null
			p.set_callbacks (cb_tree)
			p.parse_from_string_8 (a_atom_content)
			if p.is_correct then
				xdoc := cb_tree.document
				Result := feed (xdoc)
			end
		end

	feed (xdoc: XML_DOCUMENT): like feed_from_string
			-- Feed from `xdoc' XML document.	
		do
			across
				parsers as ic
			until
				Result /= Void
			loop
				if ic.item.is_detected (xdoc) then
					Result := ic.item.feed (xdoc)
				end
			end
		end

end
