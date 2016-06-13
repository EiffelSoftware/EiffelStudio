class
	TEAM

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_name)
			create persons.make (0)
		end

feature -- Access

	name: IMMUTABLE_STRING_32

	persons: ARRAYED_LIST [PERSON]

feature -- Element change

	put (a_person: PERSON)
		do
			persons.extend (a_person)
		end

invariant

end
