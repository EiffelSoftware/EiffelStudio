class AA

create

	make

feature

	make is
		local
			b: BB
		do
			if b /= Void then
				b.f
			end
			print ("AA%N")
		end

end -- class AA
