indexing
	description: "A line break"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	LINE_BREAK

inherit
	GENERIC_ELEMENT
		redefine
			start_tag,
			children_allowed
		end;

create
	make

feature -- Basic operations

	start_tag (target_display: EV_RICH_TEXT) is
			-- Add line break.
		do
			target_display.append_text ("%N")
		end

feature -- Status report

	children_allowed: BOOLEAN is False
			-- This element may not have children.

end -- class LINE_BREAK
