note
	description: "Abstract class for commands that draws figures in a window."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DEMO_CMD

inherit
	EV_STOCK_COLORS

feature {NONE} -- Initialization

	make_in (a_area: like drawing_area; a_stop: like stop_controller)
			-- Init	
		do
			stop_controller := a_stop
			drawing_area := a_area
		ensure
			drawing_area_set: drawing_area = drawing_area
			stop_controller_set: stop_controller = a_stop
		end

feature -- Access

	stop_controller: separate STOP_CONTROLLER
			-- Agent to stop current by other processor

	drawing_area: separate CLIENT_AREA
			-- Drawing area from other processor to perform drawing.

feature -- Execution

	execute
			-- Draw rectangles, until window closed.
		local
			l_stop: BOOLEAN
		do
			from
			until
				l_stop
			loop
				draw (drawing_area)
					-- Call through other processor to stop or not.
				l_stop := should_stop (stop_controller)
			end
		end

feature -- Basic operations

	draw (t_parent: like drawing_area)
			-- Draw
		require
			t_parent_not_void: t_parent /= Void
		deferred
		end

feature {NONE} -- Implementation

	std_colors: ARRAY [EV_COLOR]
		once
			Result := <<
				grey,
				blue,
				cyan,
				green,
				yellow,
				red,
				magenta,
				white,
				black,
				dark_grey,
				dark_blue,
				dark_cyan,
				dark_green,
				dark_yellow,
				dark_red,
				dark_magenta>>
		ensure
			result_not_void: Result /= Void
		end

	should_stop (a_stop: like stop_controller): BOOLEAN
			-- Wrapper for `stop_controller' call
		do
			Result := a_stop.is_stopped
		end

	random: RANDOM
			-- Initialize a randon number
		once
			create Result.make
			random.start
		ensure
			result_not_void : Result /= Void
		end

	next_number (range: INTEGER): INTEGER
			-- Random number between 1 and `range'
			--| Side effect function.
		do
			random.forth
			if range <= 0 then
				Result := 10
			else
				Result := random.item \\ range + 1
			end
		ensure
			valid_result_inf: Result > 0
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
