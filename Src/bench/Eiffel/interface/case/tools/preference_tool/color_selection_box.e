indexing
	description: "Color Selection Box."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	COLOR_SELECTION_BOX

inherit
	DIALOG_SELECTION_BOX
		rename
			dialog_tool as color_tool
		redefine
			make,resource,display,color_tool
		end

creation
	make

feature -- Creation
	
	make(h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
			-- Creation
		local
			h2: EV_HORIZONTAL_BOX
			com: EV_ROUTINE_COMMAND
		do
			precursor(h,new_caller)
			!! h2.make(frame)
			!! color_b.make(h2)
			color_b.set_vertical_resize(FALSE)
			color_b.set_horizontal_resize(FALSE)
			color_b.set_minimum_size(30,30)
			!! change_b.make_with_text(h2,"Change ...")
			change_b.set_vertical_resize(FALSE)
			change_b.set_horizontal_resize(FALSE)
			h2.set_child_expandable(change_b,FALSE)
			h2.set_child_expandable(color_b,FALSE)
			!! com.make(~change)
			change_b.add_click_command(com, Void)
		end

feature -- Commands

	dialog_ok (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Popup Color Dialog
		require else
			color_selected : color_tool.color /= Void
		local
			color: EV_COLOR
			s: STRING
		do
			color := color_tool.color
			!! s.make(20)
			s.append(color.red.out)
			s.append(";")
			s.append(color.green.out)
			s.append(";")
			s.append(color.blue.out)
			resource.set_value_with_color(s,color)
			caller.update
		end

	create_tool is
			-- Create Color Tool.
		do
			create color_tool.make(caller)
		end

feature -- Display
	
	Display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			precursor(new_resource)
			color_b.set_background_color(resource.actual_value)
			color_b.set_foreground_color(resource.actual_value)
		end

feature -- Implementation

	color_tool: EV_COLOR_DIALOG
		-- Color Palette from which we can select a color.

	resource: COLOR_RESOURCE
		-- Resource.

	color_b: EV_BUTTON
		-- Buttons.

invariant
	COLOR_SELECTION_BOX_color_b_exists: color_b /= Void
	--COLOR_SELECTION_BOX_color_tool_consistent: color_tool /= Void implies resource /= Void
end -- class COLOR_SELECTION_BOX
