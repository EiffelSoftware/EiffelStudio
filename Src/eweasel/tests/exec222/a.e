class A [G, H]

feature -- Access

	i: G

feature -- Modification

	put (value: H) is
		do
			i ?= value
		end

end