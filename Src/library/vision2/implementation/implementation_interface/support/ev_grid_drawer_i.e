indexing
	description: "Objects that draw the EV_GRID widget as required."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_DRAWER_I
	
inherit
	REFACTORING_HELPER
	
create
	make_with_grid
	
feature {NONE} -- Initialization

	make_with_grid (a_grid: EV_GRID_I) is
			-- Create `Current' associated to `grid' `a_grid'.
		require
			a_grid_not_void: a_grid /= Void
		do
			grid := a_grid
		ensure
			grid_set: grid = a_grid
		end

feature -- Access

	grid: EV_GRID_I

feature -- Basic operations

	full_redraw is
			-- Redraw complete client area of `grid'.
		do
			to_implement ("EV_GRID_DRAWER_I.full_redraw")
		end
		
	partial_redraw (an_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw part of client area within `grid' specified by
			-- coordinates `an_x', `a_y', `a_width', `a_height'.
		require
--			an_x_positive: an_x >= 0
--			a_y_positive: a_y >= 0
--			a_width_positive: a_width >= 0
--			a_height_positive: a_height >= 0
		local
			x, y: INTEGER
			width, height: INTEGER
			grid_content: SPECIAL [SPECIAL [EV_GRID_ITEM_I]]
		do
			print ("%N%NPartial redraw an_x : " + an_x.out + "a_y : " + a_y.out + "a_width : " + a_width.out + "a_height : " + a_height.out + "%N%N")
			grid_content := grid.row_list
			
--			grid.drawable.set_foreground_color (red)
--			grid.drawable.fill_rectangle (an_x, a_y, a_width, a_height)
			width := 50
			height := 16
			from
				y := a_y - (a_y \\ height)
			until
				y > a_y + a_height
			loop
				from
					x := an_x - (an_x \\ width)
				until
					x > an_x + a_width
				loop
					grid.drawable.set_foreground_color (red)
					grid.drawable.fill_rectangle (x, y, width, height)
					grid.drawable.set_foreground_color (black)
					grid.drawable.draw_text_top_left (x, y, x.out + "," + y.out)
					x := x + width
				end
				y := y + height
			end
			
			--to_implement ("EV_GRID_DRAWER_I.partial_redraw")
		end
		
	white: EV_COLOR is
			--
		do
			Result := (create {EV_STOCK_COLORS}).white
		end
		
	red: EV_COLOR is
			--
		do
			Result := (create {EV_STOCK_COLORS}).red
		end
		
	black: EV_COLOR is
			--
		do
			Result := (create {EV_STOCK_COLORS}).black
		end
		

feature {NONE} -- Implementation

invariant
	grid_not_void: grid /= Void

end
