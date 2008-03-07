indexing
	description: "Draw history of the memory useage."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_DRAW_HISTORY

inherit
	MA_DRAW_STATISTIC

	MA_SINGLETON_FACTORY
		export
			{NONE} all
		end
create
	make_default

feature {NONE} -- Initlization

	make_default  is
			-- Creation method
		do
			graph_height := 80
			graph_width := 400
			bottom_interval := 20
			create internal_pixmap.make_with_size (graph_width, graph_height)
			internal_pixmap.set_background_color (graph_pixmap_background_color)
			create graph_used_history.make (100)
			create graph_overhead_history.make (100)
		end

feature -- Command

	draw_graph (a_used_percent, a_overhead_percent: DOUBLE) is
			-- Do draw_history graph and draw_history_grid.
		do
			save_history (a_used_percent, a_overhead_percent)
			update_graph
		end

	update_graph is
			-- Update the graph, because size may changed.
		do
			internal_pixmap.clear
			internal_pixmap.set_size (main_window.gc_graphs.width, main_window.gc_graphs.height)
			draw_history_grid
			-- draw used line
			draw_history_graph_line (graph_used_history, graph_used_color, line_used_width)
			-- draw overhead line
			draw_history_graph_line (graph_overhead_history, graph_overhead_color, line_overhead_width)

			control_graph_size
		end


feature {NONE} -- Control

	control_graph_size is
			-- Control the graph history size, so the graph will not so big.
		require
			two_history_same_size: graph_used_history.count = graph_overhead_history.count
		do
			if graph_used_history.count >= history_size then
				graph_used_history.start
				graph_used_history.remove
				graph_overhead_history.start
				graph_overhead_history.remove
				reduced_x := reduced_x + 1
			end
		ensure
			graph_used_history_size_reduced_one: graph_used_history.count >= history_size implies graph_used_history.count = (old graph_used_history.count) - 1
			graph_overhead_history_size_reduced_one: graph_used_history.count >= history_size implies graph_overhead_history.count = (old graph_overhead_history.count) - 1
		end


feature {NONE} -- Implemention

	history_size: INTEGER is
			-- Ths size of ARRAYED_LIST which contain the history of the graph.
		do
			Result := 1000
		end

	history_show_size: INTEGER is
			-- Size of ARRAYED_LIST which will be used for show current's width.
		do
			Result := graph_width // step
		end


	draw_history_graph_line (a_history: like graph_used_history; a_color: EV_COLOR; a_width: INTEGER) is
			-- Only draw the graph of used/overhead history.
		require
			a_history_not_void: a_history /= Void
			a_color_not_void: a_color /= Void
		local
			current_x: INTEGER
			current_percent: DOUBLE
			l_draw_array: ARRAYED_LIST [EV_COORDINATE]
			l_offset: INTEGER
		do
			from
				create l_draw_array.make (2)
				a_history.start
				if a_history.count > history_show_size then
					a_history.move (a_history.count - history_show_size)
					l_offset := (a_history.count - history_show_size) * step
				end
			until
				a_history.after
			loop
				current_x := a_history.item.pos
				current_percent := a_history.item.percent
				if a_history.index >= 2 then
					internal_pixmap.set_foreground_color (a_color)
					internal_pixmap.set_line_width (a_width)
					if last_used_percent /= current_percent or a_history.index /= a_history.count then
						l_draw_array.extend (create {EV_COORDINATE}.make_with_position (graph_width - (current_x - reduced_x * step) + l_offset, inner_graph_draw_height_y (current_percent)))
						last_used_percent := a_history.item.percent
						last_used_x := a_history.item.pos
					end
				else
					last_used_percent := a_history.item.percent
					last_used_x := a_history.item.pos
					l_draw_array.extend (create {EV_COORDINATE}.make_with_position (graph_width - (last_used_x - reduced_x * step), inner_graph_draw_height_y (last_used_percent)))
				end
				a_history.forth
			end
			if l_draw_array.count >= 2 then
				internal_pixmap.draw_polyline (l_draw_array, False)
			end
		end

	draw_history_grid  is
			-- Draw the grid on the history graph.
		local
			i : INTEGER
		do
			from
				internal_pixmap.set_line_width (line_grid_width)
				i := 0
			until
				i >= internal_pixmap.width
			loop
				internal_pixmap.set_foreground_color (graph_inner_background_color)
				-- draw vertical lines
				internal_pixmap.draw_straight_line ( i, 0, i, internal_pixmap.height)
				i := i + grid_size
			end

			from
				i := 0
			until
				i >= internal_pixmap.height
			loop
				-- draw horizontal lines
				internal_pixmap.draw_straight_line ( 0, i, internal_pixmap.width, i)
				i := i + grid_size
			end
		end

	save_history (used_percent, overhead_percent:DOUBLE)is
			-- Save the used, overhead graph internal_pixmap data.
		require
			used_percent_valid: used_percent >= 0 and used_percent <= 1
			overhead_percent_valid: overhead_percent >= 0 and overhead_percent <= 1
		do
			current_position_x := current_position_x + step
			graph_used_history.extend ([current_position_x, used_percent])
			graph_overhead_history.extend ([current_position_x, overhead_percent])
		ensure
			graph_used_history_saved: graph_used_history.count = old graph_used_history.count + 1
			graph_overhead_history_saved: graph_overhead_history.count = old graph_overhead_history.count + 1
		end

feature {NONE} -- Fields

	step: INTEGER is 6
			-- The x step between update graph.

	line_used_width: INTEGER is 3
			-- Used line width.

	line_overhead_width: INTEGER is 2
			-- Overhead line width.

	line_grid_width: INTEGER is 1
			-- Grid line width.

	reduced_x: INTEGER
			-- Reduced x which is because control graph_size.

	last_used_x, last_overhead_x: INTEGER
			-- Store last x position.

	last_used_percent, last_overhead_percent: DOUBLE
			-- Store last percent.

	current_position_x : INTEGER
			-- Current internal_pixmap x position on the internal_pixmap diagram.

	graph_used_history: ARRAYED_LIST [TUPLE [pos: INTEGER; percent: DOUBLE]]
			-- The list store used graph history.

	graph_overhead_history :  ARRAYED_LIST [TUPLE [pos: INTEGER; percent: DOUBLE]]
			-- The list of graph overhead history.

invariant

	graph_height_set: graph_height /= 0
	graph_width_set: graph_width /= 0
	bottom_interval_set: bottom_interval /= 0
	graph_used_history_not_void: graph_used_history /= Void
	graph_overhead_history_not_void: graph_overhead_history /= Void

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
