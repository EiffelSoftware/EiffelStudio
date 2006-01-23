indexing
	description: "Draw the histogram of the memory useage at a time."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_DRAW_HISTOGRAM
	
inherit
	MA_DRAW_STATISTIC
		redefine
			draw_text
		end
create
	make_default

feature {NONE}-- Initlization

	make_default  is
			-- creation method
		do
			graph_height := 80
			graph_width := 120
			right_interval := 40
			bottom_interval := 30
			create internal_pixmap.make_with_size (graph_width, graph_height)
			internal_pixmap.set_background_color (graph_pixmap_background_color)

		end
feature -- Command
	
	draw_graph (a_used_percent, a_overhead_percent: DOUBLE) is
			-- Do draw_pixmap.
		do
			internal_pixmap.set_foreground_color (graph_pixmap_background_color)
			internal_pixmap.fill_rectangle (0, 0, internal_pixmap.width, internal_pixmap.height)
			draw_histogram (a_used_percent, a_overhead_percent)
		end
		
	draw_text (a_info: STRING) is
			-- draw the text which is a number of current statistic
		do
			internal_pixmap.set_foreground_color (graph_text_color)
			internal_pixmap.draw_text (0, graph_height - bottom_interval + internal_pixmap.font.height, a_info)
		end
		
feature {NONE} -- Implementation

	draw_histogram (used_percent, overhead_percent: DOUBLE)is
			-- Draw the graph for eiffel/c/total memory useage.
		require
			used_percent_valid: used_percent >= 0 and used_percent <= 1
			overhead_percent_valid: overhead_percent >= 0 and overhead_percent <= 1		
		local 
			test: INTEGER
		do
		--	eiffel_mem_percent := eiffel_mem_info.total/total_mem_info.total--whether show the graph base on the percent?
			--draw background color
			internal_pixmap.set_foreground_color (graph_inner_background_color)
			internal_pixmap.fill_rectangle (left_top_x, left_top_y, inner_graph_width, inner_graph_height)

			--draw used
			internal_pixmap.set_foreground_color (graph_used_color)
			test := inner_graph_draw_height_y (used_percent)
			internal_pixmap.fill_rectangle (left_top_x, inner_graph_draw_height_y (used_percent), inner_graph_width, inner_graph_draw_height(used_percent))
			
			--draw overhead 
			internal_pixmap.set_foreground_color (graph_overhead_color)
			internal_pixmap.fill_rectangle (left_top_x, inner_graph_draw_height_y (overhead_percent), inner_graph_width, inner_graph_draw_height(overhead_percent))
			
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




end
