expanded class X

feature -- Access

	i: INTEGER assign put

feature -- Modification

	put (value: like i) is
		do
			i := value
		ensure
			definition: i = value
		end

end