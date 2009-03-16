class TEST

inherit
	A
		redefine
			f
		end

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			a: detachable A
			b: attached A
		do
			a.f (a, a).do_nothing
			b.f (a, a).do_nothing
		end

feature {NONE} -- Tests

	f (a: detachable ANY; b: attached ANY): detachable ANY
		do
			Result := Precursor (a, b)
			Result := a
			Result := b
			Result := a.twin
			Result := b.twin
		end

end