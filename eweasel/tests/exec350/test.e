class TEST
create
	make

feature
	 make
		local
			f: FOO
			b: BAR
	 	do
			create f.make
			f.f

			create b.make
			b.f
	 	end

end
