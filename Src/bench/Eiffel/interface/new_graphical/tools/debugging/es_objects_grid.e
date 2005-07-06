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
			create auto_resized_columns.make
			auto_resized_columns.compare_objects
			
			name := a_name
			enable_tree
			enable_partial_dynamic_content
			enable_row_height_fixed
			set_dynamic_content_function (agent compute_grid_item)
			enable_single_row_selection
			enable_solid_resizing_divider
			set_separator_color (color_separator)
			set_tree_node_connector_color (color_tree_node_connector)

			pre_draw_overlay_actions.extend (agent on_draw_borders)
			header.item_resize_actions.extend (agent invalidate_for_border)

			row_expand_actions.extend (agent on_row_expand)
			row_collapse_actions.extend (agent on_row_collapse)
			set_item_pebble_function (agent on_pebble_function)
			set_item_accept_cursor_function (agent on_pnd_accept_cursor_function)
			set_item_deny_cursor_function (agent on_pnd_deny_cursor_function)
			pointer_double_press_item_actions.extend (agent on_pointer_double_press_item)
			header.pointer_button_press_actions.extend (agent on_header_clicked)
			header.pointer_double_press_actions.force_extend (agent on_header_auto_width_resize)

			mouse_wheel_scroll_size := 3 --| default value
			mouse_wheel_actions.extend (agent on_mouse_wheel_action)
			key_press_actions.extend (agent on_key_pressed)
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

feature -- To be implemented

	enable_grid_redraw is
		do
			to_implement ("here we should call {GRID}.unlock_update")
--			unlock_update
		end

	disable_grid_redraw is
		do
			to_implement ("here we should call {GRID}.lock_update")
--			lock_update
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

feature -- Scrolling

	scroll_rows (a_step: INTEGER; is_full_page_scrolling: BOOLEAN) is
		local
			vy_now, vy: INTEGER
		do
			vy_now := virtual_y_position
			if 
				is_full_page_scrolling
			then
				vy := vy_now - viewable_height * a_step
			else
				vy := vy_now - mouse_wheel_scroll_size * a_step * row_height
			end
			if vy_now /= vy then			
				if vy < 0 then
					vy := 0
				else
					vy := vy.min (maximum_virtual_y_position)
				end
				set_virtual_position (virtual_x_position, vy)
			end
			request_columns_auto_resizing			
		end		

