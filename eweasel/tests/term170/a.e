class
	A [G]

feature

	f: LIST [G]
		local
			a: LIST [G]
		attribute
			create {LINKED_LIST [G]} a.make
			Result := a
		end

end
