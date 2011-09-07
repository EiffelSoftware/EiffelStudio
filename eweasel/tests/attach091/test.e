class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			a: A [TEST]
			b: B
			c: C
		do
			create a.make (Current)
				-- Valid cases.
			a.x := Current
			a.y := Current
			a.z := Current
			a.ax := Current
			a.ay := Current
			a.az := Current
			a.dx := Current
			a.dy := Current
			a.dz := Current
				-- Invalid cases.
			a.x := Void
			a.y := Void
			a.z := Void
			a.ax := Void
			a.ay := Void
			a.az := Void
			a.dx := Void
			a.dy := Void
			a.dz := Void

			create b
				-- Valid cases.
			b.x := b
			b.y := b
			b.z := b
			b.ax := b
			b.ay := b
			b.az := b
			b.dx := b
			b.dy := b
			b.dz := b
				-- Invalid cases.
			b.x := Void
			b.y := Void
			b.z := Void
			b.ax := Void
			b.ay := Void
			b.az := Void
			b.dx := Void
			b.dy := Void
			b.dz := Void

			create c.make (Current)
				-- Valid cases.
			c.x := Current
			c.y := Current
			c.z := Current
			c.ax := Current
			c.ay := Current
			c.az := Current
			c.dx := Current
			c.dy := Current
			c.dz := Current
				-- Invalid cases.
			c.x := Void
			c.y := Void
			c.z := Void
			c.ax := Void
			c.ay := Void
			c.az := Void
			c.dx := Void
			c.dy := Void
			c.dz := Void
		end

end