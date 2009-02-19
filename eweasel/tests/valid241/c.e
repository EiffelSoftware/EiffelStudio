class C
	[
		G, -- Unconstraint type
		H -> G, -- Type, constraint directly to other formal generic
		I -> A [G], -- Type, constraint indirectly to other formal generic
		J -> {B [I, J], D} -- Type, multi-constraint indirectly to other formal generic
	]

feature

	b: B [I, J]
	c: like Current
	g: G
	h: H
	i: I
	j: J
	ic: A [like Current]
	ig: A [G]
	ih: A [H]
	ii: A [I]
	ij: A [J]
	lc: like c
	lg: like g
	lh: like h
	li: like i
	lj: like j
	lic: like ic
	lig: like ig
	lih: like ih
	lii: like ij
	lij: like ij
	ilc: A [like c]
	ilg: A [like g]
	ilh: A [like h]
	ili: A [like i]
	ilj: A [like j]
	ilic: A [like ic]
	ilig: A [like ig]
	ilih: A [like ih]
	ilii: A [like ii]
	ilij: A [like ij]

feature -- Test

	make
		do
			c := c.c
			g := c.g
			g := c.h
			h := c.h
			i := c.i
			g := i.h         g := ig.h
			g := i.c.h       g := ig.c.h
			g := i.ic.h      g := ig.ic.h    
			g := i.ih.h      g := ig.ih.h    
			g := i.ih.c.h    g := ig.ih.c.h  
			g := i.lc.h      g := ig.lc.h    
			g := i.lh.h      g := ig.lh.h    
			g := i.lih.h     g := ig.lih.h   
			g := i.ilc.h     g := ig.ilc.h   
			g := i.ilh.h     g := ig.ilh.h   
			g := i.ilic.h.h  g := ig.ilic.h.h
			g := i.ilih.h    g := ig.ilih.h  
			i := j.g         i := b.g
			j := j.h         j := b.h
			g := j.g.h       g := b.g.h
			i := j.h.g       i := b.h.g
			j := j.h.h       i := b.h.h
			i := j.c.g       i := b.c.g
			j := j.c.h       j := b.c.h
			g := j.c.g.h     g := b.c.g.h
			i := j.lc.g      i := b.lc.g
			j := j.lc.h      j := b.lc.h
			g := j.lc.g.h    g := b.lc.g.h
			i := j.ic.h.g    i := b.ic.h.g
			j := j.ic.h.h    j := b.ic.h.h
			g := j.ic.h.g.h  g := b.ic.h.g.h
			i := j.ig.h      i := b.ig.h
			g := j.ig.h.h    g := b.ig.h.h
			j := j.ih.h      j := b.ih.h
		end

end