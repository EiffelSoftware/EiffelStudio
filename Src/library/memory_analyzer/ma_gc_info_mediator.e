indexing
	description: "[ 
					Mediator of
					 analyze the memory , include: show statistics of garbage
					 collector and memory useage. and draw graph and show texts.
																				 ]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_GC_INFO_MEDIATOR
inherit
	MA_SINGLETON_FACTORY

create
	make

feature {NONE} --Intialization

	make is
			-- Creation method.
		do
			eiffel_mem_info := system_util.memory.memory_statistics ({MEM_CONST}.eiffel_memory)
			c_mem_info := system_util.memory.memory_statistics ({MEM_CONST}.c_memory)
			total_mem_info := system_util.memory.memory_statistics ({MEM_CONST}.total_memory)
	
			create histogram_graph.make_default
			create history_graph_eiffel.make_default
			create history_graph_c.make_default
			create history_graph_total.make_default
		end
		
feature -- Command

	show_statistics is
			-- show garbage collection datas to the window
			-- Update `output_text' with current memory usage.
		do			-- show GC_INFO's content which is used by show_mem_info
			-- the information of full collector
			main_window.collected_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).collected.out)
			main_window.collected_average_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).collected_average.out)
			main_window.cycle_count_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).cycle_count.out)
			main_window.memory_used_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).memory_used.out)
			
			main_window.cpu_interval_time_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).cpu_interval_time.out)
			main_window.cpu_interval_time_average_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).cpu_interval_time_average.out)
			main_window.cpu_time_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).cpu_time.out)
			main_window.cpu_time_average_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).cpu_time_average.out)
			
			main_window.real_interval_time_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).real_interval_time.out)
			main_window.real_interval_time_average_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).real_interval_time_average.out)
			main_window.real_time_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).real_time.out)
			main_window.real_time_average_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).real_time_average .out)
			
			main_window.system_interval_time_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).sys_interval_time.out)
			main_window.system_interval_time_average_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).sys_interval_time_average.out)
			main_window.system_time_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).sys_time.out)
			main_window.system_time_average_full.set_text (memory.gc_statistics ({MEMORY}.full_collector).sys_time_average.out)
			
			-- the information of incremental collector
			main_window.collected_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).collected.out)
			main_window.collected_average_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).collected_average.out)
			main_window.cycle_count_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).cycle_count.out)
			main_window.memory_used_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).memory_used.out)
			
			main_window.cpu_interval_time_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).cpu_interval_time.out)
			main_window.cpu_interval_time_average_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).cpu_interval_time_average.out)
			main_window.cpu_time_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).cpu_time.out)
			main_window.cpu_time_average_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).cpu_time_average.out)
			
			main_window.real_interval_time_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).real_interval_time.out)
			main_window.real_interval_time_average_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).real_interval_time_average.out)
			main_window.real_time_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).real_time.out)
			main_window.real_time_average_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).real_time_average .out)
			
			main_window.system_interval_time_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).sys_interval_time.out)
			main_window.system_interval_time_average_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).sys_interval_time_average.out)
			main_window.system_time_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).sys_time.out)
			main_window.system_time_average_incre.set_text (memory.gc_statistics ({MEMORY}.incremental_collector).sys_time_average.out)
			
			-- other informations
			main_window.chunk_size_other.set_text (memory.chunk_size.out)
			main_window.largest_coalesced_block_other.set_text (memory.largest_coalesced_block.out)
			main_window.coalesce_period_other.set_text (memory.coalesce_period.out)
			
			main_window.scavenge_zone_size_other.set_text (memory.scavenge_zone_size.out)
			main_window.collection_period_other.set_text (memory.collection_period.out)
			main_window.tenure_other.set_text (memory.tenure.out)
			
			main_window.memory_threshold_other.set_text (memory.memory_threshold.out)
			main_window.generation_object_limit_other.set_text (memory.generation_object_limit.out)
			main_window.max_memory_other.set_text (memory.max_mem.out)
		end	

feature -- Implementation for agents	
	
	resize (a_x, a_y, a_width, a_height: INTEGER) is
			-- Things when EV_DRAWABLE resize.
		do
			histogram_graph.set_height (a_height)
		end
			
	resize_history (a_x, a_y, a_width, a_height: INTEGER) is
			-- Things when EV_DRAWABLE resize.
		do
			history_graph_eiffel.set_height (a_height)
			history_graph_c.set_height (a_height)
			history_graph_total.set_height (a_height)			
			history_graph_eiffel.set_width (a_width)
			history_graph_c.set_width (a_width)
			history_graph_total.set_width (a_width)
		end
		
	update_gc_info is
			-- Automatically update the statistics.
		do
			draw_graph
			show_statistics
		end
		
	redraw_histogram is
			-- Redraw histogram (left side graph).
		do
			draw_eiffel_histogram
			draw_c_histogram
			draw_total_histogram			
		end
		
	redraw_history is
			-- Redraw history (right side graph).
		do
			main_window.eiffel_history.draw_pixmap (0, 0, history_graph_eiffel.pixmap)
			debug ("larry")
				io.put_string ("%N redraw in MA_GC_INFO_MEDIATOR: pixmap width/height is: " + history_graph_eiffel.pixmap.width.out + " " + history_graph_eiffel.pixmap.height.out)
			end
			main_window.c_history.draw_pixmap (0, 0, history_graph_c.pixmap)
			main_window.total_history.draw_pixmap (0, 0, history_graph_total.pixmap)			
		end
	
	redraw is
			-- Redraw statistic graph.
		do			
			redraw_histogram 
			redraw_history 
			show_statistics 
		end		
		
	redraw_for_resize is
			-- First update the figure because window size may changed, then redraw it.
		do
			history_graph_eiffel.update_graph
			history_graph_c.update_graph
			history_graph_total.update_graph
			redraw
		end
		

feature {NONE} -- Implementaion for draw graphics
	
	draw_eiffel_histogram is
			-- Draw eiffel historam.
		do
			histogram_graph.draw_graph (eiffel_mem_info.used / eiffel_mem_info.total, eiffel_mem_info.overhead / eiffel_mem_info.total)
			histogram_graph.draw_text ("   "+eiffel_mem_info.used.out + "/%N    " + eiffel_mem_info.total.out)
			main_window.eiffel_histogram.draw_pixmap (0, 0, histogram_graph.pixmap)			
		end
		
	draw_c_histogram is
			-- Draw c histogram.
		do
			histogram_graph.draw_graph (c_mem_info.used / c_mem_info.total,c_mem_info.overhead / c_mem_info.total)
			histogram_graph.draw_text ("   "+c_mem_info.used.out + "/%N    " + c_mem_info.total.out)
			main_window.c_histogram.draw_pixmap (0, 0, histogram_graph.pixmap)			
		end
		
	draw_total_histogram is
			-- Draw histogram.
		do
			histogram_graph.draw_graph (total_mem_info.used / total_mem_info.total,total_mem_info.overhead / total_mem_info.total)
			histogram_graph.draw_text ("   "+total_mem_info.used.out + "/%N    " + total_mem_info.total.out)
			main_window.total_histogram.draw_pixmap (0, 0, histogram_graph.pixmap)				
		end
		

	draw_graph is
			-- Draw the statistic graph when time out.
		do
			eiffel_mem_info := memory.memory_statistics ({MEM_CONST}.eiffel_memory)
			c_mem_info := memory.memory_statistics ({MEM_CONST}.c_memory)
			total_mem_info := memory.memory_statistics ({MEM_CONST}.total_memory)
						
			history_graph_eiffel.draw_graph (eiffel_mem_info.used / eiffel_mem_info.total, eiffel_mem_info.overhead / eiffel_mem_info.total)
			history_graph_c.draw_graph (c_mem_info.used / c_mem_info.total, c_mem_info.overhead / c_mem_info.total)
			history_graph_total.draw_graph (total_mem_info.used / total_mem_info.total, total_mem_info.overhead / total_mem_info.total)
			
			main_window.eiffel_history.draw_pixmap (0, 0, history_graph_eiffel.pixmap)
			main_window.c_history.draw_pixmap (0, 0, history_graph_c.pixmap)
			main_window.total_history.draw_pixmap (0, 0, history_graph_total.pixmap)
			
			-- If the data changed, draw the new histogram.
			if last_mem_eiffel_used /= eiffel_mem_info.used or last_mem_eiffel_overhead /= eiffel_mem_info.overhead or 
				last_mem_eiffel_total /= eiffel_mem_info.total then
				last_mem_eiffel_used := eiffel_mem_info.used
				last_mem_eiffel_overhead := eiffel_mem_info.overhead
				last_mem_eiffel_total := eiffel_mem_info.total
				draw_eiffel_histogram
			end
			
			if last_mem_c_used /= c_mem_info.used or last_mem_c_overhead /= c_mem_info.overhead or
				last_mem_c_total /= c_mem_info.total then
				last_mem_c_used := c_mem_info.used
				last_mem_c_overhead := c_mem_info.overhead
				last_mem_c_total := c_mem_info.total
				draw_c_histogram
			end
			
			if last_mem_total_used /= total_mem_info.used or last_mem_total_overhead /= total_mem_info.overhead or
				last_mem_total_total /= total_mem_info.total then
				last_mem_total_used := total_mem_info.used
				last_mem_total_overhead := total_mem_info.overhead
				last_mem_total_total := total_mem_info.total
				draw_total_histogram
			end
			
		end
		
	last_mem_eiffel_used, last_mem_eiffel_overhead, last_mem_eiffel_total: DOUBLE
	last_mem_c_used, last_mem_c_overhead, last_mem_c_total: DOUBLE
	last_mem_total_used, last_mem_total_overhead, last_mem_total_total: DOUBLE
	
	histogram_graph: MA_DRAW_HISTOGRAM
	
	history_graph_eiffel, history_graph_c, history_graph_total: MA_DRAW_HISTORY

feature {NONE} -- Implementation

	eiffel_mem_info, c_mem_info, total_mem_info: MEM_INFO
		-- memory info

invariant

	histogram_graph_not_void: histogram_graph /= Void
	history_graph_eiifel_not_void: history_graph_eiffel /= Void
	history_graph_c_not_void: history_graph_c /= Void
	history_graph_total_not_void: history_graph_total /= Void
		
	eiffel_memory_info_not_void: eiffel_mem_info /= Void
	c_memory_info_not_void: c_mem_info /= Void
	total_memory_info_not_void: total_mem_info /= Void
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
