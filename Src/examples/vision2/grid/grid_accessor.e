indexing
	description: "Objects that provide access to a shared EV_GRID"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_ACCESSOR
	
inherit
	REFACTORING_HELPER

feature -- Access

	grid: EV_GRID is
			-- Once access to EV_GRID.
		once
			create Result
		end
		
	main_window: MAIN_WINDOW is
			-- Once access to MAIN_WINDOW
		once
			create Result
		end
		
	profile_cell: CELL [BOOLEAN] is
			--
		once
			create Result
		end
		
	status_bar: EV_LABEL is
			--
		once
			create Result
			Result.align_text_left
		end
		
	set_status_message (a_message: STRING) is
			--
		local
			timer: EV_TIMEOUT
		do
			status_bar.set_text (a_message)
			if timer_cell.item /= Void then
				timer_cell.item.destroy
			end
			create timer.make_with_interval (4000)
			timer.actions.extend (agent status_bar.remove_text)
			timer_cell.replace (timer)
		end
		
	timer_cell: CELL [EV_TIMEOUT] is
		once
			create Result
		end
		

	profile: BOOLEAN is
			--
		do
			Result := profile_cell.item
		end
		
	
	enable_profile is
			--
		do
			profile_cell.put (True)
		end
		
	disable_profile is
			-- 
		do
			profile_cell.put (False)
		end
		
end
