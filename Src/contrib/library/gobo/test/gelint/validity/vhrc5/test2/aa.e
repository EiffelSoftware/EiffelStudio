class AA

create

	make

feature

	make is
		local
			b: BB
		do
			create b
			print (b + b)
		end

end -- class AA
