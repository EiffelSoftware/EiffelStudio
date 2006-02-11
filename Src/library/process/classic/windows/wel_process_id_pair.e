indexing
	description: "Objects that wraps a process id with its parent process id"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS_ID_PAIR

create
	make

feature{NONE} -- Initialization

	make (a_parent_id, a_process_id: INTEGER) is
			--
		do
			parent_id := a_parent_id
			id := a_process_id
		ensure
			parent_id_set: parent_id = a_parent_id
			id_set: id = a_process_id
		end

feature -- Access

	parent_id: INTEGER
			-- Parent process id

	id: INTEGER
			-- Process id	

end
