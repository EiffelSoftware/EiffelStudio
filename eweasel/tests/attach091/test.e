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
			a.x := Void  -- VBAC(1/3)
			a.y := Void  -- VBAC(1/3)
			a.z := Void  -- VBAC(1/3)
			a.ax := Void -- VBAC(1)
			a.ay := Void -- VBAC(1)
			a.az := Void -- VBAC(1)
			a.dx := Void -- VBAC(3)
			a.dy := Void -- VBAC(3)
			a.dz := Void -- VBAC(3)

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
			b.x := Void  -- VBAC(1)
			b.y := Void  -- VBAC(1)
			b.z := Void  -- VBAC(1)
			b.ax := Void -- VBAC(1)  
			b.ay := Void -- VBAC(1)  
			b.az := Void -- VBAC(1)  
			b.dx := Void -- VBAC(3)  
			b.dy := Void -- VBAC(3)  
			b.dz := Void -- VBAC(3)  

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
			c.x := Void  -- VBAC(1/3)
			c.y := Void  -- VBAC(1/3)
			c.z := Void  -- VBAC(1/3)
			c.ax := Void -- VBAC(1)  
			c.ay := Void -- VBAC(1)  
			c.az := Void -- VBAC(1)  
			c.dx := Void -- VBAC(3)  
			c.dy := Void -- VBAC(3)  
			c.dz := Void -- VBAC(3)  
		end

end