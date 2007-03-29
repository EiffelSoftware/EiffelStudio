class E

inherit

	C [STRING]
		redefine
			p
		end

	D [INTEGER]
		redefine
			p
		end

feature

	p (a: STRING; b: INTEGER) is
		do
			io.put_string ("E.p")
			io.put_new_line
			h := a
			j := b
		end

end
