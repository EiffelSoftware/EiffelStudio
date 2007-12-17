class A [G]

create
	make

feature {NONE} -- Initialization

	make (a: !G)
		do
			item := a
		end

feature -- Access

	item: G
	
end
