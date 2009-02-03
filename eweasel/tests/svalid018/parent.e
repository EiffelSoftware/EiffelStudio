class PARENT
create
	make

feature
	make
		local
			r: REAL
		do
			r := p.x
		end

	p: PARENT

	x: DOUBLE

end
