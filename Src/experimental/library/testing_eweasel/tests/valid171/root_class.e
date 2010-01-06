class ROOT_CLASS

create
	make

feature {NONE} -- Initialization

	make is
			-- Run test.
		local
			test: TEST
			l_cur: like Current
			t: LINKED_LIST [INTEGER]
			t2: LINKED_LIST [STRING]
		do
		end

feature -- Access

	toto: like Current is
		do
			Result := Current
		end

end
