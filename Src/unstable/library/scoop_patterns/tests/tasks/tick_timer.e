note
	description: "Summary description for {TICK_TIMER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TICK_TIMER

inherit
	CP_PERIODIC_PROCESS

create
	make

feature -- Access

	count: INTEGER

feature -- Basic operations

	run
			-- <Precursor>
		do
			count := count + 1
			print ("tick%N")
		end

end
