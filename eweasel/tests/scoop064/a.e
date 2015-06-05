class A

create
	make

feature

	make
		do
			(agent foo).call (Current)
		end

	foo (a: ANY)
		do
		end

end
