class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_menu_command,
			on_accelerator_command,
			on_paint,
			class_icon,
			class_background
		end

	WEL_WINDOWS_ROUTINES

	GAME_CONSTANTS

	APP_CONSTANTS
		export
			{NONE} all
		end

	WEL_MK_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_RASTER_OPERATIONS_CONSTANTS
		export
			{NONE} all
		end

	WEL_SYSTEM_METRICS
		export
			{NONE} all
		end

	WEL_ID_CONSTANTS
		export
			{NONE} all
		end

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create the main_window, the virtual DC,
			-- the backgound DC and set the menu.
		local
			background_bitmap: WEL_BITMAP
			virtual_bitmap: WEL_BITMAP
		do
			make_top ("Xcell")
			create client_dc.make (Current)
			client_dc.get
			create virtual_dc.make_by_dc (client_dc)
			create background_dc.make_by_dc (client_dc)
			create virtual_bitmap.make_compatible (client_dc, scr_width, scr_height)
			create background_bitmap.make_compatible (client_dc, scr_width, scr_height)
			virtual_dc.select_bitmap (virtual_bitmap)
			background_dc.select_bitmap (background_bitmap)	
			set_menu (main_menu)
			resize_to_start_window
		end

feature {NONE} -- Implementation

	number_of_cards: INTEGER
			-- Number of cards to play with

	move_is_finished: BOOLEAN
			-- Is the move not finished?

	game_number: INTEGER
			-- Game number to play

	started: BOOLEAN
			-- Is the game started?

	virtual_dc: WEL_MEMORY_DC
			-- DC for copying the invalidated card regions

	background_dc: WEL_MEMORY_DC
			-- DC for copying the invalidated background

	client_dc: WEL_CLIENT_DC
			-- The client-area DC

	game_manager: GAME_MANAGER
			-- Manages the state of the game

	on_menu_command (id_menu: INTEGER) is
			-- Process the command identified by `id_menu'
		do
			if id_menu = Cmd_exit then
				if closeable then
					destroy
				end
			elseif id_menu = Cmd_about then
				about_box.activate
			elseif id_menu = Cmd_how_to_play then
				how_to_play_box.activate
			elseif id_menu = Cmd_new then
				move_is_finished := True
				change_cursor_to_wait
				main_menu.disable_item (Cmd_select_number_of_cards)
				main_menu.disable_item (Cmd_select_game_number)
				main_menu.disable_item (Cmd_new)
				main_menu.enable_item (Cmd_stop)
				if number_of_cards = 0 then
					number_of_cards := Maximum_number_of_cards
				end
				create game_manager.make (number_of_cards)
				if game_number = 0 then
					game_number := tick_count \\ Maximum_game_number
					select_game_number_dialog.set_game_number (game_number)
				end
				game_manager.shuffle_the_cards (game_number)
				game_manager.deal_game
				draw_background_virtual
				game_manager.initialize_the_cards
				draw_cards
				client_dc.bit_blt (0, 0, scr_width, scr_height, virtual_dc, 0, 0, Srccopy)
				started := true
				resize (680, 600)
				change_cursor_to_default
			elseif id_menu = Cmd_select_game_number then
				select_game_number_dialog.activate
				if select_game_number_dialog.result_id = Idok then
					game_number := select_game_number_dialog.game_number
				end
			elseif id_menu = Cmd_stop then
				main_menu.disable_item (Cmd_stop)
				main_menu.enable_item (Cmd_new)
				main_menu.enable_item (Cmd_select_number_of_cards)
				main_menu.enable_item (Cmd_select_game_number)
				virtual_dc.pat_blt (0, 0, scr_width, scr_height, patcopy)
				resize_to_start_window
				game_manager := Void
				started := false
			elseif id_menu = Cmd_select_number_of_cards then
				select_number_of_cards_dialog.activate
				if select_number_of_cards_dialog.result_id = Idok then
					number_of_cards := select_number_of_cards_dialog.no_cards
				end
			end
		end

	change_cursor_to_wait is
			-- Change the cursor to a waiting cursor image
		local
			cursor: WEL_CURSOR
		do
			create cursor.make_by_predefined_id (Idc_wait)
			cursor.set
		end

	change_cursor_to_default is
			-- Change the cursor to the default cursor
		local
			cursor: WEL_CURSOR
		do
			create cursor.make_by_predefined_id (Idc_arrow)
			cursor.set
		end

	resize_to_start_window is
			-- Resize the window to the size of start-window size
		do
			resize (start_bitmap.width + 2 * window_border_width + White_offset,
				start_bitmap.height + 2 * window_border_height + White_offset
				+ title_bar_height + menu_bar_height)
		end

	on_accelerator_command (accelerator_id: INTEGER) is
			-- Perform the corresponding menu command
		do
			on_menu_command (accelerator_id)
		end

	redraw_move (source_is_column: BOOLEAN) is
			-- Redraw an entire move
		do
			redraw_before_move (game_manager.source_is_column)
			redraw_after_move
		end

	copy_card_area (destination_dc, source_dc: WEL_DC; a_card: CARD) is
			-- Copy an entire card area from `source_dc' to `destination_dc'
		do
			destination_dc.bit_blt (a_card.x_position, a_card.y_position, a_card.width, a_card.height,
					source_dc, a_card.x_position, a_card.y_position, Srccopy)
		end

	redraw_before_move (source_is_column: BOOLEAN) is
			-- Redraw when card is selected
		local
			card_p: CARD
			card_a: CARD
		do
			card_a := active_card
			card_p := previous_card
			if source_is_column then
				if card_p /= Void then
					virtual_dc.bit_blt (card_p.x_position, card_p.y_position + card_p.height,
						card_p.width, card_a.y_position - card_p.y_position, background_dc, 
						card_p.x_position, card_p.y_position + card_p.height, Srccopy)
					draw_card (card_p, virtual_dc)
				else
					copy_card_area (virtual_dc, background_dc, card_a)
				end
			else
				copy_card_area (client_dc, background_dc, card_a)
				copy_card_area (virtual_dc, background_dc, card_a)
			end

		end

	redraw_after_move is
			-- Redraw when move is made
		do
			copy_card_area (client_dc, virtual_dc, active_card)
			game_manager.initialize_the_cards
			draw_card (active_card, client_dc)
			draw_card (active_card, virtual_dc)
		end
			
	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
		do
			-- If the user clicked on a card with the right mouse
			-- button, the selected card will be move to respectively
			-- its "home_cell", an empty columnn or an empty "xcell"
			if started then
				if move_is_finished then
					move_is_finished := False
					set_capture
					game_manager.select_source (x_pos, y_pos)
					if game_manager.source_selected then
						release_capture
						game_manager.select_destination_home_cell
						if game_manager.move_card then
							redraw_move (game_manager.source_is_column)
							if game_manager.goal_state_reached then
								end_sequence
							end
							game_manager.reset_destination
						else
							game_manager.reset_destination
							if game_manager.select_empty_column then
								if game_manager.move_card then
									redraw_move (game_manager.source_is_column)
								end
								game_manager.reset_destination
							else
								game_manager.select_empty_xcell
								if game_manager.destination_selected then
									if game_manager.move_card then
										redraw_move (game_manager.source_is_column)
									end
									game_manager.reset_destination
								end
							end
						end
						game_manager.reset_source
					end
					move_is_finished := True
				end
			end
		end
				
	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- If the user clicked on a card with the left mouse
			-- button, the selected card will become the `active_card',
			-- and the offset to the mouse pointer is computed.
		do
			if started then
				if move_is_finished then
					move_is_finished := False
					set_capture
					game_manager.select_source (x_pos, y_pos)
					if game_manager.source_selected then
						redraw_before_move (game_manager.source_is_column)
						active_card.set_offset_x (x_pos)
						active_card.set_offset_y (y_pos)
						draw_card(active_card, client_dc)
					end
				end
			end
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- If the user releases the left mouse button,
			-- the destination is selected and the move is
			-- made if possible.
		do
			if started then
				if not move_is_finished then
					release_capture
					if game_manager.source_selected then
						game_manager.select_destination (x_pos, y_pos)
						if game_manager.destination_selected then
							if game_manager.move_card then
								redraw_after_move
								if game_manager.goal_state_reached then
									end_sequence
								end
							else
								redraw_after_move
							end
							game_manager.reset_move_status
						else
							redraw_after_move
							game_manager.reset_source
						end
					end
					move_is_finished := True
				end
			end
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- The invalidated rectangles are computed and
			-- copied from the virtual DC
		local
			repaint_height: INTEGER
			repaint_width: INTEGER
			repaint_x: INTEGER
			repaint_y: INTEGER
			relative_x_position: INTEGER
			relative_y_position: INTEGER
		do
			if started and then flag_set (keys, Mk_lbutton) and then
				game_manager.source_selected then
				if x_pos < screen_width and then y_pos < screen_height then
					relative_x_position := x_pos - active_card.offset_x + active_card.x_position
					relative_y_position := y_pos - active_card.offset_y + active_card.y_position
					if relative_x_position > active_card.x_position then
						repaint_height := active_card.height
						repaint_width := relative_x_position - active_card.x_position
						repaint_x := active_card.x_position
						repaint_y := active_card.y_position
						client_dc.bit_blt (repaint_x,repaint_y,repaint_width, repaint_height, virtual_dc,repaint_x,repaint_y, srccopy)
					elseif relative_x_position < active_card.x_position then
						repaint_height := active_card.height
						repaint_width := active_card.x_position - relative_x_position
						repaint_x := relative_x_position + active_card.width
						repaint_y := active_card.y_position
						client_dc.bit_blt (repaint_x,repaint_y,repaint_width, repaint_height, virtual_dc,repaint_x,repaint_y, srccopy)
					end
					if relative_y_position > active_card.y_position then
						repaint_height :=  relative_y_position - active_card.y_position
						repaint_width := active_card.width
						repaint_x := active_card.x_position
						repaint_y := active_card.y_position
						client_dc.bit_blt (repaint_x,repaint_y,repaint_width, repaint_height, virtual_dc,repaint_x,repaint_y, srccopy)
					elseif relative_y_position < active_card.y_position then
						repaint_height :=  active_card.y_position - relative_y_position
						repaint_width := active_card.width
						repaint_x := active_card.x_position
						repaint_y := relative_y_position + active_card.height
						client_dc.bit_blt (repaint_x,repaint_y,repaint_width, repaint_height, virtual_dc,repaint_x,repaint_y, srccopy)
					end
					active_card.set_x (active_card.x_position + x_pos - active_card.offset_x)
					active_card.set_y (active_card.y_position + y_pos - active_card.offset_y)
					active_card.set_offset_x (x_pos)
					active_card.set_offset_y (y_pos)
					draw_card (active_card, client_dc)
				else
					copy_card_area (client_dc, virtual_dc,
						active_card)
				end
			end
		end

	end_sequence is
			-- The user has finished a game, a bitmap is tiled 
			-- in the client-area
		local
			x_position: INTEGER
			y_position: INTEGER
		do
			from
				x_position := 0
			until
				x_position >= scr_width
			loop
				from
					y_position := 0
				until
					y_position >= scr_height
				loop
					client_dc.draw_bitmap (end_bitmap, x_position, y_position,
						end_bitmap.width, end_bitmap.height)
					virtual_dc.draw_bitmap (end_bitmap, x_position, y_position,
						end_bitmap.width, end_bitmap.height)
					y_position := y_position + end_bitmap.height
				end
				x_position := x_position + end_bitmap.width
			end
		end
	
	draw_background_virtual is
			-- Setup the background on the virtual and the
			-- background DC
		local
			a_bitmap: WEL_BITMAP
			x_position: INTEGER
			y_position: INTEGER
			i: INTEGER
		do
			create a_bitmap.make_by_id (Background_bitmap_id)
			from
				x_position := 0
			until
				x_position >= scr_width
			loop
				from
					y_position := 0
				until
					y_position >= scr_height
				loop
					background_dc.draw_bitmap (a_bitmap, x_position, y_position,
						a_bitmap.width, a_bitmap.height)
					virtual_dc.draw_bitmap (a_bitmap, x_position, y_position,
						a_bitmap.width, a_bitmap.height)
					y_position := y_position + a_bitmap.height
				end
				x_position := x_position + a_bitmap.width
			end
			from
				x_position := Most_left_x_position + 4 * space_between_columns
				y_position := Most_top_y_position
				i := 60
			until
				i > 63
			loop
				create a_bitmap.make_by_id (i)
				virtual_dc.draw_bitmap (a_bitmap, x_position, y_position,
					a_bitmap.width, a_bitmap.height)
				i := i + 1
				x_position := x_position + space_between_columns
			end
			create a_bitmap.make_by_id (Xcell_bitmap_id)
			from
				x_position := Most_left_x_position
				i := 1
			until
				i > Number_of_cells
			loop
				virtual_dc.draw_bitmap (a_bitmap, x_position - 1, y_position,
					a_bitmap.width, a_bitmap.height)
				background_dc.draw_bitmap (a_bitmap, x_position - 1, y_position, a_bitmap.width,
					a_bitmap.height)
				i := i + 1
				x_position := x_position + space_between_columns
			end
		end


	draw_card (a_card: CARD; a_dc: WEL_DC) is
			-- Draw `a_card' on `a_dc'
		require
			a_card_not_void: a_card /= Void
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do			
			a_dc.draw_bitmap (a_card.card_image, a_card.x_position, 
				a_card.y_position, a_card.width, a_card.height)
		end

	the_cards: ARRAY [CARD] is
			-- The cards in the game
		do
			Result := game_manager.the_cards
		ensure
			result_not_void: Result /= Void
		end

	draw_cards is
			-- Draw all the cards in the game on the virtual DC
		local
			cards_in_drawing_order: LINKED_LIST [INTEGER]
		do
			cards_in_drawing_order := game_manager.cards_in_drawing_order
			from
				cards_in_drawing_order.start
			until
				cards_in_drawing_order.off
			loop
				draw_card (the_cards.entry (cards_in_drawing_order.item), virtual_dc)
				cards_in_drawing_order.forth
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- When game has started, copy the invalidated rectangle
			-- from the virtual_dc.
			-- Otherwise center and redraw the starting bitmap
		do
			if started then
				paint_dc.copy_dc (virtual_dc, invalid_rect)
			else
				paint_dc.rectangle (-1, -1, scr_width, scr_height)
				paint_dc.draw_bitmap (start_bitmap, (client_rect.width - start_bitmap.width) // 2, 
					(client_rect.height - start_bitmap.height) // 2, start_bitmap.width,
					start_bitmap.height)
			end
		end

