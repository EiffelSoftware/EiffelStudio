indexing
	description: "A text element"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	TEXT_ELEMENT

inherit
	GENERIC_ELEMENT
		rename
			make as make_element
		redefine
			start_tag,
			children_allowed
		end;

create
	make

feature -- Initialization

	make (text: STRING; a_parent: XML_ELEMENT) is
			-- Create node, and set `content' to `text'.
		require
			text_not_void: text /= Void
		do
			content := clone (text)
			content.prune_all ('%N')  -- Remove line breaks
			make_element (a_parent, "Text element")
		end

feature -- Access

	content: STRING
			-- The content of this node.

feature -- Basic operations

	start_tag (target_display: EV_RICH_TEXT) is
			-- Start text region.
		do
			target_display.append_text (content)
		end

feature -- Status report

	children_allowed: BOOLEAN is False
			-- This element may not have children.

invariant
	content_not_void: content /= Void

end -- class TEXT_ELEMENT
