indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FONT_SELECTION_BOX


inherit
	SELECTION_BOX
		redefine
			make,resource,display
		end

creation
	make

feature -- Creation
	
	make(h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
			-- Creation
		local
			h0,h1,h2: EV_HORIZONTAL_BOX
			com: EV_ROUTINE_COMMAND
		do
			precursor(h,new_caller)
			!! h2.make(frame)
			!! example.make(h2)
			example.set_minimum_width(120)
			!! change_b.make_with_text(h2,"Change ...")
			h2.set_child_expandable(change_b,FALSE)
			h2.set_child_expandable(example,FALSE)
			!! com.make(~change)
			change_b.add_click_command(com, Void)
		end

feature -- Commands

	change (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			resource_exists: resource /= Void
		local
			com: EV_ROUTINE_COMMAND
		do
			!! font_tool.make(caller)
			!! com.make(~font_selected)
			font_tool.add_ok_command(com, Void)
			font_tool.show
		end

	font_selected (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			font_tool_exists: font_tool /= Void
		local
			s: STRING
		do
			caller.update
		end

feature -- Display
	
	Display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			precursor(new_resource)
		end

feature -- Implementation

	font_tool: EV_FONT_DIALOG
		-- Color Palette from which we can select a color.

	resource: FONT_RESOURCE
		-- Resource.

	change_b: EV_BUTTON
		-- Button.

	example: EV_LABEL
		-- Example written with the font.

end -- class FONT_SELECTION_BOX
