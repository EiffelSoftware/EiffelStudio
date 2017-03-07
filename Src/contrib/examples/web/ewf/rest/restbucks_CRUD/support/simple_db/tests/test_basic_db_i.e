note
	description: "Summary description for {TEST_BASIC_DB_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_BASIC_DB_I

inherit
	EQA_TEST_SET

feature -- Factory

	new_object: ANY
		local
			a: A
			b: B
		do
			create a.make_with_name ("Test")
			create b.make ("foo", True, "test-foo")
			a.extend (b)
			create b.make ("bar", True, "test-bar")
			a.extend (b)
			Result := a
		end

	same_object (a,b: like new_object): BOOLEAN
		local
			b1,b2: B
		do
			if attached {A} a as l_a1 and attached {A} b as l_a2 then
				Result := l_a1.name.same_string (l_a2.name) and
						l_a1.count = l_a2.count
				if Result then
					from
						l_a1.items.start
						l_a2.items.start
					until
						not Result or l_a1.items.after or l_a2.items.after
					loop
						b1 := l_a1.items.item
						b2 := l_a1.items.item

						l_a1.items.forth
						l_a2.items.forth
					end
					Result := Result and l_a1.items.after = l_a2.items.after
				end
			end
		end

end
