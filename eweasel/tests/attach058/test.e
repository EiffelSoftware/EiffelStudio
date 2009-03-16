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

	f (a: attached ANY; b: detachable ANY): attached ANY
		do
			Result := Precursor (a, b)
			Result := a
			Result := b
			Result := a.twin
			Result := b.twin
		end

end