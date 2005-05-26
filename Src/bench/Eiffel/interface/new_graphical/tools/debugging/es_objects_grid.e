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

	make (a_name: STRING; a_tool: ES_OBJECTS_GRID_MANAGER) is
			-- Create current with a_name and a_tool
		do
			default_create
			name := a_name
			tool := a_tool
			enable_tree
			enable_partial_dynamic_content
			set_dynamic_content_function (agent compute_grid_item)
			enable_single_row_selection
			enable_solid_resizing_divider
			enable_column_separators
			enable_row_separators
			set_separator_color (create {EV_COLOR}.make_with_8_bit_rgb (210, 210, 210))

			row_expand_actions.extend (agent on_row_expand)
			row_collapse_actions.extend (agent on_row_collapse)
			set_item_pebble_function (agent on_pebble_function)
			set_item_accept_cursor_function (agent on_pnd_accept_cursor_function)
			set_item_deny_cursor_function (agent on_pnd_deny_cursor_function)

			mouse_wheel_actions.extend (agent on_mouse_wheel_action)
		end

feature -- properties

	tool: ES_OBJECTS_GRID_MANAGER
			-- associated tool
			-- (try to get rid of this dependency)

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

	compute_grid_item (c, r: INTEGER): EV_GRID_ITEM is
		local
			glab: EV_GRID_LABEL_ITEM
			a_row: EV_GRID_ROW
			obj_item: ES_OBJECTS_GRID_LINE
			exp_item: EB_EXPRESSION
			col: INTEGER
		do
			col := c
			if col <= column_count and r <= row_count then
				Result := item (col, r)
			end
			if Result = Void then
				a_row := row (r)
				obj_item ?= a_row.data
				if obj_item /= Void then
					obj_item.compute_grid_display
					if 0 < col and col <= a_row.count then
						Result := a_row.item (col)
					end
				else
					exp_item ?= a_row.data
					if exp_item /= Void then
						--FIXME
					end
				end
				if Result = Void then
					create glab.make_with_text ("?")
				end
			end
		end

feature -- Graphical look

	folder_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result.make_with_text (s)
			Result.set_foreground_color (folder_row_fg_color)
		end

	name_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result.make_with_text (s)
		end

	dummy_label_item (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result.make_with_text (s)
			Result.set_foreground_color (dummy_row_fg_color)
		end

	folder_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (60,60,190)
		end

	object_folder_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (60,60,190)
		end

	dummy_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (210, 210, 210)
		end

	slice_row_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (210, 160, 160)
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
