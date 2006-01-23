indexing
	description: "[
		Objects that represent a control displaying a number of small sliders which may be used to modify the tab positions
		of an associated rich text control. Simply associate a rich text via `make_with_rich_text', and the tab positions
		of the rich text are automatically updated as a user drags the sliders of `Current'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_TAB_POSITIONER
	
inherit
	EV_DRAWING_AREA
		redefine
			initialize
		end
		
create
	make_with_rich_text
		
feature {NONE} -- Creation

	make_with_rich_text (a_rich_text: EV_RICH_TEXT) is
			-- Create `Current' and set widths to `default_tab' in pixels.
		require
			rich_text_not_void: a_rich_text /= Void
		do
			default_create
			rich_text := a_rich_text
			initial_tab_width := rich_text.tab_width
			create_figures
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_DRAWING_AREA}
			set_minimum_height (16)
				-- Ensure `Current' is redrawn as necessary.
			expose_actions.extend (agent redraw_control)
			create drag_actions
			create start_drag_actions
			create end_drag_actions
			last_dashed_line_position := -1
		end
		
	create_figures is
			-- Create all figures representing sliders.
		local
			counter: INTEGER
			polygon: EV_FIGURE_POLYGON
			coor1, coor2, coor3, coor4, coor5: EV_RELATIVE_POINT
			move_handle: EV_MOVE_HANDLE
			last_move_handle: EV_MOVE_HANDLE
			line: EV_FIGURE_LINE
		do
			create all_polygons.make (positioners)
			create figure_world
			figure_world.set_background_color (fill_background_color)
			create projector.make (figure_world, Current)
			from
				counter := 1
			until
				counter > positioners
			loop
				rich_text.tab_positions.extend (rich_text.tab_width)
				create move_handle
				if last_move_handle /= Void then
					move_handle.set_origin (last_move_handle.point)
				end
				last_move_handle := move_handle
				figure_world.extend (move_handle)
				
				create coor1.make_with_position (counter * rich_text.tab_width - width_of_figure // 2, height - point_height - base_height - 1)
				create coor2.make_with_origin_and_position (coor1, 0, base_height)
				create coor3.make_with_origin_and_position (coor2, width_of_figure // 2, point_height)
				create coor4.make_with_origin_and_position (coor3, width_of_figure // 2, - point_height)
				create coor5.make_with_origin_and_position (coor4, 0, - base_height)
				
				create polygon
				polygon.extend_point (coor1)
				polygon.extend_point (coor2)
				polygon.extend_point (coor3)
				polygon.extend_point (coor4)
				polygon.extend_point (coor5)
				all_polygons.extend (polygon)
				move_handle.extend (polygon)
				
					-- Connect events to `move_handle'.
				move_handle.set_real_position_agent (agent position_handle (?, ?, polygon, counter))
				move_handle.start_actions.extend (agent move_started (polygon, counter))
				move_handle.move_actions.extend (agent slider_moving (?, ?, polygon, counter))
				move_handle.end_actions.extend (agent move_completed (polygon, counter))
				
				create line
				line.set_foreground_color (white)
				line.set_point_a (create {EV_RELATIVE_POINT}.make_with_position (coor1.x + 1, coor1.y + 1))
				line.set_point_b (create {EV_RELATIVE_POINT}.make_with_position (coor1.x + 1, coor1.y + base_height - 1))
				move_handle.extend (line)
				
				create line
				line.set_foreground_color (white)
				line.set_point_a (create {EV_RELATIVE_POINT}.make_with_position (coor1.x + 1, coor1.y + base_height))
				line.set_point_b (create {EV_RELATIVE_POINT}.make_with_position (coor1.x + width_of_figure // 2 , coor1.y + base_height + (point_height - 1)))
				move_handle.extend (line)
				
				counter := counter + 1
			end
		end

feature -- Status report
	
	start_drag_actions: EV_INTEGER_ACTION_SEQUENCE
		-- Action sequence representing the start of a drag from one of the sliders.
		-- The event data corresponds to the one based index of the slider.
	
	end_drag_actions: EV_INTEGER_ACTION_SEQUENCE
		-- Action sequence representing the completion of a drag from one of the sliders.
		-- The event data corresponds to the one based index of the slider.

	drag_actions: EV_INTEGER_ACTION_SEQUENCE
		-- A slider of `Current' is being dragged, with the event data
		-- corresponding to the point of the slider in relation to the left hand side of `Current'.

feature {NONE} -- Implementation

	move_started (polygon: EV_FIGURE_POLYGON; index: INTEGER)is
			-- A move has started on slider `index', represented by `polygon'.
		require
			polygon_not_void: polygon /= Void
		do
			start_drag_actions.call ([index])
			enable_capture
			original_x := polygon.point_array.item (1).x
		end

	move_completed (polygon: EV_FIGURE_POLYGON; index: INTEGER)is
			-- A move has completed on slider `index', represented by `polygon'.
		require
			polygon_not_void: polygon /= Void
		do
			end_drag_actions.call ([index])
			disable_capture
			
				-- Remove dashed line from screen
			screen.enable_dashed_line_style
			screen.set_invert_mode
			screen.draw_segment (last_dashed_line_position, rich_text.screen_y + 8, last_dashed_line_position, rich_text.screen_y + rich_text.height - 8)
			last_dashed_line_position := - 1
			
			rich_text.tab_positions.go_i_th (index)
			if index = 1 then
				rich_text.tab_positions.replace (polygon.point_array.item (1).x)
			else
				rich_text.tab_positions.replace (polygon.point_array.item (1).x - all_polygons.i_th (index - 1).point_array.item (1).x)
			end
		end

	slider_moving (an_x, a_y: INTEGER; polygon: EV_FIGURE_POLYGON; index: INTEGER) is
			-- Slider `index' represented by `polygon' is being dragged. `an_x' and
			-- `a_y' give the relative position to its origin before dragging.
		require
			polygon_not_void: polygon /= Void
		local
			position: INTEGER
		do
			position := polygon.point_array.item (1).x + width_of_figure // 2
			drag_actions.call ([position])
			
				-- Draw dashed line representing position
			screen.enable_dashed_line_style
			screen.set_invert_mode
			screen.draw_segment (screen_x + position, rich_text.screen_y + 8, screen_x + position, rich_text.screen_y + rich_text.height - 8)
			if last_dashed_line_position > 0 then
				screen.draw_segment (last_dashed_line_position, rich_text.screen_y + 8, last_dashed_line_position, rich_text.screen_y + rich_text.height - 8)
			end
			last_dashed_line_position := screen_x + position
		end

	position_handle (new_x, new_y: INTEGER; polygon: EV_FIGURE_POLYGON; handle_index: INTEGER): TUPLE [INTEGER, INTEGER] is
			--
		do
			create Result
			if handle_index > 1 then
				Result.put_integer_32 (new_x.max (- (initial_tab_width - width_of_figure - 1)), 1)
				Result.put_integer_32 (0, 2)
			else
				Result.put_integer_32 (new_x.max (- original_x), 1)
				Result.put_integer_32 (0, 2)
			end
		end
		
	last_dashed_line_position: INTEGER
		-- Last horizontal coordinate of dashed line drawn when slider is moved.
		
	all_polygons: ARRAYED_LIST [EV_FIGURE_POLYGON]
		-- All polygons comprising `Current'. Each entry corresponds to a polygon representing a slider border.
		
	original_x: INTEGER
		-- Original x position of slider at start of a drag operation.
		
	rich_text: EV_RICH_TEXT	
		-- Associated rich text widget.

	figure_world: EV_FIGURE_WORLD
		-- Figure world holding graphical representation of `Current',
		-- Projected onto `Current' when graphical update is required.
	
	projector: EV_DRAWING_AREA_PROJECTOR
		-- Projector for projection of `figure_world' to `Current'.
	
	width_of_figure: INTEGER is 6
		-- Width of slider.
	
	point_height: INTEGER is 3
		-- Height of point on slider.
	
	base_height: INTEGER is 4
		-- Height of slider base.
		
	positioners: INTEGER is 32
		-- Number of positioners on `Current'.
	
	initial_tab_width: INTEGER
		-- Initial width of tabs in `rich_edit'.

	redraw_control (an_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw visual elements of `Current'.
		do
			projector.project
		end

	fill_background_color: EV_COLOR is
			-- Once access to background color for `Current'.
		once
			Result := (create {EV_STOCK_COLORS}).default_background_color
		end
		
	white: EV_COLOR is
			-- Once access to color white.
		once
			Result := (create {EV_STOCK_COLORS}).white
		end

	screen: EV_SCREEN is
			-- Once access to EV_SCREEN object.
		once
			create Result
		end

invariant
	rich_text_not_void: rich_text /= Void
	drag_actions_not_void: drag_actions /= Void
	start_drag_actions_not_void: start_drag_actions /= Void
	end_drag_actions_not_void: end_drag_actions /= Void

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




end -- class EV_RICH_TEXT_TAB_POSITIONER

