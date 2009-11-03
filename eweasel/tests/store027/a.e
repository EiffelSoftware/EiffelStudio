class
	A

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- <precursor>
		do
			create entries.make (5)
			a1 := "a1"
			a2 := "a2"
			entries.put ("a1", "a1")
			entries.put (a2, "a2")
			s1 := "s1"
			s2 := "s2"
			entries.put ("s1", "s1")
			entries.put (s2, "s2")
		end

feature -- Access

	a1, a2: STRING

	entries: HASH_TABLE [STRING, STRING]

	s1, s2: STRING

end
