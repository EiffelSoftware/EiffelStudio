indexing
	description: "Window to perform GC statistics."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GC_STATISTIC_WINDOW

inherit
	ANY

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize current
		local
			l_vbar: EV_VERTICAL_BOX
			l_toolbar: EV_TOOL_BAR
			l_titem: EV_TOOL_BAR_BUTTON
		do
			create window.make_with_title ("GC statistics")
			create l_vbar
			window.extend (l_vbar)
			
				-- Create toolbar
			create l_toolbar
			l_vbar.extend (l_toolbar)
			l_vbar.disable_item_expand (l_toolbar)
			
			create l_titem.make_with_text ("Collect")
			l_titem.select_actions.extend (agent collect)
			l_toolbar.extend (l_titem)
			
			create l_titem.make_with_text ("Mem update")
			l_titem.select_actions.extend (agent show_memory_usage)
			l_toolbar.extend (l_titem)
			
				-- Create output
			create output_text
			output_text.set_font (preferences.editor_data.editor_font_preference.value)
			output_text.set_minimum_size (350, 300)
			l_vbar.extend (output_text)
		end

feature -- Update

	show is
			-- Show Current
		do
			if not window.is_show_requested then
				window.show
			end
			if window.is_minimized then
				window.restore
			end
			window.raise
		end
		
	show_memory_usage is
			-- Update `output_text' with current memory usage.
		local
			eiffel_mem_info, c_mem_info, total_mem_info: MEM_INFO
			l_content: STRING
		do
			collect

			eiffel_mem_info := mem.memory_statistics ({MEM_CONST}.eiffel_memory)
			c_mem_info := mem.memory_statistics ({MEM_CONST}.c_memory)
			total_mem_info := mem.memory_statistics ({MEM_CONST}.total_memory)
			
			create l_content.make_empty
			l_content.append ("Eiffel total memory   : " + eiffel_mem_info.total.out + "%N")
			l_content.append ("Eiffel used memory    : " + eiffel_mem_info.used.out + "%N")
			l_content.append ("Eiffel overhead memory: " + eiffel_mem_info.overhead.out + "%N")
			l_content.append ("Eiffel free memory    : " + eiffel_mem_info.free.out + "%N%N")

			l_content.append ("C total memory        : " + c_mem_info.total.out + "%N")
			l_content.append ("C used memory         : " + c_mem_info.used.out + "%N")
			l_content.append ("C overhead memory     : " + c_mem_info.overhead.out + "%N")
			l_content.append ("C free memory         : " + c_mem_info.free.out + "%N%N")

			l_content.append ("Total memory          : " + total_mem_info.total.out + "%N")
			l_content.append ("Total used memory     : " + total_mem_info.used.out + "%N")
			l_content.append ("Total overhead memory : " + total_mem_info.overhead.out + "%N")
			l_content.append ("Total free memory     : " + total_mem_info.free.out + "%N")
			
			output_text.set_text (l_content)
		end
		
	collect is
			-- Perform a GC cycle.
		do
			mem.full_collect
			mem.full_coalesce
			mem.full_collect
		end
		
		
feature {NONE} -- Access

	window: EV_TITLED_WINDOW
			-- Window containing the GC statistics.
	
	output_text: EV_TEXT
			-- Text control that contains the GC statistics.

	mem: MEMORY is
			-- Access to MEMORY routines
		once
			create Result
		ensure
			mem_not_void: mem /= Void
		end
		
invariant
	window_not_void: window /= Void
	output_text_not_void: output_text /= Void

end
