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
			print ("AA%N")
		end

end -- class AA
