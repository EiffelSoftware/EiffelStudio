indexing
	description:	
		"A pict color button that is a hole and a stone."
	date: "$Date$"
	revision: "$Revision: "

class
	EB_STONE_BUTTON 

inherit
	EV_TOOL_BAR_BUTTON

	STONE_TYPES
		undefine
			default_create
		end

creation
	make_default

feature {NONE} -- Initialization

	make_default (t: EB_TEXT_TOOL) is
			-- Create a button with parent `par',
			-- being also a hole linked to `t'.
		do
			default_create
			tool := t
			pick_actions.extend (~start_pnd)
		end

feature -- Access

	tool: EB_TEXT_TOOL
		-- tool where stones will be dropped in.

feature -- Pick and Throw

	start_pnd (i,j: INTEGER) is
			-- Process dropped stone `a_stone'
		do
			set_pebble (tool.stone)
		end

end -- class EB_STONE_BUTTON
