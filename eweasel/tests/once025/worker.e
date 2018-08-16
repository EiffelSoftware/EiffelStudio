note
	description: "Summary description for {WORKER}."
	date: "$Date$"
	revision: "$Revision$"

class
	WORKER [G -> TASK create make end]

feature -- Initialization

	new_task: G
		do
			create Result.make
		end
end
