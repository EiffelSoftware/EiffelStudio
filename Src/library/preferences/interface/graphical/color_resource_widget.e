indexing
	description	: "Default widget for viewing and editing color resources."
	date		: "$Date$"
	revision	: "$Revision$"

class
	COLOR_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			resource, 
			set_resource
		end
		
create
	make,
	make_with_resource

feature -- Status Setting
	
	set_resource (new_resource: like resource) is
			-- Set the resource.
		local
			val: EV_COLOR
			defcol: EV_STOCK_COLORS
		do
			Precursor (new_resource)
			if resource.value /= Void then
				val := resource.value
				color_label.set_background_color (val)
				color_label.parent.set_background_color (val)
				color_label.set_foreground_color (val)
			else
				create defcol
				color_label.set_text ("Auto")
				color_label.set_background_color (defcol.Default_background_color)
				color_label.set_foreground_color (defcol.Default_foreground_color)
			end
		end
		
feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "COLOR"
		end	
		
	resource: COLOR_PREFERENCE
			-- Actual resource.

feature {PREFERENCE_VIEW} -- Commands

	change is
			-- Change the value.
		require
			resource_exists: resource /= Void
			in_view: caller /= Void
		do
			create color_tool
			color_tool.set_color (resource.value)
			color_tool.ok_actions.extend (agent update_changes)
			color_tool.show_modal_to_window (caller.parent_window)
		end 
		
feature {NONE} -- Commands

	update_changes is
			-- Update the changes made in `change_item_widget' to `resource'.
		require else
			color_selected : color_tool.color /= Void
		local
			color: EV_COLOR
		do
			color := color_tool.color
			color_label.set_background_color (color)
			last_selected_value := color
		end
		
	update_resource is
			-- 
		do
			if last_selected_value /= Void then
				resource.set_value (last_selected_value)
			end	
		end		

	reset is
			-- 
		do
			if resource.has_default_value then
				resource.reset
			end	
			color_label.set_background_color (resource.value)
		end		


feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		local
			h2: EV_HORIZONTAL_BOX
			color_frame: EV_FRAME
			a_frame: EV_FRAME
		do
			create color_label

			create change_b.make_with_text_and_action ("Change...", agent change)

			create color_frame
			color_frame.extend (color_label)
			
			create h2
			h2.set_padding (3)
			h2.extend (color_frame)
			h2.extend (change_b)
			h2.disable_item_expand (change_b)

			create a_frame
			a_frame.extend (h2)
			change_item_widget := a_frame
		end

	color_tool: EV_COLOR_DIALOG
			-- Color Palette from which we can select a color.

	color_label: EV_LABEL
			-- Label to display the selected color.

	reset_b: EV_BUTTON
			-- Button to set current color to auto.

	change_b: EV_BUTTON
			-- Button labeled "Change" to popup EV_COLOR_DIALOG.

	last_selected_value: EV_COLOR

end -- class COLOR_PREFERENCE_WIDGET
