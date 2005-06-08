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
			set_resource,
			change_item_widget,
			update_changes
		end
		
create
	make,
	make_with_resource

feature -- Status Setting
	
	set_resource (new_resource: like resource) is
			-- Set the resource.
		do
			Precursor (new_resource)
--			if resource.value /= Void then
--				val := resource.value
--				color_label.set_background_color (val)
--				color_label.parent.set_background_color (val)
--				color_label.set_foreground_color (val)
--			else
--				create defcol
--				color_label.set_text ("Auto")
--				color_label.set_background_color (defcol.Default_background_color)
--				color_label.set_foreground_color (defcol.Default_foreground_color)
--			end
		end
		
feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "COLOR"
		end	
		
	resource: COLOR_PREFERENCE
			-- Actual resource.

	last_selected_value: EV_COLOR

	change_item_widget: EV_GRID_DRAWABLE_ITEM

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
			last_selected_value := color
			if last_selected_value /= Void then
				resource.set_value (last_selected_value)
			end	
			Precursor {PREFERENCE_WIDGET}
		end
		
	update_resource is
			-- 
		do
			if last_selected_value /= Void then
				resource.set_value (last_selected_value)
			end	
		end		

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.expose_actions.extend (agent on_color_item_exposed (?))
			change_item_widget.set_data (resource)			
			change_item_widget.pointer_double_press_actions.force_extend (agent show_change_item_widget)
		end

	show_change_item_widget is
			-- 
		do
			change
			if last_selected_value /= Void then
				resource.set_value (last_selected_value)
			end
		end		

	on_color_item_exposed (area: EV_DRAWABLE) is
			-- Expose part of color preference value item.
		do
			if change_item_widget.row.is_selected then				
				area.set_foreground_color (change_item_widget.parent.focused_selection_color)
				area.fill_rectangle (0, 0, change_item_widget.width, change_item_widget.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.draw_text_top_left (20, 1, resource.string_value)					
			else
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.fill_rectangle (0, 0, change_item_widget.width, change_item_widget.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				area.draw_text_top_left (20, 1, resource.string_value)					
			end			
			area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
			area.draw_rectangle (1, 1, 12, 12)
			area.set_foreground_color (resource.value)
			area.fill_rectangle (2, 2, 10, 10)			
		end		

	color_tool: EV_COLOR_DIALOG
			-- Color Palette from which we can select a color.

end -- class COLOR_PREFERENCE_WIDGET
