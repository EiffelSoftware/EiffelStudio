class
	A [G]

feature -- Access

	item: G

	cursor: A [like item] is
		do
			create Result
		end

end
