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
			Result := item.deep_twin
		end

end