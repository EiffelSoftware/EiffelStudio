class TEST

create

	make

feature

	make
		local
			b: B
		do
			create b.make
			b.f
			b.p (Void)
			b.q (Void)
		end

end
