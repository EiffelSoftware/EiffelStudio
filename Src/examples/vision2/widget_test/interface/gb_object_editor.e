indexing
	description: "Vision2 tour version of GB_OBJECT_EDITOR%
		%necessary for compilation and building purposes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITOR

inherit

	EV_VERTICAL_BOX
		export
			{NONE} all
			{ANY} destroy, parent, is_destroyed
		undefine
			is_in_default_state
		redefine
			initialize
		end
		
	INTERNAL
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
		
	GB_WIDGET_UTILITIES
		export
			{NONE} all
			{ANY} parent_window
		undefine
			default_create, copy, is_equal
		end
		
	WIDGET_TEST_SHARED
		undefine
			default_create, copy, is_equal
		end
		
	SUPPORTED_TYPES
		undefine
			default_create, copy, is_equal
		end
		
feature -- Initialization

	initialize is
			-- Initialize `Current'.
		local
			tool_bar: EV_TOOL_BAR
			separator: EV_HORIZONTAL_SEPARATOR
			vertical_box1: EV_VERTICAL_BOX			
		do
			Precursor {EV_VERTICAL_BOX}
			set_border_width (3)
			create vertical_box1
			create tool_bar
			vertical_box1.extend (tool_bar)
			vertical_box1.disable_item_expand (tool_bar)
			create separator
			vertical_box1.extend (separator)
			vertical_box1.disable_item_expand (separator)
			create attribute_editor_box
			create scrollable_holder
			create viewport
			viewport.set_minimum_width (Minimum_width_of_object_editor)
			create scrollable_holder
			vertical_box1.extend (scrollable_holder)
			create control_holder
			create scroll_bar
			scroll_bar.set_step (12)
			control_holder.set_minimum_width (Minimum_width_of_object_editor)
			vertical_box1.set_minimum_width (Minimum_width_of_object_editor + scroll_bar.width)
			scrollable_holder.extend (viewport)
			viewport.extend (control_holder)
			control_holder.extend (attribute_editor_box)
			control_holder.disable_item_expand (attribute_editor_box)

			control_holder.resize_actions.force_extend (agent update_scroll_bar)
			viewport.resize_actions.force_extend (agent update_scroll_bar)
			scroll_bar.change_actions.extend (agent scroll_bar_changed)
			scroll_bar.hide
			scrollable_holder.extend (scroll_bar)
			scrollable_holder.disable_item_expand (scroll_bar)
			extend (vertical_box1)
			vertical_box1.set_minimum_height (100)
			
			create item_parent
			control_holder.extend (item_parent)
			control_holder.disable_item_expand (item_parent)
			
			
			register_type_change_agent (agent set_type (?))
			is_initialized := True
		end
		
	is_in_default_state: BOOLEAN is True

feature -- Status setting

	set_type (a_widget: EV_WIDGET) is
			-- Assign `an_object' to `object'.
			-- Set up `Current' to modify `object'.
		do
			construct_editor (a_widget)			
			update_scroll_bar
		end

