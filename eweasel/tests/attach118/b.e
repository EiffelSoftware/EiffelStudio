class B

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: detachable A [B]
			b: detachable B
		do
			b := Current
			a := b
			a.do_nothing
			a := Current
			a.do_nothing
			b := a
			b.do_nothing
		end

end