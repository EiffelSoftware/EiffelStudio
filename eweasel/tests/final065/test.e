class TEST
create
	make

feature {NONE}

	make
		local
			a: TEST2 [STRING]
			b: TEST2 [EXPANDED_CLASS [STRING]]
			c: TEST2 [EXPANDED_CLASS [ARRAY [INTEGER]]]
		do
			create a
			a. g
			create b
			b.g
			create c
			c.g
		end

end
