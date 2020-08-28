class A [G]

create
	make

feature {NONE} -- Initialization

	make (a: attached G)
		do
			item := a
		end

feature -- Access

	item: G
	
end
