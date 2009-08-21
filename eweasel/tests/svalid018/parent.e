class PARENT
create
	make

feature
	make
		local
			r: DOUBLE
		do
			r := p.x
		end

	p: PARENT

	x: DOUBLE

end