feature -- Implementation

	previous_card: CARD is
			-- The previous card in the columnn of the active card.
			-- This is necessary for efficient redrawing.
		do
			Result := game_manager.previous_card
		end

	active_card: CARD is
			-- The card which is currently selected or moving.
		do
			Result := game_manager.active_card
		ensure
			result_not_void: Result /= Void
		end

	main_menu: WEL_MENU is
			-- The menu of the game
		once
			create Result.make_by_id (Game_menu_id)
		ensure
			menu_not_void: Result /= Void
		end

	class_background: WEL_NULL_BRUSH is
			-- Transparent window background
		once
			create Result.make
		end

	end_bitmap: WEL_BITMAP is
			-- Creates the `end_bitmap'
		once
			create Result.make_by_id (End_bitmap_id)
		ensure
			Result_not_void: Result /= Void
		end

	start_bitmap: WEL_BITMAP is
			-- Creates the `start_bitmap'
		once
			create Result.make_by_id (Start_bitmap_id)
		ensure
			Result_not_void: Result /= Void
		end

	class_icon: WEL_ICON is
			-- Creates the `class_icon'
		once
			create Result.make_by_id (Xcell_icon)
		end

	select_number_of_cards_dialog: SELECT_NUMBER_OF_CARDS_DIALOG is
			-- Creates the `select_number_of_cards_dialog'
		once
			create Result.make (Current)
		ensure
			dialog_not_void: Result /= Void
		end

	select_game_number_dialog: SELECT_GAME_NUMBER_DIALOG is
			-- Creates the `select_game_number_dialog'
		once
			create Result.make (Current)
		ensure
			dialog_not_void: Result /= Void
		end

	about_box: WEL_MODAL_DIALOG is
			-- Creates the `about_box'
		once
			create Result.make_by_id (Current, About_dialog_id)
		ensure
			Result_not_void: Result /= Void
		end

	how_to_play_box: WEL_MODAL_DIALOG is
			-- Creates the `how_to_play_box'
		once
			create Result.make_by_id (Current, How_to_play_dialog)
		ensure
			Result_not_void: Result /= Void
		end

	scr_height: INTEGER is
			-- The maximum height of the client area.
		once
			Result := full_screen_client_area_height
		ensure
			positive_height: scr_height /= 0
		end
	
	scr_width: INTEGER is
			-- The maximum width of the client area
		once
			Result := full_screen_client_area_width
		ensure
			positive_result: scr_width /= 0
		end

invariant

	background_dc_not_void: exists implies background_dc /= Void
	background_dc_exists: exists implies background_dc.exists
	virtual_dc_not_void: exists implies virtual_dc /= Void
	virtual_dc_exists: exists implies virtual_dc.exists
		
end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

