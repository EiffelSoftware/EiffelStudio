class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			a: separate A
		do
			create a
			g (a)
			h (a)
		end

feature {NONE} -- Test

	g (a: separate A)
		do
				-- Lock passing => separate callback later.
			a.f (1, create {A})
		end

	h (a: separate A)
		do
				-- No lock passing, no callback.
			a.f (3, create {separate A})
		end


end
