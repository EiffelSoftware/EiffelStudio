
indexing
	
	description: "Access to virtual interval timer server services";
	author: "David Hollenberg";
	date: "September 15, 1998"

class PROCESS_INTERVAL_TIMER_SERVER_ACCESS

feature -- Properties

	interval_timer_server: PROCESS_INTERVAL_TIMER_SERVER is
		once
			create Result.make
		end

end
