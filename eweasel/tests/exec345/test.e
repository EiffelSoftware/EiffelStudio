class TEST
create
	make

feature
	 make
		local
			b: BAR
	 	do
			create b
			b.f
			b.g
	 	end

end
