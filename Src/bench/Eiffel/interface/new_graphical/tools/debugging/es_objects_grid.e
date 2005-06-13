indexing
	description: "Objects that represents a GRID containing Object values (for debugging)"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID

inherit
	EV_GRID

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end
	
	EV_GRID_HELPER
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Create current with a_name and a_tool
		do
			default_create
			name := a_name
			enable_tree
			enable_partial_dynamic_content
			set_dynamic_content_function (agent compute_grid_item)
			enable_single_row_selection
			enable_solid_resizing_divider
			set_separator_color (color_separator)
			set_tree_node_connector_color (color_tree_node_connector)

			pre_draw_overlay_actions.extend (agent on_draw_borders)

			row_expand_actions.extend (agent on_row_expand)
			row_collapse_actions.extend (agent on_row_collapse)
			set_item_pebble_function (agent on_pebble_function)
			set_item_accept_cursor_function (agent on_pnd_accept_cursor_function)
			set_item_deny_cursor_function (agent on_pnd_deny_cursor_function)
			pointer_double_press_item_actions.extend (agent on_pointer_double_press_item)
			header.pointer_double_press_actions.force_extend (agent on_header_auto_width_resize)

			mouse_wheel_scroll_size := 3 --| default value
			mouse_wheel_actions.extend (agent on_mouse_wheel_action)
		end
		
	color_separator: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (210, 210, 210)
		end
		
	color_tree_node_connector: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (0, 0, 0)
		end		

feature -- properties

	name: STRING
			-- associated name to identify the related grid.
			
	mouse_wheel_scroll_size: INTEGER
	
	mouse_wheel_scroll_full_page: BOOLEAN
	
feature -- Change

	set_mouse_wheel_scroll_full_page (v: BOOLEAN) is
			-- Set the mouse wheel scroll page mode
		do
			mouse_wheel_scroll_full_page	:= v
		end

	set_mouse_wheel_scroll_size (v: like mouse_wheel_scroll_size) is
			-- Set the mouse wheel scroll size
		do
			mouse_wheel_scroll_size	:= v
		end


feature -- Grid item Activation
	
	grid_activate (a_item: EV_GRID_ITEM) is
		require
			a_item /= Void
		do
			a_item.activate
		end
		
feature -- Query
		
	grid_pebble_from_row (a_row: EV_GRID_ROW): ANY is
			-- Return pebble which may be contained in `a_row'
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_row /= Void then
				ctler ?= a_row.data
				if ctler /= Void then
					Result := ctler.pebble
				end
			end
		end

feature {NONE} -- Actions implementation

	on_mouse_wheel_action (a_step: INTEGER) is
		local
			vy_now, vy: INTEGER
		do
			vy_now := virtual_y_position
			if 
				mouse_wheel_scroll_full_page
				or ev_application.ctrl_pressed
			then
				vy := vy_now - viewable_height * a_step
			else
				vy := vy_now - mouse_wheel_scroll_size * a_step
			end
			if vy_now /= vy then			
				if vy < 0 then
					vy := 0
				else
					vy := vy.min (virtual_height - viewable_height)
				end
				set_virtual_position (virtual_x_position, vy)
			end
		end

	on_pebble_function (a_item: EV_GRID_ITEM): ANY is
		do
			if 
				not ev_application.ctrl_pressed
				and a_item /= Void 
			then
				Result := grid_pebble_from_row (a_item.row)
			end
		end

	on_pnd_accept_cursor_function (a_item: EV_GRID_ITEM): EV_CURSOR is
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_item /= Void then
				ctler ?= a_item.row.data
				if ctler /= Void then
					Result := ctler.pnd_accept_cursor
				end
			end
		end

	on_pnd_deny_cursor_function (a_item: EV_GRID_ITEM): EV_CURSOR is
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_item /= Void then
				ctler ?= a_item.row.data
				if ctler /= Void then
					Result := ctler.pnd_deny_cursor
				end
			end
		end
		
	on_pointer_double_press_item (ax,ay,ab: INTEGER; a_item: EV_GRID_ITEM) is
		local
			ei: ES_OBJECTS_GRID_CELL
		do
			ei ?= a_item
			if ei /= Void then
				grid_activate (ei)
			end
		end

	on_header_auto_width_resize is
		local
			div_index: INTEGER
			col: EV_GRID_COLUMN
		do
			div_index := header.pointed_divider_index
			if div_index > 0 then
				col := column (div_index)
				if ev_application.shift_pressed then
					col.set_width (col.required_width_of_item_span (first_visible_row.index, last_visible_row.index) + 3)
				else
					col.set_width (col.required_width_of_item_span (1, col.parent.row_count) + 3)
				end
			end			
		end

	on_row_expand (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			ctler ?= a_row.data
			if ctler /= Void then
				ctler.call_expand_actions (a_row)
			end
		end

	on_row_collapse (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			ctler ?= a_row.data
			if ctler /= Void then
				ctler.call_collapse_actions (a_row)
			end
		end

	on_draw_borders (drawable: EV_DRAWABLE; grid_item: EV_GRID_ITEM; a_column_index, a_row_index: INTEGER) is
		local
			current_column_width, current_row_height: INTEGER
		do
			drawable.set_foreground_color (separator_color)
			current_column_width := column (a_column_index).width
			if is_row_height_fixed then
				current_row_height := row_height
			else
				current_row_height := row (a_row_index).height
			end
			if a_column_index > 1 then
				drawable.draw_segment (0, 0, 0, current_row_height - 1)
			end
			if a_column_index = column_count then
				drawable.draw_segment (current_column_width - 1, 0,  current_column_width - 1, current_row_height - 1)
			end
			drawable.draw_segment (0, current_row_height - 1, current_column_width, current_row_height - 1)
		end
 
	compute_grid_item (c, r: INTEGER): EV_GRID_ITEM is
		local
			a_row: EV_GRID_ROW
			obj_item: ES_OBJECTS_GRID_LINE
		do
debug ("debugger_interface")
	print (generator + ".compute_grid_item ("+c.out+", "+r.out+") %N")
end
			if c <= column_count and r <= row_count then
				Result := item (c, r)
			end
			if Result = Void then
				a_row := row (r)
				obj_item ?= a_row.data
				if obj_item /= Void then
					if not obj_item.compute_grid_display_done then
						obj_item.compute_grid_display
-- We don't return the item, since they have already been added to the grid ...
--						if 0 < c and c <= a_row.count then
--							Result := a_row.item (c)
--						end
					else
							--| line already computed .. but still missing cells
							--| then we fill with empty cells
						create Result
					end
				else
					create Result
				end
			end
		ensure
			item_computed: Result /= Void or else item (c, r) /= Void
		end

feature -- Grid helpers

	front_new_row: EV_GRID_ROW is
		do
			Result := grid_front_new_row (Current)
		end

	extended_new_row: EV_GRID_ROW is
		do
			Result := grid_extended_new_row (Current)
		end
		
	extended_new_subrow (a_row: EV_GRID_ROW): EV_GRID_ROW is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		do
			Result := grid_extended_new_subrow (a_row)
		end	

	remove_subrows_from (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		do
			grid_remove_subrows_from (a_row)
		end

	remove_all_rows is
		do
			grid_remove_all_rows (Current)
		end

end
