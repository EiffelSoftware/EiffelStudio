indexing
	description: "Object that compute a class position in an EiffelCase cluster"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CASE_DISPLAY_INFO

inherit
	DOUBLE_MATH

feature -- Initialization

	init (n: INTEGER) is
			-- Init computations with `n' classes to display.
		require
			valid_class_number: n >= 0
		do
			max_column_value := (sqrt(n^1)).truncated_to_integer
			last_x := 0
			last_y := 0
			x := 0
			y := 0
			index := 0
		ensure
			max_column_volue_possible: max_column_value >= 0
		end

feature -- Access

	x, y: INTEGER
			-- Current computed position.

	max_column_value: INTEGER
			-- Maximum number of columns.
			--| I.e. number of classes to display per row.

	index: INTEGER
			-- Number of items already computed.

feature -- Computation

	compute (s: STRING) is
			-- Set `new_x' and `new_y' for next computation.
		require
			s_not_void: s /= Void
			s_not_empty: s.count > 0
		local
			length: INTEGER
		do
				-- By default, the size of a character is of 15 pixels.
			length := s.count * 15

				-- New value of `last_x' and `last_y' when changing the level.
			if index \\ max_column_value = 0 then
					-- We need to scroll down from`height_between_rows'
				last_x := First_width_spacing
				last_y := last_y + Height_between_rows
			end

				-- By default we are at the same level
			y := last_y

				-- The spacing between two classes is of 50 pixels.
			x := last_x + Width_between_columns + length // 2
			last_x := x + length // 2
			index := index + 1
		end


feature {NONE} -- Implementation

	last_x, last_y: INTEGER
			-- Position where was the last Eiffel class in cluster.

	height_between_rows: INTEGER is 100
			-- Height in pixels between two consecutive rows.

	width_between_columns: INTEGER is 50
			-- Width in pixels between two consecutive columns.

	First_width_spacing: INTEGER is 0
			-- Distance from the first item to the left of the screen.

end -- class CASE_DISPLAY_INFO
