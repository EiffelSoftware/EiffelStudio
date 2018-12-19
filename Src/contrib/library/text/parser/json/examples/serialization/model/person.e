class
	PERSON

inherit
	ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_first_name, a_last_name: READABLE_STRING_GENERAL)
		do
			create first_name.make_from_string_general (a_first_name)
			create last_name.make_from_string_general (a_last_name)
		end

feature -- Access

	first_name: IMMUTABLE_STRING_32

	last_name: IMMUTABLE_STRING_32

	details: detachable PERSON_DETAILS

	co_workers: detachable LIST [ENTITY]

feature -- Element change

	set_details (d: like details)
		do
			details := d
		end

	add_co_worker (e: ENTITY)
		local
			lst: like co_workers
		do
			lst := co_workers
			if lst = Void then
				create {ARRAYED_LIST [ENTITY]} lst.make (0)
				co_workers := lst
			end
			lst.force (e)
		end

feature -- Status report

	name: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (first_name)
			Result.append_character (' ')
			Result.append (last_name)
		end

invariant

end
