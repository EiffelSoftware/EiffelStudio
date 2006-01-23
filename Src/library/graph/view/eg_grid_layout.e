indexing
	description: "Arrange the nodes in a grid."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_GRID_LAYOUT

inherit
	EG_LAYOUT
		redefine
			default_create
		end
	
create
	make_with_world
	
feature {NONE} -- Initialization

	default_create is
			-- Create a EG_GRID_LAYOUT.
		do
			Precursor {EG_LAYOUT}
			exponent := 1.0
			number_of_columns := 1
		end

feature -- Access

	point_a_x: INTEGER
			-- The x position of the start of the grid.
	
	point_a_y: INTEGER
			-- The y position of the start of the grid.
	
	point_b_x: INTEGER
			-- The x position of the end of the grid.
	
	point_b_y: INTEGER
			-- The y position of the end of the grid.
			
	grid_width: INTEGER is
			-- The width of the grid.
		do
			Result := (point_b_x - point_a_x).abs
		ensure
			result_greater_equal_zero: Result >= 0
		end
		
	grid_height: INTEGER is
			-- The height of the grid.
		do
			Result := (point_b_y - point_a_y).abs
		ensure
			result_greater_equal_zero: Result >= 0
		end

	number_of_columns: INTEGER
			-- Number of columns. (The number of rows is calculated
			-- such that all elements fit in the grid)
	
	exponent: DOUBLE
			-- Exponent used to reduce grid width per level.
			-- (`grid_width' / cluster_level ^ `exponent').
	
feature -- Element change

	set_point_a_position (ax, ay: INTEGER) is
			-- Set `point_a_x' to `ax' and `point_a_y' to `ay'.
		do
			point_a_x := ax
			point_a_y := ay
		ensure
			set: point_a_x = ax and point_a_y = ay
		end
		
	set_point_b_position (ax, ay: INTEGER) is
			-- Set `point_b_x' to `ax' and `point_b_y' to `ay'.
		do
			point_b_x := ax
			point_b_y := ay
		ensure
			set: point_b_x = ax and point_b_y = ay
		end
		
	set_exponent (an_exponent: like exponent) is
			-- Set `exponent' to `an_exponent'.
		do
			exponent := an_exponent
		ensure
			set: exponent = an_exponent
		end
		
	set_number_of_columns (a_number_of_columns: like number_of_columns) is
			-- Set `number_of_columns' to `a_number_of_columns'.
		require
			a_number_of_columns_greater_zero: a_number_of_columns > 0
		do
			number_of_columns := a_number_of_columns
		ensure
			set: number_of_columns = a_number_of_columns
		end

feature {NONE} -- Implementation

	layout_linkables (linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]; level: INTEGER; cluster: EG_CLUSTER_FIGURE) is
			-- arrange `linkables'.
		local
			d_x, d_y: INTEGER
			start_x, start_y: INTEGER
			number_of_rows: INTEGER
			row, col: INTEGER
			l_count, i: INTEGER
			l_link: EG_LINKABLE_FIGURE
		do
			if number_of_columns = 1 then
				start_x := point_a_x // 2 + point_b_x // 2
				d_x := 0
			else
				d_x := ((point_b_x - point_a_x) / ((number_of_columns - 1) * level ^ exponent)).truncated_to_integer
				start_x := point_a_x
			end
			number_of_rows := (linkables.count / number_of_columns).ceiling
			if number_of_rows = 1 then
				start_y := point_a_y // 2 + point_b_y // 2
				d_y := 0
			else
				d_y := ((point_b_y - point_a_y) / ((number_of_rows - 1) * level ^ exponent)).truncated_to_integer
				d_y := d_y // level
				start_y := point_a_y
			end
			from
				row := 0
				i := 1
				l_count := linkables.count
			until
				row >= number_of_rows
			loop
				from
					col := 0
				until
					col >= number_of_columns or else i > l_count
				loop
					l_link := linkables.i_th (i)
					if level = 1 then
						l_link.set_port_position (start_x + col * d_x, start_y + row * d_y)
					else
						l_link.set_port_position (l_link.port_x + col * d_x, l_link.port_y + row * d_y)
					end
					i := i + 1
					col := col + 1
				end
				row := row + 1
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




end -- class EG_GRID_LAYOUT

