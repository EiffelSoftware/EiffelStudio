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
			io.put_new_line

			create b.make
			b.f
			io.put_new_line
			b.g
	 	end

end
