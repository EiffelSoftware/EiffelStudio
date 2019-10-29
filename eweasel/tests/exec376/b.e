class B

inherit
	ANY
		redefine
			out
		end

create

	make

feature {NONE} -- Creation

	make (v: like out)
		do
			out := v
		end

feature -- Output

	out: like {ANY}.out

feature

	x: like Current do Result := Current end

	a: B do Result := Current end

	b: like a do create Result.make ("1") ensure class end

	c: like a.x do create Result.make ("2") ensure class end
	
	d: like {like a}.x do create Result.make ("3") ensure class end

	e: like {like a.x}.x do create Result.make ("4") ensure class end

	f: like b do create Result.make ("5") ensure class end

	g: like x.a do create Result.make ("6") ensure class end

	h: like {like x}.a do create Result.make ("7") ensure class end

end
