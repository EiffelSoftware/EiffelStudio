class
	TEAM

inherit
	ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_name)
			create {ARRAYED_LIST [PERSON]} persons.make (0)
		end

feature -- Access

	name: IMMUTABLE_STRING_32

	persons: LIST [PERSON]

	owner: detachable PERSON

feature -- Element change

	set_owner (p: detachable PERSON)
		do
			owner := p
		end

	put (a_person: PERSON)
		do
			persons.extend (a_person)
		end

end
