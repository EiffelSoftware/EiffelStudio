class
	GAME_MANAGER

inherit
	GAME_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (no_cards: INTEGER) is
			-- Set the number of cards and create the game.
		require
			minimum_amount_of_cards: no_cards > 0
		do
			number_of_cards := no_cards
			create game.make (number_of_cards)
		end

feature -- Status report

	source: INTEGER
			-- The source of the current movement

	destination: INTEGER
			-- The destination of the current movement

	source_selected: BOOLEAN
			-- Is the source selected?

	destination_selected: BOOLEAN
			-- Is the destination selected?

	source_is_column: BOOLEAN
			-- Is the source a column?

	active_card: CARD
			-- Card that is currently selected

	previous_card: CARD
			-- If the source is a column, this card will be the 
			-- card that is one from the top in the source column.
			-- If the column has only one card or the source is
			-- not a column, this card will be void.

feature -- Element change

	move_card: BOOLEAN is
			-- Can the active card be moved from
			-- source to destination?
			-- Result is True on movement.
		require
			source_is_valid: source_selected
			destination_is_valid: destination_selected
		do
			game.set_go_from (source)
			game.set_go_to (destination)
			if game.legal_candidate then
				game.change_state
				Result := True
			end
		end

feature -- Access

	goal_state_reached: BOOLEAN is
			-- Is the game in the goal_state?
		do
			Result := game.goal_state
		end

	initialize_the_cards is
			-- Initialize each card in the game, by 
			-- setting its coordinates.
		local
			a_card_number: INTEGER
			a_card: CARD
			a_column: LINKED_LIST [INTEGER]
			a_column_number: INTEGER
			a_cell_number: INTEGER
			x_position, y_position: INTEGER
		do
			from
				y_position := Most_top_y_position
				x_position := Most_left_x_position
				a_cell_number := 1
			until
				a_cell_number > Number_of_cells
			loop
				if not game.xcell_empty (a_cell_number) then
					setup_a_card (game.card_from_xcell(a_cell_number),
						x_position, y_position)
				end
				x_position := x_position + Space_between_columns
				a_cell_number := a_cell_number + 1
			end
			from
				a_cell_number := 1
			until
				a_cell_number > Number_of_cells
			loop
				if not game.home_cell_empty (a_cell_number) then
					setup_a_card (game.card_from_home_cell (a_cell_number),
						x_position, y_position)
				end
				x_position := x_position + space_between_columns
				a_cell_number := a_cell_number + 1
			end
			y_position := Start_of_column_y_position
			x_position := Most_left_x_position

			from
				a_column_number := 1
			until
				a_column_number > Number_of_columns
			loop
				a_column := game.column_from (a_column_number)
				from
					a_column.start
				until
					a_column.after
				loop
					setup_a_card (a_column.item, x_position, y_position)
					a_column.forth
					y_position := y_position + Space_between_cards
				end
				a_column_number := a_column_number + 1
				x_position := x_position + space_between_columns
				y_position := Start_of_column_y_position
			end
		end

	select_source (x_pos, y_pos: INTEGER) is
		local
			i: INTEGER
		do
			from 
				i := First_card
			until
				i > number_of_cards + Card_offset or source_selected
			loop
				if (the_cards @ i).includes_point (x_pos, y_pos) then
					if top_of_column (the_cards @ i) then
						source := last_column_found + column_offset
						source_is_column := True
						source_selected := True
						active_card := the_cards.entry(i)
						if one_from_top_in_column (last_column_found) /= 0 then
							previous_card := (the_cards @ one_from_top_in_column (last_column_found))
						end
					elseif card_in_xcell (the_cards @ i) then
						source_is_column := False
						source_selected := True
						source := last_xcell_found
						active_card := (the_cards @ i)
						previous_card := Void
					end
				else
					source_selected := False
				end
				i := i + 1	
			end
		end

	select_destination (x_pos, y_pos: INTEGER) is	
		local
			i: INTEGER
		do
			from 
				i := First_card
			until
				i > number_of_cards + Card_offset or destination_selected
			loop
				if (the_cards @ i).card_number /= active_card.card_number then
					if (the_cards @ i).overlapped_with (active_card) then
						if top_of_column (the_cards @ i) then
							destination := last_column_found + column_offset
							destination_selected := True
						end
					end
				end
				i := i + 1
			end
			if not destination_selected then
				if active_card.y_position < Start_of_column_y_position then
					if active_card.x_position < middle_of_cells then				
						select_empty_xcell
					else
						select_destination_home_cell
					end
				end
			end
		end

	reset_move_status is
			-- Resets the move status
		require
			source_is_selected: source_selected
			destination_is_selected: destination_selected
		do
			reset_source
			reset_destination
		ensure
			no_destination: not destination_selected
			no_source: not source_selected
		end

	reset_source is
			-- Resets the source of the move status
		require
			source_is_selected: source_selected
		do
			source_selected := False
			previous_card := Void
			active_card := Void
			source := 0
		ensure
			no_source: not source_selected
		end

	reset_destination is
			-- Resets the destination of the move status
		require
			destination_is_selected: destination_selected
		do
			destination_selected := False
			destination := 0
		ensure
			no_destination: not destination_selected
		end

	select_empty_column: BOOLEAN is
			-- Selects an empty column if available
		require
			no_destination: not destination_selected
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > Number_of_columns or game.column_empty (i)
			loop
					i := i + 1
			end
			if not (i > Number_of_columns) then
				destination_selected := True
				destination := i + column_offset
			end
			Result := destination_selected
		ensure
			destination_selected_on_result: Result implies destination_selected
		end

	select_empty_xcell is
			-- Selects an empty xcell if available
		require
			no_destination: not destination_selected			
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > Number_of_cells or game.xcell_empty (i)
			loop
				i := i + 1
			end
			if not (i > Number_of_cells) then
				destination := i + Xcell_offset
				destination_selected := True
			end
		end

	select_destination_home_cell is
			-- Select the home_cell corresponding
			-- to the kind of the card
		require
			no_destination: not destination_selected
		do
			destination := (active_card.card_number \\ 4) + home_cell_offset + 1
			destination_selected := True
		ensure
			destination_is_set: destination /=0
			selected_a_destination: destination_selected
		end

	cards_in_drawing_order: LINKED_LIST [INTEGER] is
			-- A LINKED_LIST of the card numbers in drawing order,
			-- so the cards will overlap correctly when drawn.
		local
			i: INTEGER
			a_column: LINKED_LIST [INTEGER]
			a_cardnumber: INTEGER
		do
			create Result.make
			from
				i := 1
			until
				i > Number_of_cells
			loop
				if not game.xcell_empty (i) then
					Result.extend (game.card_from_xcell(i))
				end
				if not game.home_cell_empty (i) then
					Result.extend (game.card_from_home_cell(i))
				end
				i := i + 1
			end
			from
				i := 1
			until
				i > Number_of_columns
			loop
				a_column := game.column_from (i)
				from
					a_column.start
				until
					a_column.off
				loop
					Result.extend (a_column.item)
					a_column.forth
				end
				i := i +1
			end
		end

	deal_game is
			-- Deal the game.
		do
			game.deal_game
		end
		
	shuffle_the_cards (game_number: INTEGER) is
			-- Shuffle the cards with `game_number'
		require
			game_number_greater_than: game_number > 0
			game_number_smaller_equal_than: game_number <= 65000
		do
			game.shuffle_the_cards (game_number)
		end

	the_cards: ARRAY [CARD] is
			-- The cards in the game
		do
			Result := game.the_cards
		end

feature {NONE} -- Implementation

	game: GAME
			-- The game

	last_column_found: INTEGER
			-- The last column found on a search for an empty column.

	number_of_cards: INTEGER
			-- The number of cards in the game

	last_xcell_found: INTEGER
			-- The last "xcell" found on a search for an empty column.
	
	middle_of_cells: INTEGER is
			-- Compute the x_position between the
			-- xcells and the home_cells.
		require
			active_card_not_void: active_card /= Void
		do
			Result := 20 + 3 * Space_between_columns +
				active_card.card_image.width // 2
		end

	setup_a_card (a_card_number, x_position, y_position: INTEGER) is
		require
			a_card_number_greater_than: a_card_number > Card_offset
			a_card_number_smaller_than_equal: a_card_number <= number_of_cards + Card_offset
		local
			a_card: CARD
		do
			a_card := the_cards.entry (a_card_number)
			a_card.set_x (x_position)
			a_card.set_y (y_position)
		end


	one_from_top_in_column (a_column: INTEGER): INTEGER is
		do
			Result := game.one_from_top_in_column (a_column)
		end

	top_of_column (a_card: CARD): BOOLEAN is
			-- Is `a_card' top of a column?
		local
			i: INTEGER
			is_top: BOOLEAN
		do
			from
				i := 1
			until
				i > Number_of_columns or is_top
			loop
				if not game.column_empty (i) then
					if game.top_of_column (a_card, i) then
						is_top := true
						last_column_found := i
					end
				end
				i := i + 1
			end
			Result := is_top
		end

	card_in_xcell (a_card: CARD):BOOLEAN is
			-- Is a_card in a xcell?
		require
			no_destination: not destination_selected
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > Number_of_cells or game.card_in_xcell (a_card, i)
			loop
					i := i + 1
			end
			if not (i > Number_of_cells) then
				last_xcell_found := i
				Result := True
			end
		end

invariant

	game_not_void: game /= Void

end -- class GAME_MANAGER

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

