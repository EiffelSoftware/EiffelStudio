class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			a: detachable ANY
		do
			a := f (Current, Current, Current)
		end

feature {NONE} -- Tests

	t: detachable TEST
		note
			option: stable
		attribute
		end

	f (a, b, c: detachable ANY): detachable ANY
		require
			a /= Void
			a.out /= Void
		do
			from
			invariant
				b /= Void
				b.out /= Void
			until
				True
			loop
			end
			check
				c /= Void
				c.out /= Void
			end
		ensure
			Result /= Void
			Result.out /= Void
		end

invariant
	t /= Void
	t.out /= Void

end