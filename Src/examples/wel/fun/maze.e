indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAZE

inherit
	WEL_FRAME_WINDOW

	WEL_STANDARD_PENS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			make_top ("Maze")
			resize (450, 450)
			show
			run_demo
		end

feature {NONE} -- implementation

	run_demo is
		local
			dc: WEL_CLIENT_DC
			max_x, max_y: INTEGER
			x_pos, y_pos: INTEGER
			tick_counter: INTEGER
			tick_init: INTEGER
		do
			max_x := width
			max_y := height
			x_pos := max_x // 2
			y_pos := max_y // 2
			create dc.make (Current)
			dc.get
			dc.move_to (x_pos, y_pos)
			from
				tick_init := tick_count
			until
				tick_counter > demo_duration
			loop
				tick_counter := tick_count - tick_init
				dc.line_to (x_pos, y_pos)
				dc.select_pen (pens.item (next_number
					(color_max)))
				if next_number (2) = 1 then
					if x_pos > step then
						x_pos := x_pos - step
					end
				else
					if x_pos < (max_x - step) then
						x_pos := x_pos + step
					end
				end
				if next_number (2) = 1 then
					if y_pos > step then
						y_pos := y_pos - step
					end
				else
					if y_pos < (max_y - step) then
						y_pos := y_pos + step
					end
				end
			end
			dc.release
			destroy
	end

feature {NONE} -- Implementation

	color_max: INTEGER is 16
		-- Number of colors used

	step: INTEGER is 10
		-- Lenght in pixels before changing direction

	demo_duration: INTEGER is 10_000
		-- Duration of the demo in milliseconds

	pens: ARRAY [WEL_PEN] is
		once
			Result := <<
				white_pen,
				black_pen,
				grey_pen,
				dark_grey_pen,
				blue_pen,
				dark_blue_pen,
				cyan_pen,
				dark_cyan_pen,
				green_pen,
				dark_green_pen,
				yellow_pen,
				dark_yellow_pen,
				red_pen,
				dark_red_pen,
				magenta_pen,
				dark_magenta_pen>>
		ensure
			resut_not_void: Result /= Void
		end

	random: RANDOM is
			-- Initialize a randon number
		once
			create Result.make
			random.start
		ensure
			result_not_void : Result /= Void
		end

	next_number (range: INTEGER): INTEGER is
			-- Random number between 1 and `range'
			--| Side effect function.
		do
			random.forth
			Result := random.item \\ range + 1
		ensure
			valid_result_inf: Result > 0
			valid_result_sup: Result <= range
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


end -- class MAZE

