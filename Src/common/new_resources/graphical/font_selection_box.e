indexing
	description: "Font Selection Box."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	FONT_SELECTION_BOX


inherit
	DIALOG_SELECTION_BOX
		rename
			dialog_tool as font_tool
		redefine
			make,resource,display,font_tool
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

	dialog_ok (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Commit the Result of Font Tool.
		local
			s: STRING
		do
			caller.update
		--	!! s.make(20)
		--	resource.set_value(s)
		end

	create_tool is
			-- Create Font Tool.
		do
			create font_tool.make(caller)
			font_tool.select_font(resource.actual_value)
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

	example: EV_LABEL
		-- Example written with the font.

end -- class FONT_SELECTION_BOX
