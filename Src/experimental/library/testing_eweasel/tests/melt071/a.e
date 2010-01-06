class
	A [G]

create
	make

feature

	make (v: G) is
		do
			item := v
		end

feature -- Initialization

	bad is
			-- Initialize
		do
		ensure
			item = old i_th
		end

feature -- Access

	item: G

	i_th: G is
		do
			Result := item
		end

end -- class A
