indexing
	description: "Builds an attribute editor for modification of objects of type EV_FIXED."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_FIXED_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		export
			{GB_FIXED_POSITIONER} first, update_editors,
				named_list_item_from_widget
		undefine
			default_create
		end
		
	INTERNAL
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_FIXED
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_FIXED"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			button: EV_BUTTON
		do
			create button.make_with_text ("Position children...")
			if first.is_empty then
				button.disable_sensitive
			end
			create result
			initialize_attribute_editor (Result)
			Result.extend (button)
			button.select_actions.extend (agent show_layout_window)
			
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			if layout_window /= Void and then layout_window.is_show_requested then
				layout_window.update
			end
		end
		
feature {GB_FIXED_POSITIONER} -- Implementation

	set_item_x_position (widget: EV_WIDGET; x_pos: INTEGER) is
			-- Set x_position of `widget' in `first' to `x_pos'.
		local
			second: like ev_type
		do
				-- Only set position if changed.
			if widget.x_position /= x_pos then
				first.set_item_x_position (widget, x_pos)
				second := objects @ 2
				if second /= Void then
					second.set_item_x_position (second @ first.index_of (widget, 1), x_pos)
				end
					-- Update project.
				enable_project_modified
			end
		end
		
	set_item_y_position (widget: EV_WIDGET; y_pos: INTEGER) is
			-- Set y_position of `widget' in `first' to `y_pos'.
		local
			second: like ev_type
		do
				-- Only set position if changed.
			if widget.y_position /= y_pos then
				first.set_item_y_position (widget, y_pos)
				second := objects @ 2
				if second /= Void then
					second.set_item_y_position (second @ first.index_of (widget, 1), y_pos)
				end
					-- Update project.
				enable_project_modified
			end
		end
		
	set_item_width (widget: EV_WIDGET; new_width: INTEGER) is
			-- Set width of `widget' in `first' to `new_width'.
		local
			second: like ev_type
		do
				-- Only set width if changed.
			if widget.width /= new_width then
				first.set_item_width (widget, new_width)
				second := objects @ 2
				if second /= Void then
						-- Only set width of second if greater than minimum_width.
						-- This is because the item in second is displayed larger due to frame.
					if (second @ first.index_of (widget, 1)).minimum_width < new_width then
						second.set_item_width (second @ first.index_of (widget, 1), new_width)
					end
				end
					-- Update project.
				enable_project_modified
			end
		end
		
	set_item_height (widget: EV_WIDGET; new_height: INTEGER) is
			-- Set height of `widget' in `first' to `new_height'.
		local
			second: like ev_type
			combo_box: EV_COMBO_BOX
		do
				-- Only set if height changed.
				-- We cannot resize the height of a combo box, so it is disallowed.
				-- This is a Vision2 Windows limitation.
			combo_box ?= widget
			if widget.height /= new_height and combo_box = Void then
				first.set_item_height (widget, new_height)
				second := objects @ 2
				if second /= Void then
						-- Only set height of second if greater than minimum_width.
						-- This is because the item in second is displayed larger due to frame.
					if (second @ first.index_of (widget, 1)).minimum_height < new_height then
						second.set_item_height (second @ first.index_of (widget, 1), new_height)
					end
				end
					-- Update project.
				enable_project_modified
			end
		end	

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- Nothing to do here.
		end
		
	show_layout_window is
			-- Display window allowing placement of widgets.
		do
			if layout_window = Void then
				create layout_window.make_with_editor (Current)
			end
			layout_window.show_modal_to_window (parent_window (parent_editor))
		end
		
	layout_window: GB_FIXED_POSITIONER
		-- Window used for positining of children.

	x_position_string: STRING is "Children_x_position"
	
	y_position_string: STRING is "Children_y_position"
	
	height_string: STRING is "Children_height"
	
	width_string: STRING is "Children_width"

end -- class GB_EV_FIXED_EDITOR_CONSTRUCTOR
