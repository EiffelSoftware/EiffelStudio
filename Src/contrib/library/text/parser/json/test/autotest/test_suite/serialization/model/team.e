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
			create vectors.make_empty (3)
			add_vector ("abc")
			add_vector ("def")
			add_vector ("ghi")

			create dico.make (3)
			dico.force ("value1", "key1")
			dico.force ("value2", "key2")
			dico.force ("value3", "key3")
		end

feature -- Access

	name: IMMUTABLE_STRING_32

	persons: LIST [PERSON]

	owner: detachable PERSON

	vectors: SPECIAL [STRING]

	dico: STRING_TABLE [READABLE_STRING_32]

feature -- Element change

	set_owner (p: detachable PERSON)
		do
			owner := p
		end

	put (a_person: PERSON)
		do
			persons.extend (a_person)
		end

	add_vector (s: STRING)
		local
			n: INTEGER
		do
			n := vectors.count
			if n >= vectors.capacity then
				vectors := vectors.resized_area (n + 1)
			end
			vectors.extend (s)
		end

invariant

end
