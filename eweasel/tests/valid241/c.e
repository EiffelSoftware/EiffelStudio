class C
	[
		G, -- Unconstraint type
		H -> G, -- Type, constraint directly to other formal generic
		I -> A [G], -- Type, constraint indirectly to other formal generic
		J -> {B [I, J], D} -- Type, multi-constraint indirectly to other formal generic
	]

create
	make

feature

	b: B [I, J]
	c alias "@": like Current
	g alias "@@": G
	h alias "@@@": H
	i alias "@@@@": I
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

	fc alias "@"    (a: like Current): like Current do end
	fg alias "@@"   (a: G):            G            do end
	fh alias "@@@"  (a: H):            H            do end
	fi alias "@@@@" (a: I):            I            do end

feature {NONE} -- Test

	make
		do
			c := c.fc (c)                             c := @ c                            c := c @ c                                                       -- c := (agent (c).fc).item ([c])
			g := c.fg (g)                             g := @@ c                           g := c @@ g                                                      -- g := (agent (c).fg).item ([g])
			h := c.fh (h)                             h := @@@ c                          h := c @@@ h                                                     -- h := (agent (c).fh).item ([h])
			i := c.fi (i)                             i := @@@@ c                         i := c @@@@ i                                                    -- i := (agent (c).fi).item ([i])
			g := i.fh (g)          g := ig.h          g := @@@ i                          g := i @@@ g                                                     -- g := (agent (i).fh).item ([g])
			g := i.c.fh (g)        g := ig.c.h        g := @@@ @ i                        g := i @ i @@@ g                                                 -- g := (agent (i.c).fh).item ([g])
			g := i.ic.h.fh (g)     g := ig.ic.h.h     g := @@@ @@@ @@@@ i                 g := i @@@@ i.ic @@@ i.ic.h @@@ g                                -- g := (agent (i.ic.h).fh).item ([g])
			g := i.ih.fh (g)       g := ig.ih.h       g := @@@ @@@@@@ i                   g := i @@@@@@ i.ih @@@ g                                         -- g := (agent (i.ih).fh).item ([g])
			g := i.ih.c.fh (g)     g := ig.ih.c.h     g := @@@ @ @@@@@@ i                 g := i @@@@@@ i.ih @ i.ih.c @@@ g                                -- g := (agent (i.ih.c).fh).item ([g])
			g := i.lc.fh (g)       g := ig.lc.h       g := @@@ @@@@@@@ i                  g := i @@@@@@@ i.lc @@@ g                                        -- g := (agent (i.lc).fh).item ([g])
			g := i.flh (g)         g := ig.lh         g := @@@@@@@@@ i                    g := i @@@@@@@@@ g                                               -- g := (agent (i).flh).item ([g])
			g := i.lih.fh (g)      g := ig.lih.h      g := @@@ @@@@@@@@@@@@ i             g := i @@@@@@@@@@@@ i.lih @@@ g                                  -- g := (agent (i.lih).fh).item ([g])
			g := i.ilc.h.fh (g)    g := ig.ilc.h.h    g := @@@ @@@ @@@@@@@@@@@@@ i        g := i @@@@@@@@@@@@@ i.ilc @@@ i.ilc.h @@@ g                     -- g := (agent (i.ilc.h).fh).item ([g])
			g := i.ilh.fh (g)      g := ig.ilh.h      g := @@@ @@@@@@@@@@@@@@@ i          g := i @@@@@@@@@@@@@@@ i.ilh @@@ g                               -- g := (agent (i.ilh).fh).item ([g])
			g := i.ilic.h.h.fh (g) g := ig.ilic.h.h.h g := @@@ @@@ @@@ @@@@@@@@@@@@@@@@ i g := i @@@@@@@@@@@@@@@@ i.ilic @@@ i.ilic.h @@@ i.ilic.h.h @@@ g -- g := (agent (i.ilic.h.h).fh).item ([g])
			g := i.ilih.h.fh (g)   g := ig.ilih.h.h   g := @@@ @@@ @@@@@@@@@@@@@@@@@@ i   g := i @@@@@@@@@@@@@@@@@@ i.ilih @@@ i.ilih.h @@@ g              -- g := (agent (i.ilih.h).fh).item ([g])
			i := j.fg (i)          i := b.g           i := @@ j                           i := j @@ i                                                      -- i := (agent (j).fg).item ([i])
			j := j.fh (j)          j := b.h           j := @@@ j                          j := j @@@ j                                                     -- j := (agent (j).fh).item ([j])
			g := j.g.fh (g)        g := b.g.h         g := @@@ @@ j                       g := j @@ i @@@ g                                                -- g := (agent (j.g).fh).item ([g])
			i := j.h.fg (i)        i := b.h.g         i := @@ @@@ j                       i := j @@@ j @@ i                                                -- i := (agent (j.h).fg).item ([i])
			j := j.h.fh (j)        j := b.h.h         j := @@@ @@@ j                      j := j @@@ j @@@ j                                               -- j := (agent (j.h).fh).item ([j])
			i := j.c.fg (i)        i := b.c.g         i := @@ @ j                         i := j @ j @@ i                                                  -- i := (agent (j.c).fg).item ([i])
			j := j.c.fh (j)        j := b.c.h         j := @@@ @ j                        j := j @ j @@@ j                                                 -- j := (agent (j.c).fh).item ([j])
			g := j.c.g.fh (g)      g := b.c.g.h       g := @@@ @@ @ j                     g := j @ j @@ i @@@ g                                            -- g := (agent (j.c.g).fh).item ([g])
			i := j.lc.fg (i)       i := b.lc.g        i := @@ @@@@@@@ j                   i := j @@@@@@@ j.lc @@ i                                         -- i := (agent (j.lc).fg).item ([i])
			j := j.lc.fh (j)       j := b.lc.h        j := @@@ @@@@@@@ j                  j := j @@@@@@@ j.lc @@@ j                                        -- j := (agent (j.lc).fh).item ([j])
			g := j.lc.g.fh (g)     g := b.lc.g.h      g := @@@ @@ @@@@@@@ j               g := j @@@@@@@ j.lc @@ j.lc.g @@@ g                                   -- g := (agent (j.lc.g).fh).item ([g])
			i := j.ic.h.fg (i)     i := b.ic.h.g      i := @@ @@@ @@@@ j                  i := j @@@@ j.ic @@@ j.ic.h @@ i                                 -- i := (agent (j.ic.h).fg).item ([i])
			j := j.ic.h.fh (j)     j := b.ic.h.h      j := @@@ @@@ @@@@ j                 j := j @@@@ j.ic @@@ j.ic.h @@@ j                                -- j := (agent (j.ic.h).fh).item ([j])
			g := j.ic.h.g.fh (g)   g := b.ic.h.g.h    g := @@@ @@ @@@ @@@@ j              g := j @@@@ j.ic @@@ j.ic.h @@ j.ic.h.g @@@ g                    -- g := (agent (j.ic.h.g).fh).item ([g])
			i := j.ig.fh (i)       i := b.ig.h        i := @@@ @@@@@ j                    i := j @@@@@ j.ig @@@ i                                          -- i := (agent (j.ig).fh).item ([i])
			g := j.ig.h.fh (g)     g := b.ig.h.h      g := @@@ @@@ @@@@@ j                g := j @@@@@ j.ig @@@ j.ig.h @@@ g                                    -- g := (agent (j.ig.h).fh).item ([g])
			j := j.ih.fh (j)       j := b.ih.h        j := @@@ @@@@@@ j                   j := j @@@@@@ j.ih @@@ j                                         -- j := (agent (j.ih).fh).item ([j])
		end

end