feature {NONE} -- Implementation
		
	Minimum_width_of_object_editor: INTEGER is 160

	construct_editor (widget: EV_WIDGET) is
			-- Build `Current'. Build all attribute editors and populate,
			-- to represent `object'.
		local
			current_type: STRING
			current_window_parent: EV_WINDOW
			locked_in_here: BOOLEAN
			common_editor: GB_COMMON_EDITOR
			container: EV_CONTAINER
			list: EV_LIST
			tree: EV_TREE
			combo_box: EV_COMBO_BOX
			tool_bar: EV_TOOL_BAR
			drawable: EV_DRAWABLE
			multi_column_list: EV_MULTI_COLUMN_LIST
			list_extendible_controls: LIST_EXTENDIBLE_CONTROLS
			tree_extendible_controls: TREE_EXTENDIBLE_CONTROLS
			multi_column_list_extendible_controls: MULTI_COLUMN_LIST_EXTENDIBLE_CONTROLS
			combo_box_extendible_controls: COMBO_BOX_EXTENDIBLE_CONTROLS
			tool_bar_extendible_controls: TOOL_BAR_EXTENDIBLE_CONTROLS
			container_extendible_controls: CONTAINER_EXTENDIBLE_CONTROLS
			drawing_controls: DRAWABLE_CONTROLS
			object: GB_OBJECT
		do
			current_window_parent := parent_window (Current)
			if current_window_parent /= Void and ((create {EV_ENVIRONMENT}).application.locked_window = Void) then
				locked_in_here := True
				current_window_parent.lock_update	
			end
			attribute_editor_box.wipe_out
			
			from
				supported_types.start
			until
				supported_types.off
			loop
				current_type := supported_types.item
				current_type.to_upper
				if is_instance_of (widget, dynamic_type_from_string (current_type.substring (4, current_type.count))) then
					common_editor ?= new_instance_of (dynamic_type_from_string (current_type))
					common_editor.default_create
					common_editor.set_main_object (widget)
					common_editor.set_object (object)
					create object
					object.set_object (widget)
					common_editor.set_parent_editor (attribute_editor_box)
					attribute_editor_box.extend (common_editor.attribute_editor)
				end
				supported_types.forth
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_DRAWABLE")) then
				drawable ?= widget
				check
					widget_is_drawable: drawable /= Void
				end
				create drawing_controls.make_with_control (drawable, Current)
				attribute_editor_box.extend (drawing_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_LIST")) then
				list ?= widget
				check
					widget_is_list: list /= Void
				end
				create list_extendible_controls.make_with_text_control (list, Current)
				attribute_editor_box.extend (list_extendible_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_COMBO_BOX")) then
				combo_box ?= widget
				check
					widget_is_combo_box: combo_box /= Void
				end
				create combo_box_extendible_controls.make_with_text_control (combo_box, Current)
				attribute_editor_box.extend (combo_box_extendible_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_TREE")) then
				tree ?= widget
				check
					widget_is_tree: tree /= Void
				end
				create tree_extendible_controls.make_with_text_control (tree, Current)
				attribute_editor_box.extend (tree_extendible_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_MULTI_COLUMN_LIST")) then
				multi_column_list ?= widget
				check
					widget_is_multi_column_list: multi_column_list /= Void
				end
				create multi_column_list_extendible_controls.make_with_text_control (multi_column_list, Current)
				attribute_editor_box.extend (multi_column_list_extendible_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_TOOL_BAR")) then
				tool_bar ?= widget
				check
					widget_is_tool_bar: tool_bar /= Void
				end
				create tool_bar_extendible_controls.make_with_combo_control (tool_bar, Current,
					<<"BUTTON", "TOGGLE_BUTTON", "RADIO_BUTTON",
					"SEPARATOR">>)
				attribute_editor_box.extend (tool_bar_extendible_controls)
			end
			if is_instance_of (widget, dynamic_type_from_string ("EV_CONTAINER"))
				and not is_instance_of (widget, dynamic_type_from_string ("EV_GRID")) then
					-- Special case handling for EV_GRID as we do not wish to display the
					-- container properties for the grid.
					
				container ?= widget
				check
					widget_is_container: container /= Void
				end
				create container_extendible_controls.make_with_combo_control (container, Current,
					<<"BUTTON", "FRAME", "TEXT">>)
				attribute_editor_box.extend (container_extendible_controls)
			end
			
			if current_window_parent /= Void and locked_in_here then
				current_window_parent.unlock_update	
			end
		end
		
	update_scroll_bar is
			-- Show/hide the scroll bar as appropriate. Modify the
			-- range of the scroll bar as needed.
		local
			interval: INTEGER_INTERVAL
			timeout: EV_TIMEOUT
			locked_in_this_feature: BOOLEAN
		do
			if viewport.height < control_holder.minimum_height then
				if not scroll_bar.is_show_requested then
					if ((create {EV_ENVIRONMENT}).application.locked_window = Void) then
						locked_in_this_feature := True
						parent_window (Current).lock_update
					end
					viewport.resize_actions.pause
					control_holder.resize_actions.pause
						-- There is no way ti resize a box in a viewport to
						-- be smaller, so we must rebuild a new box,
						-- and expand it by putting the items in.
					control_holder.wipe_out
					viewport.prune_all (control_holder)
					create control_holder
					viewport.extend (control_holder)
					control_holder.extend (attribute_editor_box)
					control_holder.disable_item_expand (attribute_editor_box)
					control_holder.extend (item_parent)
					control_holder.disable_item_expand (item_parent)
				
						-- Set up the minimum width on the new box.
					control_holder.set_minimum_width (Minimum_width_of_object_editor)
					viewport.set_minimum_width (Minimum_width_of_object_editor)
					control_holder.resize_actions.force_extend (agent update_scroll_bar)
						-- Create a timeout and set up the action to fix a Windows
						-- Vision2 bug. See comment in `show_scroll_bar_again'.
					create timeout.make_with_interval (5)
					timeout.actions.extend (agent show_scroll_bar_again (timeout))
					scroll_bar.show	
					
					viewport.resize_actions.resume
					control_holder.resize_actions.resume
					if locked_in_this_feature then
						parent_window (Current).unlock_update
					end
				end
			else
				scroll_bar.hide
				scroll_bar_changed (0)
				control_holder.set_minimum_width (Minimum_width_of_object_editor + scroll_bar.width)
				viewport.set_minimum_width (Minimum_width_of_object_editor + scroll_bar.width)
			end
				-- If the scroll bar is visible then we must update the values
				-- to match the size of the 
			if scroll_bar.is_show_requested then
				create interval.make (0, control_holder.minimum_height - viewport.height)
				if viewport.height > 0 then
					scroll_bar.set_leap (viewport.height)
				end
				scroll_bar.value_range.adapt (interval)
				scroll_bar_changed (scroll_bar.value)
			end
		end
		
	show_scroll_bar_again (a_timeout: EV_TIMEOUT) is
			-- Call show on `scroll_bar' and destroy `a_timeout'.
			-- This is needed, as there is a Vision2 resizing bug on Windows
			-- which stops teh scroll bar being displayed when it is first shown, as you
			-- resize the main window smaller. Therefore,
			-- we call show on it after the resizing has occured to combat this problem.
			-- There should be no ill effects on either platform.
		do
			scroll_bar.show
			a_timeout.destroy			
		end
		
		
	scroll_bar_changed (value: INTEGER) is
			-- Set the offset of the controls to `Value'
			-- within the viewport.
		do
			viewport.set_y_offset (value)
		end

	item_parent: EV_VERTICAL_BOX
		-- An EV_VERTICAL_BOX to hold all GB_OBJECT_EDITOR_ITEM.
		
	name_field: EV_TEXT_FIELD
		-- Entry for the object name.
		
	event_selection_button: EV_BUTTON
		-- Brings up the event selection dialog.
		
	attribute_editor_box: EV_VERTICAL_BOX
		-- All attribute editors are placed in here.

	scrollable_holder: EV_HORIZONTAL_BOX
		-- Holds the viewport and a scrollbar.
		
	scroll_bar: EV_VERTICAL_SCROLL_BAR
		-- Scroll bar to control the positioning of the object editor.
		
	viewport: EV_VIEWPORT
		-- Viewport containg the attribute editors.
	
	control_holder: EV_VERTICAL_BOX;
		-- Holds the controls, and is placed in the scrollable area.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_OBJECT_EDITOR

