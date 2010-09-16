class A [G]

create
	make

feature {NONE} -- Creation

	make (value: G) is
		do
			item := value
		end

feature {NONE} -- Data

	item: G

feature -- Access

	test_deep_twin: G
		do
			Result := deep_twin_of (item)
		end

feature {NONE} -- Helper

	deep_twin_of (i: G): G
		do
			Result := i.deep_twin
		end

end