feature {NONE} -- Actions implementation

	on_key_pressed (k: EV_KEY) is
		do
			if 
				not ev_application.ctrl_pressed
				and not ev_application.shift_pressed
				and not ev_application.alt_pressed
			then
				inspect k.code
				when {EV_KEY_CONSTANTS}.key_page_up then
					scroll_rows (+1, True)
				when {EV_KEY_CONSTANTS}.key_page_down then
					scroll_rows (-1, True)
				else
				end
			end
		end
		
	on_mouse_wheel_action (a_step: INTEGER) is
		do
			if 
				mouse_wheel_scroll_full_page
				or ev_application.ctrl_pressed
			then
				scroll_rows (a_step, True)
			else
				scroll_rows (a_step, False)
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
		
	on_header_clicked (ax, ay, abutton: INTEGER; ax_tilt, ay_tilt, apressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			mci: EV_CHECK_MENU_ITEM
			hi: EV_HEADER_ITEM
			col: EV_GRID_COLUMN
			c: INTEGER
		do
			if abutton = 3 then
					--| Find the column whom header is clicked
				from
					c := 1
				until
					c > column_count or col /= Void
				loop
					col := column (c)
					hi := col.header_item
					if header.item_x_offset (hi) > ax and c > 1 then
						col := column (c - 1)
					elseif c = column_count then
						-- keep loop's col value
					else
						col := Void
					end
					c := c + 1
				end
					--| Col is the pointed header
				hi := col.header_item
				create m
				create mi.make_with_text (hi.text)
				mi.disable_sensitive
				m.extend (mi)
				
				m.extend (create {EV_MENU_SEPARATOR})
				
				create mci.make_with_text ("Auto resize")
				if column_has_auto_resizing (col.index) then
					mci.enable_select
					mci.select_actions.extend (agent set_auto_resizing_column (col.index, False))
				else
					mci.disable_select
					mci.select_actions.extend (agent set_auto_resizing_column (col.index, True))
				end
				m.extend (mci)
				m.show_at (header, ax, ay)
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
				process_columns_auto_resizing
			end
			request_columns_auto_resizing			
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
			request_columns_auto_resizing
		end

	on_draw_borders (drawable: EV_DRAWABLE; grid_item: EV_GRID_ITEM; a_column_index, a_row_index: INTEGER) is
		local
			current_column_width, current_row_height: INTEGER
			all_remaining_columns_minimized: BOOLEAN
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
			if a_column_index < column_count then
				if column (a_column_index + 1).virtual_x_position = column (column_count).virtual_x_position + column (column_count).width then
					all_remaining_columns_minimized := True
				end
			end
			if a_column_index = column_count or all_remaining_columns_minimized then
				drawable.draw_segment (current_column_width - 1, 0, current_column_width - 1, current_row_height - 1)
			end
			drawable.draw_segment (0, current_row_height - 1, current_column_width, current_row_height - 1)
		end

	invalidate_for_border (header_item: EV_HEADER_ITEM) is
			-- resized that has a width greater than 0 as the column border must be updated
			-- in this column.
			-- (export status {NONE})
		local
			header_index: INTEGER
			old_header_index: INTEGER
		do
			header_index := header_item.parent.index_of (header_item, 1)
			old_header_index := header_index
			if (last_width_of_header_during_resize = 0 and header_item.width > 0) or last_width_of_header_during_resize_internal > 0 and header_item.width = 0 then
				if header_index > 1 then
					from
						header_index := header_index - 1
					until
						header_index = 1 or column (header_index).width > 0
					loop
						header_index := header_index - 1
					end
				end
				if header_index < old_header_index then
					column (header_index).redraw
				end
			end
		end

	last_width_of_header_during_resize: INTEGER is
                        -- The last width of the header item that is currently being
                        -- resized. Used to determine if we must refresh the column to
                        -- the left of the current one as it could cause the border to
                        -- need to be drawn on the previous column if it is the final
                        -- column that current has a width greater than 0.
		do
			Result := last_width_of_header_during_resize_internal
		ensure
			result_non_negative: Result >= 0
		end

	last_width_of_header_during_resize_internal: INTEGER
   			-- Storage for `last_width_of_header_during_resize'.

	compute_grid_item (c, r: INTEGER): EV_GRID_ITEM is
		local
			a_row: EV_GRID_ROW
			obj_item: ES_OBJECTS_GRID_LINE
		do
debug ("debugger_interface")
	print (generator + ".compute_grid_item ("+c.out+", "+r.out+") %N")
end
			if not is_processing_remove_and_clear_all_rows then
				if c <= column_count and r <= row_count then
					Result := item (c, r)
				end
				if Result = Void then
					a_row := row (r)
					obj_item ?= a_row.data
					if obj_item /= Void then
						if not obj_item.compute_grid_display_done then
							Result := obj_item.computed_grid_item (c)
-- We don't return the item, since they have already been added to the grid ...
--							if 0 < c and c <= a_row.count then
--								Result := a_row.item (c)
--							end
						else
								--| line already computed .. but still missing cells
								--| then we fill with empty cells
							create Result
						end
					else
						create Result
					end
				end
				request_columns_auto_resizing
			end
		end

feature {NONE} -- column resizing
		
	set_auto_resizing_column (c: INTEGER; auto: BOOLEAN) is
		do
			if column_has_auto_resizing (c) then
				if not auto then
					auto_resized_columns.prune_all (c)
				end
			elseif auto then
				auto_resized_columns.extend (c)
			end
			request_columns_auto_resizing			
		end

	timer_columns_auto_resizing: EV_TIMEOUT

	request_columns_auto_resizing is
		do
			if not auto_resized_columns.is_empty then
				if timer_columns_auto_resizing = Void then
					create timer_columns_auto_resizing.make_with_interval (500)
					timer_columns_auto_resizing.actions.extend (agent process_columns_auto_resizing)
				else
					timer_columns_auto_resizing.set_interval (500)
				end
			end
		end
		
	cancel_timer_columns_auto_resizing is
		do
			if timer_columns_auto_resizing /= Void then
				timer_columns_auto_resizing.actions.wipe_out
				timer_columns_auto_resizing.destroy
				timer_columns_auto_resizing := Void
			end
		end

	process_columns_auto_resizing is
		local
			col: EV_GRID_COLUMN
			c: INTEGER
			w: INTEGER
		do
			cancel_timer_columns_auto_resizing
			if row_count > 0 then
				from
					auto_resized_columns.start
				until
					auto_resized_columns.after
				loop
					c:= auto_resized_columns.item
					if c > 0 and c <= column_count then
						col := column (c)
						if col /= Void then
							w := col.required_width_of_item_span (first_visible_row.index, last_visible_row.index) + 3
							if w > 5 then
								col.set_width (w)
							end
-- Let's see what should be the behavior ...
--							col.resize_to_content
						end
					end
					auto_resized_columns.forth
				end
			end
		end
		
	column_has_auto_resizing (c: INTEGER): BOOLEAN is
		do
			Result := auto_resized_columns.has (c)
		end
	
	auto_resized_columns: LINKED_LIST [INTEGER]

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

	remove_and_clear_subrows_from (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		do
			grid_remove_and_clear_subrows_from (a_row)
		end

	remove_and_clear_all_rows is
		require
			not is_processing_remove_and_clear_all_rows
		do
			is_processing_remove_and_clear_all_rows := True
			grid_remove_and_clear_all_rows (Current)
			is_processing_remove_and_clear_all_rows := False
		end
		
	is_processing_remove_and_clear_all_rows: BOOLEAN

end
