indexing
	description: "Builds an attribute editor for modification of objects of type EV_FIXED."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			button: EV_TOOL_BAR_BUTTON
			tool_bar: EV_TOOL_BAR
			horizontal_box: EV_HORIZONTAL_BOX
		do
			create button.make_with_text ("Position children...")
			create tool_bar
			tool_bar.extend (button)
			if first.is_empty then
				button.parent.disable_sensitive
			end
			create result.make_with_components (components)
			initialize_attribute_editor (Result)
			create horizontal_box
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			Result.extend (horizontal_box)
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
			index: INTEGER
		do
				-- Only set position if changed.
			if widget.x_position /= x_pos then
				index := first.index_of (widget, 1)
				actual_set_item_x_position (object, index, x_pos)
				for_all_instance_referers (object, agent actual_set_item_x_position (?, index, x_pos))

					-- Update project.
				enable_project_modified
			end
		end
		
	actual_set_item_x_position (an_object: GB_OBJECT; index, x_pos: INTEGER) is
			-- Set `index' items within representations of `an_object' to x position `x_pos'.
		require
			object_not_void: an_object /= Void
			index_valid: an_object.children /= Void implies index >= 1 and index <= an_object.children.count
		local
			fixed: EV_FIXED
		do
			fixed ?= an_object.object
			check
				object_was_fixed: fixed /= Void
			end
			fixed.set_item_x_position (fixed.i_th (index), x_pos)
			fixed ?= an_object.real_display_object
			if fixed /= Void then
				check
					object_was_fixed: fixed /= Void
				end
				fixed.set_item_x_position (fixed.i_th (index), x_pos)
			end
		end
		
	set_item_y_position (widget: EV_WIDGET; y_pos: INTEGER) is
			-- Set y_position of `widget' in `first' to `y_pos'.
		local
			index: INTEGER
		do
				-- Only set position if changed.
			if widget.y_position /= y_pos then
				index := first.index_of (widget, 1)
				actual_set_item_y_position (object, index, y_pos)
				for_all_instance_referers (object, agent actual_set_item_y_position (?, index, y_pos))
					-- Update project.
				enable_project_modified
			end
		end
		
	actual_set_item_y_position (an_object: GB_OBJECT; index, y_pos: INTEGER) is
			-- Set `index' items within representations of `an_object' to y position `y_pos'.
		require
			object_not_void: an_object /= Void
			index_valid: an_object.children /= Void implies index >= 1 and index <= an_object.children.count
		local
			fixed: EV_FIXED
		do
			fixed ?= an_object.object
			check
				object_was_fixed: fixed /= Void
			end
			fixed.set_item_y_position (fixed.i_th (index), y_pos)
			fixed ?= an_object.real_display_object
			if fixed /= Void then
				check
					object_was_fixed: fixed /= Void
				end
				fixed.set_item_y_position (fixed.i_th (index), y_pos)
			end
		end
		
	set_item_width (widget: EV_WIDGET; new_width: INTEGER) is
			-- Set width of `widget' in `first' to `new_width'.
		local
			index: INTEGER
		do
				-- Only set width if changed.
			if widget.width /= new_width then
				index := first.index_of (widget, 1)
				actual_set_item_width (object, index, new_width)
				for_all_instance_referers (object, agent actual_set_item_width (?, index, new_width))
					-- Update project.
				enable_project_modified
			end
		end
		
	actual_set_item_width (an_object: GB_OBJECT; index, new_width: INTEGER) is
			-- Set width of `index' item within representations of `an_object' to `new_width'.
		require
			object_not_void: an_object /= Void
			new_width_positive: new_width >=0
		local
			fixed: EV_FIXED
		do
			fixed ?= an_object.object
			check
				object_was_fixed: fixed /= Void
			end
			fixed.set_item_width (fixed.i_th (index), new_width)
			fixed ?= an_object.real_display_object
			if fixed /= Void then
				check
					object_was_fixed: fixed /= Void
				end
				if fixed.i_th (index).minimum_width < new_width then
					fixed.set_item_width (fixed.i_th (index), new_width)
				end
			end
		end	

	set_item_height (widget: EV_WIDGET; new_height: INTEGER) is
			-- Set height of `widget' in `first' to `new_height'.
		local
			combo_box: EV_COMBO_BOX
			index: INTEGER
		do
				-- Only set if height changed.
				-- We cannot resize the height of a combo box, so it is disallowed.
				-- This is a Vision2 Windows limitation.
			combo_box ?= widget
			if widget.height /= new_height and combo_box = Void then
				index := first.index_of (widget, 1)
				actual_set_item_height (object, index, new_height)
				for_all_instance_referers (object, agent actual_set_item_height (?, index, new_height))
					-- Update project.
				enable_project_modified
			end
		end	
		
	actual_set_item_height (an_object: GB_OBJECT; index, new_height: INTEGER) is
			-- Set height of `index' item within representations of `an_object' to `new_height'.
		require
			object_not_void: an_object /= Void
			new_height_positive: new_height >=0
		local
			fixed: EV_FIXED
		do
			fixed ?= an_object.object
			check
				object_was_fixed: fixed /= Void
			end
			fixed.set_item_height (fixed.i_th (index), new_height)
			fixed ?= an_object.real_display_object
			if fixed /= Void then
				check
					object_was_fixed: fixed /= Void
				end
				if fixed.i_th (index).minimum_height < new_height then
					fixed.set_item_height (fixed.i_th (index), new_height)
				end
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
	
	width_string: STRING is "Children_width";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_EV_FIXED_EDITOR_CONSTRUCTOR
