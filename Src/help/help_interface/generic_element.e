indexing
	description: "Generic XML element.  Base class for specific elements."
	author: "Parker Abercrombie"
	date: "$Date$"

class
	GENERIC_ELEMENT

inherit
	XML_NODE
		rename
			make as make_node
		end

create
	make

feature -- Initialization

	make (a_parent: XML_ELEMENT; node_name: STRING) is
			-- Create generic node with name `node_name'.
		require
			node_name_not_void: node_name /= Void
		do
			name := node_name
			make_node (a_parent)
		end;

feature -- Access

	name: STRING
			-- The name of this node.

feature -- Output

	start_tag (target_display: EV_RICH_TEXT) is
			-- Start generic region.
		require
			target_display_exists: not target_display.destroyed
		do
		end

	end_tag (target_display: EV_RICH_TEXT) is
			-- End generic region.
		require
			target_display_exists: not target_display.destroyed
		do
		end

feature -- Status report

	children_allowed: BOOLEAN is
		-- This node may have children.
		do
			Result := True
		end;

end -- class GENERIC_ELEMENT
