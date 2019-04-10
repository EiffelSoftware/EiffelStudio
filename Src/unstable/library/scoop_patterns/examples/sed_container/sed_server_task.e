note
	description: "Task description for {SED_SERVER_TASK}."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_SERVER_TASK

create
	make

feature {NONE} -- Initialization

 	make (a_name: separate  READABLE_STRING_8)
		do
			create name.make_from_separate (a_name)
			create data.make (1)
		end

feature -- Access		

	name: IMMUTABLE_STRING_8
			-- Server name.

	data: STRING_TABLE [ANY]
			-- Data associated with current server.

	completed: BOOLEAN
			-- Is server execution completed?

feature -- Execution

	reset
		do
			completed := False
		end

	execute (nb: INTEGER)
		do
			reset
			across
				1 |..| nb as c
			loop
				print (generator + ": " + name + ".execution #" + c.item.out + "%N")
				data.force (c.item, name + ".execution#" + c.item.out)
				{EXECUTION_ENVIRONMENT}.sleep (1_000_000_000) -- 1 second.
			end
			completed := True
		end

feature -- Importation

	import_data (obj: separate CP_SED_CONTAINER [ANY])
		local
			cl: CP_SED_CONTAINER [ANY]
		do
			create cl.import (obj)
			if attached {like data} cl.item as tb then
				across
					tb as c
				loop
					data.force (c.item, c.key)
				end
			end
		end

	export_data_to (obj: separate CP_SED_CONTAINER [ANY])
		local
			cl: CP_SED_CONTAINER [ANY]
		do
			create cl.put (data)
			obj.import (cl)
		end
end
