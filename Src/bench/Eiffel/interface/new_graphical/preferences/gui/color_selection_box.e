--| FIXME not reviewed
indexing
	description: "Color Selection Box."
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	COLOR_SELECTION_BOX

inherit
	DIALOG_SELECTION_BOX
		rename
--			dialog_tool as color_tool
		redefine
			make, resource, display --, color_tool
		end

creation
	make

feature -- Creation
	
	make (h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
			-- Creation
		local
			h2: EV_HORIZONTAL_BOX
			reset_b: EV_BUTTON
		do
			Precursor (h, new_caller)
			create h2
			frame.extend (h2)

			create color_b
			h2.extend (color_b)
--			color_b.disable_vertical_resize
--			color_b.disable_horizontal_resize
			h2.disable_item_expand (color_b)
			color_b.set_minimum_size (30, 30)

			create change_b.make_with_text_and_action ("Change ...",~change)
			h2.extend (change_b)
			create reset_b.make_with_text_and_action ("Auto",~change)
			h2.extend (reset_b)
--			change_b.disable_vertical_resize
--			change_b.disable_horizontal_resize
			h2.disable_item_expand (change_b)
		end

feature -- Commands

	update_changes is
			-- Retrieve Color Dialog data, and update
			-- resource accordingly.
		require else
--			color_selected : color_tool.color /= Void
		local
			color: EV_COLOR
			s: STRING
		do
--			color := color_tool.color
			create s.make(20)
			s.append(color.red.out)
			s.append(";")
			s.append(color.green.out)
			s.append(";")
			s.append(color.blue.out)
			resource.set_value_with_color (s, color)
			update_resource
			caller.update
		end

	create_tool is
			-- Create Color Tool.
		do
--			create color_tool
--			color_tool.select_color (resource.actual_value)
--			color_tool.show_modal
		end

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			Precursor (new_resource)
			color_b.set_background_color (resource.actual_value)
			color_b.set_foreground_color (resource.actual_value)
		end

feature -- Implementation

--	color_tool: EV_COLOR_DIALOG
		-- Color Palette from which we can select a color.

	resource: COLOR_RESOURCE
		-- Resource.

	color_b: EV_BUTTON
		-- Buttons.

invariant
	COLOR_SELECTION_BOX_color_b_exists: color_b /= Void
	--COLOR_SELECTION_BOX_color_tool_consistent: color_tool /= Void implies resource /= Void
end -- class COLOR_SELECTION_BOX
