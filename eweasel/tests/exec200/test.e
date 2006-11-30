class TEST
create
	make

feature

	make is
		local
			a: TEST2
			d: DIRECTORY_NAME
		do
			create a
			a.f (d)
			a.g (d)
			create d.make
			a.f (d)
			a.g (d)
		end;

end

