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
			a.x  := Current -- VBAC(2)
			a.y  := Current
			a.z  := Current -- unstable: VBAC(2)
			a.ax := Current -- VBAC(2)
			a.ay := Current -- VBAC(2)
			a.az := Current
			a.dx := Current
			a.dy := Current -- unstable: VBAC(2)
			a.dz := Current -- unstable: VBAC(2)
				-- Invalid cases.
			a.x  := Void -- VBAC(2)
			a.y  := Void -- VUAR(2) (attached)
			a.z  := Void -- stable: VUAR(2) unstable: VBAC(2)
			a.ax := Void -- VBAC(2)
			a.ay := Void -- VBAC(2)
			a.az := Void -- VUAR(2)
			a.dx := Void
			a.dy := Void -- stable: VUAR(2) unstable: VBAC(2)
			a.dz := Void -- stable: VUAR(2) unstable: VBAC(2)

			create b
				-- Valid cases.
			b.x  := b -- VBAC(2)
			b.y  := b
			b.z  := b
			b.ax := b -- VBAC(2)
			b.ay := b
			b.az := b
			b.dx := b
			b.dy := b -- unstable: VBAC(2)
			b.dz := b -- unstable: VBAC(2)
				-- Invalid cases.
			b.x  := Void -- VBAC(2)
			b.y  := Void -- VUAR(2)
			b.z  := Void -- VUAR(2)
			b.ax := Void -- VBAC(2)
			b.ay := Void -- VUAR(2)
			b.az := Void -- VUAR(2)
			b.dx := Void
			b.dy := Void -- stable: VUAR(2) unstable: VBAC(2)
			b.dz := Void -- stable: VUAR(2) unstable: VBAC(2)

			create c.make (Current)
				-- Valid cases.
			c.x  := Current -- VBAC(2) (attached)
			c.y  := Current
			c.z  := Current -- unstable: VBAC(2) (detachable)
			c.ax := Current -- VBAC(2)
			c.ay := Current -- VBAC(2) (detachable)
			c.az := Current
			c.dx := Current
			c.dy := Current -- unstable: VBAC(2) (attached)
			c.dz := Current -- unstable: VBAC(2)
				-- Invalid cases.
			c.x  := Void -- VBAC(2) (attached)
			c.y  := Void -- VUAR(2) (attached)
			c.z  := Void -- stable: VUAR(2) unstable: VUAR(2) (attached) VBAC(2) (detachable)
			c.ax := Void -- VBAC(2)
			c.ay := Void -- VUAR(2) (attached) VBAC(2) (detachable)
			c.az := Void -- VUAR(2)
			c.dx := Void
			c.dy := Void -- stable: VUAR(2) (attached) unstable: VBAC(2) (attached)
			c.dz := Void -- stable: VUAR(2) unstable: VBAC(2)
		end

end
