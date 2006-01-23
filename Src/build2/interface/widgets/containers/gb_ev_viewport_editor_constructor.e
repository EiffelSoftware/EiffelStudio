indexing
	description: "Builds an attribute editor for modification of objects of type EV_VIEWPORT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_VIEWPORT_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_VIEWPORT
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_VIEWPORT"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			
			create x_offset_entry.make (Current, Result, x_offset_string, gb_ev_viewport_x_offset, gb_ev_viewport_x_offset_tooltip,
				agent set_x_offset (?), agent valid_position (?), components)
			create y_offset_entry.make (Current, Result, y_offset_string, gb_ev_viewport_y_offset, gb_ev_viewport_y_offset_tooltip,
				agent set_y_offset (?), agent valid_position (?), components)
			create item_width_entry.make (Current, Result, item_width_string, gb_ev_viewport_item_width, gb_ev_viewport_item_width_tooltip,
				agent set_item_width (?), agent valid_item_width (?), components)
			create item_height_entry.make (Current, Result, item_height_string, gb_ev_viewport_item_height, gb_ev_viewport_item_height_tooltip,
				agent set_item_height (?), agent valid_item_height (?), components)
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			execution_agents.put (agent set_x_offset (?), x_offset_string)
			validate_agents.put (agent valid_position (?), X_offset_string)
			execution_agents.put (agent set_y_offset (?), Y_offset_string)
			validate_agents.put (agent valid_position (?), Y_offset_string)
			execution_agents.put (agent set_item_width (?), Item_width_string)
			validate_agents.put (agent valid_item_width (?), Item_width_string)
			execution_agents.put (agent set_item_height (?), Item_height_string)
			validate_agents.put (agent valid_item_height (?), Item_height_string)
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			x_offset_entry.update_constant_display (first.x_offset.out)
			y_offset_entry.update_constant_display (first.y_offset.out)
			if first.full then
				item_width_entry.update_constant_display (first.item.width.out)
				item_height_entry.update_constant_display (first.item.height.out)
			else
				item_width_entry.set_text ("0")
				item_height_entry.set_text ("0")
			end
				-- We need to enable/disable all input fields
				-- depending on whether there is currently an item
				-- in the viewport. This is because these attributes
				-- are only applicable on the children.
			if first.is_empty then
				x_offset_entry.disable_sensitive
				y_offset_entry.disable_sensitive
				item_width_entry.disable_sensitive
				item_height_entry.disable_sensitive
			else
				x_offset_entry.enable_sensitive
				y_offset_entry.enable_sensitive
				item_width_entry.enable_sensitive
				item_height_entry.enable_sensitive
			end
		end

	set_x_offset (integer: INTEGER) is
			-- Update property `x_offset' on all items in `objects'.
		do
			for_all_objects (agent {EV_VIEWPORT}.set_x_offset (integer))
			update_editors
		end
		
	set_y_offset (integer: INTEGER) is
			-- Update property `y_offset' on all items in `objects'.
		do
			for_all_objects (agent {EV_VIEWPORT}.set_y_offset (integer))
			update_editors
		end
		
	valid_position (integer: INTEGER): BOOLEAN is
			-- Is `integer' a valid coordinate in a viewport.
		do
			Result := True
		end
		
	set_item_width (integer: INTEGER) is
			-- Call `set_item_width' on all items in `objects'.
		do
				-- Note that we cannot use `for_all_objects' as we need to check the
				-- desired size against the allowable size for the second widget.
				-- This is because the minimum size of that widget is consrained by
				-- the additional parenting used in the builer display.
			actual_set_item_width (object, integer)
			for_all_instance_referers (object, agent actual_set_item_width (?, integer))
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			enable_project_modified
			update_editors
		end
		
	actual_set_item_width (an_object: GB_OBJECT; width: INTEGER) is
			-- Set width of widgets contained in representations of `an_object' to `width'.
		require
			an_object_not_void: an_object /= Void
		local
			viewport: EV_VIEWPORT
		do
			viewport ?= an_object.object
			check
				object_was_viewport: viewport /= Void
			end
			viewport.set_item_width (width)
			viewport ?= an_object.real_display_object
			if viewport /= Void then
				check
					object_was_viewport: viewport /= Void
				end
				viewport.set_item_width (width.max (viewport.item.width))
			end
		end

	set_item_height (integer: INTEGER) is
			-- Call `set_item_height' on all items in `objects'.
		do
				-- Note that we cannot use `for_all_objects' as we need to check the
				-- desired size against the allowable size for the second widget.
				-- This is because the minimum size of that widget is consrained by
				-- the additional parenting used in the builer display.
			actual_set_item_height (object, integer)
			for_all_instance_referers (object, agent actual_set_item_height (?, integer))
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			enable_project_modified
			update_editors
		end
		
	actual_set_item_height (an_object: GB_OBJECT; height: INTEGER) is
			-- Set height of widgets contained in representations of `an_object' to `height'.
		require
			an_object_not_void: an_object /= Void
		local
			viewport: EV_VIEWPORT
		do
			viewport ?= an_object.object
			check
				object_was_viewport: viewport /= Void
			end
			viewport.set_item_height (height)
			viewport ?= an_object.real_display_object
			if viewport /= Void then
				check
					object_was_viewport: viewport /= Void
				end
				viewport.set_item_height (height.max (viewport.item.height))
			end
		end
		
	valid_item_width (integer: INTEGER): BOOLEAN is
			-- Is `integer' a valid width for item of `Current'?
		do
			if integer >= first.item.minimum_width then
				Result := True
			end
		end
		
	valid_item_height (integer: INTEGER): BOOLEAN is
			-- Is `integer' a valid height for item of `Current'?
		do
			if integer >= first.item.minimum_height then
				Result := True
			end
		end

	x_offset_string: STRING is "X_offset"
	y_offset_string: STRING is "Y_offset"
	item_width_string: STRING is "Item_width"
	item_height_string: STRING is "Item_height"
	
	x_offset_entry, y_offset_entry, item_width_entry, item_height_entry: GB_INTEGER_INPUT_FIELD;
		-- Input widgets for `x_offset', `y_offset', `set_item_width' and `set_item_height'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_EV_VIEWPORT_EDITOR_CONSTRUCTOR
