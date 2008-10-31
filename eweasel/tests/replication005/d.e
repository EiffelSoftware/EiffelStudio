class
	D

inherit
	B1
		select
			g1
		end

	B2
		select
			f2
		end

	A

create
	make

feature

	make
		do
			f f1 f2
		end

end
