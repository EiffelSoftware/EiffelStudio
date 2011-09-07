class
	A

feature {NONE} -- Tests

	a: A
		attribute
			a := Current
		end

	b: A
		attribute
			b := c
		end

	c: A
		attribute
			c := b
		end

	d: A
		attribute
			e := d
		end

	e: A
		attribute
			d := e
		end

	f: A
		attribute
			if out ~ "" then
				f := Current
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
			else
				Result := l
			end
		end

	l: A
		attribute
			if out ~ "" then
				k := k
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
		end

	o: A
		attribute
			y
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