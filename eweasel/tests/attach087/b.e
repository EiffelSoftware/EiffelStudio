class B

inherit

	A
		redefine
			 d
		end

create

	make

feature

	d: like Current

	q (x: like Current)
		do
		end

end
