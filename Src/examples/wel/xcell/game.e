class
	GAME

inherit
	GAME_CONSTANTS

creation 
	make
	
feature {NONE} -- Initialization

	make (no_cards: INTEGER) is
			-- Create the columns, cells and the cards
		require
			maximum_number_of_cards: no_cards < 53
			minimum_number_of_cards: no_cards > 0
		local
			a_column: column [INTEGER]
			i: INTEGER
		do
			create columns.make (1, Number_of_columns)
			create the_card_numbers.make
			create xcells.make (1, Number_of_cells)
			create home_cells.make (1, Number_of_cells)
			number_of_cards := no_cards
			from
				i := 1
			until
				i > Number_of_columns
			loop
				create a_column.make
				columns.force (a_column, i)
				i := i + 1
			end
			from
				i := 1
			until
				i > Number_of_cells
			loop
				home_cells.force (i - 1, i)
				i := i + 1
			end
			from
				i := First_card
			until
				i > number_of_cards + Card_offset
			loop
				the_card_numbers.extend (i)
				i := i + 1
			end
			create_the_cards
		end

feature -- Status report

	legal_candidate: BOOLEAN is
			-- Are the current settings for destination
			-- and source legal to make a move?
		do
			if go_to = go_from then
				Result := False
			else
				if go_from > Column_offset then
					if go_to > Column_offset then
						if go_to > Home_cell_offset then
			-- column to home
							if legal_from_xcell_or_column_to_home then
								state_change := 1
								Result := True
							end
						else
			-- column to column
							if legal_from_xcell_or_column_to_column then
								state_change := 2
								Result := True
							end
						end
					else
						if go_to <= Column_offset then
			-- column to xcell
							if legal_from_column_to_xcell then
								state_change := 3
								Result := True
							end
						end
					end
				else
					if go_to > Column_offset and go_to <= Home_cell_offset then
			-- xcell to column
						if legal_from_xcell_or_column_to_column then
							state_change := 4
							Result := True
						end
					end
					if go_to > Home_cell_offset then
			-- xcell to home
						if legal_from_xcell_or_column_to_home then
							state_change := 5
							Result := True
						end
					end
				end	
			end
		end

	goal_state: BOOLEAN is
			-- Is the game in the goal_state?
		local
			i: INTEGER
		do
			from
				i := 1
				Result := True
			until
				i > Number_of_columns or not Result
			loop
				Result := Result and column_empty (i)
				i := i + 1
			end
			from
				i := 1
			until
				i > Number_of_cells or not Result
			loop
				Result := Result and xcell_empty (i)
				i := i + 1
			end
		end

