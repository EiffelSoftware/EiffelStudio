class
	TEST
create
	make

feature

	make is
		local
			a: ANY
		do
			a := << io, io.toto, titi >>
			a := [ io, io.toto, titi ]
		end

end
