class
	GAME_CONSTANTS

feature -- Access

	Space_between_cards: INTEGER is 28
			-- Vertical space between the cards in a column

	Space_between_columns: INTEGER is 80
			-- Horizontal space between the columns including the card width

	Most_top_y_position:INTEGER is 10
			-- Most top y_position of a card.
			-- This position is equal to the y_position 
			-- of the home_cells and the "xcells"

	Most_left_x_position: INTEGER is 20
			-- Defines the space between the cards
			-- and the left border of the window

	Number_of_cells: INTEGER is 4
			-- Number of cells for each kind of cell

	Number_of_columns: INTEGER is 8
			-- Number of columns present in the game

	home_cell_offset: INTEGER is 12
			-- A home_cell is identified in the movement by its number + 12

	Column_offset: INTEGER is 4
			-- A column is identified in the movement by its number + 4

	Card_offset: INTEGER is 3
			-- The offset of a card_number and first_card

	Xcell_offset: INTEGER is 0
			-- A xcell is identified in the movement by its number + 0

	Start_of_column_y_position: INTEGER is 130
			-- The minimal y_position of a column

	First_card: INTEGER is 4
			-- The first card number in the game

	White_offset: INTEGER is 40
			-- White space surrounding picture at start
			-- of the game

	Maximum_number_of_cards: INTEGER is 52
			-- Maximum number of cards to play with

	Maximum_game_number: INTEGER is 65000
			-- Maximum game number to play

end -- class GAME_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
