class AA

create

	make

feature

	make is
		local
			b: BB
		do
			create b
			b.f
			b.g
		end

end -- class AA
