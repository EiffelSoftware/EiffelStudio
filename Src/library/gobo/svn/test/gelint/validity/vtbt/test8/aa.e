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
			print (b.item.item.count)
		end

end -- class AA
