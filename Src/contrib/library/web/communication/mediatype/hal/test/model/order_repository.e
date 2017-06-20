note
	description: "Summary description for {ORDER_REPOSITORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ORDER_REPOSITORY

create
	make

feature {NONE} -- Initialization

	make
		do
			create repo.make (10)
			current_id := 0
			next_id := 1
		end

feature -- Access

	current_id: INTEGER

	next_id: INTEGER

	save (a_order: ORDER)
		do
			repo.force (a_order, next_id)
			current_id := next_id
			next_id := next_id + 1
		end

feature {NONE} -- implementation

	repo: HASH_TABLE [ORDER, INTEGER]

end
