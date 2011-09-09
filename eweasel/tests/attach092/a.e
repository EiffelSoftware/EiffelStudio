class
	A

feature {NONE} -- Tests

	a: A
		attribute
			a := Current
			Result := a
		end

	b: A
		attribute
			b := c
			Result := b
		end

	c: A
		attribute
			c := b
			Result := c
		end

	d: A
		attribute
			e := d
			Result := e
		end

	e: A
		attribute
			d := e
			Result := d
		end

	f: A
		attribute
			if out ~ "" then
				f := Current
				Result := f
			else
				Result := Current
			end
		end

	g: A
		attribute
			Result := Current
		end

	h: A
		attribute
			Result := Current
		end

	i: A
		attribute
			Result := j
		end

	j: A
		attribute
			Result := i
		end

	k: A
		attribute
			if out ~ "" then
				k := l
				Result := k
			else
				Result := l
			end
		end

	l: A
		attribute
			if out ~ "" then
				l := k
				Result := l
			else
				Result := k
			end
		end

	m: A
		attribute
			Result := x (Current)
		end

	n: A
		attribute
			n := x (Current)
			Result := n
		end

	o: A
		attribute
			y
			Result := o
		end

	p: A
		attribute
			Result := p
		end

feature {NONE} -- Helpers

	x (v: A): A
		do
			Result := v
		end

	y
		do
			o := Current
		end

end