feature -- Access

	the_cards: ARRAY [CARD]
			-- The cards in the game

	columns: ARRAY [column [INTEGER]]
			-- The columns in the game

	state_change: INTEGER
			-- The change which is to be made if there
			-- is a `legal_candidate'

	card_in_xcell (a_card:CARD; a_xcell: INTEGER): BOOLEAN is
			-- Is `a_card' in xcell `a_xcell'?
		do
			Result := xcells.entry (a_xcell) = a_card.card_number
		end

	top_of_column (a_card: CARD; a_column: INTEGER): BOOLEAN is
			-- Is `a_card' top of column `a_column'
		require
			valid_column_less: a_column <= Number_of_columns
			valid_column_greater: a_column > 0
			not_empty: not (columns @ a_column).empty
		do
				Result := ((columns @ a_column).the_top) = a_card.card_number
		end

	card_from_xcell (cell_number: INTEGER): INTEGER is
			-- The card from xcell `cell_number'
		require
			valid_cell_less: cell_number <= Number_of_cells
			valid_cell_greater: cell_number > 0
		do
			Result := xcells.entry (cell_number)
		end

	card_from_home_cell (cell_number: INTEGER): INTEGER is
			-- The card from home_cell `cell_number'
		require
			valid_cell_less: cell_number <= Number_of_cells
			valid_cell_greater: cell_number > 0
		do
			Result := home_cells.entry (cell_number)
		end

	card_from_top_of_column (column_number: INTEGER): INTEGER is
			-- The card from top of column `column_number'
		require
			valid_column_less: column_number <= Number_of_columns
			valid_column_greater: column_number > 0
			not_empty: not (columns @ column_number).empty
		do
			Result := (columns @ column_number).the_top
		end

	xcell_empty (cell_number: INTEGER): BOOLEAN is
			-- Is the xcell corresponding to `cell_number' empty?
		require
			valid_cell_less: cell_number <= Number_of_cells
			valid_cell_greater: cell_number > 0
		do
			Result := xcells.entry (cell_number) = 0
		end

	home_cell_empty (cell_number: INTEGER): BOOLEAN is
			-- Is the home_cell corresponding to `cell_number' empty?
		require
			valid_cell_less: cell_number <= Number_of_cells
			valid_cell_greater: cell_number > 0
		do
			Result := home_cells.entry (cell_number) <= Card_offset
		end

	column_empty (column_number: INTEGER): BOOLEAN is
			-- Is the column corresponding to `column_number' empty?
		require
			valid_column_less: column_number <= Number_of_columns
			valid_column_greater: column_number > 0
		do
			Result := (columns @ column_number).empty
		end

	one_from_top_in_column (a_column: INTEGER): INTEGER is
			-- The card number which is one from the top
			-- in the column corresponding to `a_column'
		require
			valid_column_less: a_column <= Number_of_columns
			valid_column_greater: a_column > 0
		do
			Result := (columns @ a_column).one_from_top
		end

	column_from (column_number: INTEGER): LINKED_LIST [INTEGER] is
			-- A linear representation of the column
			-- corresponding to `column_number'
		require
			valid_column_less: column_number <= Number_of_columns
			valid_column_greater: column_number > 0
		do
			Result := deep_clone (columns @ column_number)
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_go_from (move_from: INTEGER) is
			-- Set the source of the movement to be made.
		do
			go_from := move_from
		ensure
			go_from_is_set: go_from = move_from
		end

	set_go_to (to: INTEGER) is
			-- Set the destination of the movement to be made.
		do
			go_to := to
		end

	deal_game is
			-- Deal the game
		local
			column_number: INTEGER
		do
			from
				the_card_numbers.start
				column_number := 1
			until
				the_card_numbers.after
			loop
				add_to_column (column_number, the_card_numbers.item)
				column_number := column_number + 1
				if column_number > Number_of_columns then
					column_number := 1
				end
				the_card_numbers.forth
			end
		end

	shuffle_the_cards (game_number: INTEGER) is
			-- Shuffle the cards in the game with `game_number' as seed.
		require
			game_number_greater_than_zero: game_number > 0
		local
			randomizer: RANDOM
			i, j: INTEGER
			temp_cards: LINKED_LIST [INTEGER]
		do
			create temp_cards.make
			create randomizer.set_seed (game_number)
			from
				the_card_numbers.start
			until
				the_card_numbers.empty
			loop
				i := randomizer.next_random (game_number * 52) \\ the_card_numbers.count
				from
					j := 0
					the_card_numbers.start
				until
					j >= i 
				loop
					the_card_numbers.forth
					j := j + 1
				end
				temp_cards.extend (the_card_numbers.item)
				the_card_numbers.remove
			end
			the_card_numbers := temp_cards
		end

	remove_top_from_column (column_number: INTEGER) is
			-- Remove the top card number from column `column_number'
		do
			columns.entry (column_number).remove_top
		end

	change_state is
			-- Changes the state 
		require
			legal_argument: state_change /= 0 and state_change < 6
			legal_candidate: legal_candidate
		local
			a_card_number: INTEGER
			a_xcell: INTEGER
			a_home_cell: INTEGER
			a_column: INTEGER
			a_column2: INTEGER
		do
			inspect state_change
	
				when 1 then						
			-- Moving from a column to a home_cell
					a_column := column (go_from)
					a_home_cell := home_cell (go_to)
					a_card_number := card_from_top_of_column (a_column)
					remove_top_from_column (a_column)
					insert_in_home_cell (a_home_cell,a_card_number)
					state_change := 0
				when 2 then		
			-- Moving from a column to a column
					a_column := column (go_from)
					a_column2 := column (go_to)
					a_card_number := card_from_top_of_column (a_column)
					remove_top_from_column (a_column)
					add_to_column(a_column2, a_card_number)
					state_change := 0
				when 3 then
			-- Moving from a column to a xcell
					a_column := column (go_from)
					a_xcell := xcell(go_to)
					a_card_number := card_from_top_of_column(a_column)
					remove_top_from_column (a_column)
					insert_in_xcell(a_xcell,a_card_number)
					state_change := 0
				when 4 then
			-- Moving from a xcell to a column
					a_xcell := xcell(go_from)
					a_column := column (go_to)
					a_card_number := card_from_xcell(a_xcell)
					empty_xcell (a_xcell)
					add_to_column (a_column, a_card_number)
					state_change := 0
				when 5 then
			-- Moving from a xcell to a home_cell
					a_xcell := xcell(go_from)
					a_home_cell := home_cell(go_to)
					a_card_number := card_from_xcell (a_xcell)
					empty_xcell(a_xcell)
					insert_in_home_cell (a_home_cell, a_card_number)
					state_change := 0
			end
		ensure
			did_a_change: state_change = 0
		end

