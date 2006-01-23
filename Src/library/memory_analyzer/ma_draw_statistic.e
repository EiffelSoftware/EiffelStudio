indexing
	description: "Objects that used for draw graphics whihch are the datas about memory useage."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MA_DRAW_STATISTIC
	
feature -- Command
	
	draw_graph (a_used_percent, a_overhead_percent:DOUBLE) is
			-- Draw the graph of the statistics.
		require
			used_percent_not_too_large_not_too_small : a_used_percent >= 0 and a_used_percent <= 1
			overhead_percent_not_too_large_not_too_small : a_overhead_percent >= 0 and a_overhead_percent <= 1
		deferred
		end
		
	draw_text (a_info: STRING) is
			-- Draw some infomation on the graph.
		do

		end
		
	pixmap: EV_PIXMAP is
			-- Return the drawed graph.
		do
			Result := internal_pixmap
		ensure
			result_not_void: Result /= Void
		end
	
	set_height (a_height: INTEGER) is
			-- Set the height of graph.
		require
			a_height_valid: a_height >= 0 and a_height <= 800
		do
			graph_height := a_height
			internal_pixmap.set_size (graph_width, a_height)
		ensure
			a_height_set: graph_height = a_height
		end
		
	set_width (a_width: INTEGER) is
			-- Set the width of graph.
		require
			a_width_valid: a_width >= 0 and a_width <= 3000
		do
			graph_width := a_width
			internal_pixmap.set_size (a_width, graph_height)
		ensure
			a_width_set: graph_width = a_width
		end

feature -- Query
	
	inner_graph_width: INTEGER is
			-- The inner graph's width.
		do
			Result := graph_width - left_top_x - right_interval
		ensure
			result_greater_than_zero: Result > 0
		end
	
	inner_graph_height: INTEGER is
			-- The inner graph's height.
		do
			Result := graph_height - left_top_y - bottom_interval
		ensure
			result_greater_than_zero: Result > 0
		end
	
	inner_graph_draw_height (a_percent: DOUBLE): INTEGER is
			-- The inner graph's used/overhead height.
		do
			Result := (inner_graph_height * a_percent).ceiling
		ensure
			result_positive: Result >= 0
		end
		
	inner_graph_draw_height_y (a_percent: DOUBLE): INTEGER is
			-- The inner used graph's y position which can be used by EV_DRAWABLE.draw_sth.(x,y...).
		do
			Result := inner_graph_height - inner_graph_draw_height (a_percent) + left_top_y
		ensure
			result_positive: Result >= 0		
		end
		
feature {NONE} -- Implemention

	internal_pixmap: EV_PIXMAP
			-- The drawable diagram for draw histogram diagram.

	left_top_x: INTEGER is 30
			-- The statistic graph left_top x point.
	
	left_top_y: INTEGER is 10
			-- The statistic graph left_top y point.
	
	bottom_interval: INTEGER 
			-- The interval between the graph and the EV_DRAWABLE bottom which is used for draw texts.
	
	right_interval: INTEGER
			-- The interval between the inner graph and the EV_DRAWABLE right side.
	
	graph_height: INTEGER
			-- The max height of the graph.
				
	graph_width: INTEGER 
			--The max width of the graph.
		
	graph_used_color: EV_COLOR is
			-- The used section's color of the graph.
		once
			Result := (create {EV_STOCK_COLORS}).red
		end
		
	graph_overhead_color: EV_COLOR is
			-- The overhead section's color of the graph.
		once
			Result := (create {EV_STOCK_COLORS}).yellow
		ensure
			reuslt_not_void: Result /= Void
		end
		
	graph_grid_color: EV_COLOR is
			-- The grid color of the graphs.
		once
			Result := (create {EV_STOCK_COLORS}).white
		ensure
			result_not_void: Result /= Void
		end
	
	graph_inner_background_color: EV_COLOR is
			-- The background color of the inner graphs.
		once
			Result := (create {EV_STOCK_COLORS}).white
		ensure
			result_not_void: Result /= Void
		end
	
	graph_background_color: EV_COLOR is
			-- The background color of the inner graphs.
		once
			Result := (create {EV_STOCK_COLORS}).black
		ensure
			result_not_void: Result /= Void
		end
		
	graph_pixmap_background_color: EV_COLOR is
			-- The background color of the whole graph.
		once
			Result := (create {EV_STOCK_COLORS}).black
		ensure
			result_not_void: Result /= Void
		end
		
	graph_text_color: EV_COLOR is
			-- The color of the text in the graph.
		once
			Result := (create {EV_STOCK_COLORS}).white
		ensure
			result_not_void: Result /= Void
		end
		
	grid_size: INTEGER is 20
			-- The grid size of the graph.
			
invariant
	pixmap_not_void: internal_pixmap /= Void
	bottom_interval_not_zero: bottom_interval /= 0
	inner_graph_width_valid: inner_graph_width >= 0 and inner_graph_width <= graph_width
	inner_graph_height_valid: inner_graph_height >= 0 and inner_graph_height <= graph_height
	graph_width_valid: graph_width >= 0 and graph_width <= 1000
	graph_height_valid: graph_height >= 0 and graph_height <= 200
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




end
