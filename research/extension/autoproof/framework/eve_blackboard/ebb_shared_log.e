note
	description: "Access to shared instance of log."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_SHARED_LOG

feature {NONE} -- Access

	log: EBB_LOG
			-- Shared log.
		do
			Result := log_cell.item
		end

feature {NONE} -- Implementation

	log_cell: CELL [EBB_LOG]
			-- Cell to hold shared log instance.
		once
			create Result.put (create {EBB_LOG})
		end

end
