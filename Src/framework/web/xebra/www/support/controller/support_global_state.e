note
	description: "Summary description for {SUPPORT_GLOBAL_STATE}."
	date: "$Date$"
	revision: "$Revision$"

class
	SUPPORT_GLOBAL_STATE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create {DB_PROBLEM_REPORT_PERSISTENCE} persistence.make
			if not persistence.open then
				print ("ERROR IN PERSISTENCE!")
			end
		ensure
			persistence_attached: attached persistence
		end

feature -- Access

	persistence: PROBLEM_REPORT_PERSISTENCE
			-- The persistence (db/memory/filesystem/etc.)

invariant
	persistence_attached: attached persistence

end
