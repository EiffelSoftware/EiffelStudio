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
			dialog_tool as color_tool
		redefine
			make, resource, display, color_tool
		end
		
creation
	make

feature -- Creation
	
	make (h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
			-- Creation
		local
			h2: EV_HORIZONTAL_BOX
		do
			Precursor (h, new_caller)
			create h2
			h2.set_padding (3)
			h2.set_border_width (3)

			create color_b
			color_b.set_text ("default")
			h2.extend (color_b)
--			color_b.disable_vertical_resize
--			color_b.disable_horizontal_resize
--			h2.disable_item_expand (color_b)
--			color_b.set_minimum_size (30, 30)

			create change_b.make_with_text_and_action ("Change ...",~change)
			h2.extend (change_b)
			h2.disable_item_expand (change_b)
			create reset_b.make_with_text_and_action ("Auto",~set_as_auto)
			h2.extend (reset_b)
--			change_b.disable_vertical_resize
--			change_b.disable_horizontal_resize
			h2.disable_item_expand (reset_b)
			frame.extend (h2)
		end

feature -- Commands

	update_changes is
			-- Retrieve Color Dialog data, and update
			-- resource accordingly.
		require else
			color_selected : color_tool.color /= Void
		local
			color: EV_COLOR
			s: STRING
		do
			color := color_tool.color
			create s.make(20)
			s.append((color.red * 255).floor.out)
			s.append(";")
			s.append((color.green * 255).floor.out)
			s.append(";")
			s.append((color.blue * 255).floor.out)
			color_b.set_background_color (color)
			resource.set_value_with_color (s, color)
			update_resource
			caller.update
		end

	create_tool is
			-- Create Color Tool.
		do
			create color_tool
			color_tool.set_color (resource.valid_actual_value)
--			color_tool.show_modal_to_window (caller)
		end

	set_as_auto is
			-- Set `Current' as an auto color (a default must be used).
		require
			resource_may_be_void: resource.is_voidable
		do
			resource.set_void
			update_resource
			caller.update
		end
	

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		local
			val: EV_COLOR
			defcol: EV_STOCK_COLORS
		do
			Precursor (new_resource)
			if resource.is_voidable then
				reset_b.enable_sensitive
			else
				reset_b.disable_sensitive
			end
			if not resource.color_is_void then
				val := resource.actual_value
				color_b.remove_text
				color_b.set_background_color (val)
				color_b.set_foreground_color (val)
			else
				create defcol
				color_b.set_text ("default")
				color_b.set_background_color (defcol.Default_background_color)
				color_b.set_foreground_color (defcol.Default_foreground_color)
			end
		end

feature -- Implementation

	color_tool: EV_COLOR_DIALOG
		-- Color Palette from which we can select a color.

	resource: COLOR_RESOURCE
		-- Resource.

	color_b: EV_LABEL
		-- Label to display the selected color.

	reset_b: EV_BUTTON
		-- Button to set current color to auto.

invariant
	COLOR_SELECTION_BOX_color_b_exists: color_b /= Void
	--COLOR_SELECTION_BOX_color_tool_consistent: color_tool /= Void implies resource /= Void
end -- class COLOR_SELECTION_BOX
