indexing
	description	: "Color Selection Box."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

class
	COLOR_SELECTION_BOX

inherit
	SELECTION_BOX
		redefine
			resource, 
			display
		end
		
create
	make

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
				color_b.set_background_color (val)
				color_b.set_foreground_color (val)
			else
				create defcol
				color_b.set_text ("Auto")
				color_b.set_background_color (defcol.Default_background_color)
				color_b.set_foreground_color (defcol.Default_foreground_color)
			end
		end

feature {NONE} -- Commands

	change is
			-- Change the value 
		require
			resource_exists: resource /= Void
		do
			create color_tool
			color_tool.set_color (resource.valid_actual_value)
			color_tool.ok_actions.extend (agent update_changes)
			color_tool.show_modal_to_window (change_dialog)
		end 

	update_changes is
			-- Retrieve Color Dialog data, and update
			-- resource accordingly.
		require else
			color_selected : color_tool.color /= Void
		local
			color: EV_COLOR
		do
			color := color_tool.color
			color_b.set_background_color (color)
			resource.set_value_with_color (color.red_8_bit, color.green_8_bit, color.blue_8_bit)
			update_resource
			caller.update (resource)
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		local
			h2: EV_HORIZONTAL_BOX
			color_frame: EV_FRAME
			a_frame: EV_FRAME
		do
			create color_b
			color_b.set_text ("Auto")

			create change_b.make_with_text_and_action ("Change...", agent change)
			Layout_constants.set_default_size_for_button (change_b)

			create reset_b.make_with_text_and_action ("Auto", agent set_as_auto)
			Layout_constants.set_default_size_for_button (reset_b)

			create color_frame
			color_frame.extend (color_b)
			color_frame.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (40))
			
			create h2
			h2.set_padding (Layout_constants.Dialog_unit_to_pixels (3))
			h2.extend (color_frame)
			h2.disable_item_expand (color_frame)
			h2.extend (change_b)
			h2.disable_item_expand (change_b)
			h2.extend (reset_b)
			h2.disable_item_expand (reset_b)
			h2.extend (create {EV_CELL})

			create a_frame
			a_frame.extend (h2)
			change_item_widget := a_frame
		end

	set_as_auto is
			-- Set `Current' as an auto color (a default must be used).
		require
			resource_may_be_void: resource.is_voidable
		do
			resource.set_void
			update_resource
			caller.update (resource)
		end

	color_tool: EV_COLOR_DIALOG
			-- Color Palette from which we can select a color.

	resource: COLOR_RESOURCE
			-- Resource.

	color_b: EV_LABEL
			-- Label to display the selected color.

	reset_b: EV_BUTTON
			-- Button to set current color to auto.

	change_b: EV_BUTTON
			-- Button labeled "Change"

end -- class COLOR_SELECTION_BOX
