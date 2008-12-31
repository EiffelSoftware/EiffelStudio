note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	GAME_CONSTANTS

feature -- Access

	Space_between_cards: INTEGER = 28
			-- Vertical space between the cards in a column

	Space_between_columns: INTEGER = 80
			-- Horizontal space between the columns including the card width

	Most_top_y_position:INTEGER = 10
			-- Most top y_position of a card.
			-- This position is equal to the y_position 
			-- of the home_cells and the "xcells"

	Most_left_x_position: INTEGER = 20
			-- Defines the space between the cards
			-- and the left border of the window

	Number_of_cells: INTEGER = 4
			-- Number of cells for each kind of cell

	Number_of_columns: INTEGER = 8
			-- Number of columns present in the game

	home_cell_offset: INTEGER = 12
			-- A home_cell is identified in the movement by its number + 12

	Column_offset: INTEGER = 4
			-- A column is identified in the movement by its number + 4

	Card_offset: INTEGER = 3
			-- The offset of a card_number and first_card

	Xcell_offset: INTEGER = 0
			-- A xcell is identified in the movement by its number + 0

	Start_of_column_y_position: INTEGER = 130
			-- The minimal y_position of a column

	First_card: INTEGER = 4
			-- The first card number in the game

	White_offset: INTEGER = 40
			-- White space surrounding picture at start
			-- of the game

	Maximum_number_of_cards: INTEGER = 52
			-- Maximum number of cards to play with

	Maximum_game_number: INTEGER = 65000;
			-- Maximum game number to play

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GAME_CONSTANTS

