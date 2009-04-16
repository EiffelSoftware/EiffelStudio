note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMOAPPLICATION_GLOBAL_STATE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create {DEMOAPPLICATION_MEMORY_DB}db.make
			if not db.open then
				print ("ERROR DATENBAANK")
			end
		end

feature -- Access

	db: DEMOAPPLICATION_DATABASE

end
