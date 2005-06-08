indexing
	description: "Objects that represents a GRID containing Object values (for debugging)"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID

inherit
	EV_GRID

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
			set_separator_color (create {EV_COLOR}.make_with_8_bit_rgb (210, 210, 210))

			pre_draw_overlay_actions.extend (agent on_draw_borders)

			row_expand_actions.extend (agent on_row_expand)
			row_collapse_actions.extend (agent on_row_collapse)
			set_item_pebble_function (agent on_pebble_function)
			set_item_accept_cursor_function (agent on_pnd_accept_cursor_function)
			set_item_deny_cursor_function (agent on_pnd_deny_cursor_function)
			pointer_double_press_item_actions.extend (agent on_pointer_double_press_item)
			header.pointer_double_press_actions.force_extend (agent on_header_auto_width_resize)

			mouse_wheel_actions.extend (agent on_mouse_wheel_action)
		end

feature -- properties

	name: STRING
			-- associated name to identify the related grid.

feature {NONE} -- Actions implementation

	on_mouse_wheel_action (a_step: INTEGER) is
		local
			vy: INTEGER
		do
			vy := virtual_y_position - 4 * a_step --| 4 is to speed up the scrolling ...
			fixme ("jfiat: check if there is any preference for the scrolling speed ")
			if vy < 0 then
				vy := 0
			else
				vy := vy.min (virtual_height - viewable_height)
			end
			set_virtual_position (virtual_x_position, vy)
		end

	on_pebble_function (a_item: EV_GRID_ITEM): ANY is
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_item /= Void then
				ctler ?= a_item.row.data
				if ctler /= Void then
					Result := ctler.pebble
				end
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
				ei.activate
			end
		end

	on_header_auto_width_resize is
		local
			div_index: INTEGER
			col: EV_GRID_COLUMN
			m: INTEGER
		do
			div_index := header.pointed_divider_index
			if div_index > 0 then
				col := column (div_index)
				m := maximum_width_of_column (col)
				col.set_width (m + 5)
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
						create {EV_GRID_LABEL_ITEM} Result
					end
				else
					create {EV_GRID_LABEL_ITEM} Result
				end
			end
		ensure
			item_computed: item (c, r) /= Void
		end

feature -- Grid helpers

	maximum_width_of_column (col: EV_GRID_COLUMN): INTEGER is
			-- Maximum column's width for column `col'.
		require
			col /= Void
		local
			i: INTEGER
			ait: EV_GRID_LABEL_ITEM
		do
			fixme ("provide better maximum width computing not based on Label")
			if col.count > 0 then
				from
					i := 1
				until
					i > col.count
				loop
					ait ?= col.item (i)
					if ait /= Void then
						Result := Result.max (ait.horizontal_indent + ait.text_width)
					end
					i := i + 1
				end
			end
		end

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
