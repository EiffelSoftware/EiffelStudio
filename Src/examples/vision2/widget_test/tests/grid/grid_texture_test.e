indexing
	description: "[
		Objects that show drawing capabilities of EV_GRID. Double click control items to change
		settings.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_TEXTURE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			combo_item: EV_GRID_COMBO_ITEM
			counter: INTEGER
		do
			create grid
			grid.set_minimum_size (300, 300)
			grid.enable_tree
			add_items (5, 50)
			from
				counter := 20
			until
				counter > 40
			loop
				grid.row (counter).add_subrow (grid.row (counter + 1))
				counter := counter + 1
			end
			grid.insert_new_row (1)
			grid.disable_row_height_fixed
			from
				counter := 5
			until
				counter > 20
			loop
				grid.remove_item (3, counter)
				grid.remove_item (2, counter)
				counter := counter + 1
			end
			grid.pointer_button_press_item_actions.extend (agent grid_pressed)
			create combo_item.make_with_text ("Texture applied to : Background")
			combo_item.activate_actions.extend (agent fill_texture_combo (?, combo_item))
			combo_item.deactivate_actions.extend (agent reset_combo_text ("Texture applied to : ", combo_item))
			grid.set_item (1, 1, combo_item)
			
			create combo_item.make_with_text ("Scroll Texture : True")
			combo_item.activate_actions.extend (agent fill_scroll_combo (?, combo_item))
			combo_item.deactivate_actions.extend (agent reset_combo_text ("Scroll Texture : ", combo_item))
			grid.set_item (2, 1, combo_item)
			
				-- Now conenct events which perform the drawing of the textures.
			grid.pre_draw_overlay_actions.extend (agent draw_texture)
			grid.post_draw_overlay_actions.extend (agent draw_borders)
			grid.fill_background_actions.extend (agent draw_background)
			
			texture_style := 2
			scroll_style := 1
			
				-- Resize columns to width required to display contents.
			grid.column (1).set_width (grid.column (1).required_width_of_item_span (1, grid.row_count) + 4)
			grid.column (2).set_width (grid.column (2).required_width_of_item_span (1, grid.row_count) + 4)

			widget := grid
		end
		
