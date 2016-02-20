class TEST

create

	make

feature

	make
		do
			$(C)a := Void -- VJAR
			$(C)la := Void -- VJAR
			$(C)laa := Void -- VJAR
			$(C)lad := Void

			$(C)b := Void -- VJAR
			$(C)lb := Void -- VJAR
			$(C)lba := Void -- VJAR
			$(C)lbd := Void

			$(C)c := Void
			$(C)lc := Void
			$(C)lca := Void -- VJAR
			$(C)lcd := Void

				-- If "$(C)" = "--" we get VEVI for
				-- 	a
				-- 	la
				-- 	laa
				-- 	b
				-- 	lb
				-- 	lba
				-- 	lca

			s := ""
			sa := ""
		end

	a: NONE
	la: like a
	laa: attached like a
	lad: detachable like a

	b: attached NONE
	lb: like b
	lba: attached like b
	lbd: detachable like b

	c: detachable NONE
	lc: like c
	lca: attached like c
	lcd: detachable like c

	s: STRING
	sa: attached STRING
	sd: detachable STRING

	f
		do
			s := a
			s := la
			s := laa
			s := lad -- ERROR

			s := b
			s := lb
			s := lba
			s := lbd -- ERROR

			s := c -- ERROR
			s := lc -- ERROR
			s := lca
			s := lcd -- ERROR

			sa := a
			sa := la
			sa := laa
			sa := lad -- ERROR

			sa := b
			sa := lb
			sa := lba
			sa := lbd -- ERROR

			sa := c -- ERROR
			sa := lc -- ERROR
			sa := lca
			sa := lcd -- ERROR

			sd := a
			sd := la
			sd := laa
			sd := lad

			sd := b
			sd := lb
			sd := lba
			sd := lbd

			sd := c
			sd := lc
			sd := lca
			sd := lcd
		end

end
