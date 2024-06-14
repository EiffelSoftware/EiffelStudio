class
	A

create
	make

feature {NONE} -- Initialization

	make (n: like name)
			-- Initialize `Current'.
		do
			name := n
		end

feature -- Access

	name: STRING

invariant
end