feature {NONE} -- Element change

	empty_xcell (cell_number: INTEGER) is
		require
			valid_cell_less: cell_number <= Number_of_cells
			valid_cell_greater: cell_number > 0
		do
			xcells.force (0, cell_number)
		end

	empty_home_cell (cell_number: INTEGER) is
		require
			valid_cell_less: cell_number <= Number_of_cells
			valid_cell_greater: cell_number > 0
		do
			home_cells.force (0, cell_number)
		end

	insert_in_xcell (cell_number: INTEGER; a_card_number: INTEGER) is
		require
			valid_cell_less: cell_number <= Number_of_cells
			valid_cell_greater: cell_number > 0
			card_number_greater_than: a_card_number > Card_offset
			card_number_less_than: a_card_number <= number_of_cards + Card_offset
		do
			xcells.force (a_card_number, cell_number)
		end

	insert_in_home_cell (cell_number: INTEGER; a_card_number: INTEGER) is
		require
			valid_cell_less: cell_number <= Number_of_cells
			valid_cell_greater: cell_number > 0
			card_number_greater_than: a_card_number > Card_offset
			card_number_less_than: a_card_number <= number_of_cards + Card_offset
		do
			home_cells.force (a_card_number, cell_number)
		end

	add_to_column (column_number: INTEGER; a_card_number: INTEGER) is
			-- Add `a_card_number' to a column
		require
			valid_column_less: column_number <= Number_of_columns
			valid_column_greater: column_number > 0
		do
			columns.entry (column_number).add (a_card_number)
		end


feature {NONE} -- Implementation

	go_from: INTEGER
			-- Source of the movement

	go_to: INTEGER
			-- Destination of the movement

	xcells: ARRAY [INTEGER]
			-- The "xcells" in the game

	home_cells: ARRAY [INTEGER]
			-- The home_cells of the game

	number_of_cards: INTEGER
			-- Number of cards in the game

	the_card_numbers: LINKED_LIST [INTEGER]
			-- Card numbers present in the game.
			-- Used for dealing and shuffling the cards.

	card_from (i: INTEGER):INTEGER is
			-- Retrieve card_number identified
			-- by source or destination.
		require
			position_greater_than: i > Xcell_offset
			position_less_or_equal_than: i <= Xcell_offset + home_cell_offset + Column_offset
		do
			if i > home_cell_offset then
				Result := card_from_home_cell (i - home_cell_offset)
			elseif i > Column_offset then
				if not (columns @ (i - Column_offset)).empty then
					Result := card_from_top_of_column (i - Column_offset)
				end
			else
				Result := card_from_xcell (i)
			end
		end


	column (i: INTEGER): INTEGER is
			-- Compute column number identified
			-- by source or destination.			
		require
			position_greater_than: i > Column_offset
			position_less_or_equal_than: i <= home_cell_offset
		do
			Result := i - column_offset
		end

	xcell (i: INTEGER): INTEGER is
			-- Compute xcell number identified
			-- by source or destination.			
		require
			position_greater_than: i > Xcell_offset
			position_less_or_equal_than: i <= Column_offset
		do
			Result := i - xcell_offset
		end

	home_cell (i: INTEGER): INTEGER is
			-- Compute home_cell number identified
			-- by source or destination.
		require
			position_greater_than: i > home_cell_offset
			position_less_or_equal_than: i <= Column_offset + Xcell_offset + home_cell_offset
		do
			Result := i - home_cell_offset
		end

	create_the_cards is
			-- Create the cards in the game.
		require
			less_or_equal_maximum_number_of_cards: number_of_cards <= Maximum_number_of_cards
			greater_or_equal_minimum_number_of_cards: number_of_cards >= 1
		local 
			i: INTEGER
			a_card: CARD
		do
			create the_cards.make (4, number_of_cards + 3)
			from
				i := 4
			until
				i > number_of_cards + 3
			loop
				create a_card.make (i)
				the_cards.force (a_card, i)
				i := i + 1
			end
		end

	kind (a_card_number: INTEGER): INTEGER is
			-- The kind of the card
		require
			card_number_greater_than: a_card_number > Card_offset
			card_number_less_than: a_card_number <= number_of_cards + Card_offset
		do
			Result := a_card_number // 4
		end

	same_kind (a_card_number1, a_card_number2: INTEGER): BOOLEAN is
			-- Are the cards idetified by `a_card_number1'
			-- and `a_card_number' of the same kind?
		require
			card_number1_less_than: a_card_number1 <= number_of_cards + Card_offset
			card_number2_less_than: a_card_number2 <= number_of_cards + Card_offset
		do
			Result := (a_card_number1 \\ 4 = a_card_number2 \\ 4)
		end

	color_difference (a_card_number1, a_card_number2: INTEGER): BOOLEAN is
			-- Is there color difference beween the cards identified
			-- with `a_card_number1' and `a_card_number2'?
		require
			card_number1_less_than: a_card_number1 <= number_of_cards + Card_offset
			card_number2_less_than: a_card_number2 <= number_of_cards + Card_offset
		do
			Result := ((a_card_number1 + a_card_number2) \\ 2 /= 0)
		end

	difference (a_card_number1, a_card_number2: INTEGER): INTEGER is
			-- What is the difference in value of 
			-- `a_card_number2' and `a_card_number1'
		require
			card_number1_less_than: a_card_number1 <= number_of_cards + Card_offset
			card_number2_less_than: a_card_number2 <= number_of_cards + Card_offset
		do
			Result := (a_card_number2 // 4 - a_card_number1 // 4)
		end

	legal_from_xcell_or_column_To_Home:BOOLEAN is
			-- Is it legal to move from a xcell
			-- to a column with current source and
			-- destination?
		do
			Result := (difference (card_from (go_to), card_from (go_from)) = 1)
				and same_kind (card_from (go_from), card_from (go_to))
		end
	
	legal_from_column_to_xcell: BOOLEAN is
			-- Is it legal to move from a column
			-- to a xcell with current source and
			-- destination?
		do
			Result := card_from (go_to) = 0
		end


	legal_from_xcell_or_column_to_column: BOOLEAN is
			-- Is it legal to move from a column
			-- to a column with current source and
			-- destination?
		do
			Result := (difference (card_from (go_from), card_from (go_to)) = 1) 
				and color_difference (card_from(go_from), card_from (go_to))
				and card_from (go_from) /= 0
				or (card_from (go_from) /= 0 and card_from (go_to) = 0)
		end

end -- class GAME

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

