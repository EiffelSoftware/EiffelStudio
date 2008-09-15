class TEST

create
	make

feature {NONE} -- Creation

	make is
		local
			a: A [?X]
			b: B [!X]
		do
			create a
			a.test_detachable
			a.test_explicit
			a.test_anchored
			a.test_generic
			create b
			a := b
			a.test_anchored
			a.test_generic
		end

end