feature {NONE} -- Implementation

	grid: EV_GRID
		-- Widget that test is to be performed on.
		
	stock_colors: EV_STOCK_COLORS is
			-- Once access to EiffelVision2 stock colors
			-- (from GRID_ACCESSOR)
		once
			create Result
		end
		
	add_items (columns, rows: INTEGER) is
			-- Add items to `grid' occupying `columns' columns
			-- and `rows.
		local
			grid_label_item: EV_GRID_LABEL_ITEM
			column_counter, row_counter: INTEGER
		do		
			from
				row_counter := 1
			until
				row_counter > rows
			loop
				from
					column_counter := 1
				until
					column_counter > columns
				loop
					create grid_label_item.make_with_text (column_counter.out + ", " + row_counter.out )
					grid.set_item (column_counter, row_counter, grid_label_item)
					column_counter := column_counter + 1	
				end
				row_counter := row_counter + 1
			end
		end
		
	fill_texture_combo (window: EV_POPUP_WINDOW; combo: EV_GRID_COMBO_ITEM) is
			-- Fill `combo' with items  for selecting the texture style.
		require
			window_not_void: window /= Void
			combo_not_void: combo /= Void
		local
			list_item: EV_LIST_ITEM
		do
			combo.combo_box.select_actions.block
			create list_item.make_with_text ("None")
			combo.combo_box.extend (list_item)
			create list_item.make_with_text ("Background")
			combo.combo_box.extend (list_item)
			create list_item.make_with_text ("All")
			combo.combo_box.extend (list_item)
			if texture_style = 2 then
				combo.combo_box.i_th (2).enable_select
			elseif texture_style = 3 then
				combo.combo_box.i_th (3).enable_select
			end
			combo.combo_box.select_actions.extend (agent combo_texture_item_selected (combo.combo_box))
			combo.combo_box.select_actions.resume
		end

	fill_scroll_combo (window: EV_POPUP_WINDOW; combo: EV_GRID_COMBO_ITEM) is
			-- Fill `combo' with items  for selecting the texture scrolling style.
		require
			window_not_void: window /= Void
			combo_not_void: combo /= Void
		local
			list_item: EV_LIST_ITEM
		do
			combo.combo_box.select_actions.block
			create list_item.make_with_text ("True")
			combo.combo_box.extend (list_item)
			create list_item.make_with_text ("False")
			combo.combo_box.extend (list_item)
			if scroll_style = 2 then
				combo.combo_box.i_th (2).enable_select
			end
			combo.combo_box.select_actions.extend (agent combo_scroll_item_selected (combo.combo_box))
			combo.combo_box.select_actions.resume
		end

	combo_texture_item_selected (a_combo_box: EV_COMBO_BOX) is
			-- An item has been selected from `a_combo_box' signifying
			-- the texturing to be applied. Update internal
			-- values to reflect this.
		require
			a_combo_box_not_void: a_combo_box /= Void
		local
			selected_index: INTEGER
			label_item: EV_GRID_LABEL_ITEM
		do
			selected_index := a_combo_box.index_of (a_combo_box.selected_item, 1)
			label_item ?= grid.item (1, 1)
			inspect selected_index
			when 1 then
				texture_style := 1
				label_item.set_text ("Texture applied to : None")
			when 2 then
				texture_style := 2
				label_item.set_text ("Texture applied to : Background")
			else
				texture_style := 3
				label_item.set_text ("Texture applied to : All")
			end
			grid.redraw
		end
		
	combo_scroll_item_selected (a_combo_box: EV_COMBO_BOX) is
			-- An item has been selected from `a_combo_box' signifying
			-- the texture scroll style to be applied. Update internal
			-- values to reflect this.
		require
			a_combo_box_not_void: a_combo_box /= Void
		local
			selected_index: INTEGER
			label_item: EV_GRID_LABEL_ITEM
		do
			selected_index := a_combo_box.index_of (a_combo_box.selected_item, 1)
			label_item ?= grid.item (2, 1)
			inspect selected_index
			when 1 then
				scroll_style := 1
				label_item.set_text ("Scroll Texture : True")
				grid.disable_full_redraw_on_virtual_position_change
			when 2 then
				scroll_style := 2
				label_item.set_text ("Scroll Texture : False")
				grid.enable_full_redraw_on_virtual_position_change
			end
			grid.redraw
		end
		
	reset_combo_text (s: STRING; combo_item: EV_GRID_COMBO_ITEM) is
			-- Restore text of `combo_item' to `s' + selected item text of `combo_item'.
		require
			s_not_void: s /= Void
			combo_item_not_void: combo_item /= Void
		do
			combo_item.set_text (s + combo_item.combo_box.selected_item.text)
		end
		
	draw_texture (drawable: EV_DRAWABLE; grid_item: EV_GRID_ITEM; a_column_index, a_row_index: INTEGER) is
			-- Draw applied texture for item `grid_item' onto `drawable'.
		require
			drawable_not_void: drawable /= Void
		local
			an_x, a_y: INTEGER
			virtual_x, virtual_y: INTEGER
			a_height, a_width: INTEGER
			indent: INTEGER
		do
			if texture_style > 1 then
				if a_row_index > 1 or a_column_index > 2 then
					virtual_x := grid.column (a_column_index).virtual_x_position
					if scroll_style = 2 then
						virtual_x := virtual_x - grid.virtual_x_position
					end
					an_x := (virtual_x \\ texture_width)
					virtual_y := grid.row (a_row_index).virtual_y_position
					if scroll_style = 2 then
						virtual_y := virtual_y - grid.virtual_y_position
					end
					a_y := (virtual_y \\ texture_height)
					if grid.is_row_height_fixed then
						a_height := grid.row_height
					else
						a_height  := grid.row (a_row_index).height
					end
					a_width := grid.column (a_column_index).width
					if (texture_style = 2 and grid_item = Void) or texture_style = 3 then
						internal_draw_texture (drawable, an_x, a_y, a_width, a_height)
					else
						indent := grid_item.horizontal_indent
						if indent > 0 then
							internal_draw_texture (drawable, an_x, a_y, indent, a_height)
						end
					end
				end
			end
		end
		
	internal_draw_texture (drawable: EV_DRAWABLE; texture_x, texture_y, a_width, a_height: INTEGER) is
			-- Draw `marble' texture onto `drawable' offset by `texture_x' and `texture_y' with
			-- dimensions of `a_width' and `a_height'.
		require
			drawable_not_void: drawable /= Void
		local
			an_x, a_y: INTEGER
			last_x_segment, last_y_segment: INTEGER
			current_texture_x, current_texture_Y: INTEGER
		do
			from
				an_x := 0
				current_texture_x := texture_x
			until
				an_x >= a_width
			loop
				last_x_segment := (texture_width - current_texture_x).min (a_width - an_x)
				from
					a_y := 0
					current_texture_y := texture_y
				until
					a_y >= a_height
				loop
					last_y_segment := (texture_height - current_texture_y).min (a_height - a_y)
					drawable.draw_sub_pixmap (an_x, a_y, marble, create {EV_RECTANGLE}.make (current_texture_x, current_texture_y, last_x_segment, last_y_segment))
					current_texture_y := 0
					a_y := a_y + last_y_segment
				end
				drawable.draw_sub_pixmap (an_x, a_y, marble, create {EV_RECTANGLE}.make (current_texture_x, current_texture_y, last_x_segment, last_y_segment))
				current_texture_x := 0
				an_x := an_x + last_x_segment
			end
		end
		
	draw_borders (drawable: EV_DRAWABLE; grid_item: EV_GRID_ITEM; a_column_index, a_row_index: INTEGER) is
			-- Draw a border around cells 1,1 and 2,1 with a width of `border_width'.
		require
			drawable_not_void: drawable /= Void
			a_column_index_positive: a_column_index >= 1
			a_row_index_positive: a_row_index >= 1
		do
			if a_row_index = 1 then
				if grid_item /= Void then
					drawable.set_foreground_color (stock_colors.black)
					drawable.fill_rectangle (0, grid_item.height - border_width, grid.column (a_column_index).width, grid_item.height)
					drawable.set_foreground_color (stock_colors.black)
					drawable.fill_rectangle (0, 0, grid.column (a_column_index).width, border_width)
				end
				if a_column_index = 1 then
					drawable.set_foreground_color (stock_colors.black)
					drawable.fill_rectangle (0, 0, border_width, grid_item.height - border_width)
				elseif a_column_index = 2 then
					drawable.set_foreground_color (stock_colors.black)
					drawable.fill_rectangle (grid.column (a_column_index).width - border_width, 0, grid.column (a_column_index).width - border_width, grid_item.height - border_width)
				end
			end
		end
		
	border_width: INTEGER is 1
		-- Wdith of borders around control items.
		
	draw_background (drawable: EV_DRAWABLE; a_virtual_x, a_virtual_y, a_width, a_height: INTEGER) is
			-- Draw `marble' texture onto `drawable' offset by `texture_x' and `texture_y' with
			-- dimensions of `a_width' and `a_height'.
		require
			drawable_not_void: drawable /= Void
		local
			an_x, a_y: INTEGER
			virtual_x, virtual_y: INTEGER
		do
			if texture_style > 1 then
				virtual_x := a_virtual_x
				if scroll_style = 2 then
					virtual_x := virtual_x - grid.virtual_x_position
				end
				an_x := (virtual_x \\ texture_width)
				virtual_y := a_virtual_y
				if scroll_style = 2 then
					virtual_y := virtual_y - grid.virtual_y_position
				end
				a_y := (virtual_y \\ texture_height)
				if (texture_style = 2) or texture_style = 3 then
					internal_draw_texture (drawable, an_x, a_y, a_width, a_height)
				end
			else
				drawable.set_foreground_color (grid.background_color)
				drawable.fill_rectangle (0, 0, a_width, a_height)
			end
		end
		
	scroll_style: INTEGER
		-- Scrolling style applied to texture.

	texture_style: INTEGER
		-- Applied texture style.
	
	texture_width: INTEGER is
			-- Width of marble texture.
		once
			Result := marble.width
		end

	texture_height: INTEGER is
			-- Height of marble texture.
		once
			Result := marble.height
		end
	
	marble: EV_PIXMAP is
			-- Once access to a marble textured pixmap.
		once
			Result := numbered_pixmap (3)
		end
		
	grid_pressed (an_x, a_y, a_button: INTEGER; grid_item: EV_GRID_ITEM) is
			-- Respond to a button press in the grid. If the left button is
			-- pressed on the combo item, activate that item.
		do
			if grid_item /= Void and then a_button = 1 then
				if grid_item.column.index <= 2 and grid_item.row.index = 1 then
					grid_item.activate
				end
			end
		end
	
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


end -- class GRID_TEXTURE_TEST
